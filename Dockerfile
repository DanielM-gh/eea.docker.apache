FROM httpd:2.4
MAINTAINER "Vitalie Maldur" <vitalie.maldur@eaudeweb.ro>
MAINTAINER "Alin Voinea" <alin.voinea@eaudeweb.ro>

ENV UID 500
ENV USER www-data
ENV PYTHON python

RUN curl https://bootstrap.pypa.io/get-pip.py | python3.4 && \
#    pip3 install chaperone

COPY chaperone.conf     /etc/chaperone.d/chaperone.conf
COPY conf.d/virtual-host.conf /etc/httpd/conf/
COPY conf.d/httpd.conf /etc/httpd/conf/


RUN chown -R $UID:$UID /var/log /etc/httpd /run/httpd

EXPOSE 8080

ENTRYPOINT ["/usr/bin/chaperone"]
CMD ["--user", "apache"]
