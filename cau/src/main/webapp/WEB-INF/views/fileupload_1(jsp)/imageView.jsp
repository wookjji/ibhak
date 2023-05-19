<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.util.Enumeration"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="org.apache.commons.io.output.ByteArrayOutputStream"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.sql.*"%>
<%@ page import="test.DBConnection"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-ｅquiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<center>
        <table border="3" bordercolor="skyblue">
        <tr bgcolor="skyblue"><td>1</td><td>2</td><td>3</td></tr>

        <%
     // 쿼리문
     String query="SELECT  CTEST1, CTEST2,BLOB,REG_DT FROM CLOBTEST";

     // 커넥션 연결
     Connection conn = DBConnection.getConnection();

     // DB에 쿼리문을 보낸다.
     PreparedStatement pstmt = conn.prepareStatement(query);

     // 쿼리문의 결과값을 rs에 담는다.
     ResultSet rs = pstmt.executeQuery();
     try{
      // 결과값을 출력한다.
      while(rs.next()){
       // 바이너리 데이터를 저장하고 있는 컬럼으로부터 데이터를 가져온다
       InputStream in = rs.getBinaryStream("BLOB");
       // BufferedImage를 생성하면 ImageIO를 통해 브라우저에 출력하기가 쉽다.
       BufferedImage bimg = ImageIO.read(in);
       in.close();


       ByteArrayOutputStream baos = new ByteArrayOutputStream();
    ImageIO.write( bimg, "jpg", baos );
    baos.flush();
    byte[] imageInByteArray = baos.toByteArray();
    baos.close();
    String b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);

          out.println("<tr>");
          out.println("<td>"+rs.getString("CTEST1")+"</td>");
          out.println("<td>"+rs.getString("CTEST2")+"</td>");
          out.print("<td>");
          out.print("<img src='data:x-image/jpg;base64,"+ b64+"' alt='Visruth.jpg not found' />");
          out.print("</td>");
          out.println("</tr>");
      }

//실제 사용시는 당연히 finally로 io가 발생된 부분은 닫아 줘야됨
     }catch(Exception e){
            e.printStackTrace();
     }
        %>
        </table>
    </center>
</body>
</html>