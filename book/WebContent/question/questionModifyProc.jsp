<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ page import="kimgibeom.book.question.service.QuestionService"%>
<%@ page import="kimgibeom.book.question.service.QuestionServiceImpl"%>
<%@ page import="kimgibeom.book.question.domain.Question"%>
<%@ page import='java.io.IOException' %>
<%@ page import='com.oreilly.servlet.MultipartRequest' %>
<%@ page import='com.oreilly.servlet.multipart.DefaultFileRenamePolicy' %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String attachPath = "/attach"; 	
	int fileMaxSize = 1024 * 1024 * 5; 
	String encType="utf-8";
	
	ServletContext ctx = getServletContext(); 
	attachPath = ctx.getRealPath(attachPath); 
	
	MultipartRequest multiRequest = null;
	try{
		multiRequest = new MultipartRequest(request,
			attachPath, fileMaxSize, encType, new DefaultFileRenamePolicy());
	}catch(IOException e){
		throw e;
	}
	
	String attachName = multiRequest.getFilesystemName("attachFile");
	request.setAttribute("attachName", attachName);
	
	QuestionService questionService = new QuestionServiceImpl();
	Question question = questionService.findQuestion(Integer.parseInt(request.getParameter("questionNum")));

	if(attachName!=null){
		question.setAttachName((String)request.getAttribute("attachName"));
	}else{
		question.setAttachName("null");
	}
	
	question.setTitle(multiRequest.getParameter("title"));
	question.setContent(multiRequest.getParameter("content"));
	questionService.modifyQuestion(question);
%>
<c:redirect url="questionListView.jsp" />