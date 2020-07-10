<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="kimgibeom.book.book.domain.Book"%>
<%@	page import="kimgibeom.book.book.service.BookService, 
	kimgibeom.book.book.service.BookServiceImpl"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	Book book = new Book();
	BookService bookService = new BookServiceImpl();
	String cart = "";
	
	String cartNum = request.getParameter("bookCnt");
	String bookIsbn = request.getParameter("isbn");
	book = bookService.findBook(bookIsbn);
	
	int bookCnt = 0;
	if(!cartNum.equals("") && Integer.parseInt(cartNum) > 0) {   
		bookCnt = Integer.parseInt(request.getParameter("bookCnt"));
		if(bookCnt > book.getCount()){ 
		%>
			<jsp:forward page="../book/bookView.jsp?numCheck=false2&isbn=<%= book.getBookIsbn() %>"/>   
		<%	
		}
		
		String userId = String.valueOf(session.getAttribute("userId"));
		
		try{
			if(session.getAttribute("cartOrder").equals("complete")){
				if(bookIsbn != null){ //구매 직후 새로 담을 책
					cart+= bookIsbn + "/";
					Cookie cookie = new Cookie(userId, cart);
					cookie.setMaxAge(60 * 60 * 24 * 7);
					response.addCookie(cookie);
					
					Cookie cookie1 = new Cookie(bookIsbn+userId, Integer.toString(bookCnt)); 
					cookie1.setMaxAge(60 * 60 * 24 * 7);
					response.addCookie(cookie1);
				}
				
				session.setAttribute("cart", "reAdd");
			}
		}catch(Exception e){
			Cookie cookie1 = new Cookie(bookIsbn+userId, Integer.toString(bookCnt)); 
			cookie1.setMaxAge(60 * 60 * 24 * 7);
			response.addCookie(cookie1);
			
			Cookie[] cookies = request.getCookies();
			for(Cookie cookie:cookies)
				if(cookie.getName().equals(userId)) 
					cart = cookie.getValue(); //이미 장바구니에 담긴 책
			
			if(bookIsbn != null){ //새로 담을 책
				cart+= bookIsbn + "/";
				Cookie cookie = new Cookie(userId, cart);
				cookie.setMaxAge(60 * 60 * 24 * 7);
				response.addCookie(cookie);
			}	
		}
	}	
%>		
	<c:redirect url="basketListView.jsp"/>