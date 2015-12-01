package com.dbutils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public final class DbUtil {	
	 
	
	/**
	 * 获取数据库链接
	 * @throws SQLException
	 * @throws ClassNotFoundException 
	 * */
	public Connection getConnection() throws SQLException, ClassNotFoundException {
		Connection conn = null;
		  Class.forName("oracle.jdbc.driver.OracleDriver");//加入oracle的驱动，“”里面是驱动的路径
		   
		  String url = "jdbc:oracle:thin:@218.202.106.84:3173:xxtdsdb";// 数据库连接，oracle代表链接的是oracle数据库；thin:@MyDbComputerNameOrIP代表的是数据库所在的IP地址（可以保留thin:）；1521代表链接数据库的端口号；ORCL代表的是数据库名称

		  String UserName = "test";// 数据库用户登陆名 ( 也有说是 schema 名字的 )

		  String Password = "test";// 密码

		  conn = DriverManager.getConnection(url, UserName, Password);
		  return conn;
	}
	
	
}
