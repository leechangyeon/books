<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="kimgibeom.book.book.domain.Book"%>
<%@page import="kimgibeom.book.book.service.BookService"%>
<%@page import="kimgibeom.book.book.service.BookServiceImpl"%>   
<%@page import="java.util.ArrayList, java.util.List"%>      
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우주 서점</title>
<link rel="stylesheet" href="./css/main.css">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<script type="text/javascript"
   src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<style>
/* 메인 */
.contmain {
   width: 100%;
   margin: 0 auto;
}

/* swiper */
.booklist {
   width: 1070px;
   margin: 0 auto;
}

.booklist p {
   margin-top: 50px;
   margin-left: 32px;
   font-size: 20px;
   font-weight: bold;
}

.swiper-container {
   width: 1100px;
   height: 300px;
   border-radius: 7px;
   padding: 0 10px;
}

.swiper-container img {
   width: 100%;
   height: 100%;
   margin-bottom: 5px;
}

.swiper-slide {
   text-align: center;
   display: flex;
   align-items: center;
   justify-content: center;
}

.swiper-slide div div {
   background-color: #ccc;
   width: 178px;
   height: 250px;
}

.swiper-slide .book_price {
   color: #666;
   font-size: 14px;
}

.swiper-button-next {
   margin-right: -10px !important;
}

.swiper-button-prev {
   margin-left: -10px !important;
}

.simple_banner_wrap {
   position: relative;
   overflow: hidden;
   width: 100%;
   height: 250px;
}

.simple_banner_wrap ul {
   list-style: none;
   margin: 0;
   padding: 0;
   display: block;
   position: absolute;
   left: 0;
   top: 0;
   width: 100%;
   height: 100%;
}

.simple_banner_wrap ul li {
   margin: 0;
   padding: 0;
   display: block;
   position: absolute;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%;
}

.simple_banner_wrap .nav_wrap {
   position: absolute;
   bottom: 10px;
   height: 10px;
   z-index: 2;
}

.simple_banner_wrap .nav_wrap ul {
   display: block;
   position: relative;
   list-style: none;
   margin: 0;
   padding: 0;
}

.simple_banner_wrap .nav_wrap ul li {
   display: inline-block;
   position: relative;
   width: 10px;
   height: 10px;
   margin: 0 1px;
   cursor: pointer;
}

.simple_banner_wrap .nav_wrap.numeral {
   height: 14px;
   line-height: 14px;
}

.simple_banner_wrap .nav_wrap.numeral ul li {
   font-size: 12px;
   width: 14px;
   height: 14px;
   text-align: center;
   text-shadow: 1px 1px 0px #CCC;
}

.simple_banner_wrap .nav_wrap.numeral ul li.on {
   text-decoration: underline;
   font-weight: bold;
}

.simple_banner_wrap .nav_wrap.bullet {
   height: 10px;
   line-height: 10px;
   width: 100%;
   margin: 0 auto;
   text-align: center;
   margin-bottom: 5px;
}

.simple_banner_wrap .nav_wrap.bullet ul li {
   font-size: 10px;
   text-indent: -10000px;
   border-radius: 5px;
   margin: 0 5px;
   border: 1px solid #fff;
}

.simple_banner_wrap .nav_wrap.bullet ul li.on {
   background-color: #FFF;
}

.simple_banner_wrap .nav_wrap.prev_next {
   height: 14px;
   line-height: 14px;
   text-shadow: 1px 1px 0px #CCC;
}

.simple_banner_wrap .nav_wrap.prev_next ul li {
   font-size: 12px;
   width: 14px;
   height: 14px;
   font-weight: bold;
   text-align: center;
}

.swiper-slide .book_text {
   font-size: 14px;
   color: #000;
}

