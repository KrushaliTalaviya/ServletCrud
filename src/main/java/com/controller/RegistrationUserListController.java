package com.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.RegistrationDao;
import com.model.RegistrationModel;

/**
 * Servlet implementation class RegistrationUserListController. JSP to get doGet
 * method. DoGet method to get parameter value check editUserdata or deleteUser
 * 
 * @author Krushali Talaviya
 *
 */
@SuppressWarnings("serial")
@WebServlet("/registrationUserListController")
public class RegistrationUserListController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		int id = Integer.parseInt(request.getParameter("id"));
		
		if (action.equals("editUserData")) {
			
			// RegistrationUserListDao class and editUserData Method call and return model
			RegistrationModel recordEdit = null;
			try {
				recordEdit = new RegistrationDao().editUserData(id);
			} catch (Exception exception) {
				response.sendRedirect("error.jsp");
				exception.printStackTrace();
			}
			request.setAttribute("editUserData", recordEdit);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/registration.jsp");
			dispatcher.forward(request, response);
		} else if (action.equals("deleteUser")) {
			System.out.println("Id is: " + id);
			// RegistrationUserListDao class to dodeleteData method call and return Integer
			// value
			int recordDeleted = 0;

			try {
				recordDeleted = new RegistrationDao().doDeleteData(id);
			} catch (Exception exception) {
				response.sendRedirect("error.jsp");
				exception.printStackTrace();
			}

			// Check delete user or not
			if (recordDeleted > 0) {
				response.sendRedirect("registrationUserList.jsp");
			}
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	}

}
