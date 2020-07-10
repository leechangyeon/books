<%@page import="kimgibeom.book.delivery.domain.Delivery"%>
<%@page import="java.util.List"%>
<%@page import="kimgibeom.book.delivery.service.DeliveryServiceImpl"%>
<%@page import="kimgibeom.book.delivery.service.DeliveryService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%
	DeliveryService deliveryService = new DeliveryServiceImpl();
	String searchUserId = request.getParameter("searchUserId");
	out.println(searchUserId);
	if (searchUserId.equals("") || deliveryService.findUserDeliveryComplete(searchUserId).size() == 0) {
%>
<c:redirect url='deliveryCompleteListView.jsp?searchEmpty=true' />
<%
	} else {
		List<Delivery> deliveries = deliveryService.findUserDeliveryComplete(searchUserId);
		session.setAttribute("searchDeliveryComplete", deliveries);
%> 
<c:redirect url='deliveryCompleteListView.jsp' />
<%
	}
%>