<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.test.bean.BoardDTO" %>
<%@ page import="board.test.bean.BoardDAO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<link rel="stylesheet" href="/board/resources/css/list.css"/>
<title>게시판_글목록</title>
<h1>글목록</h1>
<%
	int pageSize = 10; // 한 페이지당 보이는 글 수
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum="1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int start = (currentPage - 1) * pageSize + 1; // (1-1)*10+1
	int end = currentPage * pageSize; // 1*10
%>
<div id="table">
	<table>
		<tr id="th">
		    <th>no</th>
		    <th>제목</th>
		    <th>작성자</th>
		    <th>날짜</th>
		    <th>조회수</th>
		</tr>
<%
	BoardDAO dao = new BoardDAO();
	ArrayList<BoardDTO> list = dao.getArticles(start, end); 
	for(BoardDTO dto : list){
%>	
	  <tr>
	    <td><%= dto.getNum() %></td>
	    <td><a href="content.jsp?num=<%=dto.getNum()%>"><%= dto.getTitle() %></a></td>
	    <td><%= dto.getWriter() %></td>
	    <td><%= dto.getReg() %></td>
	    <td><%= dto.getCount() %></td>
	  </tr>
<% } %>	
	</table>
</div>
<%
	int count = dao.count();
	if(count > 0){
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = (int)(currentPage/10)*10+1;
		int pageBlock = 10;
		int endPage = startPage + pageBlock - 1;
		if(endPage > pageCount){
			endPage = pageCount;
		}
		%>
		<div id="page">
		<%
		if(startPage > 10){
		%>	<a href="list.jsp?pageNum=<%=startPage-10 %>"><button class="button">이전</button></a>	
		<%}
		for(int i = startPage; i <= endPage; i++){
		%> <a href="list.jsp?pageNum=<%=i %>"><button class="button"><%=i %></button></a>	
		<%}
		if(endPage < pageCount){
		%>	<a href="list.jsp?pageNum=<%=startPage+10 %>"><button class="button">다음</button></a>	
		<%}
	}
%>
</div>
<button id="button" onclick="window.location='writeForm.jsp'">글 작성</button>