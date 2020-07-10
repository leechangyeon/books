<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우주 서점</title>
<link rel="stylesheet" href="../css/main.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<%
	if (((String) session.getAttribute("userId") != null)) {
%>
		<c:redirect url='../main.jsp' />
<%
	}
%>
<style>
.login {
	width: 790px;
	margin: 0 auto;
	font-size: 14px;
	clear: both;
	margin-bottom: 60px;
}

#login_box ul {
	list-style-type: none;
}

.login form {
	width: 450px;
	margin: 0 auto;
}

#input_button input {
	width: 450px;
	height: 50px;
	border: 1px solid #ccc;
}

#id_pass span {
	width: 20px;
}

#pass input {
	margin-top: -1px;
}

.login form p {
	font-size: 20px;
	font-weight: bold;
}

.login form a {
	padding: 14px 0;
	text-align: center;
	width: 450px;
	background: #fff;
	color: #666;
	margin-top: 20px;
	border: 1px solid #ccc;
}

.login form button {
	padding: 12px;
	width: 452px;
	height: 50px;
	background: #42a5be;
	border: 0;
	color: #fff;
	margin-top: 20px;
}

.login .btns {
	color: #959595;
	font-size: 14px;
	width: 450px;
}

.login .btns input, label {
	margin-top: 20px;
}

#autoLogin {
	margin: 0;
	line-height: 16px;
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
			<div class="leftmenu">
				<div>회원</div>
				<ul>
					<li class="action"><a href="logIn.jsp">로그인</a></li>
					<li><a href="joinAgree.jsp">회원가입</a></li>
				</ul>
			</div>
			<%
				String saveId = "";
				Cookie[] cookies = request.getCookies();
				if (cookies != null) {
					for (Cookie c : cookies) {
						if (c.getName().equals("saveId")) {
							saveId = c.getValue();
						}
					}
				}
			%>
			<!-- 로그인 -->
			<div class="content">
				<div class="login">
					<form name="loginform" action='logInProc.jsp' method='post'>
						<p>로그인</p>
						<div id="login_box">
							<ul id="input_button">
								<li id="id_pass"><input name="userId" type="text"
									placeholder=" 아이디" value='<%=saveId%>' required><%
										if(request.getParameter("idCheck")!=null && request.getParameter("idCheck").equals("false")){
											%><font color='red'>없는 계정입니다.</font><%
										}
										%></li><br>
								<li id="pass"><input name="userPw" type="password"
									placeholder=" 암호" required><%
										if(request.getParameter("pwCheck")!=null && request.getParameter("pwCheck").equals("false")){
											%><font color='red'>암호가 틀렸습니다.</font><%
										}
										%></li>
							</ul>
						</div>
						<div class="btns">
							<label><input type="checkbox" name="saveId"
								value='saveId' /> 아이디 저장</label>
						</div>
						<button id="login_btn" type="submit">로그인</button>
						<div>
							<a href="joinAgree.jsp">회원가입</a>
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