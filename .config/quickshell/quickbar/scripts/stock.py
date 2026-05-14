import argparse
import time

from requests import Session
from requests.adapters import HTTPAdapter
from urllib3 import Retry


def get_configured_session() -> Session:
    session = Session()
    session.headers.update({"User-Agent": "Mozilla/5.0"})
    retry_strategy = Retry(
        total=None,
        backoff_factor=1.0,
        status_forcelist=[429, 500, 502, 503, 504],
        allowed_methods=["GET"],
    )
    adapter = HTTPAdapter(max_retries=retry_strategy)
    session.mount("https://", adapter)
    session.mount("http://", adapter)
    return session


def fetch_price(session: Session, ticker: str) -> tuple[float, float]:
    url = f"https://query2.finance.yahoo.com/v8/finance/chart/{ticker}"
    response = session.get(url, timeout=10.0)
    response.raise_for_status()
    data = response.json()
    price = data["chart"]["result"][0]["meta"]["regularMarketPrice"]
    close = data["chart"]["result"][0]["meta"]["previousClose"]
    change = price - close
    return price, change


def run(ticker: str, update_frequency: float) -> None:
    session = get_configured_session()
    while True:
        price, change = fetch_price(session, ticker)
        print(f"{price:.2f},{change:.2f}", flush=True)
        time.sleep(update_frequency)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("ticker", type=str)
    parser.add_argument("-f", "--update-frequency", type=float, default=60.0)
    args = parser.parse_args()
    run(ticker=args.ticker, update_frequency=args.update_frequency)


if __name__ == "__main__":
    main()
