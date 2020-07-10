<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Admin_book_add</title>
<meta charset="utf-8">
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
	width: 800px;
	margin: 0 auto;
	margin-top: 40px;
	position: relative;
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

.form_del {
	position: absolute;
	top: 710px;
	right: 0;
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
						href="../delivery/payCompleteListView.jsp">배송관리</a></li>
					<li class="menu5 menu"><a
						href="../question/questionListView.jsp">문의관리</a></li>
				</ul>
			</div>
		</header>

		<div class='admin_book'>
			<div>
				<p>| 도서등록</p>
			</div>
			<br>
<form class="form-inline" action="bookRegistProc.jsp" method='post' enctype='multipart/form-data'>
				<div class="panel panel-default">
					<!-- 테이블 -->
					<div>
						<table class="table">
							<tbody>
								<tr>
									<td>이 미 지 :</td>
									<td><input type='file' name='fileName' /></td>
								</tr>
								<tr>
									<td>도 서 명 :</td>
									<td><input type='text' placeholder='도서명을 입력해주세요.' name="title" required/></td>
								</tr>
								<tr>
									<td>가&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 격 :</td>
									<td><input type='number' placeholder='가격을 입력해주세요.'
										step='10' name="price" required/></td>
								</tr>
								<tr>
									<td>저 자 명 :</td>
									<td><input type='text' placeholder='저자명을 입력해주세요.' name="writer" required/></td>
								</tr>
								<tr>
									<td>출판사명 :</td>
									<td><input type='text' placeholder='출판사명을 입력해주세요.' name="publisher" required/></td>
								</tr>
								<tr>
									<td>내용 :</td>
									<td><textarea cols='90' rows='15' placeholder='내용을 입력해주세요.' name="content" required></textarea></td>
								</tr>
								<tr>
									<td>수량 :</td>
									<td><input type='number' placeholder='수량을 입력해주세요.' name="count" required/></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<!-- 테이블 끝-->
				<div class="bottom_btn">
					<button class='button2' type="submit">
						<span class='glyphicon glyphicon-ok'></span> 도서 등록
					</button>
				</div>
			</form>
			<form action="bookListView.jsp" class="form_del">
				<button class='button2'>
					<span class='glyphicon glyphicon-remove'></span> 수정취소
				</button>
			</form>
		</div>
	</div>
</body>
</html>
