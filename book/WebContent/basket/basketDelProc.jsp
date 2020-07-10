<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>      
<%@ page import="kimgibeom.book.book.domain.Book"%>       
<%@	page import="kimgibeom.book.book.service.BookServiceImpl, 
	kimgibeom.book.book.service.BookService"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%
	String userId = String.valueOf(session.getAttribute("userId"));

	String cart = "";
	String delBook = "";
	
	Cookie[] cookies = request.getCookies();
	for(Cookie cookie: cookies)
		if(cookie.getName().equals(userId))
			cart = cookie.getValue(); 
	
	String[] books = request.getParameterValues("books");  
	if(books != null)
		for(String book:books){ 
			cart = cart.replace(book + "/", ""); //유저 별 쿠키값 수정
			Cookie cookie2 = new Cookie(userId, cart); 
			cookie2.setMaxAge(60 * 60 * 24 * 7);
				if(cart.equals("")){
					cookie2.setMaxAge(0);
				}
			response.addCookie(cookie2);
			
			delBook += book + "/"; //로컬 스토리지 생성을 위해 쿠키 생성
			Cookie delBooks = new Cookie("delBook"+userId, delBook);
			delBooks.setMaxAge(60 * 60 * 24 * 7);
			response.addCookie(delBooks);
			
			for(Cookie cookie: cookies)
				if(cookie.getName().equals(book+userId)){ 
					Cookie cookie1 = new Cookie(book+userId, "");
					cookie1.setMaxAge(0); //수량 쿠키 삭제
					response.addCookie(cookie1);
				}
		}
%>
<c:redirect url="basketListView.jsp"/>