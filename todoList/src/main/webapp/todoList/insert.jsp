<%@page import="org.apache.catalina.connector.OutputBuffer"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="kr.or.ddit.util.DBUtil3"%>
<%@page import="java.util.Scanner"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/main.css">
<script src="../js/jquery-3.6.0.js"></script>
<title>Insert title here</title>
	


</head>
<body>


 <%
 
 	request.setCharacterEncoding("UTF-8");
 	String todoList = request.getParameter("text"); 	
 	String[] updateList = request.getParameterValues("todoList");
 	
 	
 %>
 

  <%
	//입력 받은 정보를 저장한다.

	try {

		//insert
		// JDBC 참조 변수 준비
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "LSG9", pw = "java";
		Class.forName("oracle.jdbc.OracleDriver");
		conn = DriverManager.getConnection(url, user, pw);
		
			String sql=" insert into TODOLIST ( T_LIST, T_STATE, T_DATE, T_NO)"
					+ " values(?,?,sysdate,(select nvl(max(t_no),0)+1 from TODOLIST))";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, todoList);
			pstmt.setString(2, "미완료");
			
			
			int cnt = pstmt.executeUpdate();
			if(cnt>0) {
				out.print("등록성공~");
			}else {
				out.print("등록실패~");
			}
					
			pstmt.close();
			conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
  
  
 	
	
 	
	 
	
 	
 %>
 

	<%
		response.sendRedirect("index.jsp");
	%>




</body>
</html>