package com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Establish database connection
 * 
 * @author Krushali Talaviya
 *
 */
public class DBConnection {

	public static Connection getConnection() {
		Connection connection = null;

		try {
			Class.forName(DBConstant.DRIVER_NAME);
			connection = DriverManager.getConnection(DBConstant.URL , DBConstant.USER_NAME , DBConstant.PASSWORD);
		} catch (SQLException e) {
			System.out.println("SQL Eroor: "+e);
		} catch (ClassNotFoundException e) {
			System.err.println("Class not found exception: "+e);
		}

		return connection;
	}

}
