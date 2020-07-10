<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ page import="kimgibeom.book.question.service.QuestionService"%>
<%@ page import="kimgibeom.book.question.service.QuestionServiceImpl"%>
<%@ page import="kimgibeom.book.question.domain.Question"%>
<%
	request.setCharacterEncoding("UTF-8");
	QuestionService questionService = new QuestionServiceImpl();
	Question question = questionService.findQuestion(Integer.parseInt(request.getParameter("questionNum")));
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우주 서점</title>
<link rel="stylesheet" href="../css/main.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js">
	
</script>
<style>
.cont .leftmenu, .content {
	margin-bottom: 80px;
}

.list_modify .title {
	font-size: 20px;
	font-weight: bold;
}

.list_modify {
	width: 790px;
	font-size: 14px;
	margin: 20px 0 60px 50px;
}

.list_modify p {
	font-size: 20px;
	font-weight: bold;
}

.list_modify table {
	border: 1px solid #666;
	border-collapse: collapse;
	text-align: left;
	width: 790px;
	font-size: 14px;
	margin-top: 40px;
	overflow: hidden;
}

.list_modify table .text input {
	height: 25px;
	width: 35%;
}

.list_modify table .text_area textarea {
	width: 100%;
	height: 300px;
	margin: 10px 0;
	font-size: 14px;
	padding: 5px;
}

.list_modify table .date input {
	height: 25px;
}

.list_modify table .number input {
	height: 25px;
	width: 10%;
}

.list_modify table .address input {
	height: 25px;
	width: 50%;
}

.list_modify .button button {
	height: 40px;
	margin-top: 30px;
	float: right;
}

.list_modify .button .ok {
	background-color: #42a5be;
	border: 1px solid #42a5be;
	width: 70px;
	color: #fff;
}

.list_modify .button .no {
	width: 70px;
	margin-left: 5px;
}

.list_modify table tr {
	height: 30px;
}

.list_modify th {
	border-left: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 45px;
	background-color: #eee;
}

.list_modify td {
	border-right: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 45px;
}

.list_modify th span {
	color: red;
}

.list_modify .text button {
	height: 30px;
	background-color: #666;
	border: 0px;
	color: #fff;
}

.list_modify .text td span {
	font-size: 12px;
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
				<a href="../user/logIn.jsp">로그인</a> <a href="../user/joinAgree.jsp">회원가입</a>
				<c:redirect url='../user/logIn.jsp' />
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
					<li class="menu3 menu"><a href="questionListView.jsp?back=true">문의게시판</a></li>
				</ul>
			</div>
		</header>

		<!-- left메뉴 -->
		<div class="cont">
			<div class="leftmenu">
				<div>문의게시판</div>
				<ul>
					<li class="action"><a href="questionListView.jsp">문의</a></li>
				</ul>
			</div>
			<!-- 회원가입 -->
			<div class="content">
				<div class="list_modify">
					<div class="title">문의 수정</div>
					<form method='post'	action="questionModifyProc.jsp?questionNum=<%=question.getQuestionNum()%>&title=" enctype="multipart/form-data">
						<table>
							<tr class="text">
								<th><span>*</span> 제목</th>
								<td><input type="text" name="title"
									value="<%=question.getTitle()%>"/></td>
							</tr>
							<tr class="text">
								<th><span>*</span> 첨부파일</th>
								<td><input type="file" name='attachFile'/></td>
							</tr>
							<tr class="text_area">
								<th><span>*</span> 내용</th>
								<td><textarea name="content"><%=question.getContent()%></textarea>
								</td>
							</tr>
						</table>
						<div class="button">
							<button class="no" type="submit"
								formaction="questionListView.jsp">취소</button>
							<button class="ok" type="submit">수정</button>
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