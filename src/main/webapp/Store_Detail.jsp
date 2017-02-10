<%@ page import="java.io.StringWriter"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.*"%>
<%
//String Store_Id=request.getParameter("str1");
 session.setAttribute("str","123456");
  
 String str3=(String)session.getAttribute("str");
 
//session.setAttribute("str2",Store_Id );
//String Str3=(String)session.getAttribute("str2"); 
JSONArray jArray1 = new JSONArray();
JSONObject jObj = new JSONObject();
jObj.put("Store_Id",str3);
out.println(jObj);

%>
