<%@page import="kimgibeom.book.user.domain.User"%>
<%@page import="kimgibeom.book.user.service.UserServiceImpl"%>
<%@page import="kimgibeom.book.user.service.UserService"%>
<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Admin_book_modify</title>
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
	margin-top: 40px;
	margin-left: 600px;
	margin-right: 580px;
}

.email, .address {
	width: 500px;
	padding: 3px;
}

.id, .pw, .name, .birth {
	width: 200px
}

.button2 {
	float: right;
	margin-right: 4px;
	height: 30px;
}

.phone1 {
	width: 60px;
}

.phone2, .phone3 {
	width: 120px;
}

th {
	width: 100px;
}
</style>
</head>
<body>
	<div>
		<div class="top">
			<div>
				<a href="logOut.jsp">로그아웃</a><a href="../main.jsp">메인으로</a><a href="../../main.jsp">사용자페이지</a><a href="../logo/putLogo.jsp">로고등록</a><a href="../banner/putBanner.jsp">배너등록</a>
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
					<li class="menu5 menu"><a
						href="../question/questionListView.jsp">문의관리</a></li>
				</ul>
			</div>
		</header>

		<div class='admin_book'>
			<div>
				<p>| 회원수정</p>
			</div>
			<br>
			<%
				User user=null;
				UserService userService = new UserServiceImpl();
			if(session.getAttribute("modifyUserId")==null){
				String userId = request.getParameter("userId");
				user = userService.findUser(userId);
				session.setAttribute("modifyUserId", userId);
			}else{
				String userId = (String)session.getAttribute("modifyUserId");
				user = userService.findUser(userId);
			}
			%>
			<form class="form-inline" action='../main.jsp' method='post'>
				<div class="panel panel-default">
					<!-- 테이블 -->
					<div>
						<table class="table">
							<tbody>
								<tr>
									<th>아 이 디 :</th>
									<td><%=user.getUserId()%></td>
								</tr>
								<tr>
									<th>비밀번호 :</th>
									<td><input type='text' name='userPw'
										value='<%=user.getUserPw()%>' /><%
 									if (request.getParameter("userPwCheck") != null && 
 										request.getParameter("userPwCheck").equals("false")) {
 	%> 									<font color='red'>암호가 조건에 맞지 않습니다.</font> <%
 									}else if(request.getParameter("userPwChange") != null &&
 										request.getParameter("userPwChange").equals("true")){
 										%>
 											<font color='blue'>암호가 수정되었습니다.</font>
 										<%
 									}
 	%> 									<br> <span>8자리 이상 16자리 이하, 영소문, 영대문, 숫자, 특수문자 각 최소 1개
										이상 가능(공백 불가)</span></td>
								</tr>
								<tr>
									<th>이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 름 :</th>
									<td><input class='name' type='text' name='userName'
										value='<%=user.getUserName()%>' /><%
								if(request.getParameter("userNameChange") != null&&
									request.getParameter("userNameChange").equals("true")){
 								%>
 									<font color='blue'>이름이 수정되었습니다.</font>
 								<%
 								}
 								%>
 							</td>
								</tr>
								<tr>
									<th>성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 별 :</th>
									<td><input type="radio" name='userGender' value='남성'
										<%if (user.getUserGender().equals("남성")) {%> checked <%}%>
										required> 남성 &nbsp; <input type="radio"
										name='userGender' value='여성'
										<%if (user.getUserGender().equals("여성")) {%> checked <%}%>
										required> 여성<%
								if(request.getParameter("userGenderChange") != null&&
									request.getParameter("userGenderChange").equals("true")){
 								%>
 									<font color='blue'>성별이 수정되었습니다.</font>
 								<%
 								}
 								%>
 								</td>
								</tr>
								<tr>
									<th>생년월일 :</th>
									<td><input class='birth' type='date'
										name='userBirthDate' value='<%=user.getUserBirthDate()%>' />
										<%
								if(request.getParameter("userBirthDateChange") != null&&
									request.getParameter("userBirthDateChange").equals("true")){
 								%>
 									<br><font color='blue'>생년월일이 수정되었습니다.</font>
 								<%
 								}
 								%>	</td>
								</tr>
								<tr>
									<%
										String userPhoneNumber = user.getUserPhoneNumber();
										String[] userPhone = userPhoneNumber.split("-");
									%>
									<th>전화번호 :</th>
									<td><input class='phone1' type='number' name='userPhoneNumber1'
										value='<%=userPhone[0]%>' min='0' /><b> - </b> <input
										class='phone2' type='number' name='userPhoneNumber2' value='<%=userPhone[1]%>' min='0' /><b>
											- </b><input class='phone3' name='userPhoneNumber3' type='number'
										value='<%=userPhone[2]%>' min='0' /><%
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
								<tr>
									<th>E - mail :</th>
									<td><input class='email' type='email' name='userEmail'
										value='<%=user.getUserEmail()%>' /><%
								if(request.getParameter("userEmailChange") != null&&
									request.getParameter("userEmailChange").equals("true")){
 								%>
 									<br><font color='blue'>이메일주소가 수정되었습니다.</font>
 								<%
 								}
 								%>	
								</td>
								</tr>
								<tr>
									<th>주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 소 :</th>
									<td><input type="text" id="sample4_postcode" placeholder="우편번호" name="userAddress1" >
									<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
									<input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="userAddress2" >
									<input type="text" id="sample4_jibunAddress" placeholder="지번주소" name="userAddress3">
									<span id="guide" style="color:#999;display:none"></span>
									<input type="text" id="sample4_detailAddress" placeholder="상세주소" name="userAddress4" >
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
							</tbody>
						</table>
					</div>
				</div>
				<!-- 테이블 끝-->
				<button class='button2'>
					<span class='glyphicon glyphicon-remove'></span> 수정 취소
				</button>
				<button class='button2' formaction='userModifyProc.jsp'>
					<span class='glyphicon glyphicon-ok'></span> 회원 수정
				</button>
			</form>
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
</body>
</html>
