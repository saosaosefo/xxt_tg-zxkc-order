<script language="javascript">
<!--
//����Ƿ��ǺϷ���ʮ������
function isNumber(strNumber)
{
   var myReg = /^[0-9]+$/;
   if(myReg.test(strNumber))
      return true;
   return false;
}

//����Ƿ�Ϸ����ƶ��ֻ�����
function isAvailCMMobile(str)
{
	var validLength = 11;
	if(!isNumber(str))
	{
		alert("�ֻ�����ֻ�������֣����ܰ��������ַ���");
		return false;
	}

	if(str.length<validLength || str.length>validLength)
	{
		alert("�ֻ�����λ��������11λ");
		return false;
	}

	var subStrMobile = str.substr(0,3);
	if((subStrMobile<130)||(subStrMobile>139&&subStrMobile<147)||(subStrMobile>147&&subStrMobile<150)||(subStrMobile>160&&subStrMobile<177)||(subStrMobile>189))
    {
	alert("�������ֻ�����!");
	return false;
}

	return true;
}
//-->
</script>
