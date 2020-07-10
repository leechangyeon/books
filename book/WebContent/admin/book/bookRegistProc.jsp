<%@page import="java.io.IOException"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="kimgibeom.book.book.domain.BookImg"%>
<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ page import="kimgibeom.book.book.service.BookService"%>
<%@ page import="kimgibeom.book.book.service.BookServiceImpl"%>
<%@ page import="kimgibeom.book.book.domain.Book"%>
<%@	page import="java.util.ArrayList, java.util.List"%>
<%
	BookImg bookImg = new BookImg();//이미지 넣는 코드 시작
	String attachPath = "/attach";
	int fileMaxSize = 5 * 1024 * 1024;
	String enctype = "utf-8";

	ServletContext ctx = getServletContext();
	attachPath = ctx.getRealPath(attachPath);
	request.setCharacterEncoding("utf-8");
	MultipartRequest mRequest = null;
	
	try {
		mRequest = new MultipartRequest(request, attachPath, fileMaxSize, enctype,
				new DefaultFileRenamePolicy());
	} catch (IOException e) {
		throw e;
	}

	if(mRequest.getFilesystemName("fileName")!=null){
		bookImg.setBookImgName(mRequest.getFilesystemName("fileName"));
	}else{
		bookImg.setBookImgName("null");
	}

	BookService bookService = new BookServiceImpl();
	String title = mRequest.getParameter("title");
	String writer = mRequest.getParameter("writer");
	String publisher = mRequest.getParameter("publisher");
	String content = mRequest.getParameter("content");
	String price = mRequest.getParameter("price");
	String count = mRequest.getParameter("count");

	int prices = Integer.parseInt(price);
	int counts = Integer.parseInt(count);

	Book book = new Book("", title, writer, publisher, content, prices, counts);
	bookService.writeBook(book);

	bookService.writeBookImg("", bookImg);
%>
<c:redirect url="bookListView.jsp" />