FROM centos:7

RUN yum install -y epel-release
RUN yum -y update
RUN yum install -y proftpd proftpd-ldap vim ftp

RUN groupadd ftpgroup
RUN useradd -g ftpgroup -s /sbin/nologin -d /srv/ftpuser ftpuser

RUN export uid=$(id -u ftpuser)
RUN export gid=$(id -g ftpuser)

# copy the proftpd.conf file to /etc/proftpd.conf
COPY proftpd.conf /etc/proftpd.conf
COPY run.sh /run.sh
RUN chmod +x /run.sh

#start the server
CMD /run.sh

EXPOSE 20 21 60000-60009
