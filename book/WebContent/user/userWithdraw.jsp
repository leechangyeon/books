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
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<script>
	function alert1() {
		swal({
			title : "탈퇴하시겠습니까?",
			text : "탈퇴한 회원의 모든 정보는 복구되지 않습니다.",
			type : "warning",
			showCancelButton : true,
			cancelButtonText : "아니요",
			confirmButtonText : "예",
			closeOnConfirm : false
		}, function() {
			document.sub1.submit();
		});
	}
</script>

<style>
.del {
	width: 790px;
	font-size: 14px;
	margin: 20px 0 60px 50px;
}

.del table {
	border: 1px solid #666;
	border-collapse: collapse;
	text-align: left;
	width: 790px;
	font-size: 14px;
}

.del table .text input {
	height: 25px;
	width: 35%;
}

.del form {
	margin-top: 40px;
}

.del form div {
	margin-bottom: 10px;
}

.del form .button {
	overflow: hidden;
}

.del form .button button {
	height: 40px;
	margin-top: 30px;
	float: right;
}

.del table tr {
	height: 30px;
}

.del th {
	border-left: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 45px;
	background-color: #eee;
}

.del td {
	border-right: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 45px;
}

.del th span {
	color: red;
}

.del .text td input:nth-child(2) {
	width: 75px;
	height: 30px;
	background-color: #666;
	border: 0px;
	color: #fff;
	margin-left: -5px;
}

.del .title {
	font-size: 20px;
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
					<li><a href="userInfo.jsp">개인정보</a></li>
					<li><a href="../basket/basketListView.jsp">장바구니</a></li>
					<li><a href="../order/orderListView.jsp">구매조회</a></li>
					<li class="action"><a href="userWithdraw.jsp">회원탈퇴</a></li>
				</ul>
			</div>
			<!-- 회원탈퇴 -->
			<div class="content">
				<div class="del">
					<div class="title">회원 탈퇴</div>
					<form name='sub1' action="userWithdrawProc.jsp" method='post'>
						<div>※ 회원탈퇴를 하시면 더이상 우주서점을 이용하실 수 없습니다. 정말 탈퇴하시겠습니까?</div>
						<table>
							<tr class="text">
								<th><span>*</span> 암호</th>
								<td><input type="password" name='userPw' /> <input type='button'
									onclick="alert1()" value='회원탈퇴'>
									<%
										if(request.getParameter("userPwCheck")!=null&&
												request.getParameter("userPwCheck").equals("false")){
											%>
												<br><font color='red'>암호가 틀렸습니다.</font>
											<%
										}
									%>
								</td>
							</tr>
						</table>
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