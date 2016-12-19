# cityscope-wordpress
Docker image for wordpress tailored for Cityscope workbench
This extends [the official wordpress image in Dockerhub](https://hub.docker.com/_/wordpress/) 
The extension automtically installs wordpress using the wp-cli interface with username and credentials passed in from the Cityscope workbench
A set of plugins are also installed to make the auto generated blog work with the [Curious Edinburgh](curiousedinburgh.org) app. 

# Entrypoint scripts

There are three scripts here that are ran whenever a container is started:

* docker-entrypoint.sh comes from the parent Docker image, and it essentially installs Wordpress and does some basic configuration, before running Apache
* /cityscope-entrypoint.sh does some pre-preparation that has to be done *before* Wordpress is installed
* apache2dummy does configuration of the template application, and has to be done *after* Wordpress is installed. The odd name, and the fact it's on the PATH, is because docker-entrypoint.sh checks the name of the scripts passed to it

# Building / running

Normally, this image is built automatically and can be found in [Dockerhub](https://hub.docker.com/r/cityscope/wordpress/).
Similarly, it's normally run via Jupyterhub.
The below commands are for development purposes.

    docker build -t cityscope/wordpress .
    docker run -d -v "$PWD/data:/data" --user 1000 -e "MYSQL_ROOT_PASSWORD=password" --name mysql_test mysql mysqld --datadir /data/mysql --innodb-buffer-pool-size=5M --innodb-log-buffer-size=256K --query-cache-size=0 --max-connections=10 --key-buffer-size=8 --thread-cache-size=0 --host-cache-size=0 --innodb-ft-cache-size=1600000 --innodb-ft-total-cache-size=32000000 --thread-stack=131072 --sort-buffer-size=32K --read-buffer-size=8200 --read-rnd-buffer-size=8200 --max-heap-table-size=16K --tmp-table-size=1K --bulk-insert-buffer-size=0 --join-buffer-size=128 --net-buffer-length=1K --innodb-sort-buffer-size=64K --binlog-cache-size=4K --binlog-stmt-cache-size=4K
    docker run -d -v "$PWD/data:/data" --link mysql_test:mysql -p 45000:80 --name wordpress_test cityscope/wordpress -baseurl $( hostname -f ):45000 -credential password -username wordpress

