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
	String[] updateSmlCheck = request.getParameterValues("updateCk");
	String[] updateTodoList = request.getParameterValues("todoList");
	String[] updateUpdateSm = request.getParameterValues("updateSm");
	
/* 	//완료상태
	for(int i=0; i<updateTodoList.length; i++){
		out.print(updateSmlCheck[i]+"<br>");	
			
	}
	
	//게시물 번호
	for( int i=0; i<updateTodoList.length; i++){
		out.print(updateTodoList[i] +"<br>");
			
	}
	
	//게시물내용
	for( int i=0; i<updateTodoList.length; i++){
		out.print(updateUpdateSm[i] +"<br>");
			
	} */
	
	%>
	
	
<%  



for(int i=0; i<updateTodoList.length; i++){
		
		String updateS = updateSmlCheck[i];
		String updateT = updateTodoList[i];
		
		String updateU = updateUpdateSm[i];

 			
	 	 //update
  	 try{
 		 
 		// JDBC 참조 변수 준비
 		Connection conn = null; 
 		PreparedStatement pstmt = null; 
 		String url = "jdbc:oracle:thin:@localhost:1521:xe";
 		String user = "LSG9", pw = "java";
 		Class.forName("oracle.jdbc.OracleDriver");
 		conn = DriverManager.getConnection(url, user, pw);
 		
	 			 String sql = "update TODOLIST set T_LIST = ?, T_STATE = ? where T_NO = ?";
	 			 
	 			 pstmt = conn.prepareStatement(sql);
	 			 
		   		pstmt.setString(1, updateU);
	 			pstmt.setString(2, updateS); 
	 			pstmt.setString(3, updateT);
	 			
	 			int con = pstmt.executeUpdate();
				
	 			if( con > 0 ){
	 				out.print("수정 성공~!");
	 			}else{
	 				out.print("수정 실패~!");
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