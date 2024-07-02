FROM mcr.microsoft.com/mssql/server:2019-CU27-ubuntu-20.04
USER root
RUN mkdir /opt/docker && mkdir /start-scripts && chown mssql /var
COPY docker/common /opt/docker/common
RUN find /opt/docker/common -name "*.sh" | xargs chmod +x
EXPOSE 1433
USER mssql
CMD /opt/docker/common/setup.sh --renew

