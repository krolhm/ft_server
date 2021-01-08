# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rbourgea <rbourgea@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/01/29 11:32:20 by rbourgea          #+#    #+#              #
#    Updated: 2020/01/29 18:07:20 by rbourgea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# ADD DEBIAN IMAGE
FROM debian:buster

# ADD USER INFO
LABEL maintaner="rbourgea" \
    mail="<rbourgea@student.42.fr>" \
    name="ft_server"

# ADD WGET + NGINX + MARIADB + PHP7
RUN		apt-get update -y \
		&& apt-get upgrade -y \
		&& apt-get install wget -y \
		&& apt-get install nginx -y \
		&& apt-get install mariadb-server -y \
		&& apt-get -y install php7.3 php-mysql php-fpm php-cli php-mbstring -y

COPY	./srcs/* /var/

WORKDIR	/var/www/html

# CONFIG PHPMYADMIN
RUN		wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz \
		&& tar xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz \
		&& rm -rf phpMyAdmin-4.9.0.1-all-languages.tar.gz \
		&& mv phpMyAdmin-4.9.0.1-all-languages phpmyadmin \
		&& chmod 777 -R /var/www/html/phpmyadmin

# ADD WORDPRESS
RUN		wget https://wordpress.org/latest.tar.gz \
		&& tar xf latest.tar.gz \
		&& rm -rf latest.tar.gz \
		&& chmod 777 -R /var/www/html/wordpress

RUN		cp /var/localhost /etc/nginx/sites-available/localhost \
		&& ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost \
		&& rm /etc/nginx/sites-enabled/default

#certificat ssl
RUN		openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75/L=Paris/O=42/CN=rbourgea' -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

RUN		chmod 777 -R /var/init.sh
CMD		sh /var/init.sh

EXPOSE	80 443