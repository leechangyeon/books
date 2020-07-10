<%@ page language='java' contentType='text/html; charset=UTF-8'
    pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ page import="kimgibeom.book.question.service.QuestionService"%>
<%@ page import="kimgibeom.book.question.service.QuestionServiceImpl"%>
<%@ page import="kimgibeom.book.question.domain.Question"%>
<%@ page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%
	request.setCharacterEncoding("UTF-8");

	QuestionService questionService = new QuestionServiceImpl();
	String searchType = request.getParameter("searchType");
	
	if(searchType.equals("아이디")){
		String searchUserId = request.getParameter("search");
		if (searchUserId.equals("") || questionService.lookupUserId(searchUserId).size()==0) { 
			%>
				<c:redirect url='questionListView.jsp?searchEmpty=true1' />
			<%
		}else{
			List<Question> questions = questionService.lookupUserId(searchUserId);
			session.setAttribute("searchQuestions", questions);
			%>
				<c:redirect url='questionListView.jsp' />
			<%
		}
	}else{
		String searchTitle = request.getParameter("search");
		if (searchTitle.equals("") || questionService.lookupTitle(searchTitle).size()==0) {
			%>
				<c:redirect url='questionListView.jsp?searchEmpty=true2' />
			<%
		}else{
			List<Question> questions = questionService.lookupTitle(searchTitle);
			session.setAttribute("searchQuestions", questions);
			%>
				<c:redirect url='questionListView.jsp' />
			<%
		}
	}
%>


