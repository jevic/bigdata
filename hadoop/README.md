# Hadoop 配置文件示例目录
## 数据目录结构

```
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

## 启动顺序

```

[hadoop@active sbin]$ hadoop namenode -format
[hadoop@active sbin]$ hdfs zkfc -formatZK
[hadoop@active sbin]$ ./start-dfs.sh
[hadoop@active sbin]$ ./start-yarn.sh

[hadoop@standby sbin]$ hdfs namenode -bootstrapStandby # 同步NNA节点的元数据
[hadoop@standby sbin]$ hadoop-daemon.sh start namenode 
[hadoop@standby sbin]$ yarn-daemon.sh start resourcemanager

```

## 安装配置参考示例
![Hadoop HA 高可用平台配置实例](http://www.jevic.cn/2017/01/23/hadoopha/)
