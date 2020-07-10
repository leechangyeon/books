<%@ page language='java' contentType='text/html; charset=UTF-8'
   pageEncoding='UTF-8'%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="kimgibeom.book.question.service.QuestionService"%>
<%@ page import="kimgibeom.book.question.service.QuestionServiceImpl"%>
<%@ page import="kimgibeom.book.question.domain.Question"%>
<%@ page import="java.util.List"%>
<%
   request.setCharacterEncoding("UTF-8");

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
   if(request.getParameter("currentPage")==null)
      currentPage = 1;
   else
      currentPage = Integer.parseInt(request.getParameter("currentPage"));
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우주 서점</title>
<link rel="stylesheet" href="../css/main.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<style>
.list {
   width: 790px;
   font-size: 14px;
   margin: 20px 0 60px 50px;
}

.list table {
   border: 0px solid #666;
   border-collapse: collapse;
   text-align: left;
   width: 790px;
   font-size: 14px;
   margin-top: 40px;
}

.list table .text input {
   height: 25px;
   width: 35%;
}

.list table div {
   margin-bottom: 10px;
}

.list th {
   border-right: 1px solid #fff;
   padding: 0 10px;
   border-bottom: 1px solid #ccc;
   height: 40px;
   background-color: #eee;
   text-align: center;
}

.list td {
   border-right: 1px solid #fff;
   padding: 0 10px;
   border-bottom: 1px solid #ccc;
   height: 40px;
   text-align: center;
}

.list tr:hover td {
   background-color: #fafafa;
}

.list tr td:nth-child(3) {
   text-align: left;
}

.list .title {
   font-size: 20px;
   font-weight: bold;
}

.list .button {
   overflow: hidden;
}

.list .button a {
   float: right;
   padding: 8px 16px;
   margin-top: 20px;
   border: 1px solid #42a5be;
   background-color: #42a5be;
   color: #fff;
}

.list .leftline {
   border-left: 0px;
}

.list .rightline {
   border-right: 0px;
}

.leftmenu ul li {
   border-bottom: 1px solid #ccc;
}

/* 검색창 */
.list_search {
   height: 34px;
   margin-top: 25px;
   text-align: center;
}

.list_search input {
   width: 30%;
   height: 25px;
   padding-top: 4px;
}

.list_search button {
   width: 60px;
   height: 35px;;
   background-color: #666;
   color: #fff;
   border: 1px solid #ccc;
   margin-left: -6px;
}
 
.list_search select {
   height: 100%;
   margin-right: -6px;
   height: 34px;
   margin-top: 25px;
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
            <div class="list">
               <div class="title">문의</div>
               <form action='questionView.jsp'>
                  <table>
                     <colgroup>
                        <col width="8%">
                        <col width="20%">
                        <col width="42%">
                        <col width="15%">
                        <col width="15%">
                     </colgroup>
                     <tr>
                        <th class="leftline">번호</th>
                        <th>아이디</th>
                        <th>제목</th>
                        <th>작성일</th>
                        <th class="rightline">답변여부</th>
                     </tr>
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
									<td colspan='5'>문의 등록한 사용자가 없습니다.</td>
								</tr>
							<%
	                        }
	                    	
	                        if (request.getParameter("searchEmpty") != null && request.getParameter("searchEmpty").equals("true1")) {
	                        	startPage = 1;
								endPage = -1;
                     %>
								<tr><td colspan="5">검색한 사용자의 게시물이 없습니다.</td></tr>
					 <%
							}else if(request.getParameter("searchEmpty") != null && request.getParameter("searchEmpty").equals("true2")){
								startPage = 1;
								endPage = -1;
					 %>
								<tr><td colspan="5">검색된 문의글이 없습니다.</td></tr>
					 <%
							}else{
                    			for(Question question:questions){
                     %>
		                            <tr style="cursor: pointer;"
		                                onClick="location.href='questionView.jsp?questionNum=<%= question.getQuestionNum() %>'">
		                                <td><%= question.getQuestionNum() %></td>
		                                <td><%= question.getUserId() %></td>
		                                <td><%= question.getTitle() %></td>
		                                <td><%= question.getRegDate() %></td>
		                                <td><%= question.getStatus() %></td>
		                            </tr>
                     <%	
                    			}
                       		}
                     %>
                  </table>
                  <div class="button">
                     <a href="questionRegist.jsp">문의글 등록</a>
                  </div>
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
               </form>
               <div class="list_search">
                  <form action="questionSearchProc.jsp">
                     <select name="searchType">
                        <option>제목</option>
                        <option>아이디</option>
                     </select> 
                     <input type="text" name='search' value=""/>
                     <button type="submit">검색</button>
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