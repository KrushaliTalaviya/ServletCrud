<%@page import="com.model.RegistrationModel"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.controller.RegistrationUserListController"%>
<%@page import= "com.controller.AjaxHandler" %>
<%@ page errorPage="error.jsp" %> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Employee Registration Form</title>
		<link rel="stylesheet" href="css/bootstrap.css"></link>
		<link rel="stylesheet" href="css/button.css"></link>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js" ></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.0/jquery.min.js"> </script>
		<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
		<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js" ></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.min.js"> </script>
		<script src="https://kit.fontawesome.com/yourcode.js"></script>
		<script src='https://kit.fontawesome.com/a076d05399.js'></script>
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
		<style>
			#frm {
				width: 400px;
				height: auto;
				margin: auto;
				margin-top: 50px;
				margin-bottom: 20px;
			}
		</style>
		<!-- Form validation using jQuery -->
		<script>
			$(document).ready(function() {
				$("#registration-form").validate()
			});
		</script>
		<!-- Password validation using javascript -->
		<script>
			function validate(){
				var regexpass=  /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{8,15}$/;
				var password=document.myForm.password.value;
				var status;
				if(!regexpass.test(password)) {
	    			swal("Password must be between 8 to 15 characters which contain at least one lowercase letter, one uppercase letter, one numeric digit, and one special character");
	    			status = false;
				} else {
					status = true;
				}
				return status;
			}
		</script>
		<!-- Contact validation Contact already exists in database or not -->
		<script type="text/javascript">
			$(document).ready(function() {
				$("#contact").on(//"blur",
					"input",function(e) {
					$('#msg').hide();
					if ($('#contact').val() == null || $('#contact').val() == "") {
						$('#msg').show();
						$("#msg").html("Username is required field.")
						.css("color","red");
					} else {
						$( "#button" ).attr( "disabled", true );
						$.ajax({
							type : "POST",
							url : "ajaxHandler",
							data : $('#frm').serialize(),
							dataType : "html",
							cache : false,
							success : function(msg) {
										var value = "true";
										if (msg == value) {
											$("#button").attr( "disabled", true );
											swal("Contact is Already Exists");
										} else {
											$( "#button" ).attr( "disabled", false );
										}
									},
							error : function(jqXHR , textStatus , errorThrown) {
										$('#msg').show();
										$("#msg").html(textStatus + " " + errorThrown);
									}
						});
					}
				});
			});
		</script>
		<!-- Restrication of alphabates in contact field -->
		<script type="text/javascript">
			/*code: 48-57 Numbers*/
			function restrictAlphabets(e) {
				var x = e.which || e.keycode;
				if ((x >= 48 && x <= 57)) {
					return true;
				} else {
					return false;
				}
			}
		</script>
	</head>
	<body class="container-fluid">
		<h3 id="result"></h3>
		<h2>
			<% if ( (request.getParameter("contact") != null) && (request.getParameter("contact").equals("success")) ) {
			%>
				<script>
					swal ({
						text: "Registration Successfully.",
						timer: 1000,
						});
				</script>
			<% 
				} else if ( (request.getParameter("contact") != null) && (request.getParameter("contact").equals("update")) ) {
			%>
				<script>
				swal ({
					text: "Record updated Successfully.",
					timer: 2000,
					});
				</script>
			<% 
				}
			%>
		</h2>
		<div class="text-right">
			<a href="registrationUserList.jsp"  title="Show User List"> 
				<button type="submit" class="btn btn-outline-success" id = "userbtn">User List
					<i class='fas fa-user-friends' style='font-size:20px'></i>
				</button>
			</a>
		</div>
		<c:if test="${ editUserData.getId() == editUserData.getId() }">
			<span id="pass1" style="color: red; text-align: center"></span>
			<form action="registrationController" onsubmit="return validate()" method="post" class="form card" id="frm"  name = "myForm">
				<c:choose>
					<c:when test="${ editUserData.getId() > 0 }">
						<center><h2 class="bg-danger text-white card-header">Edit Form</h2></center>
					</c:when>
					<c:otherwise>
						<center><h2 class="bg-danger text-white card-header">Registration Form</h2></center>
					</c:otherwise>
				</c:choose>
				<table class="table table-hover">
					<tr>
						<td>*First Name</td>
						<td><input type="text" name="firstName" value="${ editUserData.getFirstName() }" required></td>
					</tr>
					<tr>
						<td>*Last Name</td>
						<td><input type="text" name="lastName" value="${ editUserData.getLastName() }" required></td>
					</tr>
					<tr>
						<td>*User Name</td>
						<td><input type="text" name="userName" value="${ editUserData.getUserName() }" required></td>
					</tr>
					<tr>
						<td>*Password</td>
						<td>
							<input type="password" name="password" id = "password" value="${ editUserData.getPassword() }" required>
						</td>
					</tr>
					<tr>
						<td>*Address</td>
						<td><input type="text" name="address" value="${ editUserData.getAddress() }" required></td>
					</tr>
					
					<tr>
						<td>*Contact</td>
						<td>
							<input type="text" id="contact" name="contact" onkeypress='return restrictAlphabets(event)'  pattern="^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[789]\d{9}$" title="Enter Valid mobile number ex.9811111111" value="${ editUserData.getContact() }" required>
							<div id="msg"></div>
							<input type="hidden"  name="id" value="${ editUserData.getId() }" />
						</td>
					</tr>
					<tr class="card-footer">
						<c:choose>
							<c:when test="${ editUserData.getId() > 0 }">
								<td><button type="submit" class="btn btn-outline-success" id="button">Update</button></td>
								<td>
									<a href="registration.jsp" class="btn btn-success" title="Add New User"> 
										<i class='fas fa-user-plus' style='font-size: 20px'></i>
									</a>
								</td>
							</c:when>
							<c:otherwise>
								<td><button type="submit" class="btn btn-outline-success " id="button" >Register</button></td>
								<td><button type="reset" class="btn btn-outline-danger">Reset</button></td>
							</c:otherwise>
						</c:choose>
					</tr>
				</table>
			</form>
		</c:if>
	</body>
</html>
