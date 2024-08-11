#!/bin/bash
cd "$(dirname "$0")" || exit 1

dl_json() {
    if curl -s --compressed "$URL" | jq -c > "$DST"; then
        xz -9 "$DST"
    else
        rm "$DST"
    fi
}

FNAME="$(date +%Y-%m-%dT%H:%M:%S).json"
for dataset in hellocycling docomo-cycle docomo-cycle-tokyo; do
    for resource in station_information station_status; do
        mkdir -p "${dataset}/${resource}"
        URL="https://api-public.odpt.org/api/v4/gbfs/${dataset}/${resource}.json" \
            DST="${dataset}/${resource}/${FNAME}" \
            dl_json &
    done
done
