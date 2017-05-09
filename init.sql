create database gateway1 character set utf8;
use gateway;



insert  into `sys_role`(`id`,`name`) values (1,'ROLE_CREATOR'),(2,'ROLE_ADMIN'),(3,'ROLE_EXPERT');
INSERT INTO `sys_role`(`id`,`name`) values(4,'ROLE_USER');
INSERT INTO sys_user(id, username, password) VALUES (
  1,'root123','$2a$10$qOwqRGybCT4cQwD1vkhfD.eFIWc1P2e74irm750znQ3VlLaKl5Wg2');

INSERT INTO sys_user_roles(sys_user_id, roles_id) VALUES (
  1,1
);


insert into `t_gateway`(`name`,`ip`, `port`, `max_nodes`, `max_channels`,`poll_interval`,`X`,`Y`) values (
  'gateway 1','192.168.1.1', 505, 64,32,30,13.5,14.5);
insert into `t_gateway`(`name`,`ip`, `port`, `max_nodes`, `max_channels`,`poll_interval`,`X`,`Y`) values (
  'gateway 2','192.168.1.2', 505, 64,32,30,13.5,14.5);
insert into `t_gateway`(`name`,`ip`, `port`, `max_nodes`, `max_channels`,`poll_interval`,`X`,`Y`) values (
  'gateway 3','192.168.1.3', 505, 64,32,30,13.5,14.5);
insert into `t_gateway`(`name`,`ip`, `port`, `max_nodes`, `max_channels`,`poll_interval`,`X`,`Y`) values (
  'gateway 4','192.168.1.4', 505, 64,32,30,13.5,14.5);
insert into `t_gateway`(`name`,`ip`, `port`, `max_nodes`, `max_channels`,`poll_interval`,`X`,`Y`) values (
  'gateway 5','192.168.1.5', 505, 64,32,30,13.5,14.5);

INSERT INTO sys_user(id, username, password) VALUES (
  1,'root123','$2a$10$qOwqRGybCT4cQwD1vkhfD.eFIWc1P2e74irm750znQ3VlLaKl5Wg2');

INSERT INTO sys_user_roles(sys_user_id, roles_id) VALUES (
    1,1
);

CREATE TABLE `t_nodeinfo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `x` float DEFAULT NULL,
  `y` float DEFAULT NULL,
  `desc_string` varchar(255) DEFAULT NULL,
  `gateway_id` bigint(20) DEFAULT NULL,
  `node_addr` tinyint(4) DEFAULT NULL,
  `node_name` varchar(255) DEFAULT NULL,
  `pic` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


  #==============================


  #=======================
  mysql> INSERT INTO `sys_role`(`id`,`name`) values(4,'ROLE_USER');
Query OK, 1 row affected (0.05 sec)

mysql> show tables;
+-------------------+
| Tables_in_gateway |
+-------------------+
| sys_role          |
| sys_user          |
| sys_user_roles    |
| t_gateway         |
| t_nodeinfo        |
| t_sensor          |
| t_thresholdinfo   |
| t_warning         |
| t_zigbee_node     |
+-------------------+
9 rows in set (0.00 sec)

mysql> show create table sys_role;
+----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table    | Create Table                                                                                                                                                                          |
+----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| sys_role | CREATE TABLE `sys_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 |
  +----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
  1 row in set (0.00 sec)

  mysql> show create table sys_user;
+----------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table    | Create Table                                                                                                                                                                                                     |
+----------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| sys_user | CREATE TABLE `sys_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 |
  +----------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
  1 row in set (0.00 sec)

  mysql> show create table sys_user_roles;
+----------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table          | Create Table                                                                                                                                                                                                                                                                                                                                                                                                                                               |
+----------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| sys_user_roles | CREATE TABLE `sys_user_roles` (
  `sys_user_id` bigint(20) NOT NULL,
  `roles_id` bigint(20) NOT NULL,
  KEY `FKdpvc6d7xqpqr43dfuk1s27cqh` (`roles_id`),
  KEY `FKd0ut7sloes191bygyf7a3pk52` (`sys_user_id`),
  CONSTRAINT `FKd0ut7sloes191bygyf7a3pk52` FOREIGN KEY (`sys_user_id`) REFERENCES `sys_user` (`id`),
  CONSTRAINT `FKdpvc6d7xqpqr43dfuk1s27cqh` FOREIGN KEY (`roles_id`) REFERENCES `sys_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 |
  +----------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
  1 row in set (0.00 sec)

  mysql> show tables;
+-------------------+
| Tables_in_gateway |
+-------------------+
| sys_role          |
| sys_user          |
| sys_user_roles    |
| t_gateway         |
| t_nodeinfo        |
| t_sensor          |
| t_thresholdinfo   |
| t_warning         |
| t_zigbee_node     |
+-------------------+
9 rows in set (0.01 sec)