.swiper-slide a{
   text-overflow: ellipsis;
    white-space: nowrap;
    width:178px;
    overflow: hidden;
}
</style>
<script>
   $(function() {
      initSimpleBanner();
   });

   function initSimpleBanner() {
      var wrap;
      var W;
      var H;
      var lis;
      var li;
      var nav_wrap;
      var nav_ul;
      var cnt;
      var i;
      var itv;
      var type;
      var nav_type;
      $(".simple_banner_wrap")
            .each(
                  function(idx) {
                     // init variables
                     wrap = $(this);
                     wrap.data("index", idx);
                     wrap.data("current", 0);
                     wrap.data("mouseenter", false);
                     W = wrap.width();
                     H = wrap.height();
                     switch (wrap.data("type")) {
                     case "hslide":
                     case "vslide":
                     case "alpha":
                        type = wrap.data("type");
                        break;

                     default:
                        wrap.data("type", "alpha");
                        type = "alpha";
                        break;
                     }
                     switch (wrap.data("nav-type")) {
                     case "numeral":
                     case "bullet":
                     case "prev_next":
                        nav_type = wrap.data("nav-type");
                        break;

                     default:
                        wrap.data("nav-type", "bullet");
                        nav_type = "bullet";
                        break;
                     }
                     if (isNaN(wrap.data("interval"))) {
                        wrap.data("interval", 5000);
                     }
                     lis = wrap.find("ul li");
                     cnt = lis.length;
                     wrap.data("total", cnt);

                     // init banners
                     if (type == "hslide") {
                        lis.each(function(idx, itm) {
                           li = $(itm);
                           li.css("left", W * idx + "px");
                        });
                     } else if (type == "vslide") {
                        lis.each(function(idx, itm) {
                           li = $(itm);
                           li.css("top", H * idx + "px");
                        });
                     } else {
                        lis.each(function(idx, itm) {
                           li = $(itm);
                           if (idx == 0) {
                              li.css({
                                 zIndex : 1,
                                 opacity : 1
                              });
                           } else {
                              li.css("opacity", 0);
                           }
                        });
                     }

                     // init navigation
                     wrap
                           .append('<div class="nav_wrap ' + nav_type + '"><ul></ul></div>');
                     nav_wrap = wrap.find(".nav_wrap");
                     nav_ul = wrap.find(".nav_wrap ul");
                     switch (nav_type) {
                     case "numeral":
                     case "bullet":
                        for (i = 0; i < cnt; i++) {
                           nav_ul.append('<li>' + (i + 1) + '</li>');
                        }
                        nav_ul.find("li").bind("click",
                              sbNavClickListener);
                        nav_ul.find("li").eq(0).addClass("on");
                        break;

                     case "prev_next":
                        nav_ul.append('<li>&lt;</li>');
                        nav_ul.append('<li>&gt;</li>');
                        nav_ul.find("li").bind("click",
                              sbNavClickListener);
                        break;
                     }

                     nav_wrap.css("left", (W - nav_wrap.width()) / 2
                           + "px");

                     // rest timer
                     i = idx;
                     itv = wrap.data("interval");
                     setTimeout("sbAnimateBannerTimer(" + i + ")", itv);

                     // init events
                     wrap.bind("mouseenter", sbMouseEnterListener);
                     wrap.bind("mouseleave", sbMouseLeaveListener);
                  });
   }

   /**
    * mouse enter listener
    * kill timer on mouse enter
    */
   function sbMouseEnterListener(e) {
      var wrap = $(e.currentTarget);
      wrap.data("mouseenter", true);
      if (wrap.data("stid")) {
         clearTimeout(wrap.data("stid"));
      }
   }
   /**
    * mouse leave listener
    * reset timer on mouse leave
    */
   function sbMouseLeaveListener(e) {
      var wrap = $(e.currentTarget);
      wrap.data("mouseenter", false);
      var n = wrap.data("index");
      var itv = wrap.data("interval");
      wrap.data("stid", setTimeout("sbAnimateBannerTimer(" + n + ")", itv));
   }

   /**
    * timer callback function
    */
   function sbAnimateBannerTimer(idx) {
      var wrap = $(".simple_banner_wrap").eq(idx);
      //console.log("timeout", idx, wrap.data("current"), wrap.data("total"), wrap.data("stid"));

      var c = wrap.data("current") + 1;
      if (c >= wrap.data("total")) {
         c = 0;
      }
      sbAnimateBanner(wrap, c);
   }

   /**
    * navigation click listener
    */
   function sbNavClickListener(e) {
      var n;
      var nav = $(e.target);
      var wrap = nav.parents(".simple_banner_wrap");
      switch (wrap.data("nav-type")) {
      case "numeral":
      case "bullet":
         n = nav.html() - 1;
         break;

      case "prev_next":
         var total = wrap.data("total");
         n = wrap.data("current");
         if (nav.html() == "&lt;") {
            n--;
            if (n < 0) {
               n = total - 1;
            }
         } else {
            n++;
            if (n >= total) {
               n = 0;
            }
         }
         break;
      }

      sbAnimateBanner(wrap, n);
   }

   /**
    * animates banners
    */
   function sbAnimateBanner(wrap, cur) {
      // kill timer
      if (wrap.data("stid")) {
         clearTimeout(wrap.data("stid"));
      }

      // init variables
      wrap.data("current", cur);
      var type = wrap.data("type");
      var W = wrap.width();
      var H = wrap.height();
      var wrap_ul = wrap.children("ul");
      var wrap_lis = wrap_ul.children();
      var nav_li;

      // animate banner
      if (type == "hslide") {
         wrap_ul.stop(true);
         wrap_ul.animate({
            left : -W * cur + "px"
         }, 200);
      } else if (type == "vslide") {
         wrap_ul.stop(true);
         wrap_ul.animate({
            top : -H * cur + "px"
         }, 200);
      } else {
         var li;
         wrap_lis.each(function(idx, itm) {
            li = $(itm);
            li.stop(true);
            if (idx == cur) {
               li.css("z-index", 1);
               li.animate({
                  opacity : 1
               }, 200);
            } else {
               li.css("z-index", 0);
               li.animate({
                  opacity : 0
               }, 200);
            }
         });
      }

      // update navigation
      switch (wrap.data("nav-type")) {
      case "numeral":
      case "bullet":
         wrap.find(".nav_wrap ul li").each(function(idx, itm) {
            nav_li = $(itm);
            if (idx == cur) {
               nav_li.addClass("on");
            } else {
               nav_li.removeClass("on");
            }
         });
         break;

      //case "prev_next":
      // do nothing
      //break;
      }

      // reset timer
      if (wrap.data("mouseenter") == false) {
         var n = wrap.data("index");
         var itv = wrap.data("interval");
         wrap.data("stid",
               setTimeout("sbAnimateBannerTimer(" + n + ")", itv));
      }
   }
