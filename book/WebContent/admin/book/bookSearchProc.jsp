<%@page import="java.util.ArrayList"%>
<%@page import="kimgibeom.book.book.domain.Book"%>
<%@page import="java.util.List"%>
<%@page import="kimgibeom.book.book.service.BookServiceImpl"%>
<%@page import="kimgibeom.book.book.service.BookService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%
	BookService bookService = new BookServiceImpl();
	String searchBookTitle = request.getParameter("searchBookTitle");
	if (request.getParameter("searchBookTitle").equals("") || bookService.lookupBook(searchBookTitle).size()==0) {
		%>
			<c:redirect url='bookListView.jsp?searchEmpty=true' />
		<%
	}else{
		List<Book> books=bookService.lookupBook(searchBookTitle);
		for(Book a:books){
			out.println(a.getTitle());
		}
		out.println("else끝");
		session.setAttribute("searchBookTitle", books);
		%>
			<c:redirect url='bookListView.jsp' />
		<%
	}
%>