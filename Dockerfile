FROM wordpress
WORKDIR /tmp
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x /tmp/wp-cli.phar
RUN mv /tmp/wp-cli.phar /usr/local/bin/wp
ADD ./curiousedinburgh.wordpress.2016-06-21.xml /tmp/curiousedinburgh.wordpress.2016-06-21.xml
ADD ./apache2dummy /tmp/apache2dummy
RUN chmod +x /tmp/apache2dummy
RUN mv /tmp/apache2dummy /usr/local/bin/apache2dummy
WORKDIR /var/www/html
ENTRYPOINT ["/entrypoint.sh" , "apache2dummy"]
