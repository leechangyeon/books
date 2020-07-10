<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ page import="kimgibeom.book.book.service.BookService"%>
<%@ page import="kimgibeom.book.book.service.BookServiceImpl"%>
<%@ page import="kimgibeom.book.book.domain.Book"%>
<%@	page import="java.util.ArrayList, java.util.List"%>
<%
	BookService bookService = new BookServiceImpl();
	String[] check_books = request.getParameterValues("check_book");

	if (check_books != null) {
		for (String books_del : check_books) {
			bookService.removeBook(books_del);
		}
		%>
		<c:redirect url='bookListView.jsp?back=true' />
		<%
	} else {
	%>
		<c:redirect url='bookListView.jsp?bookCheck=false' />
	<%
	}
%>