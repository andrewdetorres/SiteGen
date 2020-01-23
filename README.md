# SiteGen 

A bash script that can be used to auto deploy a simple site to deploy a basic site.

## Using SiteGen

Below is a list of instruction that can be used to deploy your new site on your linux machine.

### Prerequisites

Please insure that you are running nginx 1.14.0 or above
```
sudo apt update
sudo apt install nginx
```

### System File Structure

This script runs based on the following server setup.
```
├┬ /var/www/html
│└  \[SITE_NAME\]
│
├┬ /etc/nginx/sites-available
│└ \[SITE_NAME\]
│
├┬ /etc/nginx/sites-enabled
│└ \[SITE_NAME\]
```

### Nginx Configuration

Please ensure that the Nginx configuration sutis your requirements.

```
server {
	server_name SITENAME  www.SITENAME;
	root /var/www/html/SITENAME/public_html;

	index index.php index.html index.htm index.nginx-debian.html;

	location / {
		try_files $uri $uri/ /index.php?$args;
	}

	location ~ \.php$ {
		include snippets/fastcgi-php.conf;
		fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
	}

	location ~ /\.ht {
		deny all;
	}

  error_log /var/www/html/SITENAME/logs/error.log;
  access_log /var/www/html/SITENAME/logs/access.log;
}
```

# Authors
Andrew De Torres - [@andrewdetorres](https://github.com/andrewdetorres)
See also the list of [contributors](https://github.com/andrewdetorres/SiteGen/graphs/contributors) who participated in this project.

With thanks to Reece Benson for the idea - [@reecebenson](https://github.com/reecebenson)

# License
This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/andrewdetorres/SiteGen/blob/master/LICENSE.md) file for details