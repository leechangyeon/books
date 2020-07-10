<%@page import="java.util.ArrayList"%>
<%@page import="kimgibeom.book.order.domain.OrderBook"%>
<%@page import="kimgibeom.book.book.domain.Book"%>
<%@page import="kimgibeom.book.order.domain.Order"%>
<%@page import="java.util.List"%>
<%@page import="kimgibeom.book.order.service.OrderServiceImpl"%>
<%@page import="kimgibeom.book.order.service.OrderService"%>
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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<script>
	function alert1() {
		swal({
			title : "고객 주문 취소",
			text : "주문을 취소하시겠습니까?",
			type : "warning",
			showCancelButton : true,
			cancelButtonText : "아니요",
			confirmButtonText : "예",
			closeOnConfirm : false
		}, function() {
			document.cancel.submit();
		});
	}
</script>
<%
	request.setCharacterEncoding("UTF-8");

	if (session.getAttribute("userId") == null) {
%>
		<c:redirect url='../../main.jsp' />
<%
	}
	
	if (request.getParameter("back") != null && request.getParameter("back").equals("true")) {
	    session.setAttribute("searchOrders", null);
	}

	OrderService orderService = new OrderServiceImpl();
	List<Order> orderInfos = null;
	int currentPage;
	
	if (session.getAttribute("searchOrders") == null) { 
		orderInfos = orderService.readOrderInfos(); 
	}   
	else {
		orderInfos = (List<Order>)session.getAttribute("searchOrders");
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

.glyphicon_del {
	margin-right: -20px;
}

.cancel {
	text-align: right;
}

.cancel input {
	width: 92px;
	padding-left: 22px;
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
					<li class="menu2 menu"><a href="../book/bookListView.jsp?back=true">도서관리</a></li>
					<li class="menu3 menu"><a
						href="orderListView.jsp?back=true">주문관리</a></li>
					<li class="menu4 menu"><a
						href="../delivery/payCompleteListView.jsp?back=true">배송관리</a></li>
					<li class="menu5 menu"><a
						href="../question/questionListView.jsp?back=true">문의관리</a></li>
				</ul>
			</div>
		</header>

		<div class='admin_book'>
			<div>
				<p>| 결제완료내역</p>
			</div>
			<%
				if (request.getParameter("notSelect") != null && request.getParameter("notSelect").equals("true")) {
					%>
						<font color='red'>취소할 주문을 선택해주세요.</font>
					<%
				}
			%>
			<form action='orderSearchProc.jsp'>
				<input class='title' type='text' placeholder='사용자 아이디를 입력해주세요.'
					name='searchUserId'>
				<button type='submit' class='button1'>
					<span class='glyphicon glyphicon-search'></span> 검색
				</button>
			</form>
			<br>
			<form name='cancel' class="cancel" action='orderDelProc.jsp'>
				<div>
					<table class='table table-hover'>
						<tr>
							<th>선택</th>
							<th>주문번호</th>
							<th>아이디</th>
							<th>이름</th>
							<th>전화번호</th>
							<th>주소</th>
							<th>총 결제액</th>
							<th>상품명</th>
							<th>저자</th>
							<th>수량</th>
						</tr>
						<%
	                        int endPage = (int)(Math.ceil(currentPage/5.0)*5);
	                        int startPage = (endPage-5)+1;
	                        int lastEndPage = (int)(Math.ceil(orderInfos.size()/10.0));
	                        int startRow = (currentPage - 1) * 10;
	                        int endRow = currentPage * 10;
	                        
	                        if(endPage > lastEndPage) endPage = lastEndPage;
	                        
	                        boolean prev = startPage == 1 ? false:true;
	                        boolean next = endPage * 10 >= orderInfos.size() ? false:true;
	
	                        if(orderInfos.size()!=0){
	                        	if(lastEndPage != currentPage){
	 	                        	orderInfos = orderInfos.subList(startRow, endRow);
	 	                        }else{
	 	                        	orderInfos = orderInfos.subList(startRow, orderInfos.size());
	 	                        }
	                        }else{
	                    	%>
								<tr>
									<td colspan='10'>결제 완료된 사용자가 없습니다.</td>
								</tr>
							<%
	                        }
							
							if(request.getParameter("searchEmpty") != null && request.getParameter("searchEmpty").equals("true")) {
								startPage = 1;
								endPage = -1;
						%>
								<tr>
									<td colspan='10'>검색된 사용자가 없습니다.</td>
								</tr>
						<%
							}else {
								for (Order o : orderInfos) {
						%>


						<tr>
							<td rowspan='<%=o.getBooks().size()%>'><input
								type='checkbox' name='orderCheck' value='<%=o.getOrderNum()%>'></td>
							<td rowspan='<%=o.getBooks().size()%>'><%=o.getOrderNum()%></td>
							<td rowspan='<%=o.getBooks().size()%>'><%=o.getUser().getUserId()%></td>
							<td rowspan='<%=o.getBooks().size()%>'><%=o.getUser().getUserName()%></td>
							<td rowspan='<%=o.getBooks().size()%>'><%=o.getUser().getUserPhoneNumber()%></td>
							<td rowspan='<%=o.getBooks().size()%>'><%=o.getUser().getUserAddress()%></td>
							<td rowspan='<%=o.getBooks().size()%>'><%=o.getTotalPrice()%></td>
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
							<td><%=bookCntList.get(i).getCount()%></td>
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
				</div>
				
				<div class="paging">
                    	<ul>
						<%
                     		if(prev) {
                  		%>
                     			<li><a href="orderListView.jsp?currentPage=<%= startPage - 1 %>">&laquo;</a></li>
                  		<%
                     		}
                      		
							for(int i=startPage; i<=endPage; i++) { %>
                     			<li>
                        			<a href="orderListView.jsp?currentPage=<%= i %>"><%= i %></a>
                     			</li>
                  		<%
                     		}
                     		
							if(next) {
                  		%>
                     			<li><a href="orderListView.jsp?currentPage=<%= endPage + 1 %>">&raquo;</a></li>
                  		<% 
                    		 }
                  		%>
                  		</ul>
                  </div>
				<div>
					<span class='glyphicon glyphicon-trash glyphicon_del'></span><input
						type='button' onclick="alert1()" value='주문 취소'>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
