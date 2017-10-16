FROM phusion/baseimage:0.9.22

RUN apt-get update \
    && apt-get install -y --auto-remove --no-install-recommends curl openjdk-8-jdk libgfortran3 python-pip git wget nano ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PIO_VERSION 0.11.0
ENV SPARK_VERSION 1.6.3
ENV JDBC_PGSQL_VERSION 42.1.4

ENV PIO_HOME /opt/pio
ENV PATH=${PIO_HOME}/bin:$PATH
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

RUN cd /tmp && \
	curl -L https://github.com/apache/incubator-predictionio/archive/v${PIO_VERSION}-incubating.tar.gz -o pio.tar.gz \
    && mkdir pio \
    && tar -xzf pio.tar.gz -C pio \
    && cd pio/incubator-predictionio-${PIO_VERSION}-incubating \
	&& ./make-distribution.sh -Dscala.version=2.10.6 -Dspark.version=${SPARK_VERSION}

RUN mkdir ${PIO_HOME} && \
	tar -zxf /tmp/pio/incubator-predictionio-${PIO_VERSION}-incubating/PredictionIO-${PIO_VERSION}-incubating.tar.gz --strip-components=1 -C ${PIO_HOME} && \
	mkdir ${PIO_HOME}/vendors

RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_VERSION}-bin-hadoop2.6.tgz -O /tmp/spark.tar.gz && \
    tar -xvzf /tmp/spark.tar.gz -C ${PIO_HOME}/vendors

RUN cd ${PIO_HOME}/vendors && curl -O https://jdbc.postgresql.org/download/postgresql-${JDBC_PGSQL_VERSION}.jar

RUN pip install --upgrade pip && \
	pip install -U setuptools && \
	pip install wheel predictionio

RUN rm -rf /tmp/* && \
	rm -rf /etc/service/{cron,syslog-forwarder,syslog-ng,sshd}

COPY files/pio_event_service /etc/service/pio_event/run
COPY files/pio_query_service /etc/service/pio_query/run
COPY universal-recommender /root/ur
COPY files/import_likes_data.sh /root/ur/examples/import_likes_data.sh