mysql> show create table t_gateway;;
+-----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table     | Create Table                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
+-----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| t_gateway | CREATE TABLE `t_gateway` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `x` float DEFAULT NULL,
  `y` float DEFAULT NULL,
  `desc_string` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `poll_interval` int(11) DEFAULT NULL,
  `max_channels` int(11) DEFAULT NULL,
  `max_nodes` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `pic` varchar(255) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 |
  +-----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
  1 row in set (0.00 sec)

ERROR:
No query specified

  mysql> show tables;
+-------------------+
| Tables_in_gateway |
+-------------------+
| sys_role          |
| sys_user          |
| sys_user_roles    |
| t_gateway         |
| t_nodeinfo        |
| t_sensor          |
| t_thresholdinfo   |
| t_warning         |
| t_zigbee_node     |
+-------------------+
9 rows in set (0.00 sec)

mysql> show create table t_nodeinfo;
+------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table      | Create Table                                                                                                                                                                                                                                                                                                                                                                                 |
+------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| t_nodeinfo | CREATE TABLE `t_nodeinfo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `x` float DEFAULT NULL,
  `y` float DEFAULT NULL,
  `desc_string` varchar(255) DEFAULT NULL,
  `gateway_id` bigint(20) DEFAULT NULL,
  `node_addr` tinyint(4) DEFAULT NULL,
  `node_name` varchar(255) DEFAULT NULL,
  `pic` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 |
  +------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
  1 row in set (0.00 sec)

  mysql> show tables;
+-------------------+
| Tables_in_gateway |
+-------------------+
| sys_role          |
| sys_user          |
| sys_user_roles    |
| t_gateway         |
| t_nodeinfo        |
| t_sensor          |
| t_thresholdinfo   |
| t_warning         |
| t_zigbee_node     |
+-------------------+
9 rows in set (0.00 sec)

mysql> show create table t_sensor;
+----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table    | Create Table                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
+----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| t_sensor | CREATE TABLE `t_sensor` (
  `readout_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `channel` tinyint(4) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `data_type` tinyint(4) DEFAULT NULL,
  `gateway_id` bigint(20) DEFAULT NULL,
  `node_addr` tinyint(4) DEFAULT NULL,
  `sensor_type` tinyint(4) DEFAULT NULL,
  `value` smallint(6) DEFAULT NULL,
  `id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`readout_id`),
  KEY `FKlr1tjs254ohar0j4mbj9o4my` (`id`),
  CONSTRAINT `FKlr1tjs254ohar0j4mbj9o4my` FOREIGN KEY (`id`) REFERENCES `t_zigbee_node` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 |
  +----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
  1 row in set (0.00 sec)

  mysql> show tables;
+-------------------+
| Tables_in_gateway |
+-------------------+
| sys_role          |
| sys_user          |
| sys_user_roles    |
| t_gateway         |
| t_nodeinfo        |
| t_sensor          |
| t_thresholdinfo   |
| t_warning         |
| t_zigbee_node     |
+-------------------+
9 rows in set (0.00 sec)

mysql> show create table t_thresholdinfo;
+-----------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table           | Create Table                                                                                                                                                                                                                                                                                                                            |
+-----------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| t_thresholdinfo | CREATE TABLE `t_thresholdinfo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `channel` tinyint(4) DEFAULT NULL,
  `gateway_id` bigint(20) DEFAULT NULL,
  `lower_limit` int(11) DEFAULT NULL,
  `node_addr` tinyint(4) DEFAULT NULL,
  `upper_limit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 |
  +-----------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
  1 row in set (0.00 sec)

  mysql> show create table t_warning;
+-----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table     | Create Table                                                                                                                                                                                                                                                                                                                                                       |
+-----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| t_warning | CREATE TABLE `t_warning` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `closed` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `readout_id` bigint(20) DEFAULT NULL,
  `warn_status` int(11) DEFAULT NULL,
  `threshold_id` bigint(20) DEFAULT NULL,
  `warn_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 |
  +-----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
  1 row in set (0.00 sec)

  mysql> show create table t_zigbee_node;
+---------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table         | Create Table                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
+---------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| t_zigbee_node | CREATE TABLE `t_zigbee_node` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `node_addr` tinyint(4) DEFAULT NULL,
  `node_name` varchar(255) DEFAULT NULL,
  `node_online` bit(1) DEFAULT NULL,
  `gateway_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1rrmm2jvkg4h8lngjguimxb8a` (`gateway_id`),
  CONSTRAINT `FK1rrmm2jvkg4h8lngjguimxb8a` FOREIGN KEY (`gateway_id`) REFERENCES `t_gateway` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 |
  +---------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
  1 row in set (0.00 sec)
