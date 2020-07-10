<%@page import="kimgibeom.book.order.domain.Order"%>
<%@page import="kimgibeom.book.order.service.OrderServiceImpl"%>
<%@page import="kimgibeom.book.order.service.OrderService"%>
<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@page import="kimgibeom.book.order.domain.OrderBook"%>
<%@page import="kimgibeom.book.book.domain.Book"%>
<%@page import="kimgibeom.book.delivery.domain.Delivery"%>
<%@page import="java.util.List"%>
<%@page import="kimgibeom.book.delivery.service.DeliveryServiceImpl"%>
<%@page import="kimgibeom.book.delivery.service.DeliveryService"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin_book</title>
<link rel="stylesheet" href="../../css/main.css">

<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">

<style>
a {
	text-decoration: none;
	color: inherit;
	display: block
}

a:hover {
	text-decoration: none;
}

.button4 {
	background-color: #e2001e;
	border: none;
	color: white;
	padding: 3px 12px;
	text-align: center;
	font-size: 16px;
	margin: 4px 2px;
	opacity: 0.6;
	transition: 0.3s;
	display: inline-block;
	text-decoration: none;
	cursor: pointer;
}

.button4:hover {
	opacity: 1
}

.button5 {
	background-color: #a5501c;
	border: none;
	color: white;
	padding: 3px 12px;
	text-align: center;
	font-size: 16px;
	margin: 4px 2px;
	opacity: 0.6;
	transition: 0.3s;
	display: inline-block;
	text-decoration: none;
	cursor: pointer;
}

.button5:hover {
	opacity: 1
}

.admin_book div p {
	font-weight: bold;
	font-size: 20px;
}

.admin_book {
	margin-top: 40px;
	margin-left: 440px;
	margin-right: 420px;
}

.title {
	width: 500px;
}

th, td {
	text-align: center;
}

#paging-body {
	float: left;
	width: 100%;
	text-align: center;
}

.button1 {
	background-color: #f5501c;
	border: none;
	color: white;
	padding: 4px 14px;
	text-align: center;
	font-size: 16px;
	margin: 4px 2px;
	opacity: 0.6;
	transition: 0.3s;
	display: inline-block;
	text-decoration: none;
	cursor: pointer;
	border: none;
}

.button1:hover {
	opacity: 1
}

.button2, .button3 {
	float: right;
	margin-right: 4px;
	height: 30px;
}

.title {
	width: 500px;
	padding: 3px;
}

.deli_num {
	width: 300px;
}
</style>
</head>
<body>
	<div>
		<div class="top">
			<div>
				<a href="../user/logOut.jsp">로그아웃</a><a href="../main.jsp">메인으로</a><a href="../../main.jsp">사용자페이지</a><a href="../logo/putLogo.jsp">로고등록</a><a href="../banner/putBanner.jsp">배너등록</a>
			</div>
		</div>

		<div class="tophead">
			<div class="logo">
				<a href="../main.jsp?back=true"><h3><strong>관리자 페이지</strong></h3></a>
			</div>
		</div>

		<header>
			<div class="nav">
				<ul>
					<li class="menu1 menu"><a href="../main.jsp">회원관리</a></li>
					<li class="menu2 menu"><a href="../book/bookListView.jsp">도서관리</a></li>
					<li class="menu3 menu"><a href="../order/orderListView.jsp">주문관리</a></li>
					<li class="menu4 menu"><a
						href="payCompleteListView.jsp">배송관리</a></li>
					<li class="menu5 menu"><a
						href="../question/questionListView.jsp">문의관리</a></li>
				</ul>
			</div>
		</header>
		<div class='admin_book'>
			<div>
				<p>| 배송정보입력</p>
			</div>
			<br>
			<div>
				<form action='#'>
					<table class='table'>
						<tr>
							<th>아이디</th>
							<th>이름</th>
							<th>주문번호</th>
							<th>전화번호</th>
							<th>주소</th>
							<th>총 결제액</th>
							<th>상품명</th>
							<th>저자</th>
							<th>수량</th>
						</tr>
						<%
							int orderNum = Integer.parseInt(request.getParameter("orderNum"));
							OrderService orderService = new OrderServiceImpl();
							List<Order> orders = orderService.readPayCompleteOrder(orderNum);
							session.setAttribute("orderNum",orderNum);
				
							for (Order o : orders) {
						%>
						<tr>
							<td rowspan='<%=o.getBooks().size()%>'><%= o.getUser().getUserId() %></td>
							<td rowspan='<%=o.getBooks().size()%>'><%= o.getUser().getUserName() %></td>
							<% 
								String strOrderNum = toStringOrderNum(orderNum);
							%>
							<td rowspan='<%=o.getBooks().size()%>'><%= strOrderNum %></td>
							<td rowspan='<%=o.getBooks().size()%>'><%= o.getUser().getUserPhoneNumber() %></td>
							<td rowspan='<%=o.getBooks().size()%>'><%= o.getUser().getUserAddress() %></td>
							<td rowspan='<%=o.getBooks().size()%>'><%= o.getTotalPrice() %></td>
						<%
								int book = o.getBooks().size();
								List<Book> bookList = o.getBooks();
								List<OrderBook> bookCntList = o.getOrder_books();
						%>
						<%
								for (int i = 0; i < book; i++) {
						%>
									<td><%=bookList.get(i).getTitle()%></td>
									<td><%=bookList.get(i).getWriter()%></td>
									<td><%= bookCntList.get(i).getCount() %></td>
						</tr>
						<%
									if (i != book) {
						%>
						<tr>
						<%
									}
								}
							}
							%>
	
					</table>
					<hr>
					<br>
				</form>
				<form class="form-inline">
					<div class="panel panel-default">
						<!-- 테이블 -->
						<div>
							<table class="table">
								<tbody>
									<tr>
										<th>현재상태</th>
										<td>결제완료</td>
									</tr>
									<tr>
										<th>택배사</th>
										<td>한진택배</td>
									</tr>
									<tr>
										<th><b>운송장 번호</b></th>
										<td><input class='deli_num' type='number' name="deliNum"
											placeholder='송장번호를 입력해주세요.' value=""/></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<!-- 테이블 끝-->

					<button class='button2' formaction='payCompleteListView.jsp'>
						<span class='glyphicon glyphicon-remove'></span> 등록취소
					</button>
					<button class='button2' formaction='deliveryNumberRegistProc.jsp'>
						<span class='glyphicon glyphicon-ok'></span> 배송정보등록
					</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
<%!
public String toStringOrderNum(int orderNum) {
	if (orderNum / 10000000 > 0)	
		return "" + orderNum;
	else if (orderNum / 1000000 > 0)
		return "0" + orderNum;
	else if (orderNum / 100000 > 0)
		return "00" + orderNum;
	else if (orderNum / 10000 > 0)
		return "000" + orderNum;
	else if (orderNum / 1000 > 0)
		return "0000" + orderNum;
	else if (orderNum / 100 > 0)
		return "00000" + orderNum;
	else if (orderNum / 10 > 0)
		return "000000" + orderNum;
	else
		return "0000000" + orderNum;
}
%>