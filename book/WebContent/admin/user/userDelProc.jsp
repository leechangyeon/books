<%@page import="kimgibeom.book.user.service.UserServiceImpl"%>
<%@page import="kimgibeom.book.user.service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	UserService userService = new UserServiceImpl();
	String[] userIds = request.getParameterValues("userId");
	
	if (userIds != null) {
		for (String userId : userIds) {
			out.println(userId);
			if(userService.withdrawUser(userId)){
				out.println("제거성공");	
			}
		}
		%>
			<c:redirect url='../main.jsp?back=true' />
		<%
	} else {
%>
		<c:redirect url='../main.jsp?userCheck=false' />
<%
	}
%>