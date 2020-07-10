<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="kimgibeom.book.question.service.QuestionService"%>
<%@ page import="kimgibeom.book.question.service.QuestionServiceImpl"%>
<%@ page import="kimgibeom.book.question.domain.Question"%>
<%@ page import="java.util.List"%>
<%
	QuestionService questionService = new QuestionServiceImpl();

	int questionNum = (int) session.getAttribute("questionNum");
	Question question = questionService.findQuestion(questionNum);
	String content = question.getContent();
	String answer = request.getParameter("admin_answer").trim();
	if(!answer.equals("")){
		content = content + "<br>" + "--------------------------------" + "<br>" + answer;
		question.setContent(content);
		question.setStatus("답변완료");
		questionService.modifyQuestion(question);
	}
%>
<c:redirect url="questionListView.jsp?back=true"/>