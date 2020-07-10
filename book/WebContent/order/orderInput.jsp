<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ page import="kimgibeom.book.user.service.UserService"%>
<%@ page import="kimgibeom.book.user.service.UserServiceImpl"%>
<%@ page import="kimgibeom.book.user.domain.User"%>
<%@page import="kimgibeom.book.book.domain.Book"%>
<%@page import="kimgibeom.book.book.service.BookService"%>
<%@page import="kimgibeom.book.book.service.BookServiceImpl"%>
<%@page import="java.util.ArrayList, java.util.List"%>	
<%@ page import="java.util.StringTokenizer" %>       
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8"> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우주 서점</title>
<link rel="stylesheet" href="../css/main.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<style>
.title {
	font-size: 20px;
	font-weight: bold;
	margin: 70px 0 40px 0;
	text-align: left;
}

.book_buy:nth-child(1) {
	text-align: center;
}

.book_buy:nth-child(1) span {
	font-weight: bold;
}

.book_buy {
	width: 790px;
	font-size: 14px;
	margin-left: 50px;
}

.book_buy table {
	border: 1px solid #666;
	border-collapse: collapse;
	text-align: left;
	width: 790px;
	font-size: 14px;
}

.book_buy table .text input {
	height: 25px;
	width: 35%;
}

.book_buy table .number input {
	height: 25px;
	width: 10%;
}

.book_buy table .address input {
	height: 25px;
	width: 50%;
}

.book_buy table .radio input {
	margin: 7px 7px;
}

.book_buy form .button {
	overflow: hidden;
}

.book_buy form .button button {
	height: 40px;
	margin-top: 30px;
	float: right;
}

.book_buy form .button .ok {
	background-color: #42a5be;
	border: 1px solid #42a5be;
	width: 70px;
	color: #fff;
}

.book_buy form .button .no {
	width: 70px;
	margin-left: 5px;
}

.book_buy table tr {
	height: 30px;
}

.book_buy th {
	border-left: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 45px;
	background-color: #eee;
}

.book_buy td {
	border-right: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 45px;
}

.book_buy th span {
	color: red;
}

.book_buy .text button {
	height: 30px;
	background-color: #666;
	border: 0px;
	color: #fff;
}

.book_buy .text td span {
	font-size: 12px;
}

.list_add {
	margin-top: 5px;
	background-color: #e7faff;
	height: 40px;
	padding-top: 25px;
	text-align: left;
}

