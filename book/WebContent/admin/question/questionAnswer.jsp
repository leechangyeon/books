<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ page import="kimgibeom.book.question.service.QuestionService"%>
<%@ page import="kimgibeom.book.question.service.QuestionServiceImpl"%>
<%@ page import="kimgibeom.book.question.domain.Question"%>
<%
	QuestionService questionService = new QuestionServiceImpl();
	int index = 0;
	if (request.getParameter("questionNum") == null) {
		index = (int) (session.getAttribute("questionNum"));
	} else {
		index = Integer.parseInt(request.getParameter("questionNum"));
	}
	Question question = questionService.findQuestion(index);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Admin_questionAnswer</title>
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
	}%>
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
	width: 1000px;
	margin: 0 auto;
	margin-top: 40px;
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
					<li class="menu2 menu"><a href="../book/bookListView.jsp?back=true">도서관리</a></li>
					<li class="menu3 menu"><a
						href="../order/orderListView.jsp?back=true">주문관리</a></li>
					<li class="menu4 menu"><a
						href="../delivery/payCompleteListView.jsp">배송관리</a></li>
					<li class="menu5 menu"><a href="questionListView.jsp">문의관리</a></li>
				</ul>
			</div>
		</header>

		<div class='admin_book'>
			<div>
				<p>| 답변등록</p>
			</div>
			<br>
			<form class="form-inline" action="questionAnswerProc.jsp">
				<div class="panel panel-default">
					<!-- 테이블 -->
					<div>
						<table class="table">
							<tbody>
								<tr>
									<td>문의제목</td>
									<td><%=question.getTitle()%></td>
								</tr>
								<tr>
									<td>문의내용</td>
									<td><%=question.getContent()%></td>
								</tr>
								<tr>
									<td>답변내용</td>
									<td><textarea cols='120' rows='15'
											placeholder='답변내용을 입력해주세요.' name='admin_answer' value=""></textarea> 
											<%
												 session.setAttribute("questionNum", question.getQuestionNum());
											%></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<!-- 테이블 끝-->
				<div class="bottom_btn">
					<button class='button2' type="submit"
						formaction="questionListView.jsp">
						<span class='glyphicon glyphicon-remove'></span> 등록취소
					</button>
					<button class='button2' type="submit">
						<span class='glyphicon glyphicon-ok'></span> 답변 등록
					</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>