FROM ubuntu
#FROM linode/lamp
#FROM php:7.0-apache
RUN apt-get -qq update
RUN apt-get -qq -y install vim curl 
RUN apt-get -qq -y install nginx-full
RUN apt-get -qq -y install openssl

RUN mkdir -p /var/www/vagrant
# Set owner to www-data
RUN chown -R www-data:www-data /var/www
# Set permissions
RUN chmod -R 0751 /var/www
RUN rm -rf /etc/nginx/sites-enabled/default
ADD vagrant-catalog.com /etc/nginx/sites-available/vagrant-catalog.com
RUN ln -s /etc/nginx/sites-available/vagrant-catalog.com /etc/nginx/sites-enabled/vagrant-catalog.com


# Create folders
#RUN mkdir -p /var/www/vagrant/example/boxes
#RUN curl --output /var/www/vagrant/example/boxes/Snappy_0.0.1.box https://dl.dropboxusercontent.com/s/cd9cfhrmraif1op/Snappy.box
#ADD example.json /var/www/vagrant/example/example.json

# to remove the example box
# rm -rf /var/www/vagrant/example






#RUN apt-get -qq update
#RUN apt-get -qq -y install zip unzip apache2 curl
#RUN apt-get -qq -y install php7.0
#RUN apt-get -qq -y install phpunit

#COPY composer.sh /tmp
#RUN /tmp/composer.sh
#RUN cp composer.phar /usr/bin/composer
#RUN chmod a+rwx /usr/bin/composer
#RUN composer --version

#RUN echo $PATH
#RUN cd /var/www/html && pwd
#RUN cd /var/www/html && composer update

#ENV COMPOSER_VERSION 1.1.2
# Install Composer
#RUN php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION} && rm -rf /tmp/composer-setup.php

# Display version information.
#CMD ["/etc/init.d/apache2 start"]
EXPOSE 80
#ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]
#CMD ["/etc/init.d/apache2 start", "-b", "0.0.0.0"]
#CMD service apache2 start && tail -F /dev/null
CMD ["nginx","-g", "daemon off;"]
ENTRYPOINT service nginx start && tail -f /dev/null
#MAINTAINER all@cpointe-inc.com
#https://docs.docker.com/engine/admin/using_supervisord/

#RUN apt-get update && apt-get install -y openssh-server apache2 supervisor
#RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor

#COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#EXPOSE 22 80
#CMD ["/usr/bin/supervisord"]

# Composer Docker Container
#FROM composer/composer:base-php5-alpine
#MAINTAINER Rob Loach <robloach@gmail.com>

#ENV COMPOSER_VERSION 1.1.2

# Install Composer
#RUN php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION} && rm -rf /tmp/composer-setup.php

# Display version information.
#RUN composer --version
