if [ ! -f example/boxes/Snappy_0.0.1.box ]; then
    mkdir -p example/boxes
    curl --output example/boxes/Snappy_0.0.1.box https://dl.dropboxusercontent.com/s/cd9cfhrmraif1op/Snappy.box
fi
docker kill vagrant-catalog
docker rm vagrant-catalog
docker build -t vagrant-catalog .
docker run -v example:/var/www/vagrant/example -p 80:80 -d --name vagrant-catalog vagrant-catalog
#docker run -p 80:80 -d --name my-running-app my-php-app /etc/init.d/apache2 start
#docker run -p 80:80 -d --name my-running-app my-php-app
docker exec -it vagrant-catalog bash
