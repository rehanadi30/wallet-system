# README

## HOW TO RUN

1. Migrate the DB

        rails db:migrate

2. Create test user and test wallet

        rails consoler
        User.create!(email: 'test@example.com', password: 'password')
        wallet = user.wallet
        TransactionService.credit(wallet: wallet, amount: 100)
        puts wallet.balance

3. Start the Server

        rails server

## API

1. Login (POST)

        http://localhost:3000/api/v1/sessions

    Request
        
        {
            "email": "test@example.com",
            "password": "password123"
        }
    
    Response Example:
        
        {
            "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE3Mjk2MjUwNTd9.Wh4nwRmQ3ITMT98urI9VJKR_N8zlFT1K-87R9swDfv0",
            "user_id": 1
        }

Use the token as Bearer Token on Auth for the next APIs

2. Credit Money (POST)

        http://localhost:3000/api/v1/wallet/credit

    Request
        
        {
            "amount": 100.00,
            "description": "Deposit"
        }
    
    Response Example:
        
        {
            "id": 1,
            "source_wallet_id": null,
            "target_wallet_id": 1,
            "amount": "100.0",
            "transaction_type": "credit",
            "description": "Deposit",
            "created_at": "2024-10-21T18:54:32.991Z",
            "updated_at": "2024-10-21T18:54:32.991Z"
        }


3. Debit Money (POST)
        
        http://localhost:3000/api/v1/wallet/debit

    Request
        
        {
            "amount": 100.00,
            "description": "Cash Refund"
        }
    
    Response Example:
        
        {
            "id": 4,
            "source_wallet_id": 1,
            "target_wallet_id": null,
            "amount": "100.0",
            "transaction_type": "debit",
            "description": "Debit",
            "created_at": "2024-10-21T20:43:00.495Z",
            "updated_at": "2024-10-21T20:43:00.495Z"
        }

4. Transfer Money (POST)

        http://localhost:3000/api/v1/wallet/transfer

    Request

        {
            "target_wallet_id": 2,
            "amount": 100.0,
            "description": "Payment for services"
        }

5. Check Wallet Balance (GET)

        http://localhost:3000/api/v1/wallet/balance

6. Get a Stock Price (GET)
        
        http://localhost:3000/api/v1/stocks/price/{symbol}

    Put the stock symbol. For example:

        http://localhost:3000/api/v1/stocks/price/ZOMA.NS

7. Get Stock Prices (Separated by Comma) (GET)

        http://localhost:3000/api/v1/stocks/prices?symbols=[{symbol1},{symbol2}]

    Put the stocks symbols. For example:

        http://localhost:3000/api/v1/stocks/prices?symbols=TATADVRA.NS,ZOMA.NS

8. Get All Stock Prices (GET)

        http://localhost:3000/api/v1/stocks/price_all

    Response

        [
            {
                "identifier": "NIFTY 50",
                "change": -72.95000000000073,
                "dayHigh": 24978.3,
                "dayLow": 24679.6,
                "lastPrice": 24781.1,
                "lastUpdateTime": "21-Oct-2024 16:00:00",
                "meta": {
                    "companyName": null,
                    "industry": null,
                    "isin": null
                },

                .
                .
                .

                {
                    ...
                }
        ]