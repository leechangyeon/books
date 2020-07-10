<%@page import="kimgibeom.book.user.domain.User"%>
<%@page import="kimgibeom.book.user.service.UserService"%>
<%@page import="kimgibeom.book.user.service.UserServiceImpl"%>
<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%
	String userPw = request.getParameter("userPw");
	UserService userService = new UserServiceImpl();

	User user = userService.findUser((String) (session.getAttribute("userId")));
	if (userPw.equals(user.getUserPw())) {
%>
<jsp:forward page='userModify.jsp' />
<%
	} else {
%>
<c:redirect url='userInfo.jsp?userPwCheck=false' />
<%
	}
%>