<%@page import="java.util.ArrayList"%>
<%@page import="kimgibeom.book.user.domain.User"%>
<%@page import="java.util.List"%>
<%@page import="kimgibeom.book.user.service.UserServiceImpl"%>
<%@page import="kimgibeom.book.user.service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%
	UserService userService = new UserServiceImpl();
	String searchUserId=request.getParameter("searchUserId");
	out.println(searchUserId);
	if (request.getParameter("searchUserId").equals("") || userService.lookupUser(searchUserId).size()==0) {
		%>
			<c:redirect url='../main.jsp?searchEmpty=true' />
		<%
	}else{
		List<User> users=userService.lookupUser(searchUserId);
		for(User a:users){
			out.println(a.getUserId());
		}
		out.println("else끝");
		session.setAttribute("searchUsers", users);
		%>
			<c:redirect url='../main.jsp' />
		<%
	}
%>