</script>
</head>
<body>
   <div class="container">
      <!-- 탑 -->
      <div class="top">
         <div>
            <% 
               if (session.getAttribute("userId") != null) {
            %>
            ${userId}<%
               out.println("님, 환영합니다");
            %>
            <a href="user/logOut.jsp">로그아웃</a> <a href="user/userInfo.jsp">마이페이지</a>
               <%
                  if(session.getAttribute("userId").equals("admin")){
                     %>
                        <a href="admin/main.jsp">관리자페이지</a>
                     <%
                  }
               %>
            <%
               } else {
            %>
            <a href="user/logIn.jsp">로그인</a> <a href="user/joinAgree.jsp">회원가입</a>
            <%
               }
            %>
         </div>
      </div>
      
      <%
	if((String)session.getAttribute("logoImage")!=null){
		String logoImage=(String)session.getAttribute("logoImage");
		session.setAttribute("logoImage", null);
		Cookie cookie = new Cookie("logoImage",logoImage);
		cookie.setMaxAge(60*60*24*365*10000);
		response.addCookie(cookie);
		%>
			<c:redirect url='admin/logo/putLogo.jsp?putLogo=true' />
		<%
	}
      if((String)session.getAttribute("bannerImg1")!=null){
			String bannerImg1=(String)session.getAttribute("bannerImg1");
			session.setAttribute("bannerImg1", null);
			Cookie cookie = new Cookie("bannerImg1",bannerImg1);
			cookie.setMaxAge(60*60*24*365*10000);
			response.addCookie(cookie);
			%>
				<c:redirect url='admin/banner/putBanner.jsp?putBanner1=true' />
			<%
		}
      if((String)session.getAttribute("bannerImg2")!=null){
			String bannerImg2=(String)session.getAttribute("bannerImg2");
			session.setAttribute("bannerImg2", null);
			Cookie cookie = new Cookie("bannerImg2",bannerImg2);
			cookie.setMaxAge(60*60*24*365*10000);
			response.addCookie(cookie);
			%>
				<c:redirect url='admin/banner/putBanner.jsp?putBanner2=true' />
			<%
		}
      if((String)session.getAttribute("bannerImg3")!=null){
			String bannerImg3=(String)session.getAttribute("bannerImg3");
			session.setAttribute("bannerImg3", null);
			Cookie cookie = new Cookie("bannerImg3",bannerImg3);
			cookie.setMaxAge(60*60*24*365*10000);
			response.addCookie(cookie);
			%>
				<c:redirect url='admin/banner/putBanner.jsp?putBanner3=true' />
			<%
		}
	%>
