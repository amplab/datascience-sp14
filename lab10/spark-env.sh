#!/usr/bin/env bash

# This file contains environment variables required to run Spark. Copy it as
# spark-env.sh and edit that to configure Spark for your site.
#
# The following variables can be set in this file:
# - SPARK_LOCAL_IP, to set the IP address Spark binds to on this node
# - MESOS_NATIVE_LIBRARY, to point to your libmesos.so if you use Mesos
# - SPARK_JAVA_OPTS, to set node-specific JVM options for Spark. Note that
#   we recommend setting app-wide options in the application's driver program.
#     Examples of node-specific options : -Dspark.local.dir, GC options
#     Examples of app-wide options : -Dspark.serializer
#
# If using the standalone deploy mode, you can also set variables for it here:
# - SPARK_MASTER_IP, to bind the master to a different IP address or hostname
# - SPARK_MASTER_PORT / SPARK_MASTER_WEBUI_PORT, to use non-default ports
# - SPARK_WORKER_CORES, to set the number of cores to use on this machine
# - SPARK_WORKER_MEMORY, to set how much memory to use (e.g. 1000m, 2g)
# - SPARK_WORKER_PORT / SPARK_WORKER_WEBUI_PORT
# - SPARK_WORKER_INSTANCES, to set the number of worker processes per node

SPARK_JAVA_OPTS="-Dspark.local.dir=/tmp "
SPARK_JAVA_OPTS+="-Xmx2G -XX:MaxPermSize=350m -XX:ReservedCodeCacheSize=256m   "
SPARK_JAVA_OPTS+="-Dhadoop.security.authentication=simple "
SPARK_JAVA_OPTS+="-Djava.security.krb5.realm=berkeley.edu -Djava.security.krb5.kdc=kdc.berkeley.edu "
#"-Djava.security.krb5.realm=OX.AC.UK -Djava.security.krb5.kdc=kdc0.ox.ac.uk:kdc1.ox.ac.uk "
#SPARK_JAVA_OPTS+="-Dspark.serializer=org.apache.spark.serializer.KryoSerializer "
#SPARK_JAVA_OPTS+="-Dspark.kryo.registrator=org.apache.spark.graphx.GraphKryoRegistrator  "
#SPARK_JAVA_OPTS+="-Dspark.kryoserializer.buffer.mb=10 "
export SPARK_JAVA_OPTS

export SPARK_WORKER_MEMORY=1G

export SPARK_WORKER_CORES=1
export SPARK_LOCAL_IP=127.0.0.1
