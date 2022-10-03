#!/bin/sh

echo -e "======================== 1. 启动nginx ========================\n"

    nginx -s reload 2>/dev/null || nginx -c /etc/nginx/nginx.conf

echo -e "==============================================================\n"

echo -e "======================== 2、启动后端接口 ========================\n"

    cd /Sub-Store/backend
    pm2 start sub-store.min.js --name "sub-store" --source-map-support --time

echo -e "==============================================================\n"

pm2 log sub-store
exec "$@"
