<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="kimgibeom.book.question.service.QuestionService"%>
<%@ page import="kimgibeom.book.question.service.QuestionServiceImpl"%>
<%@ page import="kimgibeom.book.question.domain.Question"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import='java.io.IOException'%>
<%@ page import='com.oreilly.servlet.MultipartRequest'%>
<%@ page import='com.oreilly.servlet.multipart.DefaultFileRenamePolicy'%>
<%
	request.setCharacterEncoding("UTF-8");
	String attachPath = "/attach";
	int fileMaxSize = 1024 * 1024 * 5;
	String encType = "utf-8";

	ServletContext ctx = getServletContext();
	attachPath = ctx.getRealPath(attachPath);

	MultipartRequest multiRequest = null;
	try {
		multiRequest = new MultipartRequest(request, attachPath, fileMaxSize, encType,
				new DefaultFileRenamePolicy());
	} catch (IOException e) {
		throw e;
	}
	request.setAttribute("attachName", multiRequest.getOriginalFileName("attachFile"));

	QuestionService questionService = new QuestionServiceImpl();
	Date date = Date.valueOf(LocalDate.now());
	Question question = new Question();
	String title = multiRequest.getParameter("title");
	String content = multiRequest.getParameter("content");
	
	question.setTitle(title);
	question.setContent(content);
	question.setStatus("답변미완료");
	question.setUserId((String) session.getAttribute("userId"));
	question.setRegDate(date);

	if (request.getAttribute("attachName") != null) {
		question.setAttachName((String) request.getAttribute("attachName"));
	} else {
		question.setAttachName("null");
	}
	if (title.trim().equals("") || content.trim().equals("")){
%>
	<c:redirect url="questionRegist.jsp?msg=1" />
<%
	} else {
		questionService.enrollQuestion(question);
	}
%>
<c:redirect url="questionListView.jsp" />