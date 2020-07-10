<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="kimgibeom.book.question.service.QuestionService" %>
<%@ page import="kimgibeom.book.question.service.QuestionServiceImpl" %>
<%@ page import="kimgibeom.book.question.domain.Question" %>
<%@ page import="java.util.List" %>
<%
	QuestionService questionService = new QuestionServiceImpl();
	String[] check_questions = request.getParameterValues("check_question");
	
	if(check_questions != null) {
		for(String questions_del : check_questions) {
			int index = Integer.parseInt(questions_del);
			questionService.removeQuestion(index);
		}
		%>
		<c:redirect url='questionListView.jsp?back=true' />
		<%
	} else {
	%>
		<c:redirect url='questionListView.jsp?questionCheck=false' />
	<%
	}
%>