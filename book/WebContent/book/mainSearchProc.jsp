<%@page import="kimgibeom.book.book.domain.Book"%>
<%@page import="java.util.List"%>
<%@page import="kimgibeom.book.book.service.BookServiceImpl"%>
<%@page import="kimgibeom.book.book.service.BookService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	BookService bookService = new BookServiceImpl();
	String select = request.getParameter("mainSearchSelect");
	String searchText = request.getParameter("searchText");

	if (select.equals("book")) {
		List<Book> books = bookService.searchBooks(searchText);
		session.setAttribute("searchBooks", books);
%>
<c:redirect url='bookListView.jsp' />
<%
	} else {
	}
%>