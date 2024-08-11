#!/bin/bash
set -eo pipefail

if [[ -z "${DATE}" ]]; then
    return 1
fi

xz -T0 -dc "${DATE}"T*.xz \
    | jq -c \
    | uniq \
    | zstd -T0 -18 \
    > "${DATE}".json.zst

rm "${DATE}"T*.xz
