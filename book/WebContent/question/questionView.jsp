 <%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ page import="kimgibeom.book.question.service.QuestionService"%>
<%@ page import="kimgibeom.book.question.service.QuestionServiceImpl"%>
<%@ page import="kimgibeom.book.question.domain.Question"%>
<%
	QuestionService questionService = new QuestionServiceImpl();
	int index = Integer.parseInt(request.getParameter("questionNum"));
	Question question = questionService.findQuestion(index);	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우주 서점</title>
<link rel="stylesheet" href="../css/main.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<script>
	function alert1() {
		swal({
			title : "문의글 삭제",
			text : "문의글을 삭제하시겠습니까?",
			type : "warning",
			showCancelButton : true,
			cancelButtonText : "아니요",
			confirmButtonText : "예",
			closeOnConfirm : false
		}, function() {
			document.delquestion.submit();
		});
	}
</script>
<style>
.list_view {
	width: 790px;
	font-size: 14px;
	margin: 20px 0 60px 50px;
}

.list_view table {
	border: 0px solid #666;
	border-collapse: collapse;
	text-align: left;
	width: 790px;
	font-size: 14px;
	margin-top: 40px;
}

.lilist_viewst table div {
	margin-bottom: 10px;
}

.list_view th {
	border-top: 1px solid #666;
	border-right: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 40px;
	background-color: #eee;
	padding-left: 25px;
	font-size: 16px;
}

.list_view td {
	border-right: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 40px;
	padding-left: 25px;
}

.list_view td span {
	color: #666;
	margin-left: 10px;
}

.list_view .title {
	font-size: 20px;
	font-weight: bold;
}

.list_view .button {
	overflow: hidden;
}

.list_view .button a {
	float: right;
	padding: 8px 16px;
	margin-top: 20px;
	border: 1px solid #42a5be;
	background-color: #42a5be;
	color: #fff;
}

.list_view .button button, input {
	height: 40px;
	margin-top: 30px;
	float: right;
}

.list_view .button .mod {
	background-color: #42a5be;
	border: 1px solid #42a5be;
	width: 70px;
	color: #fff;
}

.list_view .button .del {
	width: 70px;
	margin-left: 5px;
}

.list_view .button .lis {
	width: 70px;
	margin-left: 5px;
	background-color: #666;
	color: #fff;
	border: 1px solid #666;
	float: left;
}

.list_view .textarea td {
	padding: 10px 26px;
}

.list_view .textarea td div {
	min-height: 300px;
}

.list_view .leftline {
	border-left: 0px;
}

.list_view .rightline {
	border-right: 0px;
}

.leftmenu ul li {
	border-bottom: 1px solid #ccc;
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
			<!-- 회원탈퇴 -->
			<div class="content">
				<div class="list_view">
					<div class="title">문의</div>
					<form name='delquestion' method="post" action="questionDelProc.jsp?questionNum=<%=question.getQuestionNum()%>">
						<table>
							<colgroup>
								<col width="20%">
								<col width="80%">
							</colgroup>
							<tr>
								<th class="leftline"><%=question.getTitle()%></th>
							</tr>
							<tr>
								<td>등록일 <span><%=question.getRegDate()%></span></td>
							</tr>
							<tr class="textarea">
								<td>
									<div>
										<%=question.getContent()%>
									</div>
								</td>
							</tr>
							<tr>
								<td>첨부파일 
									<span>
										<%
											if(question.getAttachName().equals("null") || question.getAttachName() == null){
										%>
											첨부파일없음
										<%
											}else{ 
										%>
												<a href="../attach/<%= question.getAttachName()%>" download><%= question.getAttachName()%></a>
										<%
											}
										%>
									</span>
								</td>
							</tr>
						</table>
						<div class="button">
						<%
								if(session.getAttribute("userId") != null && session.getAttribute("userId").equals(question.getUserId())){
						%>
							<input class="del" type='button' onclick="alert1()" value='삭제'>
							<button class="mod" type="submit" formaction="questionModify.jsp?questionNum=<%= question.getQuestionNum()%>">수정</button>
						<%
								}
							
						%>
							<button class="lis" formaction="questionListView.jsp">목록</button>
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