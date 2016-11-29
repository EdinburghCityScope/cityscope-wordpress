FROM wordpress
WORKDIR /tmp

# Due to our use of volumes and NFS, we need all the user files to be owned by uid 1000, but Apache is configured to run everything as the www-data user (uid 33), so we need to change that user's ID
RUN usermod -u 1000 www-data
RUN groupmod -g 1000 www-data

RUN chown -Rhc --from=33 1000 /usr /var
RUN chown -Rhc --from=:33 :1000 /usr /var

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x /tmp/wp-cli.phar
RUN mv /tmp/wp-cli.phar /usr/local/bin/wp

ADD ./resources /tmp/resources

ADD ./cityscope-entrypoint.sh /cityscope-entrypoint.sh
ADD ./apache2dummy /usr/local/bin/apache2dummy

RUN sed -i -e "s#/var/www/html#/var/www/html/wordpress#g" /etc/apache2/sites-available/000-default.conf

# The default entrypoint will try to change the owner of the files to www-data, but this seems to fail (even though it's running as root, and the files are already owned by www-data)
# This appears to be NFS-related, and the easiest way to get round it is to prevent /entrypoint from trying to change ownership
RUN sed -i -e "s#tar xf#tar x --no-same-owner -f#" /entrypoint.sh
RUN sed -i -e "/chown www-data/d" /entrypoint.sh

ENTRYPOINT [ "/cityscope-entrypoint.sh", "/entrypoint.sh", "apache2dummy" ]
