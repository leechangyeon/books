<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우주 서점</title>
<link rel="stylesheet" href="../css/main.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<style>
.member_step1 {
	width: 780px;
	margin: 20px 0 0 60px;
}

.member_step1>div:nth-child(1) {
	text-align: center;
}

.member_step1 span {
	font-weight: bold;
}

.member_step1>div:nth-child(2) {
	font-size: 14px;
	margin-top: 70px;
}

.member_step1 .textbox {
	width: 748px;
	overflow: scroll;
	height: 150px;
	border: 1px solid #ccc;
	padding: 15px;
}

.member_step1 .button button {
	width: 70px;
	height: 40px;
	background-color: #42a5be;
	border: 0px;
	color: #fff;
}

.member_step1 .button {
	text-align: right;
	margin-top: 40px;
}

.member_step1 form .text {
	text-align: right;
	margin-top: 10px;
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
				<div>회원</div>
				<ul>
					<li><a href="logIn.jsp">로그인</a></li>
					<li class="action"><a href="joinAgree.jsp">회원가입</a></li>
				</ul>
			</div>
			<!-- 회원가입 -->
			<div class="content">
				<div class="member_step1">
					<div>
						<span>STEP1 약관 동의</span> > STEP2 고객 정보 입력 > STEP3 회원가입완료
					</div>
					<div>
						<p>개인정보 수집 및 이용에 대한 안내</p>
						<div class="textbox">
							우주서점 에서는 기업/단체 및 개인의 정보 수집 및 이용 등 처리에 있어 아래의 사항을 관계법령에 따라 고지하고
							안내해 드립니다.<br> <br> 1. 정보수집의 이용 목적 : 도서 구매 및 문의<br>
							2. 수집/이용 항목 : 이름, 생년월일, 성별, E-mail, 핸드폰 번호, 주소, 문의 내용<br> 3.
							보유 및 이용기간 : 상담 종료 후 2년, 정보제공자의 삭제 요청 시 즉시
						</div>
						<form action="join.jsp">
							<div class="text">
								<input type="checkbox" required /> 개인정보 수집 및 이용에 동의합니다.
							</div>
							<div class="button">
								<button type="submit">다음</button>
							</div>
						</form>
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
</html>