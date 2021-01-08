# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    init.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rbourgea <rbourgea@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/01/29 11:32:12 by rbourgea          #+#    #+#              #
#    Updated: 2020/01/29 18:46:54 by rbourgea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

INDEX=ON

#!/bin/bash

service php7.3-fpm start
service mysql start

mysql < /var/db_wp.sql
mysql < /var/user.sql

if [ "$INDEX" = "ON" ]; then
    mv /var/index.html /var/www/html
fi

nginx -g "daemon off;"
