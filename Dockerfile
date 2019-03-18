FROM openjdk:8u181-jdk-stretch

LABEL MAINTAINER=fx19880617@gmail.com

ENV PINOT_BRANCH=master
ENV PINOT_HOME=/opt/pinot

# extra dependency for running launcher
RUN apt-get update && apt-get install -y --no-install-recommends \
		vim wget curl git maven\
	&& rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/apache/incubator-pinot.git /opt/incubator-pinot  && \
    cd /opt/incubator-pinot && \
    git checkout ${PINOT_BRANCH} && \
    mvn install package -DskipTests -Pbin-dist && \
    mkdir -p ${PINOT_HOME}/configs && \
    mkdir -p ${PINOT_HOME}/data && \
    cp -r pinot-distribution/target/apache-pinot-incubating-*-bin/apache-pinot-incubating-*-bin/* ${PINOT_HOME}/. && \
	chmod +x ${PINOT_HOME}/bin/*.sh

COPY configs ${PINOT_HOME}/configs

VOLUME ["${PINOT_HOME}/configs", "${PINOT_HOME}/data"]

WORKDIR ${PINOT_HOME}

ENTRYPOINT ["./bin/pinot-admin.sh"]

CMD ["run"]
