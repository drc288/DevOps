-- to set up replication, 
-- you’ll need to have a database with at least one table and one row in your primary MySQL server (web-01)
-- create a database, a table and one entry it
CREATE DATABASE IF NOT EXISTS devopsers_corp;
CREATE TABLE IF NOT EXISTS nexus6 (id INT, name VARCHAR(256));
INSERT INTO `halley` (`id`, `name`) VALUES ('35', "Gato");
CREATE USER IF NOT EXISTS 'replica_user'@'%' IDENTIFIED BY 'mariposa5';
GRANT ALL PRIVILEGES ON *.* TO 'holberton_user'@'localhost';
GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'%';
-- change mariposa5 for the password of the root user
CREATE USER IF NOT EXISTS 'replica_user'@'%' IDENTIFIED BY 'mariposa5';
GRANT ALL PRIVILEGES ON *.* TO 'devopsers'@'localhost';
GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'%';