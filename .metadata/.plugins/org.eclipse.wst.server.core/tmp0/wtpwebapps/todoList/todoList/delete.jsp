<%@page import="java.security.KeyStore.Entry"%>
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
<title>Insert title here</title>
</head>
<body>

<%

request.setCharacterEncoding("UTF-8");
String[] deleteNo = request.getParameterValues("deleteList");



%>


<% 


//String del00 : deleteNo
for(int i=0; i<deleteNo.length; i++ ){
	
	String del00 = deleteNo[i];
	
	try{
		
		// JDBC 참조 변수 준비
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "LSG9", pw = "java";
		Class.forName("oracle.jdbc.OracleDriver");
		conn = DriverManager.getConnection(url, user, pw);
		
		String sql = "delete from TODOLIST where T_NO = ?"; 
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, del00);
		
		int cnt = pstmt.executeUpdate();
		
		if( cnt > 0){
			out.print("삭제 성공~");
		}else{
			out.print("삭제 실패~");
		}
		
		pstmt.close();
		conn.close();
		
		
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	
	
	
} 


%>

	<%
		response.sendRedirect("index.jsp");
	%>



</body>
</html>