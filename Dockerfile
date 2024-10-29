FROM mcr.microsoft.com/mssql/server:2022-latest

USER root

RUN apt-get -y upgrade  && apt-get -y update  && apt-get -y install vim dos2unix unzip

RUN mkdir /root/sqlpackage && \
    wget https://aka.ms/sqlpackage-linux -O /tmp/sqlpackage.zip && \
    unzip /tmp/sqlpackage.zip -d /root/sqlpackage && \
    chmod a+x /root/sqlpackage/sqlpackage
RUN mv /opt/mssql-tools18 /opt/mssql-tools/

RUN mkdir /opt/docker
COPY docker/common /opt/docker/common
RUN find /opt/docker/common -name "*.sh" | xargs dos2unix
RUN find /opt/docker/common -name "*.sh" | xargs chmod +x
EXPOSE 1433
