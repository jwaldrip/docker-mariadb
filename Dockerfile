FROM jwaldrip/base

# Environment
ENV MYSQL_USER admin
ENV MYSQL_PASS password

# Install
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
RUN add-apt-repository 'deb http://mirror.jmu.edu/pub/mariadb/repo/10.0/ubuntu trusty main'
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server

# Setup
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD create_admin.sh /create_admin.sh
RUN /create_admin.sh

# Run
EXPOSE 3306
ENTRYPOINT mysqld_safe
