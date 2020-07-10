<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="kimgibeom.book.delivery.domain.Delivery"%>
<%@page import="kimgibeom.book.delivery.service.DeliveryServiceImpl"%>
<%@page import="kimgibeom.book.delivery.service.DeliveryService"%>
<%
	request.setCharacterEncoding("utf-8");
	String orderNum = request.getParameter("orderNum");
	DeliveryService deliveryService = new DeliveryServiceImpl();
	Delivery delivery = deliveryService.findDelivery(Integer.parseInt(orderNum));
%>
<style>
.content {
	margin: 0 auto;
	margin-top: 50px;
}

a {
	text-decoration: none;
	display: block;
	background-color: #42a5be;
	color: #fff;
	padding: 10px 0;
}
	
h2 {
	text-align: center;
}

table {
	width: 100%;
}

th {
	background-color: #eee;
}

th, td {
	height: 31px;
	text-align: center;
}

table, th, td {
	border: 1px solid #ccc;
	border-collapse: collapse;
}

ul {
	list-style: none;
	margin: 0;
	padding: 0;
}

.btn {
	width: 70px;
	text-align: center;
	margin: 0 auto;
	margin-top: 30px;
}
</style>
<script type="text/javascript">
	//브라우져 닫기 기능
	<!--
	function closeWin() {
	var nvua = navigator.userAgent;
	if (nvua.indexOf('MSIE') >= 0){
	if(nvua.indexOf('MSIE 5.0') == -1) {
	top.opener = '';
	}
	} else if (nvua.indexOf('Gecko') >= 0){
	top.name = 'CLOSE_WINDOW';
	wid = window.open('','CLOSE_WINDOW');
	}
	top.close();
	}
	// -->
</script>
<div class="content">
	<h2>배송정보</h2>
	<table>
		<tr>
			<th>택배사</th>
			<td>한진택배</td>
		</tr>
		<tr>
			<th> 운송장 번호</th>
			<td><%= delivery.getDeliveryNum() %></td>
		</tr>
	</table>
	<div class="btn">
		<a href="javascript:void(0);" onclick="javascript:history.onclick=closeWin();">닫기</a>
	</div>
</div>