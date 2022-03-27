<%@page import="org.apache.catalina.connector.OutputBuffer"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Scanner"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/main.css">
<script src="../js/jquery-3.6.0.js"></script>
<script src="../js/main.js"></script>

</head>
<body>

<h1>Todo List</h1>
<!-- 정보 입력받기 -->
<form action="insert.jsp" method="post" id="smMain">
	<div class = "smMainbox">
		<input type ="text" id="text" name="text">
		<input type ="button" name="sendClick" id="sendClick" value ="추가하기">
		<div class="test"></div>
	</div>
</form>

<%
//select
	try {	
		
		// JDBC 참조 변수 준비
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "LSG9", pw = "java";
		Class.forName("oracle.jdbc.OracleDriver");
		conn = DriverManager.getConnection(url, user, pw);
		
	
			String sql1="select T_LIST, T_STATE, TO_CHAR(T_DATE, 'YYYY-MM-DD-HH24miss')T_DATE, T_NO from TODOLIST ORDER BY T_DATE DESC";
			
			pstmt = conn.prepareStatement(sql1);
			
			ResultSet rs = pstmt.executeQuery();
			
			out.print("<form action ='update.jsp' method='post' id='update0' name='update0' >");
		
			while(rs.next()){
				out.print("<ul><input type = 'checkbox' id='todoList' name='todoList' value='"+rs.getInt(4)+"' ><input type = 'checkbox' id='deleteList' name='deleteList' value='"+rs.getInt(4)+"' ><li class = 'liList1'>"+rs.getString(1)+"</li>");
				out.print("<li class = 'liList2'><b>"+rs.getString(2)+"</b></li>");
				out.print("<li class = 'liList3'>"+rs.getString(3)+"</li>");
				out.print("<li class = 'liList4'>"+rs.getInt(4)+"</li></ul>");
			
			}
			
	
			out.print("</form>");
			out.print("<input type='button' value='수정하기' id='submitCheck'>");
			out.print("<input type='button' value='삭제하기' id='deleteCheck'>");
			
			rs.close();
			pstmt.close();
			conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
%>


</body>
</html>