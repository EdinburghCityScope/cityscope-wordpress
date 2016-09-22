FROM wordpress
WORKDIR /tmp
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x /tmp/wp-cli.phar
RUN mv /tmp/wp-cli.phar /usr/local/bin/wp
ADD ./benbutcharttourblog.wordpress.2016-09-02.xml /tmp/benbutcharttourblog.wordpress.2016-09-02.xml
ADD ./apache2dummy /tmp/apache2dummy
ADD ./RCS-museum.jpg /tmp/RCS-museum.jpg
ADD ./robert-knox-2.jpg /tmp/robert-knox-2.jpg
ADD ./surgeons-hall.jpg /tmp/surgeons-hall.jpg
ADD ./old-college.jpg /tmp/old-college.jpg
ADD ./Apple_App_Store_Logo1.gif /tmp/Apple_App_Store_Logo1.gif
ADD ./PhoneSplash.png /tmp/PhoneSplash.png
ADD ./PhoneMap.png /tmp/PhoneMap.png
ADD ./PhoneList.png /tmp/PhoneList.png
ADD ./suffusion /var/www/html/wp-content/themes/suffusion
RUN chmod +x /tmp/apache2dummy
RUN mv /tmp/apache2dummy /usr/local/bin/apache2dummy
WORKDIR /var/www/html
ENTRYPOINT ["/entrypoint.sh" , "apache2dummy"]