<!--검색창 -->
      <div class="tophead">
         <div class="logo">
            <a href="main.jsp">
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
            			%><img src='img/<%=logoImgName%>'/><%
            		}
            	%></a>
         </div>
         <div class="sear">
            <div class="search">
               <form action="book/mainSearchProc.jsp">
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
					<li class="menu1 menu"><a href="introduce/ceoGreet.jsp">서점
							소개</a>
						<ul>
							<li><a href="introduce/ceoGreet.jsp">인사말</a></li>
							<li><a href="introduce/companyLocation.jsp">오시는 길</a></li>
						</ul></li>
					<li class="menu2 menu"><a href="book/bookListView.jsp?back=true">도서</a></li>
					<li class="menu3 menu"><a
						href="question/questionListView.jsp">문의게시판</a></li>
				</ul>
			</div>
		</header>

      <div class="contmain">
         <!-- 메인배너 -->
         <div class="simple_banner_wrap banner01" align="center">
            <ul>
               <li style="background-color: #42a5be;">
               <%
            		cookies = request.getCookies();
            		String bannerImgName1="";
            		if(cookies != null){
            			for(Cookie c:cookies){
            				if(c.getName().equals("bannerImg1")){
            					bannerImgName1=c.getValue();
            				} 
            			}
            		}
            		if(bannerImgName1.equals("")){
            			%>배너1이미지<%
            		} 
            		else{
            			%><img src='img/<%=bannerImgName1%>'/><%
            		}
            	%></li>
               <li style="background-color: #449e60;"> <%
            		cookies = request.getCookies();
            		String bannerImgName2="";
            		if(cookies != null){
            			for(Cookie c:cookies){
            				if(c.getName().equals("bannerImg2")){
            					bannerImgName2=c.getValue();
            				} 
            			}
            		}
            		if(bannerImgName2.equals("")){
            			%>배너1이미지<%
            		} 
            		else{
            			%><img src='img/<%=bannerImgName2%>'/><%
            		}
            	%></li>
               <li style="background-color: #cf619a;"> <%
            		cookies = request.getCookies();
            		String bannerImgName3="";
            		if(cookies != null){
            			for(Cookie c:cookies){
            				if(c.getName().equals("bannerImg3")){
            					bannerImgName3=c.getValue();
            				} 
            			}
            		}
            		if(bannerImgName3.equals("")){
            			%>배너1이미지<%
            		} 
            		else{
            			%><img src='img/<%=bannerImgName3%>'/><%
            		}
            	%></li>
            </ul>
         </div>

         <!-- 책 슬라이드 -->
         <div class="booklist">
            <p>신규도서</p>
            <div class="swiper-container">
               <div class="swiper-wrapper">
               <%
                  List<Book> books = new ArrayList<>();
                  String isbn = "";
                  
                  BookService bookService = new BookServiceImpl();
                  List<Book> bookIsbns = bookService.readIsbns(); 
                  for(Book bookIsbn:bookIsbns){
                     isbn = String.valueOf(bookIsbn.getBookIsbn());
                     books.add(bookService.findBook(isbn));
                  }
                  
                  for(int i=0; i<(int)(books.size()/2); i++){ //DB 책 역순으로 변경
                     Book tmp = books.get(i);
                     books.set(i, books.get(books.size()-i-1));
                     books.set(books.size()-i-1, tmp);
                  }
                     for(Book book:books){ 
               %>               
                  <div class="swiper-slide">
                     <div>                           
                        <a href='./book/bookView.jsp?isbn=<%= book.getBookIsbn() %>'><div>
                        <%
                        if(bookService.readBookImgName(book.getBookIsbn())!=null && !bookService.readBookImgName(book.getBookIsbn()).getBookImgName().equals("null")){
                        String imgName=(bookService.readBookImgName(book.getBookIsbn())).getBookImgName();
                           %>
                              <img src='attach/<%=imgName%>'/>
                           <%
                        }
                        else{
                           out.println("이미지 등록x");
                        }
                        %>
                        </div> 
                           <span class="book_text"><%= book.getTitle() %></span><br><span class="book_price"><%= book.getPrice() %>원</span></a>
                     </div>
                  </div>
                  <%
                     }
                  %>                     
               </div>

               <!-- 네비게이션 지정 -->
               <div class="swiper-button-next"></div>
               <!-- 다음 버튼(오른쪽) -->
               <div class="swiper-button-prev"></div>
               <!-- 이전 버튼(왼쪽) -->
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
            			%><img src='img/<%=logoImgName2%>'/><%
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
<!-- 책 슬라이드 스크립트 -->
<script>
   new Swiper('.swiper-container', {
      slidesPerView : 5, // 동시에 보여줄 슬라이드 갯수
      spaceBetween : -18, // 슬라이드간 간격
      slidesPerGroup : 5, // 그룹으로 묶을 수

      navigation : {
         nextEl : '.swiper-button-next', // 다음 버튼 클래스명
         prevEl : '.swiper-button-prev', // 이번 버튼 클래스명
      },
   });
</script>