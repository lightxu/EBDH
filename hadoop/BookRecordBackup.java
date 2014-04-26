package com.lightxu;
        
import java.io.*;
import java.util.*;
import java.net.URI;
        
import org.apache.hadoop.fs.*;
import org.apache.hadoop.conf.*;
import org.apache.hadoop.io.*;
import org.apache.hadoop.util.*;
import org.apache.hadoop.mapreduce.*;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;
        
public class BookRecordBackup {
 public final static int blockSize = 10000;
 
 public static class Map extends Mapper<LongWritable, Text, LongWritable, Text> {
    private Text word = new Text();
        
    public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
        String line = value.toString();
        LongWritable block_id = new LongWritable(Long.parseLong(line.substring(0, line.indexOf(" "))) / blockSize);
        context.write(block_id, value);
    }
 } 
        
 public static class Reduce extends Reducer<LongWritable, Text, NullWritable, NullWritable> {

    public void reduce(LongWritable key, Iterable<Text> values, Context context) 
      throws IOException, InterruptedException {
        Configuration conf = context.getConfiguration();

        String file_prefix = conf.get("backup.file.prefix");
        String file_path = file_prefix + "/" + key.toString();
        FileSystem fs = FileSystem.get(URI.create(file_path), conf);
        OutputStream out = fs.create(new Path(file_path));

        for (Text value : values) {
          out.write(value.toString().getBytes("UTF-8"));
        }
        out.flush();
        out.close();
        context.write(null, null);
    }
 }
        
 public static void main(String[] args) throws Exception {
    Configuration conf = new Configuration();
    String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
    if (otherArgs.length != 2) {
      System.err.println("Usage: BookRecordBackup <in> <out>");
      System.exit(2);
    }
    conf.set("backup.file.prefix", otherArgs[1]);
        
    Job job = new Job(conf, "book record backup");

    job.setJarByClass(BookRecordBackup.class);
    
    job.setMapperClass(Map.class);
    job.setReducerClass(Reduce.class);
        
    job.setInputFormatClass(TextInputFormat.class);
    job.setMapOutputKeyClass(LongWritable.class);
    job.setMapOutputValueClass(Text.class);
    job.setOutputKeyClass(NullWritable.class);
    job.setOutputValueClass(NullWritable.class);
        
    FileInputFormat.addInputPath(job, new Path(otherArgs[0]));
    FileOutputFormat.setOutputPath(job, new Path(otherArgs[1]));
        
    System.exit(job.waitForCompletion(true) ? 0 : 1);
 }
        
}
