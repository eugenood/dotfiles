import requests
import sys
import time


def fetch_area_id(area_name):
    req = requests.get(
        "https://api-open.data.gov.sg/v2/real-time/api/two-hr-forecast",
        headers={"User-Agent": "Mozilla/5.0"},
    )
    res = req.json()
    areas = res["data"]["area_metadata"]
    for id, area in enumerate(areas):
        if area["name"] == area_name:
            return id
    raise KeyError("Area not found.")


def fetch_forecast(area_id):
    req = requests.get("https://api-open.data.gov.sg/v2/real-time/api/two-hr-forecast")
    res = req.json()
    return res["data"]["items"][0]["forecasts"][area_id]["forecast"]


def run(area_name):
    area_id = fetch_area_id(area_name)
    update_freq = 600
    while True:
        forecast = fetch_forecast(area_id)
        print(f"{forecast}", flush=True)
        time.sleep(update_freq)


def main():
    if len(sys.argv) <= 1:
        sys.exit(1)
    area_name = sys.argv[1]
    run(area_name)


if __name__ == "__main__":
    main()
