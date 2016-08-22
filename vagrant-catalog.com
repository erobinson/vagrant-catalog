server {
    listen   80 default_server;
    listen   [::]:80 ipv6only=on default_server;

    server_name vagrant-catalog.com vagrant-catalog 192.168.99.100;

    root /var/www;

    # Match the box name in location and search for its catalog
    # e.g. http://www.example.com/vagrant/devops/ resolves /var/www/vagrant/devops/devops.json  
    location ~ ^/vagrant/([^\/]+)/$ {
        index $1.json;
        try_files $uri $uri/ $1.json =404;
        autoindex off;
    }

    # Enable auto indexing for the folder with box files
    location ~ ^/vagrant/([^\/]+)/boxes/$ {
        try_files $uri $uri/ =404;
        autoindex on;
        autoindex_exact_size on;
        autoindex_localtime on;
    }

    # Serve json files with content type header application/json
    location ~ \.json$ {
        add_header Content-Type application/json;
    }

    # Serve box files with content type application/octet-stream
    location ~ \.box$ {
        add_header Content-Type application/octet-stream;
    }

    # Deny access to document root and the vagrant folder
    location ~ ^/(vagrant/)?$ {
        return 403;
    }
}
