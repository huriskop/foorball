import streamlit as st
import mysql.connector
import pandas as pd

conn = mysql.connector.connect(
    host="127.0.0.1",
    port=3306,
    user="root",
    password="1234",
    database="football_transfer_system"
)

st.title("Football Transfer System")

page = st.sidebar.selectbox(
    "Menu",
    ["All Players", "Search Players", "My Squad", "Budget", "Transfers", "Sell Player"]
)

if page == "All Players":
    st.subheader("All Players")

    query = """
    SELECT 
        p.player_id,
        p.player_name,
        p.position,
        p.rating,
        p.market_value,
        c.club_name
    FROM players p
    JOIN clubs c ON p.club_id = c.club_id;
    """

    df = pd.read_sql(query, conn)
    st.dataframe(df)


elif page == "Search Players":
    st.subheader("Search Players")

    position = st.selectbox("Choose position", ["ST", "LW", "RW", "CM", "CAM", "CDM", "CB", "LB", "RB", "GK"])
    max_price = st.number_input("Maximum market value", value=100000000)

    query = """
    SELECT 
        p.player_id,
        p.player_name,
        p.position,
        p.rating,
        p.market_value,
        c.club_name
    FROM players p
    JOIN clubs c ON p.club_id = c.club_id
    WHERE p.position = %s AND p.market_value <= %s;
    """

    df = pd.read_sql(query, conn, params=(position, max_price))
    st.dataframe(df)

    st.subheader("Add Player to My Squad")

    player_id = st.number_input("Enter player_id", min_value=1, step=1)
    position_slot = st.selectbox(
        "Choose squad position",
        ["GK", "CB", "LB", "RB", "CDM", "CM", "CAM", "LW", "RW", "ST"]
    )

    if st.button("Add to Squad"):
        cursor = conn.cursor()

        # 1. Get player club and price
        cursor.execute("""
            SELECT club_id, market_value
            FROM players
            WHERE player_id = %s
        """, (player_id,))

        player_info = cursor.fetchone()

        if player_info is None:
            st.error("Player ID not found.")

        else:
            from_club_id = player_info[0]
            transfer_fee = player_info[1]

            cursor.execute("""
                SELECT *
                FROM squad
                WHERE user_id = 1
                AND player_id = %s
            """, (player_id,))

            if cursor.fetchone():
                st.warning("Player already in squad!")

            else:

            # 2. Check current budget and squad value
                cursor.execute("""
                    SELECT 
                        u.budget - IFNULL(SUM(p.market_value), 0) AS remaining_budget
                    FROM users u
                    LEFT JOIN squad s ON u.user_id = s.user_id
                    LEFT JOIN players p ON s.player_id = p.player_id
                    WHERE u.user_id = 1
                    GROUP BY u.budget;
                """)

                remaining_budget = cursor.fetchone()[0]

            # 3. Budget check
                if transfer_fee > remaining_budget:
                    st.error("Not enough budget to buy this player!")

                else:
                    # 4. Add player to squad
                    cursor.execute("""
                        INSERT INTO squad (user_id, player_id, position_slot, date_added)
                        VALUES (%s, %s, %s, CURDATE())
                    """, (1, player_id, position_slot))

                    # 5. Add transfer history
                    cursor.execute("""
                        INSERT INTO transfers
                        (player_id, from_club_id, to_user_id, transfer_fee, transfer_date, transfer_type)
                        VALUES (%s, %s, %s, %s, CURDATE(), 'BUY')
                    """, (player_id, from_club_id, 1, transfer_fee))

                    conn.commit()

                    st.success("Player added to squad and transfer history updated!")



elif page == "My Squad":
    st.subheader("My Squad")

    query = """
    SELECT
        s.squad_id,
        u.team_name,
        p.player_name,
        p.position,
        p.rating,
        p.market_value,
        s.position_slot
    FROM squad s
    JOIN users u ON s.user_id = u.user_id
    JOIN players p ON s.player_id = p.player_id
    WHERE u.user_id = 1;
    """

    df = pd.read_sql(query, conn)
    st.dataframe(df)


elif page == "Budget":
    st.subheader("Budget Summary")

    query = """
    SELECT
        u.team_name,
        u.budget,
        SUM(p.market_value) AS total_squad_value,
        u.budget - SUM(p.market_value) AS remaining_budget
    FROM users u
    JOIN squad s ON u.user_id = s.user_id
    JOIN players p ON s.player_id = p.player_id
    WHERE u.user_id = 1
    GROUP BY u.team_name, u.budget;
    """

    df = pd.read_sql(query, conn)
    st.dataframe(df)

elif page == "Transfers":
    st.subheader("Transfer History")

    query = """
    SELECT
        t.transfer_id,
        t.transfer_type,
        p.player_name,
        CASE
            WHEN t.transfer_type = 'BUY' THEN c.club_name
            WHEN t.transfer_type = 'SELL' THEN u.team_name
        END AS from_team,
        CASE
            WHEN t.transfer_type = 'BUY' THEN u.team_name
            WHEN t.transfer_type = 'SELL' THEN 'Transfer Market'
        END AS to_team,
        t.transfer_fee,
        t.transfer_date
    FROM transfers t
    JOIN players p ON t.player_id = p.player_id
    JOIN clubs c ON t.from_club_id = c.club_id
    JOIN users u ON t.to_user_id = u.user_id
    ORDER BY t.transfer_id DESC;
    """

    df = pd.read_sql(query, conn)
    st.dataframe(df)

elif page == "Sell Player":
    st.subheader("Sell Player")

    query = """
    SELECT
        s.squad_id,
        p.player_name,
        p.position,
        p.market_value
    FROM squad s
    JOIN players p ON s.player_id = p.player_id
    WHERE s.user_id = 1;
    """

    df = pd.read_sql(query, conn)
    st.dataframe(df)

    squad_id = st.number_input("Enter squad_id to sell", min_value=1, step=1)

    if st.button("Sell Player"):
        cursor = conn.cursor()

        # 1. Get player info from squad
        cursor.execute("""
            SELECT 
                s.player_id,
                p.club_id,
                p.market_value
            FROM squad s
            JOIN players p ON s.player_id = p.player_id
            WHERE s.squad_id = %s
            AND s.user_id = 1
        """, (squad_id,))

        sell_info = cursor.fetchone()

        if sell_info is None:
            st.error("Squad ID not found.")
        else:
            player_id = sell_info[0]
            original_club_id = sell_info[1]
            transfer_fee = sell_info[2]

            # 2. Add SELL record to transfer history
            cursor.execute("""
                INSERT INTO transfers
                (player_id, from_club_id, to_user_id, transfer_fee, transfer_date, transfer_type)
                VALUES (%s, %s, %s, %s, CURDATE(), 'SELL')
            """, (player_id, original_club_id, 1, transfer_fee))

            # 3. Remove player from squad
            cursor.execute("""
                DELETE FROM squad
                WHERE squad_id = %s
                AND user_id = 1
            """, (squad_id,))

            conn.commit()

            st.success("Player sold and transfer history updated!")