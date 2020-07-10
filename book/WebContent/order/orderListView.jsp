<%@page import="kimgibeom.book.order.domain.OrderBook"%>
<%@page import="kimgibeom.book.book.domain.Book"%>
<%@page import="java.util.List"%>
<%@page import="kimgibeom.book.order.domain.Order"%>
<%@page import="kimgibeom.book.order.service.OrderServiceImpl"%>
<%@page import="kimgibeom.book.order.service.OrderService"%>
<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우주 서점</title>
<link rel="stylesheet" href="../css/main.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<script>
	function alert1() {
		swal({
			title : "구매를 취소하시겠습니까?",
			text : "결제 취소 시 입금은 4~5 영업일 이내입니다.",
			type : "warning",
			showCancelButton : true,
			cancelButtonText : "아니요",
			confirmButtonText : "예",
			closeOnConfirm : false
		}, function() {
			document.cancel.submit();
		});
	}
	function alert3() {
		swal("배송정보", "아직 배송이 시작되지 않았습니다.");
	}
	function alert2() {
		swal("배송정보", "택배사 : 한진택배\n운송장번호 : 12412-12-412442");
	}
</script>
<style>
.glyphicon_del {
	margin-right: -20px;
}

.cancel {
	text-align: right;
}

.sell_list {
	width: 790px;
	font-size: 14px;
	margin: 20px 0 60px 50px;
}

.sell_list table {
	border: 0px solid #666;
	border-collapse: collapse;
	text-align: left;
	width: 790px;
	font-size: 14px;
}

.sell_list table .text input {
	height: 25px;
	width: 35%;
}

.sell_list form {
	margin-top: 40px;
}

.sell_list form div {
	margin-bottom: 10px;
}

.sell_list form .button {
	overflow: hidden;
}

.sell_list form .button button {
	height: 40px;
	margin-top: 30px;
	float: right;
}

.sell_list th {
	border-right: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 40px;
	background-color: #eee;
	text-align: center;
	font-size: 13px;
}

.sell_list td {
	border-right: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 40px;
	text-align: center;
	font-size: 12px;
}

.sell_list td button {
	font-size: 12px;
}

.sell_list tr:hover td {
	background-color: #fafafa;
}

.sell_list tr td:nth-child(2) {
	text-align: left;
}
/*.basket_add tr td .yes{background-color:#666; border:0px; color:#fff; padding:3px 6px;}*/
.sell_list tr td .no {
	background-color: #fff;
	border: 1px solid #ccc;
	padding: 3px 6px;
	color: #999;
}

.sell_list .text button {
	height: 30px;
	background-color: #666;
	border: 0px;
	color: #fff;
}

.sell_list .title {
	font-size: 20px;
	font-weight: bold;
}

.sell_list form .button button {
	height: 40px;
	margin-top: 30px;
	float: right;
}

.sell_list .leftline {
	border-left: 0px;
}

