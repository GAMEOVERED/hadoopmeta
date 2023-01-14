--hadoopinstallation--windows--
cd sbin
start-all.cmd
hdfs namenode -format
-----------------------------------
-------SPARK------------
sudo apt install scala
scala --version
(checkdirectorybeforeextraction)
$ sudo tar -xvf spark-3.2.1-bin-hadoop3.2.tgz
$ sudo mkdir /opt/spark
$ sudo mv spark-3.2.0-bin-hadoop3.2/* /opt/spark
$ sudo chmod -R 777 /opt/spark
$ sudo nano ~/.bashrc
export SPARK_HOME=/opt/spark
export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
$ source ~/.bashrc
$ start-master.sh
---
(visit..http://Localhost:8080..underSpark://Ubuntu.myguest.virtualbox.org:7077)
$ start-worker.sh Spark://Ubuntu.myguest.virtualbox.org:7077
(continuedGraphX)
----GraphX----(DONOTPERFORM)-------------------------------------
# Entering graphical data in spark shell
#creating graphical data in graphx
import org.apache.spark.graphx._
# creating own data type
case class User(name: String, age: Int)
val users = List((1L, User("Alex", 26)), (2L, User("Bill", 42)), (3L, User("Carol", 18)), (4L, User("Dave", 16)), (5L, User("Eve", 45)), (6L, User("Farell", 30)), (7L, User ("Garry", 32)), (8L, User("Harry", 36)), (9L, User("Ivan", 28)), (10L, User("Jill", 48)))
val usersRDD = sc.parallelize (users)
val follows = List(Edge(1L, 2L, 1), Edge(2L, 3L, 1), Edge(3L, 1L, 1), Edge(3L, 4L, 1), Edge(3L, 5L, 1), Edge(4L, 5L, 1), Edge(6L, 5L, 1), Edge(7L, 6L, 1), Edge(6L, 8L, 1), Edge(7L, 8L, 1), Edge(7L, 9L, 1), Edge(9L, 8L, 1), Edge(8L, 10L, 1), Edge(10L, 9L, 1), Edge(1L, 1L, 1))
val followsRDD = sc.parallelize(follows)
# creating user to access data 19
val defaultUser = User("Icarus", 22)
val socialgraph = Graph (usersRDD, followsRDD, defaultUser)
#Access data of the graph
socialgraph.numEdges
socialgraph.numVertices
socialgraph.inDegrees.collect
socialgraph.outDegrees.collect
-------------------------------------------------------------
--------------------------------------------------------------------------------
--hiveinstallation--ubuntu--
(hive-2.3.9)
https://downloads.apache.org/hive/
---
$ nano ~/.bashrc
export HIVE_HOME=/home/hadoop/hive
export PATH=$PATH:$HIVE_HOME/bin
---
$ nano $HADOOP_HOME/etc/Hadoop/core-site.xml
<property>
<name>hadoop.proxyuser.hadoop.groups</name>
<value>*</value>
</property>
<property>
<name>hadoop.proxyuser.hadoop.hosts</name>
<value>*</value>
</property>
<property>
<name>hadoop.proxyuser.server.hosts</name>
<value>*</value>
</property>
<property>
<name>hadoop.proxyuser.server.groups</name>
<value>*</value>
</property>
---
$ hadoop fs –mkdir /tmp
$ hadoop fs –mkdir /tmp/user
$ hadoop fs –mkdir /tmp/user/hive
$ hadoop fs –mkdir /tmp/user/hive/warehouse
---
$ hadoop fs -chmod g+w /tmp
$ hadoop fs -chmod g+w tmp/user/hive/warehouse
---
$ schematool -dbType derby -initSchema
---
$ hiveserver2
---
$ beeline -n hadoop -u jdbc:hive2://localhost:10000
---
$ create database test;
# verify with
$ show databases;
---
$ create table test.emp (id int, name string);
---
$ insert into test.emp VALUES(1, ‘Andy’);
$ insert into test.emp VALUES(2, ‘Ramy’);
$ insert into test.emp VALUES(3, ‘Youka’);
---
$ select * from test.emp
--------------------------------------------------
------HBase-------------
(downloadhbasefromwebsiteandplaceitinHadoopDir)
(openhbase-env.shinhbase/conf)
$ sudo nano hbase/conf/hbase-env.sh
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
---
(.bashrc)
$ nano ~/.basrhc
export HBASE_HOME=/home/hbuser/hbase
export PATH= $PATH:$HBASE_HOME/bin
---
$ source ~/.bashrc
---
(hbase/conf/hbase-site.xml)
<property>
<name>hbase.rootdir</name>
<value>file:///home/hbuser/hbase</value>
</property>
<property>
<name>hbase.zookeeper.property.dataDir</name>
<value>/home/hbuser/hbase</value>
</property>
---
$ start-hbase.sh
$ hbase shell
---
(inHbaseshell)
	Create ‘emp’, ‘pri_data’, ‘pro_data’
	Put ‘emp’, ‘1’, ‘pri_data:name’, ‘Andy’
	e =get_table
	e.put ‘1’, ‘pri_data:age’, ‘22’
	e.put ‘1’, ‘pro_data:post’, ‘asst. manager’
	e.put ‘1’, ‘pro_data:salary’, ‘40k’
	e.put ‘2’, ‘pri_data:name’, ‘Icarus’
	e.put ‘2’, ‘pri_data:age’, ‘22’
	e.put ‘2’, ‘pro_data:post’, ‘manager’
	e.get ‘1’
	e.get ‘2’
------------------------------------------------------
------PIG-------
(downloadfromwebsite&&extract)
$ sudo tar –xf pig-0-17.0.tar.gx
---
$ mv pig-0-17-0 /home/Hadoop/pig
---
(.bashrc)
export PIG_HOME=/home/hadoop/pig
export PATH =$PATH:/home/hadoop/pig/bin
export PIG_CLASSPATH=$HADOOP_HOME/conf
---
$pig--version
---
$pig--x local
---
$ nano /home/hadoop/textfile.txt
---
lines = LOAD ‘/home/hadoop/textfile.txt’ AS (line:chararray);
words = FOREACH lines GENERATE FLATTEN(TOKENIZE(line)) as word;
grouped = GROUP words BY word;
wordcount = FOREACH grouped GENERATE group, COUNT(words);
DUMP wordcount;
-------------------------------------------------------------





