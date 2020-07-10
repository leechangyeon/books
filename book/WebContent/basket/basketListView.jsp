<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kimgibeom.book.book.domain.Book"%>    
<%@	page import="kimgibeom.book.book.service.BookServiceImpl, 
	kimgibeom.book.book.service.BookService"%>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="java.util.StringTokenizer" %>       
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우주 서점</title>
<link rel="stylesheet" href="../css/main.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<style>
.basket_add {
	width: 790px;
	font-size: 14px;
	margin: 20px 0 60px 50px;
}
 
.basket_add table {
	border: 0px solid #666;
	border-collapse: collapse;
	text-align: left;
	width: 790px;
	font-size: 14px;
}

.basket_add table .text input {
	height: 25px;
	width: 35%;
}

.list_add {
	margin-top: 40px;
	background-color: #e7faff;
	height: 40px;
	padding-top: 25px;
}

.list_add span {
	font-weight: bold;
}

.basket_add form {
	margin-top: 10px;
}

.basket_add form div {
	margin-bottom: 10px;
}

.basket_add form .button {
	overflow: hidden;
}

.basket_add form .button button {
	height: 40px;
	margin-top: 30px;
	float: right;
}

.basket_add th {
	border-right: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 40px;
	background-color: #eee;
	text-align: center;
}

.basket_add td {
	border-right: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 40px;
	text-align: center;
}

.basket_add tr:hover td {
	background-color: #fafafa;
}

.basket_add tr td:nth-child(3) {
	text-align: left;
}

.basket_add .text button {
	height: 30px;
	background-color: #666;
	border: 0px;
	color: #fff;
}

.basket_add .title {
	font-size: 20px;
	font-weight: bold;
}

.basket_add form .button button {
	height: 40px;
	margin-top: 30px;
	float: right;
}

.basket_add form .button .ok {
	background-color: #42a5be;
	border: 1px solid #42a5be;
	width: 150px;
	color: #fff;
}

.basket_add form .button .no {
	width: 70px;
	margin-left: 5px;
}

.basket_add .leftline {
	border-left: 0px;
}

