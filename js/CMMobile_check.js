<script language="javascript">
<!--
//检测是否是合法的十进制数
function isNumber(strNumber)
{
   var myReg = /^[0-9]+$/;
   if(myReg.test(strNumber))
      return true;
   return false;
}

//检查是否合法的移动手机号码
function isAvailCMMobile(str)
{
	var validLength = 11;
	if(!isNumber(str))
	{
		alert("手机号码只能是数字，不能包含其它字符。");
		return false;
	}

	if(str.length<validLength || str.length>validLength)
	{
		alert("手机号码位数必须是11位");
		return false;
	}

	var subStrMobile = str.substr(0,3);
	if((subStrMobile<130)||(subStrMobile>139&&subStrMobile<147)||(subStrMobile>147&&subStrMobile<150)||(subStrMobile>160&&subStrMobile<177)||(subStrMobile>189))
    {
	alert("非内蒙手机号码!");
	return false;
}

	return true;
}
//-->
</script>
