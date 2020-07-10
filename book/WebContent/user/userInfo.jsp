<%@page import="kimgibeom.book.user.domain.User"%>
<%@page import="kimgibeom.book.user.service.UserServiceImpl"%>
<%@page import="kimgibeom.book.user.service.UserService"%>
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
.myview {
	margin: 20px 0 60px 50px;
}

.myview table {
	border: 1px solid #666;
	border-collapse: collapse;
	text-align: left;
	width: 790px;
	font-size: 14px;
}

.myview table .text input {
	height: 25px;
	width: 50%;
}

.myview form {
	margin-top: 40px;
}

.myview form .button {
	overflow: hidden;
}

.myview form .button button {
	height: 40px;
	margin-top: 30px;
	float: right;
}

.myview form .button .ok {
	background-color: #42a5be;
	border: 1px solid #42a5be;
	width: 70px;
	color: #fff;
}

.myview form .button .no {
	width: 70px;
	margin-left: 5px;
}

.myview table tr {
	height: 30px;
}

.myview th {
	border-left: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 45px;
	background-color: #eee;
}

.myview td {
	border-right: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 45px;
}

.myview th span {
	color: red;
}

.myview .title {
	font-size: 20px;
	font-weight: bold;
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
				<a href="logOut.jsp">로그아웃</a> <a href="userInfo.jsp">마이페이지</a><%
						if(session.getAttribute("userId").equals("admin")){
							%>
								<a href="../admin/main.jsp">관리자페이지</a>
							<%
						}
					%>
				<%
					} else {
				%>
				<a href="logIn.jsp">로그인</a> <a href="joinAgree.jsp">회원가입</a>
				<c:redirect url='logIn.jsp' />
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
					<li class="action"><a href="userInfo.jsp">개인정보</a></li>
					<li><a href="../basket/basketListView.jsp">장바구니</a></li>
					<li><a href="../order/orderListView.jsp">구매조회</a></li>
					<li><a href="userWithdraw.jsp">회원탈퇴</a></li>
				</ul>
			</div>
			<%
				String userId = (String) session.getAttribute("userId");
				UserService userService = new UserServiceImpl();
				User user = userService.findUser(userId);

				String userPwCheck = request.getParameter("userPwCheck");
			%>
			<!-- 회원가입 -->
			<div class="content">
				<div class="myview">
					<div class="title">개인정보</div>
					<form action="userInfoProc.jsp">
						<table>
							<tr class="text">
								<th>아이디</th>
								<td><%=user.getUserId()%></td>
							</tr>
							<tr class="text">
								<th><span>*</span> 암호</th>
								<td><input type="password"
									placeholder="본인확인을 위해 비밀번호를 입력해주십시오." name='userPw' required />
									<%
										if (userPwCheck != null) {
											if (userPwCheck.equals("false")) {
									%><font color='red'> 암호가 틀렸습니다.</font>
									<%
										}
										}
									%></td>
							</tr>
							<tr class="text">
								<th>이름</th>
								<td><%=user.getUserName()%></td>
							</tr>
							<tr class="radio">
								<th>성별</th>
								<td><%=user.getUserGender()%></td>
							</tr>
							<tr class="date">
								<th>생년월일</th>
								<td><%=user.getUserBirthDate()%></td>
							</tr>
							<tr class="number">
								<th>핸드폰 번호</th>
								<td><%=user.getUserPhoneNumber()%></td>
							</tr>
							<tr class="text">
								<th>E-mail</th>
								<td><%=user.getUserEmail()%></td>
							</tr>
							<tr class="address">
								<th>주소</th>
								<td><%=user.getUserAddress()%></td>
							</tr>
						</table>
						<div class="button">
							<button class="ok" type="submit">수정하기</button>
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