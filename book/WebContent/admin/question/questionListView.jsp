<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ page import="kimgibeom.book.question.service.QuestionService" %>
<%@ page import="kimgibeom.book.question.service.QuestionServiceImpl" %>
<%@ page import="kimgibeom.book.question.domain.Question" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin_question</title>
<link rel="stylesheet" href="../../css/main.css">

<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<%
	request.setCharacterEncoding("UTF-8");

	if(session.getAttribute("userId")==null){
		%>
			<c:redirect url='../../main.jsp' />
		<%
	}

   if (request.getParameter("back") != null && request.getParameter("back").equals("true")) {
      session.setAttribute("searchQuestions", null);
   }
   
   QuestionService questionService = new QuestionServiceImpl();
   List<Question> questions = null;
   int currentPage;
   
   if (session.getAttribute("searchQuestions") == null) { 
   	  questions = questionService.listQuestions();   
   }   
   else {
      questions = (List<Question>)session.getAttribute("searchQuestions");
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

.button2 {
	float: right;
	margin-right: 4px;
	height: 30px;
}

.title {
	width: 500px;
	padding: 3px;
}
.table tbody tr td:nth-child(4) {
	text-align:left;
}
.answer input {
	width:45px;
}

.btn_button {
	margin-bottom: 120px;
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
						href="../delivery/payCompleteListView.jsp?back=true">배송관리</a></li>
					<li class="menu5 menu"><a
						href="questionListView.jsp?back=true">문의관리</a></li>
				</ul>
			</div>
		</header>

		<div class='admin_book'>
			<div>
				<p>| 문의리스트</p>
			</div>
			<%
					if (request.getParameter("questionCheck") != null && request.getParameter("questionCheck").equals("false")) {
				%>
				<font color='red'>삭제할 문의글을 선택하지 않았습니다.</font>
				<%
					}
				%>
			<br>
			<form action='questionSearchProc.jsp'>
				<input class='title' type='text' placeholder='회원 아이디를 입력해주세요.' name='searchUserId'>
				<button type='submit' class='button1'>
					<span class='glyphicon glyphicon-search'></span> 검색
				</button>
			</form>

			<br> <br>
			<div>
				<form action="questionDelProc.jsp">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>선택</th>
								<th>문의번호</th>
								<th>회원아이디</th>
								<th>문의제목</th>
								<th>작성일</th>
								<th>답변여부</th>
								<th>답변</th>
							</tr>
						</thead>
						<tbody>
							 <%
		                        int endPage = (int)(Math.ceil(currentPage/5.0)*5);
		                        int startPage = (endPage-5)+1;
		                        int lastEndPage = (int)(Math.ceil(questions.size()/10.0));
		                        int startRow = (currentPage - 1) * 10;
		                        int endRow = currentPage * 10;
		                        
		                        if(endPage > lastEndPage) endPage = lastEndPage;
		                        
		                        boolean prev = startPage == 1 ? false:true;
		                        boolean next = endPage * 10 >= questions.size() ? false:true;
		
		                        if(questions.size()!=0){
		                        	 if(lastEndPage != currentPage){
										questions = questions.subList(startRow, endRow);
				                     }else{
				                        questions = questions.subList(startRow, questions.size());
				                        }
		                        }else{
		                        %>
									<tr>
										<td colspan='7'>문의 등록한 사용자가 없습니다.</td>
									</tr>
								<%
		                        }
		                       
		                    	
		                        if (request.getParameter("searchEmpty") != null && request.getParameter("searchEmpty").equals("true")) {
		                        	startPage = 1;
									endPage = -1;
		                     %>
									<tr><td colspan="7">검색한 사용자의 게시물이 없습니다.</td></tr>
							 <%
								}else{
		                    		for(Question question:questions){
		                     %>
			                           <tr>
					                        <td><input type='checkbox' name='check_question' value='<%= question.getQuestionNum() %>'/></td>
					                        <td><%= question.getQuestionNum() %></td>
					                        <td><%= question.getUserId() %></td>
					                        <td><%= question.getTitle() %></td>
					                        <td><%= question.getRegDate() %></td>
					                        <td><%= question.getStatus() %></td>
					                        <td class="answer">
					                           <input type="button" onClick="location.href='questionAnswer.jsp?questionNum=<%=question.getQuestionNum()%>'" value="답변"/>
					                        </td>
					                     </tr>
					         <%      }
					             }
					         %>
						</tbody>
					</table>
					
					<div class="paging">
                    	<ul>
						<%
                     		if(prev) {
                  		%>
                     			<li><a href="questionListView.jsp?currentPage=<%= startPage - 1 %>">&laquo;</a></li>
                  		<%
                     		}
                      		
							for(int i=startPage; i<=endPage; i++) { %>
                     			<li>
                        			<a href="questionListView.jsp?currentPage=<%= i %>"><%= i %></a>
                     			</li>
                  		<%
                     		}
                     		
							if(next) {
                  		%>
                     			<li><a href="questionListView.jsp?currentPage=<%= endPage + 1 %>">&raquo;</a></li>
                  		<% 
                    		 }
                  		%>
                  		</ul>
                  </div>
                  
					<div class="btn_button">
						<button class='button2' type='submit'>
							<span class='glyphicon glyphicon-trash'></span> 문의 삭제
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>