## Hadoop 配置文件示例目录
## 数据目录结构

```
mkdir -p /data/hadoop/{data,dfs,log,tmp}
mkdir -p /data/hadoop/data/{dfs,tmp,yarn}
mkdir -p /data/hadoop/data/dfs/{data,name}
mkdir -p /data/hadoop/dfs/{data,name}

/data/hadoop
├── data
│   ├── dfs
│   │   ├── data
│   │   └── name
│   ├── tmp
│   │   └── journal
│   └── yarn
│       └── local
├── dfs
│   ├── data
│   └── name
│
├── log
│   └── yarn
└── tmp

```

HA cluster
----

```
各节点分别执行:
hadoop-daemon.sh start journalnode


[hadoop@active sbin]$ hadoop namenode -format
[hadoop@active sbin]$ hdfs zkfc -formatZK
[hadoop@active sbin]$ ./start-dfs.sh
[hadoop@active sbin]$ ./start-yarn.sh


[hadoop@standby sbin]$ yarn-daemon.sh start resourcemanager

```

## 安装配置参考示例
[Hadoop HA 高可用平台配置实例](http://www.jevic.cn/2017/01/23/hadoop-ha/)


