FROM ubuntu:18.04

RUN apt-get update \
    && apt-get -y install curl git python3 python3-pip default-jdk \
    && cd /opt \
    && wget http://apachemirror.wuchna.com//activemq/5.15.12/apache-activemq-5.15.12-bin.tar.gz \
    && tar zxf apache-activemq-5.15.12-bin.tar.gz \
    && ln -s /opt/apache-activemq-5.15.12 activemq \
    && git clone https://github.com/mosip/abis-testing-kit.git \
    && cd /opt/abis-testing-kit \
    && pip3 install -r requirements.txt

COPY .env /opt/abis-testing-kit/.env
COPY sample_data/ /opt/abis-testing-kit/src/store/
EXPOSE 8000

RUN ["chmod", "+x", "/opt/abis-testing-kit/src/run.sh"]
ENTRYPOINT [".", "./run.sh"]
