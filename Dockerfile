FROM mcr.microsoft.com/mssql/server:2019-CU5-ubuntu-18.04
USER root
RUN apt-get -y upgrade  && apt-get -y update  && apt-get -y install vim dos2unix
RUN mkdir /opt/docker
COPY docker/common /opt/docker/common
RUN find /opt/docker/common -name "*.sh" | xargs dos2unix
RUN find /opt/docker/common -name "*.sh" | xargs chmod +x
EXPOSE 1433
USER mssql
CMD /opt/docker/common/setup.sh --renew

