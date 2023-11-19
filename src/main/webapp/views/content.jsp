<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.test.bean.BoardDTO" %>
<%@ page import="board.test.bean.BoardDAO" %>
<link rel="stylesheet" href="/board/resources/css/content.css"/>
<title>게시판_게시글 내용</title>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	BoardDAO dao = new BoardDAO();
	BoardDTO dto = dao.content(num);
%>
<div id="container">
	<h1><%= dto.getTitle()%></h1>
	<div id="count"><b>조회수 : <%= dto.getCount()%></b></div>
	<div id="text">
		<b id="no">no : <%= dto.getNum()%></b>
		<b>작성자 : <%= dto.getWriter()%></b>
		<b id="reg">작성일 : <%= dto.getReg()%></b>
	</div>
	<hr id="title_hr">
	<div id="content">
		<%= dto.getContent()%>
	</div>
	<hr>
</div>
<button onclick="window.location='update.jsp?num=<%=dto.getNum()%>'">글 수정</button>
<button onclick="window.location='delete.jsp?num=<%=dto.getNum()%>'">글 삭제</button>
