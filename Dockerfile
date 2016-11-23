FROM wordpress
WORKDIR /tmp

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x /tmp/wp-cli.phar
RUN mv /tmp/wp-cli.phar /usr/local/bin/wp

ADD ./resources /tmp/resources

ADD ./cityscope-entrypoint.sh /cityscope-entrypoint.sh
ADD ./apache2dummy /usr/local/bin/apache2dummy

RUN sed -i -e "s#/var/www/html#/var/www/html/wordpress#g" /etc/apache2/sites-available/000-default.conf

ENTRYPOINT [ "/cityscope-entrypoint.sh", "/entrypoint.sh", "apache2dummy" ]
