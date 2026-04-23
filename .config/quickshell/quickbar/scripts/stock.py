import requests
import sys
import time


def fetch_price(ticker):
    req = requests.get(
        f"https://query2.finance.yahoo.com/v8/finance/chart/{ticker}",
        headers={"User-Agent": "Mozilla/5.0"},
    )
    res = req.json()
    price = res["chart"]["result"][0]["meta"]["regularMarketPrice"]
    close = res["chart"]["result"][0]["meta"]["previousClose"]
    change = price - close
    return price, change


def run(ticker):
    update_freq = 60
    while True:
        price, change = fetch_price(ticker)
        print(f"{price:.2f},{change:.2f}", flush=True)
        time.sleep(update_freq)


def main():
    if len(sys.argv) <= 1:
        sys.exit(1)
    ticker = sys.argv[1]
    run(ticker)


if __name__ == "__main__":
    main()
