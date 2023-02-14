<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.util.DBConnection"%>
<%@page import="com.util.DBConstant"%>
<%@page import="com.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%-- <%@page isErrorPage = "true" %> --%>
<%@ page errorPage="error.jsp" %> 
<html>
	<head>
		<title>User-List</title>
		<script src="https://kit.fontawesome.com/yourcode.js"></script>
		<script src='https://kit.fontawesome.com/a076d05399.js'></script>
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
		<script>
			$(document).ready(function() {
				$('.btn1').click(function(e){
					e.preventDefault();
					//console.log("hello");
					var deleteid = $(this).val();
					Swal.fire ({
					    title: 'Are you sure?',
					    text: "You won't be able to revert this!",
					    icon: 'warning',
					    showCancelButton: true,
					    confirmButtonColor: '#3085d6',
					    cancelButtonColor: '#d33',
					    confirmButtonText: 'Yes, delete it!'
						}).then((result) => {
						if (result.value) {
							Swal.fire(
							    'Deleted!',
							    'Your file has been deleted.',
							    'success'
							)
			           			window.location = "registrationUserListController?action=deleteUser&id="+deleteid; 
			           		}
					})
				})
			})
		</script>
	</head>
	<body>
		<br>
		<div class="row" style= "margin-left: auto; margin-right: auto;">
			<div class="container">
				<h2 class="text-center">User List</h2>
				<div class="text-right">
					<a href="registration.jsp" class="btn btn-success" title="Add New User"> 
						<i class='fas fa-user-plus' style='font-size: 20px'></i>
					</a>
				</div>
				<br>
				<table class="table table-bordered">
					<thead>
						<tr style = "text-align: center; padding: 10px">
							<th>Id</th>
							<th>First Name</th>
							<th>Last Name</th>
							<th>User Name</th>
							<th>Address</th>
							<th>Contact</th>
							<th style="Width: 150px;">Actions</th>
						</tr>
					</thead>
					<tbody>
						<%
						 	try {
								Connection connection = DBConnection.getConnection();
								String query = "SELECT id, firstName, lastName, userName, address, contact FROM userlist ORDER BY id DESC";
								PreparedStatement preparedStatement = connection.prepareStatement(query);
								ResultSet result = preparedStatement.executeQuery();
								while ( result.next() ) {
						%>
						<tr style = "line-height: 35px;">
							<td><%= result.getInt("id") %></td>
							<td><%= result.getString("firstName") %></td>
							<td><%= result.getString("lastName") %></td>
							<td><%= result.getString("userName") %></td>
							<td><%= result.getString("address") %></td>
							<td><%= result.getString("contact") %></td>
							<td style = "display: flex;">
								<a href="registrationUserListController?action=editUserData&id=<%=result.getInt(1)%>" >
									<button class = "btn btn-link"><i class='fas fa-pen' style='font-size: 24px;'></i></button>
								</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<button class = "btn btn-link btn1" value=<%=result.getInt(1)%>>
									<i class='fas fa-trash' style='font-size: 24px; color: red;'></i>
								</button>
							</td>
						</tr>
						
						<%
							}
								result.close();
								preparedStatement.close();
							}
							catch (Exception e) {
								response.sendRedirect("error.jsp");
								e.printStackTrace();
							}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</body>
</html>
