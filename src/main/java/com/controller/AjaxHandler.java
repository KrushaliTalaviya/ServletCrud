package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.DBConnection;

@WebServlet("/ajaxHandler")
public class AjaxHandler extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public AjaxHandler() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PreparedStatement preparedStatement = null;
		PrintWriter out = response.getWriter();
		ResultSet result = null;
		String name = request.getParameter("contact");

		if (name != null && name.trim().length() > 0) {
			try {
				Connection connection = DBConnection.getConnection();
				String query = "select * from userlist where contact = ?";
				preparedStatement = connection.prepareStatement(query);
				preparedStatement.setString(1, name);
				result = preparedStatement.executeQuery();

				if ((result != null) && (result.next()) ) {
					out.print("true");
				} else {
					out.print("");
				}
			} catch (Exception e) {
				response.sendRedirect("error.jsp");
				e.printStackTrace();
			}
		} else {
			out.print("<span style=\"color:red;\">Username is required field. ok</span>");
		}
	}
}
