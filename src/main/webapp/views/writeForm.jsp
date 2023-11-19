<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/board/resources/css/writeForm.css">
<title>게시판_글쓰기</title>
<h1>글쓰기</h1>
<div id="form">
	<form action="writePro.jsp" method="post">
		<table>
			<tr>
				<td>제 목</td>
				<td><input type="text" name="title" required/></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input type="text" id="two" name="writer" required/></td>
			</tr>
			<tr>
				<td>내 용</td>
				<td><textarea name="content" cols="70" rows="18" required></textarea></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="pw"/></td>
			</tr>	
		</table>
		<button type="submit">글쓰기</button>
	</form>
</div>