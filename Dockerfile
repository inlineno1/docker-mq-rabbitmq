FROM inlineno1/centos7:0.1

# yum repository erlang add
# 
# [erlang-solutions]
# name=Centos $releasever - $basearch - Erlang Solutions
# baseurl=https://packages.erlang-solutions.com/rpm/centos/$releasever/$basearch
# gpgcheck=1
# gpgkey=https://packages.erlang-solutions.com/rpm/erlang_solutions.asc
# enabled=1
RUN echo -e "\n[erlang-solutions]\nname=Centos \$releasever - \$basearch - Erlang Solutions\nbaseurl=https://packages.erlang-solutions.com/rpm/centos/\$releasever/\$basearch\ngpgcheck=1\ngpgkey=https://packages.erlang-solutions.com/rpm/erlang_solutions.asc\nenabled=1" >> /etc/yum.repos.d/epel.repo

# erlang install
RUN yum -y install erlang

# rabbitmq install
RUN rpm --import https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc
RUN wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.7.4/rabbitmq-server-3.7.4-1.el7.noarch.rpm && \
    yum -y install rabbitmq-server-3.7.4-1.el7.noarch.rpm && rm rabbitmq-server-3.7.4-1.el7.noarch.rpm

# management plugin enable -> http://localhost:15672/
RUN rabbitmq-plugins enable rabbitmq_management

# port
EXPOSE 15672
