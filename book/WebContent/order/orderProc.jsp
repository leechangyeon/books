<%@page import="kimgibeom.book.book.service.BookService"%>
<%@page import="kimgibeom.book.book.service.BookServiceImpl"%>
<%@page import="kimgibeom.book.order.domain.OrderBook"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<%@page import="kimgibeom.book.order.domain.Order"%>
<%@page import="kimgibeom.book.book.domain.Book"%>
<%@page import="kimgibeom.book.order.service.OrderService"%>
<%@page import="kimgibeom.book.order.service.OrderServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%
	BookService bookService = new BookServiceImpl(); 
	OrderService OrderService = new OrderServiceImpl();
	String bookTitle = (String) (session.getAttribute("orderBookTitle"));
	String bookIsbn = (String) (session.getAttribute("orderBookIsbn"));
	int bookTotalPrice = (int) (session.getAttribute("orderBookTotalPrice"));

	OrderService.putOrder((String) session.getAttribute("userId"),
			new Order(1, Date.valueOf("1111-11-11"), "결제완료", bookTotalPrice));
	String userId = (String) session.getAttribute("userId");
	out.println(userId);
	List<Order> orders = OrderService.readOrder(userId);
	int i = orders.size() - 1;
	int orderNum = orders.get(i).getOrderNum();
	int orderBookCnt=(int) session.getAttribute("orderBookCount");

	OrderService.putOrderBook(orderNum, bookIsbn, new OrderBook(orderBookCnt));
	bookService.modifyBookCnt(bookIsbn,orderBookCnt);
	
	session.setAttribute("orderBookTitle", null);
	session.setAttribute("orderBookTotalPrice", null);
	session.setAttribute("orderBookIsbn", null);
	session.setAttribute("orderBookCount", null);
%><c:redirect url='orderSuccess.jsp' />