import requests
import sys
import time


def get_until_ok(request_url, retry_interval=10):
    while True:
        try:
            res = requests.get(request_url, headers={"User-Agent": "Mozilla/5.0"})
        except requests.exceptions.ConnectionError:
            print(flush=True)
            time.sleep(retry_interval)
            continue
        return res


def fetch_price(ticker):
    res = get_until_ok(
        f"https://query2.finance.yahoo.com/v8/finance/chart/{ticker}"
    ).json()
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
