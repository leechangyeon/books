<%@page import="kimgibeom.book.user.service.UserServiceImpl"%>
<%@page import="kimgibeom.book.user.service.UserService"%>
<%@page import="kimgibeom.book.user.domain.User"%>
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
<link rel="stylesheet" href="../css/member.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<style>
.modify {
	width: 790px;
	font-size: 14px;
	margin: 20px 0 60px 50px;
}

.modify p {
	font-size: 20px;
	font-weight: bold;
}

.modify table {
	border: 1px solid #666;
	border-collapse: collapse;
	text-align: left;
	width: 790px;
	font-size: 14px;
}

.modify table .text input {
	height: 25px;
	width: 35%;
}

.modify table .text_pw input {
	margin-top: 5px;
}

.modify table .date input {
	height: 25px;
}

.modify table .number input {
	height: 25px;
	width: 10%;
}

.modify table .address input {
	height: 25px;
	width: 50%;
}

.modify table .address input {
	height: 25px;
	width: 50%;
	margin-top: 5px;
}

.modify table .address input:nth-child(4) {
	margin-bottom: 5px;
}

.modify table .address div {
	overflow: hidden;
}

.modify table .address div input {
	float: left;
}

.modify table .address div input:nth-child(1) {
	width: 30%;
}

.modify table .address div input:nth-child(2) {
	width: 16%;
	margin-left: -1px;
	height: 31px;
}

.modify form {
	margin-top: 40px;
}

.modify form .button {
	overflow: hidden;
}

.modify form .button button {
	height: 40px;
	margin-top: 30px;
	float: right;
}

.modify form .button .ok {
	background-color: #42a5be;
	border: 1px solid #42a5be;
	width: 70px;
	color: #fff;
}

.modify form .button .no {
	width: 70px;
	margin-left: 5px;
}

.modify table tr {
	height: 30px;
}

.modify th {
	border-left: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 45px;
	background-color: #eee;
}

.modify td {
	border-right: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 45px;
}

.modify th span {
	color: red;
}

.modify .text button {
	height: 30px;
	background-color: #666;
	border: 0px;
	color: #fff;
}

.modify .text td span {
	font-size: 12px;
}

.modify .title {
	font-size: 20px;
	font-weight: bold;
}

.modify .text td span {
	font-size: 12px;
	color:#666;
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
				UserService userService = new UserServiceImpl();
				User user = userService.findUser((String) (session.getAttribute("userId")));
			%>
			<!-- 회원가입 -->
			<div class="content">
				<div class="modify">
					<div class="title">개인정보 수정</div>
					<form action='userModifyProc.jsp' method='post'>
						<table>
							<tr class="text">
								<th>아이디</th>
								<td><%=user.getUserId() %></td>
							</tr>
							<tr class="text text_pw">
								<th>암호</th>
								<td><input type="password" name='userPw' /> <%
 									if (request.getParameter("userPwCheck") != null && 
 										request.getParameter("userPwCheck").equals("false")) {
 	%> 									<font color='red'>암호가 조건에 맞지 않습니다.</font> <%
 									}else if(request.getParameter("userPwChange") != null &&
 										request.getParameter("userPwChange").equals("true")){
 										%>
 											<font color='blue'>암호가 수정되었습니다.</font>
 										<%
 									}
 	%> 									<br> <span>8자리 } 이상 16자리 이하, 영소문, 영대문, 숫자, 특수문자 각 최소 1개
										이상 가능(공백 불가)</span></td>
							</tr>
							<tr class="text">
								<th>이름</th>
								<td><input type="text" name='userName' />
								<%
								if(request.getParameter("userNameChange") != null&&
									request.getParameter("userNameChange").equals("true")){
 								%>
 									<font color='blue'>이름이 수정되었습니다.</font>
 								<%
 								}
 								%>
 							</td>
							</tr>
							<tr class="radio">
								<th>성별</th>
								<td><label><input type="radio" name="userGender" value='남성'>
										남성</label> <label><input type="radio" name="userGender"
										value='여성'> 여성</label>
								<%
								if(request.getParameter("userGenderChange") != null&&
									request.getParameter("userGenderChange").equals("true")){
 								%>
 									<font color='blue'>성별이 수정되었습니다.</font>
 								<%
 								}
 								%>
 								</td>
							</tr>
							<tr class="date">
								<th>생년월일</th>
								<td><%=user.getUserBirthDate() %></td>
							</tr>
							<tr class="number">
								<th>핸드폰 번호</th>
								<td><input type="number" name='userPhoneNumber1' min='0'/> - <input
									type="number" name='userPhoneNumber2' min='0'/> - <input type="number"
									name='userPhoneNumber3' min='0'/>
								<%
								if(request.getParameter("userPhoneNumberChange") != null&&
									request.getParameter("userPhoneNumberChange").equals("true")){
 								%>
 									<font color='blue'>핸드폰 번호가 수정되었습니다.</font>
 								<%
 								}else if(request.getParameter("userPhoneNumberNotAll") != null&&
 										request.getParameter("userPhoneNumberNotAll").equals("true")){
 									%>
 									<font color='red'>모든 입력창에 입력해주세요.</font>
 									<%
 								}
 								%>		
								</td>
							</tr>
							<tr class="text">
								<th>E-mail</th>
								<td><input type="email" name='userEmail' />
								<%
								if(request.getParameter("userEmailChange") != null&&
									request.getParameter("userEmailChange").equals("true")){
 								%>
 									<font color='blue'>이메일주소가 수정되었습니다.</font>
 								<%
 								}
 								%>	
								</td>
							</tr>
							<tr class="address">
								<th>주소</th>
								<td>
									<div>
										<input type="text" id="sample4_postcode" placeholder="우편번호" name="userAddress1">
										<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
									</div>
									<input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="userAddress2">
									<input type="text" id="sample4_jibunAddress" placeholder="지번주소" name="userAddress3">
									<input type="text" id="sample4_detailAddress" placeholder="상세주소" name="userAddress4">
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
						</table>
						<div class="button">
							<button class="no" type="submit" formaction="userInfo.jsp?">취소</button>
							<button class="ok" type="submit">수정</button>
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