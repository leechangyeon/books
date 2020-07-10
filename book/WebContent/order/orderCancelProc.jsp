<%@page import="kimgibeom.book.order.service.OrderServiceImpl"%>
<%@page import="kimgibeom.book.order.service.OrderService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%
	if (request.getParameter("orderNum") != null) {
		int orderNum = Integer.parseInt(request.getParameter("orderNum"));
		OrderService orderService = new OrderServiceImpl();

		orderService.removeOrder(orderNum);
%>
<c:redirect url='orderListView.jsp' />
<%
	} else {
%>
<c:redirect url='orderListView.jsp?selectOrder=false' />
<%
	}
%>