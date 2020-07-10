<%@page import="kimgibeom.book.book.domain.Book"%>
<%@page import="kimgibeom.book.book.service.BookService"%>
<%@page import="kimgibeom.book.book.service.BookServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="java.util.ArrayList, java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우주 서점</title>
<link rel="stylesheet" href="../css/main.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
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
	text-align: center;
	overflow: hidden;
}

.book_list .list ul {
	float: left; 
	margin-left: 30px;
	overflow: hidden;
	width:175px;
}

.book_list .list ul:nth-child(1) {
	margin-left: 0;
}

.book_list .list .book_img {
	width: 175px;
	height: 220px;
	background-color: #ccc;
}

.book_list .list .book_img img {
	width: 100%;
	height: 100%;
}

.book_list .list .text {
	margin-top: 10px;
	text-overflow: ellipsis;
 	white-space: nowrap;
 	width:175px;
 	overflow: hidden;
}

.book_list .list span {
	font-size: 14px;
	color: #666;
}

.book_list .second_list {
	margin-top: 30px;
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
					<li class="menu2 menu"><a href="bookListView.jsp?back=true">도서</a></li>
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
					<li class="action"><a href="bookListView.jsp?back=true">판매 도서</a></li>
				</ul>
			</div>
			<!-- 회원가입 -->
			
			<div class="content">
				<div class="book_list">
					<div class="title">판매 도서</div>
					<%
						if(request.getParameter("back")!=null&&request.getParameter("back").equals("true")){
							session.setAttribute("searchBooks",null);
						}
					
						List<Book> books = new ArrayList<>();
						String isbn = "";
						
						BookService bookService = new BookServiceImpl();
						List<Book> bookIsbns = bookService.readIsbns();
						
						if(session.getAttribute("searchBooks")!=null){
							books=(List<Book>)session.getAttribute("searchBooks");
						}else{
							for(Book bookIsbn:bookIsbns){
								isbn = String.valueOf(bookIsbn.getBookIsbn());
								books.add(bookService.findBook(isbn));
							}
						}
						int list = bookIsbns.size() / 4+1; //단락 수
						int num = 0;
						for(int i=0; i<list; i++){ //단락 수 만큼 출력
							num++; //1부터 시작. 자식 for문 빠져나오면 1 추가
							int cnt = 0;
					%>								
					<div class="list second_list">	
						<% 
							if(books.size()==0){
								%><ul>
									도서를 찾을수 없습니다.
								</ul>
								</div>
								<%
								break;
							}else{
								
							for(Book book:books){ 
								cnt++;
								//이번 단락은 cnt가 0 초과 4 이하 그 다음 단락은 cnt가 4 초과 8 이하일 때 출력해야 한다.
								if((num-1)*4 < cnt && cnt <= num*4){
						%>
						<ul>
								<a href="bookView.jsp?isbn=<%= book.getBookIsbn() %>">
								<li class="book_img"><%
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
								</li>
								<li class="text">
							<%
								out.print(book.getTitle());
							%>
								<span><br>
							<%
								out.print(book.getPrice() + "원");
							%>
								</span></li>
								</a>
						</ul>	
						<%
								}
							}	}
						%>					
					</div>
					<%
						}
					%>
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