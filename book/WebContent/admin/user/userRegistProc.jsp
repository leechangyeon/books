<%@page import="java.sql.Date"%>
<%@page import="java.util.List"%>
<%@page import="kimgibeom.book.user.domain.User"%>
<%@page import="kimgibeom.book.user.service.UserServiceImpl"%>
<%@page import="kimgibeom.book.user.service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%
	request.setCharacterEncoding("utf-8");
	UserService userService = new UserServiceImpl();

	String userId = request.getParameter("userId");
	String userPw = request.getParameter("userPw");
	String userName = request.getParameter("userName").replaceAll(" ", "");
	String userGender = request.getParameter("userGender");
	String userBirthDateStr = request.getParameter("userBirthDate");
	Date userBirthDate = Date.valueOf(userBirthDateStr);
	String userPhoneNumber1 = request.getParameter("userPhoneNumber1");
	String userPhoneNumber2 = request.getParameter("userPhoneNumber2");
	String userPhoneNumber3 = request.getParameter("userPhoneNumber3");
	String userEmail = request.getParameter("userEmail");
	String userAddress1 = request.getParameter("userAddress1");
	String userAddress2 = request.getParameter("userAddress2");
	String userAddress3 = request.getParameter("userAddress3");
	String userAddress4 = request.getParameter("userAddress4");
	String userAddress=userAddress1+userAddress2+userAddress3+userAddress4;

	String userPhoneNumber = userPhoneNumber1 + "-" + userPhoneNumber2 + "-" + userPhoneNumber3;
	String pwCheck = "((?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^a-zA-Z0-9가-힣]).{8,15})";
	String emailCheck = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$";
	String idCheck = "^[a-z]{1}[a-z0-9]{7,11}$";

	List<User> userIds = userService.readUserIds();
	boolean idOverlap = false;

	for (User user : userIds) {
		String id = user.getUserId();
		if (userId.equals(id)) {
			idOverlap = true;
		}
	}

	if (!userId.matches(idCheck)) {
%>
<c:redirect url='userRegist.jsp?idCheck=false' />
<%
	} else if (idOverlap == true) {
%>
<c:redirect url='userRegist.jsp?idOverlap=true' />
<%
	} else if (!userPw.matches(pwCheck)) {
%>
<c:redirect url='userRegist.jsp?pwCheck=false' />
<%
	} else if (!userEmail.matches(emailCheck)) {
%>
<c:redirect url='userRegist.jsp?emailCheck=false' />
<%
	} else {
		User user = new User(userId, userPw, userName, userGender, userBirthDate, userEmail, userPhoneNumber,
				userAddress);
		userService.writeUser(user);
%>
<c:redirect url='../main.jsp' />
<%
	}
%>