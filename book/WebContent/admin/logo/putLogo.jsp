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
<link rel="stylesheet" href="../../css/main.css">

<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<%
	if (session.getAttribute("userId") == null) {
%>
<c:redirect url='../../user/logIn.jsp' />
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

input {
	width: 500px;
	padding: 3px;
}

.button2 {
	float: right;
	margin-right: 4px;
	height: 30px;
}

.bottom_btn {
	overflow: hidden;
	margin-bottom: 60px;
	margin-right:100px;
}

.title {
	width: 500px;
	padding: 3px;
}

</style>
</head>
<body>
	<div>
		<div class="top">
			<div>
				<a href="../user/logOut.jsp">로그아웃</a><a href="../main.jsp">메인으로</a><a href="../../main.jsp">사용자페이지</a><a href="putLogo.jsp">로고등록</a><a href="../banner/putBanner.jsp">배너등록</a>
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
					<li class="menu2 menu"><a
						href="../book/bookListView.jsp?back=true">도서관리</a></li>
					<li class="menu3 menu"><a
						href="../order/orderListView.jsp?back=true">주문관리</a></li>
					<li class="menu4 menu"><a
						href="../delivery/payCompleteListView.jsp">배송관리</a></li>
					<li class="menu5 menu"><a
						href="../question/questionListView.jsp">문의관리</a></li>
				</ul>
			</div>
		</header>
		<%
			session.setAttribute("logoImage", null);
		%>
		<div class='admin_book'>
			<div>
				<p>| 로고등록</p>
			</div>
			<br>
			<br>
			<form action='putLogoProc.jsp' method='post' enctype='multipart/form-data'>
				<table class="table">
					<tbody>
						<tr>
							<td>로 고 이 미 지 :</td>
							<td><input type='file' name='fileName' /></td><br>
							<%
								if(request.getParameter("putLogo")!=null && request.getParameter("putLogo").equals("true")){
									%><font color='blue'><h4>로고 등록 성공</h4></font><%
								}else if(request.getParameter("putLogo")!=null&&request.getParameter("putLogo").equals("false")){
									%><font color='red'><h4>이미지를 첨부해 주세요.</h4></font><%
								}
							%>
						</tr>
					</tbody>
				</table>
				
				<div class="bottom_btn">
					<button class='button2' type="submit">
						<span class='glyphicon glyphicon-ok'></span> 로고 등록
					</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>