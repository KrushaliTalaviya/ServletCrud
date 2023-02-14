package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.model.RegistrationModel;
import com.util.DBConnection;

/**
 * Get Connection Create editUser method and return model. Create select Querie
 * and get data to set model. ExecuteUpdate and return model. Create
 * doUpdateData method. Create Update Querie. Create doDeleteData method Create
 * delete Querie.
 * 
 * @author krushali
 *
 */
public class RegistrationUserListDao {

	int executeUpdate = 0;
	Connection connection;
	RegistrationModel registrationModel;

	public RegistrationModel editUserData(int id) throws SQLException {
		connection = DBConnection.getConnection();
		String query = "SELECT * FROM userlist WHERE id = ?";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, id);
			ResultSet result = preparedStatement.executeQuery();
			if (result.next()) {
				registrationModel = new RegistrationModel();
				registrationModel.setId(result.getInt(1));
				registrationModel.setFirstName(result.getString("firstName"));
				registrationModel.setLastName(result.getString("lastName"));
				registrationModel.setUserName(result.getString("userName"));
				registrationModel.setPassword(result.getString("Password"));
				registrationModel.setAddress(result.getString("address"));
				registrationModel.setContact(result.getString("contact"));
			}
		} catch (Exception exception) {
			exception.printStackTrace();
		} finally {
			connection.close();
		}
		return registrationModel;
	}

	public int doUpdateData(RegistrationModel registrationModel) throws Exception {
		connection = DBConnection.getConnection(); // Connection database
		String query = "UPDATE userlist SET firstName=?, lastName=?, userName=?, Password=?, address=?, contact=? WHERE id=?";

		try {
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, registrationModel.getFirstName());
			preparedStatement.setString(2, registrationModel.getLastName());
			preparedStatement.setString(3, registrationModel.getUserName());
			preparedStatement.setString(4, registrationModel.getPassword());
			preparedStatement.setString(5, registrationModel.getAddress());
			preparedStatement.setString(6, registrationModel.getContact());
			preparedStatement.setInt(7, registrationModel.getId());

			executeUpdate = preparedStatement.executeUpdate();
		} catch (Exception exception) {
			exception.printStackTrace();
		} finally {
			connection.close();
		}
		return executeUpdate;
	}

	public int doDeleteData(int id) throws SQLException {
		executeUpdate = 0;
		connection = DBConnection.getConnection(); // Connection database
		System.out.println(id);
		String query = "DELETE FROM userlist WHERE id = ?";
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, id);
			executeUpdate = preparedStatement.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			connection.close();
		}
		return executeUpdate;
	}

}
