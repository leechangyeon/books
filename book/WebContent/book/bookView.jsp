<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kimgibeom.book.book.domain.Book"%>
<%@	page import="kimgibeom.book.book.service.BookServiceImpl, kimgibeom.book.book.service.BookService"%>
<%@ page import='java.util.List, java.util.ArrayList' %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<style>
.book_list {
	width: 790px;
	margin: 20px 0 60px 50px;
	font-size: 14px;
}

.book_list .title {
	font-size: 20px;
	font-weight: bold;
	margin-bottom: 40px;
}

.book_list .list {
	overflow: hidden;
}

.book_list .list div {
	float: left;
}

.book_list .list .book_img {
	width: 320px;
	height: 400px; 
	background-color: #ddd;
	margin-right: 50px;
}

.book_list .list .book_img img {
	width: 100%;
	height: 100%;
}

.book_list .list .book_text {
	width: 410px;
	color: #666;
}

.book_list .list .book_text .title {
	font-size: 21px;
	color: black;
}

.book_list .list .book_text p {
	margin: 5px 0 12px 0;
}

.book_list .list .book_text .pay {
	font-weight: bold;
	margin-bottom: 5px;
	color: black;
}

.book_list .list .book_text form {
	margin: 15px 0 15px 0;
	overflow: hidden;
}

.book_list .list .book_text form .booknum {
	width: 15%;
	height: 20px;
}

.book_list .list .book_text form .button {
	float: right;
}

.book_list .list .book_text form .button input {
	width: 202px;
	padding: 5px 0;
}

.book_list .list .book_text form .button input:nth-child(1) {
	background-color: #666;
	border: 1px solid #666;
	color: #fff;
}

.book_list .list .book_text form .button button {
	width: 202px;
	padding: 5px 0;
}

.book_list .list .book_text form button:nth-child(1) {
	background-color: #666;
	border: 1px solid #666;
	color: #fff;
}

hr {
	margin: 10px 0;
}

.int_text {
	line-height: 1.4em;
}

.buttom_button {
	overflow: hidden;
	width: 100%;
}

.buttom_button a {
	float: right;
	border: 1px soild #666;
	background-color: #666;
	padding: 8px 16px;
	margin-top: 30px;
	color: #fff;
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
					<form action="mainSearchProc.jsp">
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
						href="../question/questionListView.jsp">문의게시판</a></li>
				</ul>
			</div>
		</header>

		<!-- left메뉴 -->
		<div class="cont">
			<div class="leftmenu">
				<div>도서</div>
				<ul>
					<li class="action"><a href="bookListView.jsp?back=true">판매 도서</a></li>
				</ul>
			</div>
			<!-- 판매도서 -->
			<div class="content">
				<div class="book_list">
					<div class="title">판매 도서</div>
					<div class="list">
						<div class="book_img">
								<%
								String bIsbn=(String)session.getAttribute("isbn");
								session.setAttribute("isbn", null);
								BookService bookService = new BookServiceImpl();
								request.setCharacterEncoding("utf-8");
								String bookIsbn = ""; 
								if (bIsbn != null) {
									bookIsbn = bIsbn;
								} else {
									bookIsbn = request.getParameter("isbn");
								}
								Book book = bookService.findBook(bookIsbn);
								
								if(bookService.readBookImgName(book.getBookIsbn())!=null && !bookService.readBookImgName(book.getBookIsbn()).getBookImgName().equals("null")){
								String imgName=(bookService.readBookImgName(book.getBookIsbn())).getBookImgName();
									%>
										<img src='../attach/<%=imgName%>'/>
									<%
								}
								else{
									%>이미지 등록x<%
								}
								%>
								</div>
						<div class="book_text">
							<span class="title"><%=book.getTitle()%></span><br>
							<%=book.getWriter()%>
							지음 |
							<%=book.getPublisher()%><br> <br> <span class="pay">가격
								: <%=book.getPrice()%>원
							</span>
							<form name='add'
								action="../basket/basketProc.jsp?isbn=<%=book.getBookIsbn()%>" method='post'>
								주문수량: <input type="number" class="booknum" name="bookCnt"
									min='0' max='<%=book.getCount()%>' <%if(book.getCount()==0){ %>value='0'/><font color='red'><strong>
									재고가 없습니다.</strong></font><%}else{ %>value='1'/><%} %>
								<%
								if (request.getParameter("numCheck") != null && request.getParameter("numCheck").equals("false1")) {
							%>
								<font color='red'>선택한 수량이 0입니다.</font>
								<%
									} else if (request.getParameter("numCheck") != null && request.getParameter("numCheck").equals("false2")) {
								%>
								<font color='red'>재고보다 입력한 수량이 더 많습니다.</font>
								<%
									} else if (request.getParameter("numCheck") != null && request.getParameter("numCheck").equals("false3")) {
								%>
								<font color='red'>수량을 입력해주세요.</font>
								<%
									}
								%>
								<hr>
								<div class="button">
									<% 
										if (session.getAttribute("userId") != null) { 
											%>	
											<input type="button" onclick="load()" value="장바구니에 담기">
											<button type="submit"
												formaction="../order/orderInput.jsp?isbn=<%=book.getBookIsbn()%>">바로구매</button>
										<%
										} else {
										%>
											<button type="submit" formaction='../user/logIn.jsp'>장바구니에 담기</button>
											<button type="submit" formaction='../user/logIn.jsp'>바로구매</button>
										<%
										}
									%>
								</div>
							</form>
							<div class="int_text">
								<%=book.getContent()%>
							</div>
						</div>
						<div class="buttom_button">
							<a href="../book/bookListView.jsp">목록</a>
						</div>
					</div>
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
<script>
	function load() {//로컬 스토리지를 이용하여 서버 재부팅 후에도 같은 책 담기 방지
		var val = localStorage.getItem(<%=book.getBookIsbn()%>+"<%=session.getAttribute("userId")%>"); 
		if(val == "cartBook"){ 
			alert2(); //장바구니에 이미 담긴 책
		} else { //장바구니에 없는 책
			alert1(); 
		}
	}
	
	function alert1() {
		form = document.add;
		var max = <%= book.getCount() %>
		if (max >= form.bookCnt.value && form.bookCnt.value > 0) {
			swal({
				title : "장바구니",
				text : "장바구니에 추가되었습니다.",
				type : "success",
				confirmButtonText : "예",
				closeOnConfirm : false
			}, function() {
				form.submit();
			});
		} else if (form.bookCnt.value < 1 || form.bookCnt.value == "") {
			swal({
				title : "장바구니",
				text : "1개 이상 담을수 있습니다.",
				type : "error",
				confirmButtonText : "예",
				closeOnConfirm : false
			});
		} else {
			form.submit();
		}
	}
	
	function alert2() {
		form = document.add;
		if (form.bookCnt.value < 1 || form.bookCnt.value == "") {
			swal({
				title : "장바구니",
				text : "1개 이상 담을수 있습니다.",
				type : "error",
				confirmButtonText : "예",
				closeOnConfirm : false
			});
		}else{
			swal({
				title : "장바구니",
				text : "이미 장바구니에 담겼습니다.",
				type : "error",
				confirmButtonText : "예",
				closeOnConfirm : false
			});
		}
	}
	
<%	try{
		if(session.getAttribute("cartOrder").equals("complete")){
			%>
				localStorage.removeItem(<%=book.getBookIsbn()%>+"<%=session.getAttribute("userId")%>");
			<%
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>	
</script>	
</html>