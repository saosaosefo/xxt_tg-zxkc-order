<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK" %>
<%@ page import = "java.sql.*"%>
<%@ include file="login_interceptor.jsp"%>
<jsp:useBean id="ConDB"  scope="page" class="com.dbutils.DbUtil" />
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<%@ page import = "oracle.sql.*"%>
<%@ page import = "oracle.jdbc.driver.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.5; minimum-scale=1;" />
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link href="/css/index.css" rel="stylesheet" type="text/css" />
<link href="/css/public.css" rel="stylesheet" type="text/css" />
<%@ include file="/js/CMMobile_check.js"%>
<title>订购</title>
</head>
<%
Connection con = ConDB.getConnection();
if(con == null)
{
  out.print("<p>");
  out.print("连接失败！<br/>");
  out.print("</p>");
  return;
}
String manager_id = request.getParameter("manager_id");
//System.out.println(manager_id+"#############");
//int manager_id = 3512;
String ph_no = request.getParameter("phoneNum");
String area_code = "";

ResultSet area_code_rs=null;
Statement area_code_st=null;
area_code_st=con.createStatement();
String area_code_sql = "SELECT DISTINCT area_code FROM EDU.MANAGER_SUB m where m.MANAGER_ID="+manager_id+" and type in (1,2,3)";
area_code_rs = area_code_st.executeQuery(area_code_sql);

String area=null;

PreparedStatement pstmt = null;
ResultSet area_rs=null;
ResultSet rs=null;

Statement area_st=null;
Statement st=null;
st=con.createStatement();
area_st=con.createStatement();

ResultSet all_rs=null;
Statement all_st=null;
all_st=con.createStatement();

String sql = "";
String area_sql = "";
String areaName="";
if(area==null){
	area="0";areaName=" ";
}

String sub_area = request.getParameter("sub_area");
String sub_area_name="";
if(sub_area==null){
	sub_area="0";sub_area_name=" ";
}


String temp="";
try{
%>
<body>
	<div id="pcTop"></div>
	<div id="pcLogo">
		<img src="/images/xxt_logo_20150830.gif" class="img1 img2" />
	</div>
	<div id="first" style="height: 10%">
		<%@ include file="head.jsp"%>
	</div>
	<div class="second">
		<form name="form" action="">
				<h4 style="font-size:1.5em;">请选择地区</h4>
				<%
				
				
				area_sql ="SELECT DISTINCT AREA_NAME,AREA_CODE FROM "
				+"("
				+"SELECT A.AREA_NAME,A.AREA_CODE"
				+" FROM EDU.MANAGER_SUB M,EDU.AREA_CODE A"
				+" WHERE M.AREA_CODE=A.AREA_CODE"
				+" AND M.TYPE IN (1,2)"
				+" AND M.MANAGER_ID="+manager_id
				+" UNION ALL"
				+" SELECT A.AREA_NAME,A.AREA_CODE"
				+" FROM EDU.MANAGER_SUB M,EDU.AREA_CODE A,EDU.ORGANIZATION O"
				+" WHERE M.AREA_CODE=A.AREA_CODE"
				+" AND A.AREA_CODE=O.AREA"
				+" AND M.TYPE =3"
				+" AND M.MANAGER_ID="+manager_id
				+")";
			
			    area_rs = area_st.executeQuery(area_sql);
			    %> 
			  	<select name="area" onchange="JavaScript:change_class(document.form.area,document.form.sub_area_class,document.form.sub_area);return;" style="width: 100%; height:36px;">    
				<option value="0" <%if(area.equals("0")){%> selected<%}%>>-请选择-</option>
				<%while(area_rs.next()){ %>
				<option value="<%=area_rs.getString(2)%>" <%if(area.equals(area_rs.getString(2))){%> selected<%}%>><%=area_rs.getString(1)%></option>
				<% } %>      
				</select> 
					
				<h4 style="font-size:1.5em;">请选择营业部</h4>
				<select id="sub_area" name="sub_area" style="width: 100%; height:36px;"> 
					<option value="0">-全部-</option>
		       	</select>
				
				<p style="visibility: hidden;" >
	           	<select name="sub_area_class" >
	            <%
	            while(area_code_rs.next()){
	            sql = "SELECT DISTINCT ECNAME,CODE,ECID,area_code FROM (SELECT C.ECNAME,C.CODE,B.ECID,c.AREA_CODE FROM EDU.MANAGER_SUB M,EXTAPP.SUBAREA_CODE_DIC C,ORDMAN.BOSS_EC_INFO B WHERE M.SUB_ID=C.SUB_CODE AND C.CODE=SUBSTR(B.SERVICECODE,10,5) "
	  			   +" AND M.TYPE =2"
	 			   +" AND C.TYPE=1"
	 			   +" AND B.STATUS=1"
	 			   +" AND C.AREA_CODE=?"
	 			   +" AND MANAGER_ID="+manager_id
	 			   +" UNION ALL"
	 			   +" SELECT C.ECNAME,C.CODE,B.ECID,c.AREA_CODE"
	 			   +" FROM EDU.MANAGER_SUB M,EXTAPP.SUBAREA_CODE_DIC C,ORDMAN.BOSS_EC_INFO B"
	 			   +" WHERE M.SUB_ID=C.AREA_CODE AND C.CODE=SUBSTR(B.SERVICECODE,10,5) "
	 			   +" AND M.TYPE =1 AND C.TYPE=1 AND B.STATUS=1 "
	 			   +" AND C.AREA_CODE=? "
	 			   +" AND MANAGER_ID="+manager_id
	 			   +" UNION ALL "
	 			   +" SELECT C.ECNAME,C.CODE,B.ECID,c.AREA_CODE "
	 			   +" FROM EDU.MANAGER_SUB M,EDU.ORGANIZATION O,EXTAPP.SUBAREA_CODE_DIC C,ORDMAN.BOSS_EC_INFO B "
	 			   +" WHERE M.SUB_ID=o.id "
	 			   +" and o.SUB_AREA=c.SUB_CODE "
	 			   +" AND C.CODE=SUBSTR(B.SERVICECODE,10,5) "
	 			   +" AND M.TYPE =3 "
	 			   +" AND C.TYPE=1 "
	 			   +" AND B.STATUS=1 "
	 			   +" AND C.AREA_CODE=? "
	 			   +" AND MANAGER_ID="+manager_id+")";
	
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1,area_code_rs.getString(1));
	            pstmt.setString(2,area_code_rs.getString(1));
	            pstmt.setString(3,area_code_rs.getString(1));
	            rs = pstmt.executeQuery();
	            }
		        while(rs.next())
		        {%>
	            <option id="<%=rs.getString(4)%>" value="<%=rs.getString(3)%>" ><%=rs.getString(1)%></option>
	            
	            <%}%>
	            </select>
			  	<script language="javascript">
						init(document.form.area,document.form.sub_area_class,document.form.sub_area);											
				</script>
	 			</p>
				
				<h4 style="font-size:1.5em;">请输入手机号</h4>
				
		        <div class="sdBox0" style="left:0px;width: 200px;">
		        	<input name="phoneNum" id="phone" type="text" class="sdBox1Input"
		        	<%if(ph_no==null||"".equals(ph_no)){%>
		        		placeholder="请输入手机号"
		        	<%}else{%>
		        		value="<%=ph_no %>"
		        	<% }%>
		        	 onblur="tosub()" size = 11 maxlength=11 style="width: 70%;left:2px;">
		        	 <img src="/images/input.jpg" class="img2 img3" style="width: 80%"/>
	        	</div>
	        	<div style="margin-left:190px;width: 120px;">
		        	<input class="a_demo_one" name="clear" id="clear" type="button" value="清空" onclick="clearPhone()" style="width: 100%;left:10%;">
		        </div>
				
		        
		        <div style="width: 100%;margin-top:12px;">
		        	<input class="a_demo_one" type="button" value="确定" onclick="form_submit()" style="width: 100%;top:80%">
		        </div>
		        <input id="manager_id" name="manager_id" type="hidden" value="<%=manager_id %>">
			</form>
    </div>
    <div class="pcLine2"></div>
	<div class="foot1">
	客服热线：1255068<br />
	版权所有：内蒙古校信通教育科技有限公司
	</div>