.sell_list .rightline {
	border-right: 0px;
}
</style>
</head>
<body>
	<div class="container">
		<!-- 탑배너 -->
		<div class="top">
			<div>
				<%
					if (session.getAttribute("userId") != null) {
				%>
				${userId}<%
					out.println("님, 환영합니다");
				%>
				<a href="../user/logOut.jsp">로그아웃</a> <a href="../user/userInfo.jsp">마이페이지</a>
				<%
					if (session.getAttribute("userId").equals("admin")) {
				%>
				<a href="../admin/main.jsp">관리자페이지</a>
				<%
					}
				%>
				<%
					} else {
				%>
				<a href="../user/logIn.jsp">로그인</a> <a href="../user/joinAgree.jsp">회원가입</a>
				<c:redirect url='../user/logIn.jsp' />
				<%
					}
				%>
			</div>
		</div>

		<!-- 검색창 -->
		<div class="tophead">
			<div class="logo">
				<a href="../main.jsp">
            	<%
            		Cookie[] cookies = request.getCookies();
            		String logoImgName="";
            		if(cookies != null){
            			for(Cookie c:cookies){
            				if(c.getName().equals("logoImage")){
            					logoImgName=c.getValue();
            				} 
            			}
            		}
            		if(logoImgName.equals("")){
            			%>로고이미지<%
            		} 
            		else{
            			%><img src='../img/<%=logoImgName%>'/><%
            		}
            	%></a> 
			</div>
			<div class="sear">
				<div class="search">
					<form action="../book/mainSearchProc.jsp">
						<select name="mainSearchSelect">
							<option value="book">도서</option>
						</select> <input type="text" name="searchText"
							placeholder="검색어를 입력해 주세요." required>
						<button type="submit">
							<i class="fas fa-search"></i>
						</button>
					</form>
				</div>
			</div>
		</div>

		<!-- 메뉴 -->
		<header>
			<div class="nav">
				<ul>
					<li class="menu1 menu"><a href="../introduce/ceoGreet.jsp">서점
							소개</a>
						<ul>
							<li><a href="../introduce/ceoGreet.jsp">인사말</a></li>
							<li><a href="../introduce/companyLocation.jsp">오시는 길</a></li>
						</ul></li>
					<li class="menu2 menu"><a href="../book/bookListView.jsp?back=true">도서</a></li>
					<li class="menu3 menu"><a
						href="../question/questionListView.jsp?back=true">문의게시판</a></li>
				</ul>
			</div>
		</header>
		<!-- left메뉴 -->
		<div class="cont">
			<div class="leftmenu leftmenu_3">
				<div>마이페이지</div>
				<ul>
					<li><a href="../user/userInfo.jsp">개인정보</a></li>
					<li><a href="../basket/basketListView.jsp">장바구니</a></li>
					<li class="action"><a href="orderListView.jsp">구매조회</a></li>
					<li><a href="../user/userWithdraw.jsp">회원탈퇴</a></li>
				</ul>
			</div>
			<%
				OrderService orderService = new OrderServiceImpl();
				String userId = (String) session.getAttribute("userId");
				List<Order> userOrders = orderService.readUserOrderInfos(userId);
			%>
			<div class="content">
				<div class="sell_list">
					<div class="title">구매조회</div>
					<form class='cancel' name='cancel' action='orderCancelProc.jsp'>
						<table>
							<colgroup>
								<col width="10%">
								<col width="11%">
								<col width="12%">
								<col width="20%">
								<col width="9%">
								<col width="7%">
								<col width="10%">
								<col width="10%">
								<col width="12%">
							</colgroup>
							<tr>
								<th class="leftline">주문번호</th>
								<th>주문일자</th>
								<th>총 결제금액<br>
								</th>
								<th>책 제목</th>
								<th>책 가격</th>
								<th>수량</th>
								<th>주문상태</th>
								<th>취소</th>
								<th class="rightline">배송조회</th>
							</tr>
							<%
								for (Order o : userOrders) {
									boolean one = true;
							%>
							<% 
									int orderNum = o.getOrderNum();
									String strOrderNum = toStringOrderNum(orderNum);
							%>
							<tr>
								<td rowspan='<%=o.getBooks().size()%>'><%=strOrderNum%></td>
								<td rowspan='<%=o.getBooks().size()%>'><%=o.getOrderDate()%></td>
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
								<td><%=bookList.get(i).getPrice()%></td>
								<td><%=bookCntList.get(i).getCount()%></td>
								<%
									if (one == true) {
								%>
								<td rowspan='<%=o.getBooks().size()%>'><%=o.getStatus()%></td>
								<td rowspan='<%=o.getBooks().size()%>'>
									<%
										if (o.getStatus().equals("결제완료")) {
									%> <input type='radio' name='orderNum'
									value='<%=o.getOrderNum()%>'> <%
									 	} else {
									 %> 취소불가 <%
									 	}
									 %>
								</td>
								<%
									if (o.getStatus().equals("결제완료")) {
								%>
								<td rowspan='<%=o.getBooks().size()%>'><input type='button'
									value='배송조회' onclick='alert3()' /></td>
								<%
									} else {
								%>
								<td rowspan='<%=o.getBooks().size()%>'>
									<input class="pop_alert" type='button' value='배송조회' onClick="window.open('orderPop.jsp?orderNum=<%= o.getOrderNum() %>', '', 'width=400, height=280, left=750, top=250'); return false;"/>
								</td>
								<%
									}
												one = false;
											}
								%>
							</tr>
							<%
								}
								}
							%>
						</table>
						<br>
						<br>
						<div>
							<%
								if (request.getParameter("selectOrder")!=null && request.getParameter("selectOrder").equals("false")) {
									%>
										<font color='red'>취소할 주문을 선택하세요.</font><br><br>
									<%
								}
							%>

							<span class='glyphicon glyphicon-trash glyphicon_del'></span><input
								type='button' onclick="alert1()" value='주문 취소' />
						</div>
					</form>
				</div>
			</div>
		</div>

		<!-- 푸터 -->
		<footer>
			<div class="fot">
				<div class="logo">
					<%
            		Cookie[] cookies2 = request.getCookies();
            		String logoImgName2="";
            		if(cookies2 != null){
            			for(Cookie c:cookies2){
            				if(c.getName().equals("logoImage")){
            					logoImgName2=c.getValue();
            				} 
            			}
            		}
            		if(logoImgName2.equals("")){
            			%>로고이미지<%
            		} 
            		else{
            			%><img src='../img/<%=logoImgName2%>'/><%
            		}
            	%>
				</div>
				<div>
					우주서점 &nbsp;&nbsp;서울 마포구 월드컵북로 21 2층 풍성빌딩 &nbsp;&nbsp;대표이사 : 김기범<br>
					사업자등록번호 : 102-80-11690 &nbsp;&nbsp;대표전화 : 1544-1000 (발신자 부담전화)<br>
					COPYRIGHT© SPACE BOOK CENTER ALL RIGHTS RESERVED.
				</div>
			</div>
		</footer>
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