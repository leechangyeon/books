<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ page import="kimgibeom.book.book.service.BookService" %>
<%@ page import="kimgibeom.book.book.service.BookServiceImpl" %>
<%@ page import="kimgibeom.book.book.domain.Book" %>
<%@	page import="java.util.ArrayList, java.util.List"%>
<%
	request.setCharacterEncoding("UTF-8");

	if (request.getParameter("back") != null && request.getParameter("back").equals("true")) {
		session.setAttribute("searchBookTitle", null);
	}

	String isbn = "";
	
	BookService bookService = new BookServiceImpl();
	List<Book> books = new ArrayList<>();
	int currentPage;
	
	if(session.getAttribute("searchBookTitle") == null){
		List<Book> bookIsbns = bookService.readIsbns();
		for(Book bookIsbn:bookIsbns){ 
			isbn = String.valueOf(bookIsbn.getBookIsbn());
			books.add(bookService.findBook(isbn));
		}
	}else{
		List<Book> bookIsbns = bookService.readIsbns();
		for(Book bookIsbn:bookIsbns){ 
			isbn = String.valueOf(bookIsbn.getBookIsbn());
			books.add(bookService.findBook(isbn));
		}
		List<Book> searchBookTitle = (List<Book>) session.getAttribute("searchBookTitle");
		books = searchBookTitle;
	}
	
	if(request.getParameter("currentPage")==null){
		currentPage = 1;
	}else{
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
%>
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
	if(session.getAttribute("userId")==null){
%>
		<c:redirect url='../../main.jsp' />
<%
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

.btn_button {
	margin-bottom: 120px;
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
					<li class="menu2 menu"><a href="bookListView.jsp?back=true">도서관리</a></li>
					<li class="menu3 menu"><a
						href="../order/orderListView.jsp?back=true">주문관리</a></li>
					<li class="menu4 menu"><a
						href="../delivery/payCompleteListView.jsp?back=true">배송관리</a></li>
					<li class="menu5 menu"><a
						href="../question/questionListView.jsp?back=true">문의관리</a></li>
				</ul>
			</div>
		</header>

		<div class='admin_book'>
			<div>
				<p>| 도서리스트</p>
			</div>
				<%
					if (request.getParameter("bookCheck") != null && request.getParameter("bookCheck").equals("false")) {
				%>
				<font color='red'>삭제할 도서를 선택하지 않았습니다.</font>
				<%
					}
				%>
			<form action="bookSearchProc.jsp">
				<input class='title' type='text' placeholder='도서 제목을 입력해주세요.' name='searchBookTitle'/>
				<button type='submit' class='button1'>
					<span class='glyphicon glyphicon-search'></span> 검색
				</button>
			</form>
			<br>
			<div>
				<form action="">
					<table class='table table-hover'>
						<tr>
							<th>선택</th>
							<th>ISBN</th>
							<th>도서명</th>
							<th>가격</th>
							<th>저자명</th>
							<th>출판사</th>
							<th>수정</th>
						</tr>
						<%
	                        int endPage = (int)(Math.ceil(currentPage/5.0)*5);
	                        int startPage = (endPage-5)+1;
	                        int lastEndPage = (int)(Math.ceil(books.size()/10.0));
	                        int startRow = (currentPage - 1) * 10;
	                        int endRow = currentPage * 10;
	                        
	                        if(endPage > lastEndPage) endPage = lastEndPage;
	                        
	                        boolean prev = startPage == 1 ? false:true;
	                        boolean next = endPage * 10 >= books.size() ? false:true;
	
	                        if(books.size()!=0){
	                        	 if(lastEndPage != currentPage){
	                        		 books = books.subList(startRow, endRow);
			                     }else{
			                    	 books = books.subList(startRow, books.size());
			                        }
	                        }else{
	                        %>
								<tr>
									<td colspan='8'>등록된 도서가 없습니다.</td>
								</tr>
							<%
	                        }
	                        
							if(request.getParameter("searchEmpty") != null && request.getParameter("searchEmpty").equals("true")) {
								startPage = 1;
								endPage = -1;
						%>
								<tr><td colspan="8">검색된 도서가 없습니다.</td></tr>
						<%
							}else {
								for (Book book: books) {
						%>
									<tr>
										<td><input type='checkbox' name='check_book' value="<%= book.getBookIsbn() %>"/></td>
										<td><%= book.getBookIsbn() %></td>
										<td><%= book.getTitle() %></td>
										<td><%= book.getPrice() %></td>
										<td><%= book.getWriter() %></td>
										<td><%= book.getPublisher() %></td>
										<td>
											<input type="button" onClick="location.href='bookModify.jsp?bookIsbn=<%= book.getBookIsbn() %>'" value="수정"/>
										</td>
									</tr>
						<%
								}
							}
						%>
					</table>
					
					<div class="paging">
                    	<ul>
						<%
                     		if(prev) {
                  		%>
                     			<li><a href="bookListView.jsp?currentPage=<%= startPage - 1 %>">&laquo;</a></li>
                  		<%
                     		}
                      		
							for(int i=startPage; i<=endPage; i++) { %>
                     			<li>
                        			<a href="bookListView.jsp?currentPage=<%= i %>"><%= i %></a>
                     			</li>
                  		<%
                     		}
                     		
							if(next) {
                  		%>
                     			<li><a href="bookListView.jsp?currentPage=<%= endPage + 1 %>">&raquo;</a></li>
                  		<% 
                    		 }
                  		%>
                  		</ul>
                  	</div>
                  
					<div class="btn_button">
						<button class='button2' formaction='bookDelProc.jsp' type="submit">
							<span class='glyphicon glyphicon-trash'></span> 도서 삭제
						</button>
						<button class='button3' formaction='bookRegist.jsp'>
							<span class='glyphicon glyphicon-ok'></span> 도서 등록
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
