<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="kimgibeom.book.question.service.QuestionService"%>
<%@ page import="kimgibeom.book.question.service.QuestionServiceImpl"%>
<%@ page import="kimgibeom.book.question.domain.Question"%>
<% 
	QuestionService questionService = new QuestionServiceImpl();
	int index = Integer.parseInt(request.getParameter("questionNum"));
	questionService.removeQuestion(index);		
%>
<c:redirect url="questionListView.jsp?back=true"/>