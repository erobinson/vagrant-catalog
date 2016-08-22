# downloads the example vagrant box
if [ ! -f example/boxes/Snappy_0.0.1.box ]; then
    mkdir -p example/boxes
    curl --output example/boxes/Snappy_0.0.1.box https://dl.dropboxusercontent.com/s/cd9cfhrmraif1op/Snappy.box
fi

# kill any previously running catalog container
docker kill vagrant-catalog
docker rm vagrant-catalog

# build docker container
docker build -t vagrant-catalog .

# run docker container
# -v -- used to map boxes - should be updated to map desired boxes
# -p - opening port 80
# --name - running as vagrant-catalog to be able to get a bash prompt once launched and destroy easily
docker run -v example:/var/www/vagrant/example -p 80:80 -d --name vagrant-catalog vagrant-catalog

# start a bash prompt inside the container
docker exec -it vagrant-catalog bash
