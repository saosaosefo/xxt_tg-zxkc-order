<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK" %>
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
<title>登录</title>
</head>
<body>
	<div id="pcTop"></div>
	<div id="pcLogo">
		<img src="/images/xxt_logo_20150830.gif" class="img1 img2" />
		
	</div>
	
	<div class="banner">
	<hr>
		<img src="/images/img-1.jpg" class="img1 img2" />
	</div>
	<div class="second">
	<div class="sdYhdl">
    	<img src="/images/in-4.jpg" class="img1 img2" />
    </div>
	    <form name="login" action="" > 
	 		<a href="#" onclick="wjmm()" class="sdWjmm p14huang1">
    			忘记密码？
   		 	</a>
		    <div class="sdBox0 sdBox1">
		    	<input name="username" id="uname" type="text" placeholder="请输入用户名(手机号)" onblur="tosub()" size = 11 maxlength=11 class="sdBox1Input" value="" />
		    	<img src="/images/in-5.jpg" class="img2 img3" />
		    </div>
		    <div class="sdBox0 sdBox2">
		    	<input name="password" id="pwd" placeholder="请输入密码" type="password" class="sdBox1Input" value="" />
		
		    	<img src="/images/in-6.jpg" class="img2 img3" />
		    </div>
		    <div class="sdBox0 sdBox3" style="height: 46px;">
		    	<input name="sub" type="button" class="a_demo_one" value="登录" onclick="check_pwd()" />
		    </div>
	    </form>
</div>
<div class="foot1" style="margin-top:200px;">
	客服热线：1255068<br />
	版权所有：内蒙古校信通教育科技有限公司
</div>
</body>
<script type="text/javascript">
	function check_pwd(){
		login.action="pwd_check.jsp";
		login.submit();
	}
	function tosub(){
		//判断手机号码空、数字、是否为内蒙用户
		/*if((login.username.value=="")){
			alert("帐号不能为空");   
			login.username.focus();   
			return;
		}*/
		if(login.username.value!=""){	
			if(!isAvailCMMobile(login.username.value)){
				document.getElementById("uname").value="";
				login.username.focus(); 
				return false;
			}
		}
	}
	function wjmm(){
		var username=document.getElementById('uname').value;
		window.location.href ="/wjmm.jsp?username="+username;
	}
</script>
</html>