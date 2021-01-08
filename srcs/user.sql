-- Create MySQL user for PhpMyAdmin
CREATE USER 'rbourgea'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'rbourgea'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;