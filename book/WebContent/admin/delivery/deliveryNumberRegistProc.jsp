<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ page import="kimgibeom.book.delivery.domain.Delivery"%>
<%@ page import="kimgibeom.book.order.domain.Order"%>
<%@ page import="kimgibeom.book.order.service.OrderService"%>
<%@ page import="kimgibeom.book.order.service.OrderServiceImpl"%>
<%@ page import="kimgibeom.book.delivery.service.DeliveryService"%>
<%@ page import="kimgibeom.book.delivery.service.DeliveryServiceImpl"%>
<%
	request.setCharacterEncoding("utf-8");
	DeliveryService deliveryService = new DeliveryServiceImpl();
	OrderService orderService = new OrderServiceImpl();
	int orderNum = (int) session.getAttribute("orderNum");
	deliveryService.enrollDelivery(orderNum, new Delivery(request.getParameter("deliNum"), "한진", 3000));

	session.setAttribute("orderNum", null);

	orderService.modifyOrderStatus(orderNum);
%>
<c:redirect url="payCompleteListView.jsp?back=true" />