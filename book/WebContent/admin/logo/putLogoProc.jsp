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
	if (mRequest.getFilesystemName("fileName") == null) {
%>
		<c:redirect url='putLogo.jsp?putLogo=false' />
<%
	}
	session.setAttribute("logoImage", mRequest.getFilesystemName("fileName"));
%>
<c:redirect url='../../main.jsp' />