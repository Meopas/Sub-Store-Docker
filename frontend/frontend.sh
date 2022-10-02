#!/bin/sh

echo -e "======================== 1. 启动nginx ========================\n"

    if [ ! -f "/etc/nginx/conf.d/frontend.conf" ]; then
        echo -e "生成 nginx 配置文件\n"
        envsubst '${ALLOW_IP}' < /etc/nginx/conf.d/frontend.template > /etc/nginx/conf.d/frontend.conf    
    fi
    nginx -s reload 2>/dev/null || nginx -c /etc/nginx/nginx.conf

echo -e "==============================================================\n"

echo -e "======================== 2、启动 Sub-Store 界面 ========================\n"

    sed -i "s|https://sub.store|${DOMAIN}|g" `grep "https://sub.store" -rl /Sub-Store/frontend/dist`

echo -e "==============================================================\n"

exec "$@"
