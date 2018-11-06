FROM anapsix/alpine-java

ENV SONAR_SCANNER_VERSION 3.2.0.1227

RUN apk add --update ca-certificates openssl curl nodejs unzip

WORKDIR /root

RUN wget -O /root/sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip

RUN unzip sonar-scanner.zip

RUN mv /root/sonar-scanner-${SONAR_SCANNER_VERSION}-linux /root/sonar-scanner
RUN rm /root/sonar-scanner.zip

ADD runner.sh /usr/bin/runner.sh
RUN chmod +x /usr/bin/runner.sh
