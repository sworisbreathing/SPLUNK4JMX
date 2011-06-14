#!/bin/sh
### ====================================================================== ###
##                                                                          ##
##  Start Script for JMX MBean Poller                                       ##
##                                                                          ##
### ====================================================================== ###
CONFIG_FILE_NAME=$1

# Setup the JVM
if [ "x$JAVA" = "x" ]; then
    if [ "x$JAVA_HOME" != "x" ]; then
	JAVA="$JAVA_HOME/bin/java"
    else
	JAVA="java"
    fi
fi


SPLUNK4JMX_HOME=$SPLUNK_HOME/etc/apps/SPLUNK4JMX
MAIN_CLASS=com.dtdsoftware.splunk.JMXMBeanPoller
LIB_DIR=$SPLUNK4JMX_HOME/bin/lib
POLLER_JARS=$LIB_DIR/castor-1.3-core.jar:$LIB_DIR/castor-1.3-xml.jar:$LIB_DIR/commons-logging-1.1.1.jar:$LIB_DIR/jmxpoller.jar:$LIB_DIR/tools-lin.jar:$LIB_DIR/log4j-1.2.15.jar:$LIB_DIR/xercesImpl.jar
JVM_MEMORY="-Xms64m -Xmx64m"
JAVA_OPTS="$JVM_MEMORY"
CONFIG_XML=$SPLUNK4JMX_HOME/bin/config/$CONFIG_FILE_NAME


"$JAVA" -Dsplunk4jmx.home=$SPLUNK4JMX_HOME $JAVA_OPTS -classpath $LIB_DIR:$POLLER_JARS $MAIN_CLASS $CONFIG_XML
