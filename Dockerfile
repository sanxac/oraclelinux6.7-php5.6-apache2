# To test
# docker build -t foo
# docker run -it --rm -p 8080:80 foo

FROM oraclelinux:6.7
WORKDIR /root

# os
RUN yum update -y
RUN yum install wget tar perl make gcc openssl openssl-devel libxml2-devel curl-devel libc-client llibc-client-devel gd gd-devel nodejs git bzip2 httpd-devel -y

# php install
COPY php-5.6.24.tar.bz2 /root/
RUN tar -jxvf php-5.6.24.tar.bz2

RUN cd php-5.6.24 && ./configure --with-apxs2=/usr/sbin/apxs --disable-cgi --enable-mysqlnd --enable-mbstring --with-curl --with-openssl && make && make install

# php extensions
RUN yum install php-common php-mysql php-pecl-memcache php-ldap php-mbstring php-process -y

# php.ini
COPY php.ini /usr/local/lib/php.ini

# httpd.conf to load the PHP module. The path on the right hand side of the LoadModule statement must point to the path of the PHP module on your system. The make install from above may have already added this for you, but be sure to check.
# Verify path to module
# not installed.  something like apt-get install libapache2-mod-php5

COPY docker.conf /etc/httpd/conf.d

CMD ["/usr/sbin/apachectl", "-DFOREGROUND"]
