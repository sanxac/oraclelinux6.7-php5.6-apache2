# To test
# docker build -t foo
# docker run -it --rm -p 8080:80 foo

FROM oraclelinux:6.7
WORKDIR /root

# os
RUN yum update -y
RUN yum install wget tar perl make gcc openssl openssl-devel libxml2-devel curl-devel libc-client llibc-client-devel gd gd-devel nodejs git bzip2 httpd -y

# php install
COPY php-5.6.24.tar.bz2 /root/
RUN tar -jxvf php-5.6.24.tar.bz2

# from apt-get docker box:
# ./configure --with-apxs2 --disable-cgi --enable-mysqlnd --enable-mbstring --with-curl --with-libedit --with-openssl

# needs to be built with apxs but it does not work (not found)
RUN cd php-5.6.24 && ./configure && make && make install

# php extensions
RUN yum install php-common php-mysql php-pecl-memcache php-ldap php-mbstring php-process -y

# php.ini
COPY php.ini /usr/local/etc/php/php.ini

# Edit your httpd.conf to load the PHP module. The path on the right hand side of the LoadModule statement must point to the path of the PHP module on your system. The make install from above may have already added this for you, but be sure to check.
# LoadModule php5_module modules/libphp5.so

# Tell Apache to parse certain extensions as PHP.
# <FilesMatch \.php$>
#    SetHandler application/x-httpd-php
# </FilesMatch>



CMD ["/usr/sbin/apachectl", "-DFOREGROUND"]
