#FROM centos:7
FROM eeacms/centos:7s
MAINTAINER "Vitalie Maldur" <vitalie.maldur@eaudeweb.ro>
MAINTAINER "Alin Voinea" <alin.voinea@eaudeweb.ro>

ENV UID 500
ENV USER apache
ENV PYTHON python

RUN curl https://bootstrap.pypa.io/get-pip.py | python3.4 && \
    pip3 install chaperone

COPY chaperone.conf     /etc/chaperone.d/chaperone.conf
COPY conf.d/virtual-host.conf /etc/httpd/conf/
COPY conf.d/httpd.conf /etc/httpd/conf/

RUN useradd -u $UID -m -s /bin/bash $USER
RUN yum -y updateinfo
RUN yum -y install httpd \
  mod_ldap \
  mod_session \
  mod_ssl

# Cleanup cache
RUN yum clean all; rm -rf /tmp/* /var/tmp/*

RUN chown -R $UID:$UID /var/log /etc/httpd 

EXPOSE 8080

ENTRYPOINT ["/usr/bin/chaperone"]
#CMD ["--user", "apache"]
