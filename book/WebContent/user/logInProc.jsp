<%@page import="kimgibeom.book.user.domain.User"%>
<%@page import="kimgibeom.book.user.service.UserServiceImpl"%>
<%@page import="kimgibeom.book.user.service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%
	UserService userService = new UserServiceImpl();

	String userId = request.getParameter("userId");
	String userPw = request.getParameter("userPw");
	String saveId = request.getParameter("saveId");

	User user = new User();

	user = userService.findUser(userId);

	if (user == null) {
%>
<c:redirect url='logIn.jsp?idCheck=false' />
<%
	} else if (userId.equals("admin") && userPw.equals(user.getUserPw())) {
		session.setAttribute("userId", userId);
		if (saveId != null) { //암호와 비번이 맞음과 동시에 saveId에 체크를 했다면 이 if문으로 들어온다.
			if (saveId.equals("saveId")) {
				Cookie cookie = new Cookie("saveId", userId);
				cookie.setMaxAge(60 * 60 * 24 * 365);
				response.addCookie(cookie);
			}
		}%>
			<c:redirect url='../main.jsp' />
		<%
	} else {
		if (userId.equals(user.getUserId()) && userPw.equals(user.getUserPw())) { //입력한 값과 db아이디 비번이 둘다 맞을시 로그인
			session.setAttribute("userId", userId);
			if (saveId != null) { //암호와 비번이 맞음과 동시에 saveId에 체크를 했다면 이 if문으로 들어온다.
				if (saveId.equals("saveId")) {
					Cookie cookie = new Cookie("saveId", userId);
					cookie.setMaxAge(60 * 60 * 24 * 365);
					response.addCookie(cookie);
				}
			}
%>
			<c:redirect url='../main.jsp' />
<%
	} else {
%>
			<c:redirect url='logIn.jsp?pwCheck=false' />
<%
	}
	}
%>