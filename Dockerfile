FROM phusion/baseimage:0.9.22

MAINTAINER Thomas Decaux

RUN apt-get update \
    && apt-get install -y --auto-remove --no-install-recommends curl openjdk-8-jdk libgfortran3 python-pip git wget nano ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PIO_VERSION 0.11.0
ENV SPARK_VERSION 2.1.1
ENV ELASTICSEARCH_VERSION 5.5.0

ENV PIO_HOME /opt/pio
ENV PATH=${PIO_HOME}/bin:$PATH
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

RUN cd /tmp && \
	wget http://mirror.nexcess.net/apache/incubator/predictionio/${PIO_VERSION}-incubating/apache-predictionio-${PIO_VERSION}-incubating.tar.gz -O pio.tar.gz \
    && mkdir pio \
    && tar -xzf pio.tar.gz -C pio \
    && cd pio \
	&& ./make-distribution.sh -Dscala.version=2.11.8 -Dspark.version=${SPARK_VERSION} -Delasticsearch.version=${ELASTICSEARCH_VERSION}

RUN mkdir ${PIO_HOME} && \
	tar -zxf /tmp/pio/PredictionIO-${PIO_VERSION}-incubating.tar.gz --strip-components=1 -C ${PIO_HOME} && \
	mkdir ${PIO_HOME}/vendors

RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_VERSION}-bin-hadoop2.6.tgz -O /tmp/spark.tar.gz && \
    tar -xvzf /tmp/spark.tar.gz -C ${PIO_HOME}/vendors

RUN pip install --upgrade pip && \
	pip install -U setuptools && \
	pip install wheel predictionio

RUN rm -rf /tmp/* && \
	rm -rf /etc/service/{cron,syslog-forwarder,syslog-ng,sshd}

COPY files/pio_event_service /etc/service/pio_event/run

HEALTHCHECK --interval=30s --timeout=30s --retries=3 \
  CMD curl -si localhost:7070/health | grep 'HTTP/1.1 200 OK' > /dev/null