package com.dbutils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public final class DbUtil {	
	 
	
	/**
	 * ��ȡ���ݿ�����
	 * @throws SQLException
	 * @throws ClassNotFoundException 
	 * */
	public Connection getConnection() throws SQLException, ClassNotFoundException {
		Connection conn = null;
		  Class.forName("oracle.jdbc.driver.OracleDriver");//����oracle������������������������·��
		   
		  String url = "jdbc:oracle:thin:@218.202.106.84:3173:xxtdsdb";// ���ݿ����ӣ�oracle�������ӵ���oracle���ݿ⣻thin:@MyDbComputerNameOrIP����������ݿ����ڵ�IP��ַ�����Ա���thin:����1521�����������ݿ�Ķ˿ںţ�ORCL����������ݿ�����

		  String UserName = "test";// ���ݿ��û���½�� ( Ҳ��˵�� schema ���ֵ� )

		  String Password = "test";// ����

		  conn = DriverManager.getConnection(url, UserName, Password);
		  return conn;
	}
	
	
}
