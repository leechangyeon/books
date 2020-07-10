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
.member>div:nth-child(1) {
	text-align: center;
}

.member>div:nth-child(1) span {
	font-weight: bold;
}

.member {
	width: 790px;
	font-size: 14px;
	margin-left: 50px;
}

.member p {
	font-size: 20px;
	font-weight: bold;
}

.member table {
	border: 1px solid #666;
	border-collapse: collapse;
	text-align: left;
	width: 790px;
	font-size: 14px;
}

.member table .text input {
	margin-top:5px;
	height: 25px;
	width: 35%;
}

.member table .date input {
	height: 25px;
}

.member table .number input {
	height: 25px;
	width: 10%;
}

.member table .address input {
	height: 25px;
	width: 50%;
	margin-top: 5px;
}

.member table .address input:nth-child(4) {
	margin-bottom: 5px;
}

.member table .address div {
	overflow: hidden;
}

.member table .address div input {
	float: left;
}

.member table .address div input:nth-child(1) {
	width: 30%;
}

.member table .address div input:nth-child(2) {
	width: 16%;
	margin-left: -1px;
	height: 31px;
}

.member form {
	margin-top: 70px;
}

.member form .button {
	overflow: hidden;
}

.member form .button button {
	height: 40px;
	margin-top: 30px;
	float: right;
}

.member form .button .ok {
	background-color: #42a5be;
	border: 1px solid #42a5be;
	width: 70px;
	color: #fff;
}

.member form .button .no {
	width: 70px;
	margin-left: 5px;
}

.member table tr {
	height: 30px;
}

.member th {
	border-left: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 45px;
	background-color: #eee;
}

.member td {
	border-right: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 45px;
}

.member th span {
	color: red;
}

.member .text button {
	height: 30px;
	background-color: #666;
	border: 0px;
	color: #fff;
}

.member .text td span {
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
					<li class="menu3 menu"><a href="../question/questionListView.jsp?back=true">문의게시판</a></li>
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
				<div class="member">
					<div>
						STEP1 약관 동의 > <span>STEP2 고객 정보 입력</span> > STEP3 회원가입완료
					</div>
					<form action="joinProc.jsp" method='post'>
						<table>
							<tr class="text">
								<th><span>*</span> 아이디</th>
								<td><input type="text" name='userId' required /> <%
 													if (request.getParameter("idCheck")!=null && 
 															request.getParameter("idCheck").equals("false")) {
 %>															<font color='red'> 아이디가 조건에 맞지 않습니다.</font><%
 													}else if(request.getParameter("idOverlap")!=null && 
 															request.getParameter("idOverlap").equals("true")){%>
 															<font color='red'> 이미 사용중인 아이디입니다.</font>
 													<%}
 %>							<br> <span>8자리 이상 12글자 이하의 영문, 숫자 각 최소 1개 이상(첫글자는 영문), 공백 불가</span></td>
							</tr>
							<tr class="text">
								<th><span>*</span> 암호</th>
								<td><input type="password" name='userPw' required /><%
													if (request.getParameter("pwCheck")!=null && 
 															request.getParameter("pwCheck").equals("false")) {
 %>															<font color='red'> 암호가 조건에 맞지 않습니다.</font><%
 													}%><br>
									<span>8자리 이상 16글자 이하의 영문 대소문자, 숫자, 특수문자 각 최소 1개 이상, 공백
										불가</span></td>
							</tr>
							<tr class="text">
								<th><span>*</span> 이름</th>
								<td><input type="text" name='userName' required /></td>
							</tr>
							<tr class="radio">
								<th><span>*</span> 성별</th>
								<td><label><input type="radio" name="userGender" value='남성'
									required> 남성 </label><label><input type="radio" name="userGender"
									value='여성' required> 여성</label></td>
							</tr>
							<tr class="date">
								<th><span>*</span> 생년월일</th>
								<td><input type="date" name='userBirthDate' required /></td>
							</tr>
							<tr class="number">
								<th><span>*</span> 핸드폰 번호</th>
								<td><input type="number" name='userPhoneNumber1' min='0' required />
									- <input type="number" name='userPhoneNumber2' min='0' required /> - <input
									type="number" name='userPhoneNumber3' min='0' required /></td>
							</tr>
							<tr class="text">
								<th><span>*</span> E-mail</th>
								<td><input type="email" name=userEmail required /><%
													if (request.getParameter("emailCheck")!=null && 
 															request.getParameter("emailCheck").equals("false")) {
 %>															<font color='red'> 메일이 조건에 맞지 않습니다. '@'와 '.'를 입력하세요. </font><%
 													}%></td>
							</tr>
							<tr class="address">
								<th><span>*</span> 주소</th>
								<td>
									<div>
										<input type="text" id="sample4_postcode" placeholder="우편번호" name="userAddress1" required>
										<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
									</div>
									<input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="userAddress2" required>
									<input type="text" id="sample4_jibunAddress" placeholder="지번주소" name="userAddress3">
									<input type="text" id="sample4_detailAddress" placeholder="상세주소" name="userAddress4" required>
								</td>
							</tr>
						</table>
						<div class="button">
							<button class="no" type="button" onclick="location.href='../main.jsp'">취소</button>
							<button class="ok" type="submit">확인</button>
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