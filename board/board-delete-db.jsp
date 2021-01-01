<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정 완료</title>
<style>
   .wallpaper{
         background-color:#343f50;
   }
   .table_border{ /* 흰색배경 css */
      background-color:white;
      -webkit-box-shadow: 10px 10px 11px 2px rgba(219,216,212,0.61);
      -moz-box-shadow: 10px 10px 11px 2px rgba(219,216,212,0.61);
      box-shadow: 10px 10px 11px 2px rgba(204,198,190,1);
      height : 500px;
      width : 700px;   }
   .my_box2{/*버튼 css  */
      font-family: '함초롬돋움';
      color: white;
      font-weight : bold;
      text-align : center;
      border : 2px solid #f08b07;
      background-color: #343f50;
      height : 40px;
      width : 150px;
      border-radius: 5px;
   }
</style>
</head>
<body  class="wallpaper">
<%
	int id;
	String passwd="", sql, sql1;
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	id=Integer.parseInt(request.getParameter("id"));
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost:3306/pjboard_db";
		conn=DriverManager.getConnection(url,"root","9878");
		stmt=conn.createStatement();
		sql="select * from pjboard_tbl where id = "+id;
		rs=stmt.executeQuery(sql);
	}
	catch(Exception e) {
		out.println("DB 연동 오류입니다. : " + e.getMessage());
	}
	passwd=request.getParameter("passwd");
	while(rs.next()){
		if(!passwd.equals(rs.getString("passwd")))
		{
%>
	<br><br><br><br>
	<center>
	<img src="image/jj.png"/><br><br>
	<div class="table_border">
	<br><big><b>비밀번호가 틀렸습니다.</b></big><br><br>
	<a href="board-read.jsp?id=<%=request.getParameter("id")%>">
	<input type=button value="뒤로가기" class="my_box2"/>
	</a>
	</center>
<%
		}
		else{
			sql1="delete from pjboard_tbl where id="+id;
			try{
				stmt.executeUpdate(sql1);
			}
			catch(Exception e){
				out.println("DB 연동 오류입니다. : "+e.getMessage());
			}
%>	
   <br><br><br><br>
	<center>
	<img src="jj.png"/><br><br>
	<div class="table_border">
	<br><big><b>게시글이 삭제되었습니다.</b></big><br><br>
	<a href="board-list.jsp"><input type=button value="목록보기" class="my_box2"/></a>
	</center>
<%
	break;
		}
	}
%>
</body>
</html>