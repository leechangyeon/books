<%@page import="kimgibeom.book.user.domain.User"%>
<%@page import="kimgibeom.book.user.service.UserServiceImpl"%>
<%@page import="kimgibeom.book.user.service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%
	UserService userService = new UserServiceImpl();
	User user = userService.findUser((String) session.getAttribute("userId"));
	String userPw = request.getParameter("userPw");

	if (user.getUserPw().equals(userPw)) {
		userService.withdrawUser((String) session.getAttribute("userId"));
		session.invalidate();
		%>
			<c:redirect url='../main.jsp' />
		<%
	} else { 
		%>
			<c:redirect url='userWithdraw.jsp?userPwCheck=false' />
		<%
	}
%>