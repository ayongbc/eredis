# eredis

erlang现在真是没有人维护了, 这个项目已经很久没有更新了, 我fork了一份, 做了一些修改, 我英文不好，只能用中文了

## 支持断线重连
eredis进程启动参数添加了重连cd时间，no_reconnect表示不重连，其他表示重连间隔时间，单位毫秒

```erlang
    eredis:start_link([{host, "127.0.0.1"}, {port, 6379}, {database, 0}, {password, ""}, {reconnect_sleep, 100}]).
```

## 修改主从切换bug

在redis主从切换的时候，主节点变为从节点的时候，连接会收到readonly的错误码，这时候需要重新连接，
但是eredis没有处理这个错误码，导致连接一直处于错误状态，不会重连，我修改了这个bug

## 支持哨兵模式

首先启动eredis_sentinel进程，参数为哨兵服务器ip列表
```erlang
    eredis_sentinel:start_link([{"127.0.0.1", 26379}, {"127.0.0.1", 26479}, {"127.0.0.1", 26579}]).
```

然后启动eredis进程，参数的host哨兵模式的master名称

```erlang
    eredis:start_link([{host, "sentinel:mymaster"}, {port, 0}, {database, 10}, {password, ""}, {reconnect_sleep, 100}]).
```
