## oozie
#### app_test 任务测试

```
## put 目录到hdfs
hadoop fs -put app_test /user/oozie/
## 提交任务
cd app_test
oozie job --oozie http://localhost:11000/oozie -config job.properties -run
```

#### oozie-ui
[Ambari安装oozie UI无法显示](https://www.jevic.cn/2020/03/17/oozie-ui/)
