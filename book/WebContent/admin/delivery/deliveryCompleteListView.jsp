<%@page import="kimgibeom.book.order.domain.OrderBook"%>
<%@page import="kimgibeom.book.book.domain.Book"%>
<%@page import="kimgibeom.book.delivery.domain.Delivery"%>
<%@page import="java.util.List"%>
<%@page import="kimgibeom.book.delivery.service.DeliveryServiceImpl"%>
<%@page import="kimgibeom.book.delivery.service.DeliveryService"%>
<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
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
<%
	request.setCharacterEncoding("UTF-8");

	if (session.getAttribute("userId") == null) {
%>
		<c:redirect url='../../main.jsp' />
<%
	}
	
	if (request.getParameter("back") != null && request.getParameter("back").equals("true")) {
	    session.setAttribute("searchDeliveryComplete", null);
	}

	DeliveryService deliveryService = new DeliveryServiceImpl();
	List<Delivery> deliveries = null;
	int currentPage;
	
	if (session.getAttribute("searchDeliveryComplete") == null) { 
		deliveries = deliveryService.readDeliveryCompleteList();
	}   
	else {
		deliveries = (List<Delivery>)session.getAttribute("searchDeliveryComplete");
	}
	   
	if(request.getParameter("currentPage")==null){
		currentPage = 1;
	}else{
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
%>
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
	margin-left: 270px;
	margin-right: 250px;
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
/* 페이징 */
.paging {
   width: 100%;
   text-align: center;
   overflow: hidden;
   margin-top: 30px;
}

.paging ul {
   display: inline-block;
}

.paging ul li {
   float: left;
   border: 1px solid #999;
   border-left: 0px;
}

.paging ul li a {
   padding: 7px 12px;
}

.paging ul li:hover {
   background-color: #42a5be;
   color: #fff;
}

.paging ul li:nth-child(1) {
   border-left: 1px solid #999;
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
					<li class="menu1 menu"><a href='../main.jsp?back=true'>회원관리</a></li>
					<li class="menu2 menu"><a href="..book/bookListView.jsp?back=true">도서관리</a></li>
					<li class="menu3 menu"><a
						href="../order/orderListView.jsp?back=true">주문관리</a></li>
					<li class="menu4 menu"><a href="payCompleteListView.jsp?back=true">배송관리</a></li>
					<li class="menu5 menu"><a
						href="../question/questionListView.jsp?back=true">문의관리</a></li>
				</ul>
			</div>
		</header>
		<div class='admin_book'>
			<button class='button4'>
				<a href='payCompleteListView.jsp?back=true'>결제완료</a>
			</button>
			<button class='button5'>
				<a href='deliveryCompleteListView.jsp?back=true'>배송완료</a>
			</button>
		</div>
		<div class='admin_book'>
			<div>
				<p>| 배송완료내역</p>
			</div>
			<form action="deliveryCompleteSearchProc.jsp">
				<input class='title' type='text' placeholder='사용자 아이디를 입력해주세요.' name="searchUserId">
				<button type='submit' class='button1'>
					<span class='glyphicon glyphicon-search'></span> 검색
				</button>
			</form>
			<br>
			<div>
				<form action='#'>
					<table class='table table-hover'>
						<tr>
							<th>주문번호</th>
							<th>운송장번호</th>
							<th>아이디</th>
							<th>이름</th>
							<th>핸드폰번호</th>
							<th>주소</th>
							<th>총 결제액</th>
							<th>제목</th>
							<th>저자</th>
							<th>수량</th>
						</tr>
						<%
	                        int endPage = (int)(Math.ceil(currentPage/5.0)*5);
	                        int startPage = (endPage-5)+1;
	                        int lastEndPage = (int)(Math.ceil(deliveries.size()/10.0));
	                        int startRow = (currentPage - 1) * 10;
	                        int endRow = currentPage * 10;
	                        
	                        if(endPage > lastEndPage) endPage = lastEndPage;
	                        
	                        boolean prev = startPage == 1 ? false:true;
	                        boolean next = endPage * 10 >= deliveries.size() ? false:true;
	
	                        if(deliveries.size()!=0){
	                        	 if(lastEndPage != currentPage){
	                        		 deliveries = deliveries.subList(startRow, endRow);
			                     }else{
			                    	 deliveries = deliveries.subList(startRow, deliveries.size());
			                        }
	                        }else{
	                        %>
								<tr>
									<td colspan='10'>배송 완료된 사용자가 없습니다.</td>
								</tr>
							<%
	                        }
	                    	
	                        if (request.getParameter("searchEmpty") != null && request.getParameter("searchEmpty").equals("true")) {
	                        	startPage = 1;
								endPage = -1;
	                     %>
								<tr><td colspan="10">검색한 사용자의 게시물이 없습니다.</td></tr>
						 <%
							}else{
								for (Delivery delivery : deliveries) {
									int orderNum = delivery.getOrder().getOrderNum();
									String strOrderNum = toStringOrderNum(orderNum);
						 %>
										<tr>
											<td rowspan='<%=delivery.getOrderBooks().size()%>'><%= strOrderNum %></td>
											<td rowspan='<%=delivery.getBooks().size()%>'><%= delivery.getDeliveryNum() %></td>
											<td rowspan='<%=delivery.getBooks().size()%>'><%=delivery.getUser().getUserId() %></td>
											<td rowspan='<%=delivery.getBooks().size()%>'><%=delivery.getUser().getUserName() %></td>
											<td rowspan='<%=delivery.getBooks().size()%>'><%= delivery.getUser().getUserPhoneNumber() %></td>
											<td rowspan='<%=delivery.getBooks().size()%>'><%= delivery.getUser().getUserAddress() %></td>
											<td rowspan='<%=delivery.getBooks().size()%>'><%= delivery.getOrder().getTotalPrice() %></td>
							<%
										int book = delivery.getBooks().size();
										List<Book> bookList = delivery.getBooks();
										List<OrderBook> bookCntList = delivery.getOrderBooks();
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
								}
							%>
					</table>
				</form>
			</div>
			<div class="paging">
				<ul>
				<%
                	if(prev) {
                %>
                    	<li><a href="deliveryCompleteListView.jsp?currentPage=<%= startPage - 1 %>">&laquo;</a></li>
                <%
                    }
                     		
					for(int i=startPage; i<=endPage; i++) { %>
                    	<li>
                       		<a href="deliveryCompleteListView.jsp?currentPage=<%= i %>"><%= i %></a>
                    	</li>
                <%
                    }
                    		
					if(next) {
                %>
                    	<li><a href="deliveryCompleteListView.jsp?currentPage=<%= endPage + 1 %>">&raquo;</a></li>
                <% 
                   	}
                %>
                </ul>
             </div>
		</div>
	</div>
</body>
</html>
<%!
public String toStringOrderNum (int orderNum) {
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