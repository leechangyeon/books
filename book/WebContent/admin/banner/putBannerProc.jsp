<%@page import="java.io.IOException"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String attachPath = "/img";
	int fileMaxSize = 5 * 1024 * 1024;
	String enctype = "utf-8";

	ServletContext ctx = getServletContext();
	attachPath = ctx.getRealPath(attachPath);
	System.out.println(attachPath);
	request.setCharacterEncoding("utf-8");
	MultipartRequest mRequest = null;

	try {
		mRequest = new MultipartRequest(request, attachPath, fileMaxSize, enctype);
	} catch (IOException e) {
		throw e;
	}
	if (mRequest.getFilesystemName("fileName1") != null) {
		session.setAttribute("bannerImg1", mRequest.getFilesystemName("fileName1"));
%>
<c:redirect url='../../main.jsp' />
<%
	}
	if (mRequest.getFilesystemName("fileName2") != null) {
		session.setAttribute("bannerImg2", mRequest.getFilesystemName("fileName2"));
%>
<c:redirect url='../../main.jsp' />
<%
	}
	if (mRequest.getFilesystemName("fileName3") != null) {
		session.setAttribute("bannerImg3", mRequest.getFilesystemName("fileName3"));
%>
<c:redirect url='../../main.jsp' />
<%
	}
%>
<c:redirect url='putBanner.jsp?putBanner=false' />