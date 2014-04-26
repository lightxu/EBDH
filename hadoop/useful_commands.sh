rm -rf BookRecordBackup
hadoop dfs -rmr /user/hadoop/backup
mkdir BookRecordBackup
javac -classpath /home/hadoop/bin/hadoop/hadoop-core-1.2.1.jar:/home/hadoop/bin/hadoop/lib/commons-cli-1.2.jar -d BookRecordBackup BookRecordBackup.java
jar -cvf BookRecordBackup.jar -C BookRecordBackup .
hadoop jar BookRecordBackup.jar com.lightxu.BookRecordBackup /user/hadoop/large_size.csv /user/hadoop/backup

awk '{printf "%d %s\n", NR, $0}' < sample.csv