</body>
<%
}catch(Exception e){
	
}finally{
	if(rs!=null) rs.close();
	if(area_rs!=null) area_rs.close();
	if(area_st!=null) area_st.close();
	if(area_code_rs!=null) area_code_rs.close();
	if(all_rs!=null) all_rs.close();
    if(st!=null) st.close();
    if(area_code_st!=null) area_code_st.close();
    if(all_st!=null) all_st.close();
    if(pstmt!=null) pstmt.close();
    if(con!=null) con.close();
}
%>
<script language="javascript">

function change_class(plocs,locs,mylocs)
{
   mylocs.length=1;
   var vid;
   for(var x=0;x<plocs.length;x++)
	{
	   
	   var opt = plocs.options[x];
	  if (opt.selected)
		  vid=opt.value;
	}
   for(var x=0;x<locs.length;x++)
	{		
 	    var opt1 = locs.options[x];
 	   if(opt1.value==vid){
		    mylocs.options[mylocs.options.length] = new Option(opt1.text, opt1.value, 0, 0);
 	   }
 	   else if(opt1.id==vid)
		{
		    mylocs.options[mylocs.options.length] = new Option(opt1.text, opt1.value, 0, 0);
		}
	}
}
function init(plocs,locs,mylocs)
{	
	change_class(plocs,locs,mylocs)
	if(locs.value!="0")
		mylocs.value = locs.value;
}



function tosub(){
	//判断手机号码空、数字、是否为内蒙用户
	/*if((form.phoneNum.value=="")){
		alert("手机号不能为空！");   
		form.phoneNum.focus();   
		return;
	}*/
	if(form.phoneNum.value!=""){	
		if(!isAvailCMMobile(form.phoneNum.value)){
			return false;
		}
	}
}
var dc="";
function form_submit(){
	if((form.phoneNum.value=="")){
		alert("手机号不能为空！");   
		form.phoneNum.focus();   
		return;
	}
	if(form.phoneNum.value!=""){
		if(document.getElementById("sub_area").value=="0"){
			alert("您未选择营业部，无法订购产品！");
			return false;
		}
		if(document.getElementById("sub_area").value!="0"){
			//alert(document.getElementById("sub_area").value);
			form.action="product_new.jsp";
			form.submit()
			
		}
	}
}
function clearPhone(){
	document.getElementById("phone").value="";
	form.phoneNum.focus(); 
}
</script>
</html>