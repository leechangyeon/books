<%@page import="kimgibeom.book.order.service.OrderServiceImpl"%>
<%@page import="kimgibeom.book.order.service.OrderService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%
	String[] delOrderNum = request.getParameterValues("orderCheck");
	if(delOrderNum==null){
		%>
			<c:redirect url='orderListView.jsp?notSelect=true' />
		<%
	}else{
		OrderService orderService = new OrderServiceImpl();
		for(int i=0;i<delOrderNum.length;i++){
			if(orderService.removeOrder(Integer.parseInt(delOrderNum[i]))){
				out.println("제거성공");
			}
		}
	%>
		<c:redirect url='orderListView.jsp?back=true' />
	<%
	}
%>