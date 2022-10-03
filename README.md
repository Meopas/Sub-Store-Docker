<div align="center">
<br>
<img width="200" src="https://raw.githubusercontent.com/58xinian/icon/master/Sub-Store1.png" alt="Sub-Store">
<br>
<br>
<h2 align="center">Sub-Store VPS 部署<h2>
</div>

项目修改于：<https://github.com/dompling/DockerFiles/tree/master/Sub-Store>

特别感谢：[@dompling](https://github.com/dompling)

## Docker-compose 部署

``` yml
version: '3'

services:
  substore:
    image: saintwe/sub-store-backend:latest
    container_name: substore
    restart: always
    shm_size: 512mb
    ports:
      - "6080:80"
    volumes:
      - ./root.json:/Sub-Store/backend/root.json
      - ./sub-store.json:/Sub-Store/backend/sub-store.json
      - ./crontab:/var/spool/cron/crontabs/root
    environment:
      - TZ=Asia/Shanghai
```

- 将上面内容调整后放到服务器 `docker-compose.yml` 中
- 在 `docker-compose.yml` 同目录中执行 `echo "{}" > ./sub-store.json && echo "{}" > ./root.json && echo "0 */3 * * * /usr/bin/curl http://127.0.0.1/api/sync/artifacts >> /release/sync.log" > ./crontab`
- 目录文件配置好之后在 `substore` 目录执行  
  `docker-compose up -d` 启动；  
  `docker-compose logs` 打印日志；  
  `docker-compose pull` 更新镜像；  
  `docker-compose stop` 停止容器；  
  `docker-compose restart` 重启容器；  
  `docker-compose down` 停止并删除容器；

<br>

## 前端

Fork 此仓库配合 Cloudflare Pages 以及访问策略实现身份认证

```
# 构建命令
sed -i "s|https://sub.store|https://youdomain|g" `grep https://sub.store -rl $(pwd)/dist`
```

## 结束语

> 感谢 [@dompling](https://github.com/dompling)
> 感谢 [@Peng-YM](https://github.com/Peng-YM/Sub-Store) 大佬的无私奉献将代码开源