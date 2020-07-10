<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.Date"%>
<%@page import="kimgibeom.book.user.domain.User"%>
<%@page import="kimgibeom.book.user.service.UserServiceImpl"%>
<%@page import="kimgibeom.book.user.service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%
	request.setCharacterEncoding("utf-8");
	UserService userService = new UserServiceImpl();

	String userId = (String) session.getAttribute("userId");
	String userPw = request.getParameter("userPw");
	String userName = request.getParameter("userName").replaceAll(" ", "");
	String userGender = request.getParameter("userGender");
	String userPhoneNumber1 = request.getParameter("userPhoneNumber1");
	String userPhoneNumber2 = request.getParameter("userPhoneNumber2");
	String userPhoneNumber3 = request.getParameter("userPhoneNumber3");
	String userPhoneNumber = userPhoneNumber1 + "-" + userPhoneNumber2 + "-" + userPhoneNumber3;
	String userEmail = request.getParameter("userEmail");
	String userAddress1 = request.getParameter("userAddress1");
	String userAddress2 = request.getParameter("userAddress2");
	String userAddress3 = request.getParameter("userAddress3");
	String userAddress4 = request.getParameter("userAddress4");
	String userAddress=userAddress1+userAddress2+userAddress3+userAddress4;

	String pwCheck = "((?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^a-zA-Z0-9가-힣]).{8,15})";
	String url = "userModify.jsp?";

	User user = null;

	if (userPw.equals("")) {
	} else {
		if (userPw.matches(pwCheck)) {
			user = new User(userId, userPw, "", "", Date.valueOf("1111-11-11"), "", "", "");
			userService.modifyUserPw(user);
			url += "userPwChange=true&";
			out.println("암호변경");
		} else {
			url += "userPwCheck=false&";
		}
	}

	if (userName.equals("")) {
	} else {
		out.println(userName);
		user = new User(userId, "", userName, "", Date.valueOf("1111-11-11"), "", "", "");
		userService.modifyUserName(user);
		url += "userNameChange=true&";
		out.println("이름변경");

	}

	if (userGender == null) {
	} else {
		user = new User(userId, "", "", userGender, Date.valueOf("1111-11-11"), "", "", "");
		userService.modifyUserGender(user);
		url += "userGenderChange=true&";
		out.println("성별변경");
	}

	if (userPhoneNumber1.equals("") && userPhoneNumber2.equals("") && userPhoneNumber3.equals("")) {
	} else if (!userPhoneNumber1.equals("") && !userPhoneNumber2.equals("") && !userPhoneNumber3.equals("")) {
		user = new User(userId, "", "", "", Date.valueOf("1111-11-11"), "", userPhoneNumber, "");
		userService.modifyUserPhoneNumber(user);
		url += "userPhoneNumberChange=true&";
		out.println("폰번호변경");
	}else{
		url += "userPhoneNumberNotAll=true&";
	}

	if (userEmail.equals("")) {
	} else {
		user = new User(userId, "", "", "", Date.valueOf("1111-11-11"), userEmail, "", "");
		userService.modifyUserEmail(user);
		url += "userEmailChange=true&";
		out.println("메일변경");
	}

	if (userAddress.trim().equals("")) {
	} else {
		user = new User(userId, "", "", "", Date.valueOf("1111-11-11"), "", "", userAddress);
		userService.modifyUserAddress(user);
		url += "userAddressChange=true&";
		out.println("주소변경");
	}
%>
<c:redirect url='<%=url%>' />