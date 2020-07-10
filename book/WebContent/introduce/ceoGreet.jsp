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
.ceo {
	width: 790px;
	margin: 20px 0 60px 50px;
	font-size: 14px;
}

.ceo .title {
	font-size: 20px;
	font-weight: bold;
	margin-bottom: 40px;
}

.ceo span {
	font-size: 22px;
	color: #42a5be;
}

.ceo p {
	text-align: right;
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
					<li class="menu1 menu"><a href="ceoGreet.jsp">서점
							소개</a>
						<ul>
							<li><a href="ceoGreet.jsp">인사말</a></li>
							<li><a href="companyLocation.jsp">오시는 길</a></li>
						</ul></li>
					<li class="menu2 menu"><a href="../book/bookListView.jsp?back=true">도서</a></li>
					<li class="menu3 menu"><a href="../question/questionListView.jsp?back=true">문의게시판</a></li>
				</ul>
			</div>
		</header>

		<!-- left메뉴 -->
		<div class="cont">
			<div class="leftmenu">
				<div>서점 소개</div>
				<ul>
					<li class="action"><a href="ceoGreet.jsp">인사말</a></li>
					<li><a href="companyLocation.jsp">오시는 길</a></li>
					<ul>
			</div>
			<!-- 회원가입 -->
			<div class="content">
				<div class="ceo">
					<div class="title">CEO 인사말</div>
					<span>“우주문고는 좋은 책을 추천하고, 읽는 방법을 소개하여 고객이<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;책을 통해 꿈을 키워가는 사회가 될 수 있도록 노력하겠습니다.”
					</span><br> <br> <br> <br> 우주 서점은 단순히 책을 파는 데 그치지 않고,
					모든 사람들이 지식과 정보, 문화의 습득을 통해 자기 성장을 이루고 자아 실천의 즐거움을 누릴수 있도록 끊임없이
					노력하겠습니다.<br> <br> 우주 서점은 지금의 성장에 안주하지 않고, 고객만족에 최선을 다할
					것이며, 글로벌 지식문화 브랜드로 성장하여 최상의 고객가치를 제공할 수 있도록 전력을 다하고자 합니다.<br>
					<br> 우주 문고를 이용하시는 모든 고객들께 다시 한 번 진심으로 감사의 말씀을 드립니다.<br> <br>
					<br> <br>

					<p>대표이사 김기범</p>
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