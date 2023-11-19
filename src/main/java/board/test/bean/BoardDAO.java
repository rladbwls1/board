package board.test.bean;

import board.db.OracleDB;
import board.test.bean.BoardDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BoardDAO extends OracleDB{
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	public int Board_Write(BoardDTO dto) {
		int result = 0;
		try{
			conn = getConnection();
			String sql = "insert into freeboard2 values(freeboard2_seq.nextval, ?, ?, ?, ?, sysdate, 0, 0, 0, 0)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setInt(4, dto.getPw());
			//pstmt.setInt(5, dto.getRef());
			//pstmt.setInt(6, dto.getRe_step());
			//pstmt.setInt(7, dto.getRe_level());
			result = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return result;
	}
	
	public ArrayList<BoardDTO> getArticles(int start, int end){
		ArrayList<BoardDTO> list = new ArrayList<>();
		conn = getConnection();
		try {
			String sql = "select * from "
					+ " (select b.* , rownum r from "
					+ " (select * from freeboard2 order by num desc) b) "
					+ " where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPw(rs.getInt("pw"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setCount(rs.getInt("count"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setRe_level(rs.getInt("re_level"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return list;
	}
	
	public BoardDTO content(int num) {
		BoardDTO dto = new BoardDTO();
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
			"update freeboard2 set count=count+1 where num = ?"); 
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			String sql = "select * from freeboard2 where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setCount(rs.getInt("count"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return dto;
	}
	
	public int count() {
		int result = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from freeboard2";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return result;
	}
}
