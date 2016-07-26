# To test
# docker build -t foo
# docker run -it --rm -p 8080:80 foo

FROM oraclelinux:6.7
WORKDIR /root

# php.ini
COPY conf/php.ini /usr/local/etc/php/php.ini

# os
RUN yum update -y
RUN yum install wget tar perl make gcc openssl openssl-devel libxml2-devel curl-devel libc-client llibc-client-devel gd gd-devel nodejs git bzip2 httpd -y

# php install
COPY php-5.6.24.tar.bz2 /root/
RUN tar -jxvf php-5.6.24.tar.bz2

RUN cd php-5.6.24 && ./configure && make && make install

# php extensions

# <!--
#   php56 @5.6.22_0+libedit (active)
#   php56-apache2handler @5.6.22_0 (active)
#   php56-curl @5.6.22_0 (active)
#   php56-iconv @5.6.22_0 (active)
#   php56-igbinary @1.2.1_0 (active)
#   php56-ldap @5.6.22_0 (active)
#   php56-mbstring @5.6.22_0 (active)
#   php56-mcrypt @5.6.22_0 (active)
#   php56-memcached @2.1.0_1 (active)
#   php56-mysql @5.6.22_0+mysqlnd (active)
#   php56-openssl @5.6.22_0 (active)
#   php56-posix @5.6.22_0 (active)
#   php56-soap @5.6.22_0 (active)
#   php56-xdebug @2.4.0_0 (active)
#   php_select @1.0_0 (active)
#  -->

# EXPOSE 80

# setup domains
# TODO: The web server installs itself to /etc/httpd
COPY conf/api.conf /etc/apache2/sites-available/
COPY conf/app.conf /etc/apache2/sites-available/

CMD ["/usr/sbin/apachectl", "-DFOREGROUND"]