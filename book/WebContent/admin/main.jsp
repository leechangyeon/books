<%@page import="java.util.ArrayList"%>
<%@page import="kimgibeom.book.user.domain.User"%>
<%@page import="java.util.List"%>
<%@page import="kimgibeom.book.user.service.UserServiceImpl"%>
<%@page import="kimgibeom.book.user.service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin_book</title>
<link rel="stylesheet" href="../css/main.css">

<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<%
	if(session.getAttribute("userId")==null){
		%>
			<c:redirect url='../user/logIn.jsp' />
		<%
	}
	if (request.getParameter("back") != null && request.getParameter("back").equals("true")) {
		session.setAttribute("searchUsers", null);
	}
	
	UserService userService = new UserServiceImpl();
	List<User> users = null;
	int currentPage;
	
	if(session.getAttribute("searchUsers")==null){
		users = userService.readUsers();
	}else{
		users = (List<User>) session.getAttribute("searchUsers");
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
				<a href="user/logOut.jsp">로그아웃</a><a href="../main.jsp">사용자페이지</a><a href="logo/putLogo.jsp">로고등록</a><a href="banner/putBanner.jsp">배너등록</a>
			</div>
		</div>

		<div class="tophead">
			<div class="logo">
				<a href="main.jsp?back=true"><h3><strong>관리자 페이지</strong></h3></a>
			</div>
		</div>

		<header>
			<div class="nav">
				<ul>
					<li class="menu1 menu"><a href='main.jsp?back=true'>회원관리</a></li>
					<li class="menu2 menu"><a href="book/bookListView.jsp?back=true">도서관리</a></li>
					<li class="menu3 menu"><a
						href="order/orderListView.jsp?back=true">주문관리</a></li>
					<li class="menu4 menu"><a
						href="delivery/payCompleteListView.jsp?back=true">배송관리</a></li>
					<li class="menu5 menu"><a href="question/questionListView.jsp?back=true">문의관리</a></li>
				</ul>
			</div>
		</header>
		<div class='admin_book'>
			<div>
				<p>| 회원관리</p>
				<%
					if (request.getParameter("userCheck") != null && request.getParameter("userCheck").equals("false")) {
				%>
				<font color='red'>삭제할 회원을 선택하지 않았습니다.</font>
				<%
					}
				%>
			</div>
			<form action='user/userSearchProc.jsp'>
				<div>
					<input class='title' type='text' name='searchUserId' value=""
						placeholder='회원 아이디를 입력해주세요'>
					<button type='submit' class='button1'>
						<span class='glyphicon glyphicon-search'></span> 검색
					</button>
				</div>
			</form>
			<br>
			<form action='user/userDelProc.jsp'>
				<div>
					<table class="table table-hover">
						<tr>
							<th>선택</th>
							<th>아이디</th>
							<th>이름</th>
							<th>생년월일</th>
							<th>전화번호</th>
							<th>주소</th>
							<th>가입일</th>
							<th>수정</th>
						</tr>
						<%
                     		int endPage = (int)(Math.ceil(currentPage/5.0)*5);
                       		int startPage = (endPage-5)+1;
                       		int lastEndPage = (int)(Math.ceil(users.size()/10.0));
                       		int startRow = (currentPage - 1) * 10;
                       		int endRow = currentPage * 10;
                       
                      		if(endPage > lastEndPage) endPage = lastEndPage;
                       
                       		boolean prev = startPage == 1 ? false:true;
                       		boolean next = endPage * 10 >= users.size() ? false:true;

                       		if(users.size()!=0){
	                        	if(lastEndPage != currentPage){
	                        		users = users.subList(startRow, endRow);
	 	                        }else{
	 	                        	users = users.subList(startRow, users.size());
	 	                        }
	                        }else{
	                    	%>
								<tr>
									<td colspan='8'>등록된 회원 없습니다.</td>
								</tr>
							<%
	                        }
                    		                     		
                   			if (request.getParameter("searchEmpty") != null && request.getParameter("searchEmpty").equals("true")) {
                   				startPage = 1;
								endPage = -1;
                    		%>
								<tr><td colspan="8">검색한 사용자의 게시물이 없습니다.</td></tr>
				 		<%
							}else{
								for (User user : users) {
						%>
									<tr>
										<td><input type='checkbox' name='userId'
											value='<%=user.getUserId()%>' /></td>
										<td><%=user.getUserId()%></td>
										<td><%=user.getUserName()%></td>
										<td><%=user.getUserBirthDate()%></td>
										<td><%=user.getUserPhoneNumber()%></td>
										<td><%=user.getUserAddress()%></td>
										<td><%=user.getUserRegDate()%></td>
										<td><input type='button'
											onClick="location.href='user/userModify.jsp?userId=<%=user.getUserId()%>'"
											value='수정'></td>
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
                     			<li><a href="main.jsp?currentPage=<%= startPage - 1 %>">&laquo;</a></li>
                  		<%
                     		}
                      		
							for(int i=startPage; i<=endPage; i++) { %>
                     			<li>
                        			<a href="main.jsp?currentPage=<%= i %>"><%= i %></a>
                     			</li>
                  		<%
                     		}
                     		
							if(next) {
                  		%>
                     			<li><a href="main.jsp?currentPage=<%= endPage + 1 %>">&raquo;</a></li>
                  		<% 
                    		 }
                  		%>
                  		</ul>
                 	</div>
					
					<div>
						<button class='button2'>
							<span class='glyphicon glyphicon-trash'></span> 회원 삭제
						</button>
						<button class='button3' formaction='user/userRegist.jsp'>
							<span class='glyphicon glyphicon-ok'></span> 회원 등록
						</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>