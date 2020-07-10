<%@page import="kimgibeom.book.question.domain.Question"%>
<%@page import="java.util.List"%>
<%@page import="kimgibeom.book.question.service.QuestionServiceImpl"%>
<%@page import="kimgibeom.book.question.service.QuestionService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%
	QuestionService questionService = new QuestionServiceImpl();
	String searchUserId = request.getParameter("searchUserId");
	out.println(searchUserId);
	if (request.getParameter("searchUserId").equals("") || questionService.lookupUserId(searchUserId).size() == 0) {
%>
<c:redirect url='questionListView.jsp?searchEmpty=true' />
<%
	} else {
		List<Question> questions = questionService.lookupUserId(searchUserId);
		for (Question q : questions) {
			out.println(q.getQuestionNum());
		}
		out.println("else끝");
		session.setAttribute("searchQuestions", questions);
%>
<c:redirect url='questionListView.jsp' />
<%
	}
%>