.list_add span {
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
					<li class="menu3 menu"><a href="../question/questionListView.jsp">문의게시판</a></li>
				</ul>
			</div>
		</header>

		<!-- left메뉴 -->
		<div class="cont">
			<div class="leftmenu">
				<div>도서</div>
				<ul>
					<li class="action"><a href="../book/bookListView.jsp">판매 도서</a></li>
				</ul>
			</div>
			<!-- 회원가입 -->
			<div class="content">
				<div class="book_buy">
					<div>
						<span>STEP1 회원정보 입력</span> > STEP2 결제 안내 > STEP3 결제 완료
					</div>
					<div class="title">도서 구매</div>
					<form action="orderPay.jsp" method="post">
						<table>
							<%
								request.setCharacterEncoding("utf-8");
								
								String userId = String.valueOf(session.getAttribute("userId"));
								//String userId = (String)session.getAttribute("userId");
								UserService userService = new UserServiceImpl();
								User user = userService.findUser(userId);
							%>
							<tr class="text">
								<th><span>*</span> 아이디</th>
								<td><%= user.getUserId() %></td>
							</tr>
							<tr class="text">
								<th><span>*</span> 이름</th>
								<td><input type="text" name="userName" required /></td>
							</tr>
							<tr class="number">
								<th><span>*</span> 핸드폰 번호</th>
								<td><input type="number" required /> - <input type="number" />
									- <input type="number" /></td>
							</tr>
							<tr class="address">
								<th><span>*</span> 주소</th>
								<td><input type="text" id="sample4_postcode" placeholder="우편번호" required>
									<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
									<input type="text" id="sample4_roadAddress" placeholder="도로명주소" required>
									<input type="text" id="sample4_jibunAddress" placeholder="지번주소" >
									<span id="guide" style="color:#999;display:none"></span>
									<input type="text" id="sample4_detailAddress" placeholder="상세주소" required>
								<%
								if(request.getParameter("userAddressChange") != null&&
									request.getParameter("userAddressChange").equals("true")){
 								%>
 									<font color='blue'>주소가 수정되었습니다.</font>
 								<%
 								}
 								%>	
								</td>
							</tr>
							<tr class="radio">
								<th><span>*</span> 결제수단</th>
								<td><input type="radio" name="payment" value="체크카드/신용카드" required> 신용카드 /
									체크카드<br> <input type="radio" name="payment" value="핸드폰" required> 핸드폰
									결제</td>
							</tr>
						</table>
						<%
							int bookCnt = 0;
							int bookTotalPrice = 0;
							int deliPrice = 3000;
							
							BookService bookService = new BookServiceImpl();
							Book book = new Book();
							
							try{ //bookView에서 주문
								request.setCharacterEncoding("utf-8");
								
								String bookIsbn = request.getParameter("isbn");
								
								session.setAttribute("isbn", bookIsbn);
								book = bookService.findBook(bookIsbn);
															
								String bookTmp = request.getParameter("bookCnt");
								
								if(!bookTmp.equals("") && bookTmp!=null && !bookTmp.equals("0")) {	
									bookCnt = Integer.parseInt(bookTmp);
									if(book.getCount()<bookCnt){
							%>
										<c:redirect url='../book/bookView.jsp?numCheck=false2'/>
							<%			
									}
								}else if(bookTmp.equals("0")){
							%>
									<c:redirect url='../book/bookView.jsp?numCheck=false1'/>
							<%		
								}else{
							%>		
									<c:redirect url='../book/bookView.jsp?numCheck=false3'/>
							<%		
								}
								
								int bookPrice = book.getPrice();
								bookTotalPrice = bookCnt * bookPrice;
								
								session.setAttribute("orderBookTitle", book.getTitle());
								session.setAttribute("orderBookTotalPrice", bookTotalPrice + deliPrice);
								session.setAttribute("orderBookIsbn", book.getBookIsbn());
								session.setAttribute("orderBookCount", bookCnt);
								
							} catch (Exception e) {	//장바구니에서 주문
								List<String> bookTitles = new ArrayList<>();
								
								List<String> cartBookIsbns = (List)(session.getAttribute("cartBookIsbn")); //ISBN 리스트
								session.setAttribute("orderBookIsbns", cartBookIsbns);
								
								for(String cartBookIsbn:cartBookIsbns){
									book = bookService.findBook(cartBookIsbn);
									bookTitles.add(book.getTitle());
									session.setAttribute("orderBookTitles", bookTitles);
								}
								
								List<Integer> cartBookCnts = (List)session.getAttribute("cartBookCnt"); //Cnt 리스트				
								for(int cartBookCnt:cartBookCnts){
									session.setAttribute("orderBookCounts", cartBookCnts);
								}
								
								List<Integer> cartBookPrices = (List)session.getAttribute("cartBookPrice"); //상품가격 리스트
								for(int cartBookPrice:cartBookPrices){
									bookTotalPrice = cartBookPrice;
									session.setAttribute("orderBookTotalPrice", bookTotalPrice + deliPrice);
								}
							}
						%>
						<div class="list_add">
							&nbsp;&nbsp;상품 가격: <%= bookTotalPrice %>원 &nbsp;+ &nbsp;
							배송비: <%= deliPrice %>원 &nbsp;= &nbsp;
							<span>총가격: <%= bookTotalPrice + deliPrice %>원</span>
						</div>	
						<div class="button">
						<%
							if(request.getParameter("bookCnt")!=null){
						%>	
							<button class="ok" type="submit" formaction="orderPay.jsp?proc=1&totalPrice=<%= bookTotalPrice %>">다음</button>
							<button class="no" type="submit" formaction="../book/bookView.jsp?isbn=<%= book.getBookIsbn() %>">취소</button>
						<%
							} else {
						%>	
							<button class="ok" type="submit" formaction="orderPay.jsp?proc=2&totalPrice=<%= bookTotalPrice %>">다음</button>
							<button class="no" type="submit" formaction="../basket/basketListView.jsp">취소</button>
						<%
							}
						%>
						</div>										
					</form>
				</div>
			</div>
		</div>	
<!-- 우편번호 API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();      
    }
</script>
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