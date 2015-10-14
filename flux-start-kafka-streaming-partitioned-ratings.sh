cd $PIPELINE_HOME/myapps
echo '...Building and Packaging Streaming App...'
sbt streaming/package

echo '...Starting Spark Ratings Streaming App...'
nohup spark-submit --packages org.apache.spark:spark-streaming-kafka-assembly_2.10:1.4.1,org.apache.kafka:kafka_2.10:0.8.2.1,com.datastax.spark:spark-cassandra-connector-java_2.10:1.4.0-M2 --class com.fluxcapacitor.pipeline.spark.streaming.StreamingRatingsPartitioned $PIPELINE_HOME/myapps/streaming/target/scala-2.10/streaming_2.10-1.0.jar 2>&1 1>$PIPELINE_HOME/logs/streaming/streaming-ratings-partitioned-out.log &
echo '...logs available with tail -f $PIPELINE_HOME/logs/streaming/streaming-ratings-out.log...'
cd $PIPELINE_HOME