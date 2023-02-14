package com.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.RegistrationDao;
import com.dao.RegistrationUserListDao;
import com.model.RegistrationModel;

/**
 * Servlet implementation class RegistrationController. JSP to get data post
 * method and model set data. Model set to RegistrationDao class and set
 * database and return Integer value. Check condition Record inserted or not.
 * 
 * @author Krushali Talaviya
 *
 */
@SuppressWarnings("serial")
@WebServlet("/registrationController")
public class RegistrationController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RegistrationModel registrationModel = new RegistrationModel();
		registrationModel.setFirstName(request.getParameter("firstName"));
		registrationModel.setLastName(request.getParameter("lastName"));
		registrationModel.setUserName(request.getParameter("userName"));
		registrationModel.setPassword(request.getParameter("password"));
		registrationModel.setAddress(request.getParameter("address"));
		registrationModel.setContact(request.getParameter("contact"));
		if ((request.getParameter("id")).isEmpty()) {

			// Insert data and Return Integer value
			int recordInsert = 0;
			try {
				recordInsert = new RegistrationDao().doInsertData(registrationModel);
			} catch (Exception exception) {
				response.sendRedirect("Error.jsp");
				exception.printStackTrace();
			}

			// Check Record inserted or Not
			if (recordInsert > 0) {
				response.sendRedirect("registration.jsp?contact=success");
			} else {
				request.getRequestDispatcher("registration.jsp").forward(request, response);
			}
		} else {
			registrationModel.setId(Integer.parseInt(request.getParameter("id")));

			// Update model and return Integer value
			int recordUpdated = 0;
			try {
				recordUpdated = new RegistrationUserListDao().doUpdateData(registrationModel);
			} catch (Exception exception) {
				request.getRequestDispatcher("/Error.jsp").forward(request, response);
				exception.printStackTrace();
			}

			// Check record updated or not
			if (recordUpdated > 0) {
				response.sendRedirect("registrationUserListController?action=editUserData&id="
						+ request.getParameter("id") + "&contact=update");
			} else {
				request.getRequestDispatcher("registration.jsp").forward(request, response);
			}
		}
	}

}