.basket_add .rightline {
	border-right: 0px;
}
</style>
</head>
<body>
	<div class="container">
		<!-- 탑 -->
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
					} else {
				%>
				<a href="../user/logIn.jsp">로그인</a> <a href="../user/joinAgree.jsp">회원가입</a>
				<c:redirect url="../user/logIn.jsp" />
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
            		Cookie[] cookies1 = request.getCookies();
            		String logoImgName="";
            		if(cookies1 != null){
            			for(Cookie c:cookies1){
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
					<li class="menu3 menu"><a href="../question/questionListView.jsp?back=true">문의게시판</a></li>
				</ul>
			</div>
		</header>

		<!-- left메뉴 -->
		<div class="cont">
			<div class="leftmenu leftmenu_3">
				<div>마이페이지</div>
				<ul>
					<li><a href="../user/userInfo.jsp">개인정보</a></li>
					<li class="action"><a href="basketListView.jsp">장바구니</a></li>
					<li><a href="../order/orderListView.jsp">구매조회</a></li>
					<li><a href="../user/userWithdraw.jsp">회원탈퇴</a></li>
				</ul>
			</div>
			
			<div class="content">
				<div class="basket_add">
					<div class="title">장바구니</div>
					<%
						List<String> isbns = new ArrayList<>();
						List<String> delIsbns = new ArrayList<>();
						StringTokenizer st = null;
						String cart = "";
						
						String userId = String.valueOf(session.getAttribute("userId"));
						
						Cookie[] cookies = request.getCookies();
						try{
							if(session.getAttribute("cartOrder").equals("complete")){
								for(Cookie cookie:cookies){
									if(cookie.getName().equals(userId)){
										cart = cookie.getValue();
										st = new StringTokenizer(cart, "/");
										while(st.hasMoreTokens()) delIsbns.add(st.nextToken());
										
										Cookie cookie3 = new Cookie(userId, "");
										cookie3.setMaxAge(0);
										response.addCookie(cookie3);
									}
								}
							}
						}catch(Exception e){
							e.printStackTrace();
							
							for(Cookie cookie: cookies){ 
								if(cookie.getName().equals(userId)){
									cart = cookie.getValue();
									st = new StringTokenizer(cart, "/");
									while(st.hasMoreTokens()) isbns.add(st.nextToken());
								}
							}
						}
						
						BookService bookService = new BookServiceImpl();
						Book book = new Book();			
					%>			
					<form action="basketDelProc.jsp" method="post">
						<table>
							<colgroup>
								<col width="6%">
								<col width="8%">
								<col width="35%">
								<col width="8%">
								<col width="17%">
								<col width="16%">
								<col width="8%">
							</colgroup>
							<tr>
								<th class="leftline">선택</th>
								<th>번호</th>
								<th>도서명</th>
								<th>가격</th>
								<th>저자명</th>
								<th>출판사</th>
								<th class="rightline">수량</th>
							</tr>
						<%
							int listNum = 0;
							int bookPrice = 0;
							int totPrice = 0;
							int cartNum = 0;
							
							//구매를 위한 정보들
							List<String> books = new ArrayList<>();
							List<Integer> bookCnts = new ArrayList<>();
							List<Integer> bookTotPrice = new ArrayList<>();
							
							for(String bookIsbn:isbns){
								listNum++;
								book = bookService.findBook(bookIsbn);
								
								books.add(bookIsbn);
								session.setAttribute("cartBookIsbn", books); 
								
								for(Cookie cookie: cookies) 
									if(cookie.getName().equals(bookIsbn+userId))
										cartNum = Integer.parseInt(cookie.getValue());
								
								bookCnts.add(cartNum); 
								session.setAttribute("cartBookCnt", bookCnts);
								
								bookPrice = book.getPrice() * cartNum; //각 책의 단가 * 수량
								totPrice += bookPrice;
								
								bookTotPrice.add(totPrice);
								session.setAttribute("cartBookPrice", bookTotPrice);
							%>
								<tr>
									<td><input type="checkbox" name="books" value="<%= book.getBookIsbn() %>"/></td>
									<td><%= listNum %></td>
									<td><%= book.getTitle() %></td>
									<td><%= book.getPrice() %></td>
									<td><%= book.getWriter() %></td>
									<td><%= book.getPublisher() %></td> 
									<td><%= cartNum %> 
								</tr>
						<%		
							}		
						%>			
					
					<div class="list_add">
					<% 	int deliveryFee = 0; 
						if(bookPrice != 0) deliveryFee = 3000;
					%>
						&nbsp;&nbsp;상품 가격: <%= totPrice %>원 
						&nbsp;+ &nbsp;배송비: <%= deliveryFee %>원 
						&nbsp;= &nbsp;<span>총가격: <%= totPrice + deliveryFee %>원</span>
					</div>	
						</table>
						<div class="button">
							<button class="no" type="submit" formaction="../order/orderInput.jsp">구매</button>
							<button class="ok" type="submit">장바구니에서 제거</button>
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
<script>
	<%if(book.getBookIsbn()!=null){%> // 로컬 스토리지 생성
	localStorage.setItem(<%=book.getBookIsbn()%>+"<%=session.getAttribute("userId")%>","cartBook");
	<%}%>
	<%	
	String delBook = "";
	StringTokenizer st2 = null;
	List<String> delBooks = new ArrayList<>();
	
	try{
	for(Cookie cookie:cookies)
		if(cookie.getName().equals("delBook"+session.getAttribute("userId"))){
			delBook = cookie.getValue();
			st2 = new StringTokenizer(delBook, "/");
			while(st2.hasMoreTokens()) delBooks.add(st2.nextToken());
			
			for(String Book:delBooks){ //해당 로컬 스토리지 삭제
			%>	
				localStorage.removeItem(<%=Book%>+"<%=session.getAttribute("userId")%>");
			<%	
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}
		}
	
	if(session.getAttribute("cartOrder").equals("complete")){
		for(String isbn:delIsbns){
			for(Cookie cookie:cookies)
				if(cookie.getName().equals(isbn+userId)){
					Cookie cookie4 = new Cookie(isbn+userId, "");
					cookie4.setMaxAge(0);
					response.addCookie(cookie4);
				%>
					localStorage.removeItem(<%=isbn%>+"<%=session.getAttribute("userId")%>");
				<%
				}			
		}
		
		session.setAttribute("cartOrder", null);
	}
	}catch(Exception e){
	e.printStackTrace();
	}
	%>
</script>
</html>    