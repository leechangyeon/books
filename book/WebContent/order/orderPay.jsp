<%@page import="java.sql.Date"%>
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
<style>
.title {
	font-size: 20px;
	font-weight: bold;
	margin: 70px 0 40px 0;
	text-align: left;
}

.book_buy_step2:nth-child(1) {
	text-align: center;
}

.book_buy_step2:nth-child(1) span {
	font-weight: bold;
}

.book_buy_step2 {
	width: 790px;
	font-size: 14px;
	margin-left: 50px;
}

.book_buy_step2 form .button {
	overflow: hidden;
}

.book_buy_step2 form .button button {
	height: 40px;
	margin-top: 30px;
	float: right;
}

.book_buy_step2 form .button .ok {
	background-color: #42a5be;
	border: 1px solid #42a5be;
	width: 70px;
	color: #fff;
}

.book_buy_step2 form .button .no {
	width: 70px;
	margin-left: 5px;
}

.list_add {
	margin-top: 5px;
	background-color: #e7faff;
	height: 95px;
	padding-top: 25px;
	text-align: left;
	padding-left: 40px;
}

.list_add span {
	font-weight: bold;
}

.text {
	font-weight: 100 !important;
	color: #666;
	font-size: 13px;
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
				<a href="../user/logOut.jsp">로그아웃</a> <a href="../user/userInfo.jsp">마이페이지</a><%
						if(session.getAttribute("userId").equals("admin")){
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
			<div class="leftmenu">
				<div>도서</div>
				<ul>
					<li class="action"><a href="../book/bookListView.jsp">판매 도서</a></li>
				</ul>
			</div>
			<!-- 회원가입 -->
			<div class="content">
				<div class="book_buy_step2">
					<div>
						STEP1 회원정보 입력 > <span>STEP2 결제 안내</span> > STEP3 결제 완료
					</div>
					<div class="title">도서 구매</div>
					<%
						request.setCharacterEncoding("utf-8");
						String payment = request.getParameter("payment");
						int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
						int deliPrice=3000;
						int price=totalPrice+deliPrice;
					%>
				<%if(request.getParameter("proc").equals("1")){ %>
					<form action="orderProc.jsp">
				<%} else {%>
					<form action="cartOrderProc.jsp">
				<%} %>
						<div class="list_add">
							<span>결제 안내</span>&nbsp;&nbsp;<br><br>
							수&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;단 : <%= payment %>
							<br>
							총 결제금액	: <%=price %>원
						</div>
						<div class="button">
							<button class="no" type="submit" formaction="orderInput.jsp">취소</button>
							<button class="ok" type="submit">결제</button>
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