FROM ubuntu
MAINTAINER edward.r.robinson@gmail.com

# get some tools - there is probably a nginx container that would be better to use
RUN apt-get -qq update
RUN apt-get -qq -y install vim curl 
RUN apt-get -qq -y install nginx-full
RUN apt-get -qq -y install openssl

# make directory
RUN mkdir -p /var/www/vagrant

# Set owner to www-data
RUN chown -R www-data:www-data /var/www

# Set permissions
RUN chmod -R 0751 /var/www

# add configuration
RUN rm -rf /etc/nginx/sites-enabled/default
ADD vagrant-catalog.com /etc/nginx/sites-available/vagrant-catalog.com
RUN ln -s /etc/nginx/sites-available/vagrant-catalog.com /etc/nginx/sites-enabled/vagrant-catalog.com

# opening port 80 in the container
EXPOSE 80

# set nginx to continue running once container starts
CMD ["nginx","-g", "daemon off;"]

# run the nginx service
ENTRYPOINT service nginx start && tail -f /dev/null
