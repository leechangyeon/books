<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Admin_book_add</title>
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
	width: 800px;
	margin: 0 auto;
	margin-top: 40px;
	position: relative;
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

.bottom_btn {
	overflow: hidden;
	margin-bottom: 60px;
	margin-right: 100px;
}

.form_del {
	position: absolute;
	top: 511px;
	right: 0;
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
					<li class="menu5 menu"><a href="../question/questionListView.jsp">문의관리</a></li>
				</ul>
			</div>
		</header>

		<div class='admin_book'>
			<div>
				<p>| 회원등록</p>
			</div>
			<br>
			<form class="form-inline" action='userRegistProc.jsp' method='post'>
				<div class="panel panel-default">
					<!-- 테이블 -->
					<div>
						<table class="table">
							<tbody>
								<tr>
									<th>아 이 디 :</th>
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
								<tr>
									<th>비밀번호 :</th>
									<td><input type="password" name='userPw' required /><%
													if (request.getParameter("pwCheck")!=null && 
 															request.getParameter("pwCheck").equals("false")) {
 %>															<font color='red'> 암호가 조건에 맞지 않습니다.</font><%
 													}%><br>
									<span>8자리 이상 16글자 이하의 영문 대소문자, 숫자, 특수문자 각 최소 1개 이상, 공백
										불가</span></td>
								</tr>
								<tr>
									<th>이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 름 :</th>
									<td><input type="text" name='userName' required /></td>
								</tr>
								<tr>
									<th>성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 별 :</th>
									<td><label><input type="radio" name="userGender" value='남성'
									required> 남성 </label><label><input type="radio" name="userGender"
									value='여성' required> 여성</label></td>
								</tr>
								<tr>
									<th>생년월일 :</th>
									<td><input type="date" name='userBirthDate' required /></td>
								</tr>
								<tr>
									<th>전화번호 :</th>
									<td><input type="number" name='userPhoneNumber1' min='0' required />
									- <input type="number" name='userPhoneNumber2' min='0' required /> - <input
									type="number" name='userPhoneNumber3' min='0' required /></td>
								</tr>
								<tr>
									<th>E - mail :</th>
									<td><input type="email" name=userEmail required /> <%
													if (request.getParameter("emailCheck")!=null && 
 															request.getParameter("emailCheck").equals("false")) {
 													%>	<font color='red'> 메일이 조건에 맞지 않습니다. '@'와 '.'를 입력하세요. </font><%
 													}%>
 									</td>
								</tr>
								<tr>
									<th>주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 소 :</th>
									<td><input type="text" id="sample4_postcode" placeholder="우편번호" name="userAddress1" required>
									<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
									<input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="userAddress2" required>
									<input type="text" id="sample4_jibunAddress" placeholder="지번주소" name="userAddress3">
									<span id="guide" style="color:#999;display:none"></span>
									<input type="text" id="sample4_detailAddress" placeholder="상세주소" name="userAddress4" required>
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
				<div class="bottom_btn">
					<button class='button2'>
						<span class='glyphicon glyphicon-ok'></span> 회원 등록
					</button>
				</div>
			</form>
			<form action="" class="form_del">
				<button class='button2' formaction='../main.jsp'>
					<span class='glyphicon glyphicon-remove'></span> 등록취소
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