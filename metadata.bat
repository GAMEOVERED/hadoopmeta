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
$ hadoop fs ???mkdir /tmp
$ hadoop fs ???mkdir /tmp/user
$ hadoop fs ???mkdir /tmp/user/hive
$ hadoop fs ???mkdir /tmp/user/hive/warehouse
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
$ insert into test.emp VALUES(1, ???Andy???);
$ insert into test.emp VALUES(2, ???Ramy???);
$ insert into test.emp VALUES(3, ???Youka???);
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
???	Create ???emp???, ???pri_data???, ???pro_data???
???	Put ???emp???, ???1???, ???pri_data:name???, ???Andy???
???	e =get_table
???	e.put ???1???, ???pri_data:age???, ???22???
???	e.put ???1???, ???pro_data:post???, ???asst. manager???
???	e.put ???1???, ???pro_data:salary???, ???40k???
???	e.put ???2???, ???pri_data:name???, ???Icarus???
???	e.put ???2???, ???pri_data:age???, ???22???
???	e.put ???2???, ???pro_data:post???, ???manager???
???	e.get ???1???
???	e.get ???2???
------------------------------------------------------
------PIG-------
(downloadfromwebsite&&extract)
$ sudo tar ???xf pig-0-17.0.tar.gx
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
lines = LOAD ???/home/hadoop/textfile.txt??? AS (line:chararray);
words = FOREACH lines GENERATE FLATTEN(TOKENIZE(line)) as word;
grouped = GROUP words BY word;
wordcount = FOREACH grouped GENERATE group, COUNT(words);
DUMP wordcount;
-------------------------------------------------------------

sudo apt update
sudo apt install default-jdk default-jre -y
java -version; javac ???version
which javac
copy the path
readlink -f /usr/bin/javac    (/usr/bin/javac   path which we have copy)
copy the path before /bin/javac
sudo nano .bashrc 
#Add JAVA_HOME path to .bashrc
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64    (path from which javac)

 2.Install OpenSSH on Ubuntu
sudo apt install openssh-server openssh-client -y

3.Enable Passwordless SSH for Hadoop User
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa

4.Use the cat command to store the public key as authorized_keys in the ssh directory:
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

5.Set the permissions for your user with the chmod command:
chmod 0600 ~/.ssh/authorized_keys

6.SSH to localhost
ssh localhost
7.Download and Install Hadoop on Ubuntu
wget <mirror link>

8.Extract the files
tar xzf hadoop-3.3.0.tar.gz

9.Modify the following files:

            bashrc
            hadoop-env.sh
            core-site.xml
            hdfs-site.xml
            mapred-site-xml
            yarn-site.xml
##.bashrc
sudo nano .bashrc 

add it at the end of the file

#Hadoop Related Options
export HADOOP_HOME=/home/amit/hadoop-3.3.0  
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"

Save it.

Run the command on the terminal to make new environment variables visible.
source ~/.bashrc
##hadoop-env.sh

Uncomment JAVA_HOME by removing # and modify it to
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

##core-site.xml

<configuration>
<property>
  <name>fs.default.name</name>
  <value>hdfs://localhost:9000</value>
</property>
</configuration>

Create a directory for datanodes and namenodes and add its location in hdfs-site.xml

##hdfs-site.xml
<configuration>
<property>
<name>dfs.replication</name>
<value>1</value>
</property>
<property>
<name>dfs.name.dir</name>
<value>file:///home/hadoop/hdfs/namenode</value>
</property>
<property>
<name>dfs.data.dir</name>
<value>file:///home/hadoop/hdfs/datanode</value>
</property>
<property>
<name>dfs.permissions.enabled</name>
<value>false</value>
</property>
</configuration>
##mapred-site-xml

<property> 
  <name>mapreduce.framework.name</name> 
  <value>yarn</value> 
</property> 

##yarn-site.xml

<property>
  <name>yarn.nodemanager.aux-services</name>
  <value>mapreduce_shuffle</value>
</property>
<property>
  <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
  <value>org.apache.hadoop.mapred.ShuffleHandler</value>
</property>
<property>
  <name>yarn.resourcemanager.hostname</name>
  <value>127.0.0.1</value>
</property>
<property>
  <name>yarn.acl.enable</name>
  <value>0</value>
</property>
<property>
  <name>yarn.nodemanager.env-whitelist</name>   
  <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PERPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value>
</property>

10.Format HDFS NameNode
hdfs namenode -format

11.Start Hadoop Cluster
./start-dfs.sh
./start-yarn.sh
jps

12.Access Hadoop UI from Browser

Hadoop NameNode UI: http://localhost:9870	
YARN Resource Manager: http://localhost:8088





