package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.model.RegistrationModel;
import com.util.DBConnection;

/**
 * Get connection. Insertdata in database. ExecuteUpdate and return value.
 * 
 * @author Krushali Talaviya
 *
 */
public class RegistrationDao {

	Connection connection = null;
	int executeUpdate = 0;

	public int doInsertData(RegistrationModel registrationModel) throws SQLException {
		connection = DBConnection.getConnection(); // Get connection
		String query = "INSERT INTO userlist( firstName, lastName, userName, Password, address, contact) VALUES(?, ?, ?, ?, ?, ?)";
		try {
			// PreparedStatement to query execute
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, registrationModel.getFirstName());
			preparedStatement.setString(2, registrationModel.getLastName());
			preparedStatement.setString(3, registrationModel.getUserName());
			preparedStatement.setString(4, registrationModel.getPassword());
			preparedStatement.setString(5, registrationModel.getAddress());
			preparedStatement.setString(6, registrationModel.getContact());

			executeUpdate = preparedStatement.executeUpdate();
		} catch (Exception exception) {
			exception.printStackTrace();
		} finally {
			connection.close();
		}
		return executeUpdate;
	}

}
