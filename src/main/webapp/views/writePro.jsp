<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.test.bean.BoardDTO" %>
<%@ page import="board.test.bean.BoardDAO" %>
<h1>글 등록 확인</h1>
<%	
	request.setCharacterEncoding("UTF-8");
	BoardDTO dto = new BoardDTO();
	dto.setWriter(request.getParameter("writer"));
	dto.setTitle(request.getParameter("title"));
	dto.setContent(request.getParameter("content"));
	String pw = request.getParameter("pw");
	if (pw != null && !pw.isEmpty()) {
		dto.setPw(Integer.parseInt(pw));
	}
	BoardDAO dao = new BoardDAO();
	int result = dao.Board_Write(dto);
	
	if(result == 1){
		%>		
		<script>
			alert("등록되었습니다✨");
		</script>
		<%
		response.sendRedirect("list.jsp"); 
	}else{
%>		
		<script>
			alert("글 등록이 안되었습니다 ㅠ_ㅠ")
		</script>
<%	}	
%>
<h1><%=result %>행 추가되었습니다.</h1>

