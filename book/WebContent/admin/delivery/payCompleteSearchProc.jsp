<%@page import="kimgibeom.book.order.domain.Order"%>
<%@page import="java.util.List"%>
<%@page import="kimgibeom.book.order.service.OrderServiceImpl"%>
<%@page import="kimgibeom.book.order.service.OrderService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%
	OrderService orderService = new OrderServiceImpl();
	String searchUserId = request.getParameter("searchUserId");
	out.println(searchUserId);
	if (searchUserId.equals("") || orderService.findUserOrderInfos(searchUserId).size() == 0) {
%>
<c:redirect url='payCompleteListView.jsp?searchEmpty=true' />
<%
	} else {
		List<Order> orders = orderService.findUserOrderInfos(searchUserId);
		session.setAttribute("searchOrderPayComplete", orders);
%>
<c:redirect url='payCompleteListView.jsp' />
<%
	}
%>