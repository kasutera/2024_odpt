#!/bin/bash
# GNU date
DATE=$(date +%Y-%m-%d --date '1 day ago')

for dataset in hellocycling docomo-cycle docomo-cycle-tokyo; do
    for resource in station_information station_status; do
        pushd "${dataset}/${resource}" || exit 1
        DATE="$DATE" ../../compress_by_day.sh
        popd || exit 1
    done
done
