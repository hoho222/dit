<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ include file="/WEB-INF/include/gnb.jsp" %>
<%@ include file="/WEB-INF/include/top.jsp" %>
<%@ include file="/WEB-INF/include/head.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script>
function email_change(){
 	var embs = document.getElementById("emailBack_sel").value;
 	
 	document.getElementById("emailBack").value = embs;
 	
	if(embs == ''){
		document.getElementById("emailBack").readOnly = false;
	}else{
		document.getElementById("emailBack").readOnly = true;
	}
}

function validSubmit() {
	var f = document.frm;
	
	if(f.isOverlapCheck.value != "Y"){
		alert("이메일 중복 확인을 안했거나 중복된 이메일 입니다.\n이메일 주소를 다시 확인해 주세요!");
		return false;
	}
	
	if(document.getElementById("emailAuthFin").innerHTML != "인증완료"){
		alert("이메일 인증을 반드시 해주세요!");
		return false;
	}
	
	if(f.name.value == ""){
		alert("이름을 입력해주세요");
		f.name.focus();
		return false;
	}
	
	if(f.nickName.value == ""){
		alert("닉네임을 입력해주세요");
		f.nickName.focus();
		return false;
	}
	
	if(f.password.value == ""){
		alert("비밀번호를 입력해주세요");
		f.password.focus();
		return false;
	}
	
	if(f.re_password.value == ""){
		alert("비밀번호 확인을 입력해주세요");
		f.re_password.focus();
		return false;
	}
	
	if(f.password.value != f.re_password.value){
		alert("비밀번호와 비밀번호 확인을 똑같이 입력해주세요!");
		return false;
	}
	
	if(f.hp.value == ""){
		alert("핸드폰번호를 입력해주세요");
		f.hp.focus();
		return false;
	}
	
	if(f.birthDate.value == ""){
		alert("생년월일을 입력해주세요");
		f.birthDate.focus();
		return false;
	}
	
	f.action="join";
	f.submit();
}

//이메일 아이디 중복확인(ajax로 구현)
function emailOverlap() {
	var f = document.frm;
	var regExp = /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/;
	
    if(f.emailFront.value == "" || f.emailBack.value == ""){
		alert('이메일을 빠짐없이 입력해주세요.'); 
		return false;
	} else {
		var email = f.emailFront.value + "@" +f.emailBack.value;
		if(!email.match(regExp)){
			alert("이메일 형식에 맞지않습니다.");
			return false;
		}
		
		$.ajax({
		   type : 'POST',  
		   data:"emailId="+ email,
		   dataType : 'text',
		   url : 'joinoverlap',  
		   success : function(rData, textStatus, xhr) {
			  
			   if(rData == "true"){
			   	document.getElementById("emailOverlapFin").innerHTML = "<font color='blue'>가능</font>";
			   	f.isOverlapCheck.value = "Y";
			   }else if(rData == "false"){
			   	document.getElementById("emailOverlapFin").innerHTML = "<font color='red'>불가능</font>";
			   	f.isOverlapCheck.value = "N";
			   }
		   },
		   error : function(xhr, status, e) {  
		   		alert("중복확인을 할 수 없습니다!");
		   		console.log("중복확인 에러 원인 >> "+e);
		   }
		});  
	}
}

//이메일 인증
function emailAuth() {
	var f = document.frm;
	var email = f.emailFront.value + "@" + f.emailBack.value;
	var regExp = /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/;
	var title="이메일인증";
	
	if(f.emailFront.value == "" || f.emailBack.value == "") {
		alert("이메일 주소를 빠짐없이 입력해주세요.");
		if(f.emailFront.value == "") {
			f.emailFront.focus();
		} else if(f.emailBack.value == "") {
			f.emailBack.focus();
		}
		return false;
	}
	
	if(!email.match(regExp)){
		alert("이메일 형식에 맞지않습니다.");
		return false;
	}
	
	window.open("", title, 'width=400, height=200');
	
	f.emailAddr.value = email;
	f.target = title;
	f.action = "joinauth";
	f.method = "post";
	f.submit();

}

</script>

</head>
<body>

<center>
<h2>회원가입</h2>

<form id="frm" name="frm" method="post">
	
	<table border="1">
		<tr>
			<td>이메일(ID)</td>
			<td>
				<input type="hidden" name="emailAddr"/>
				<input type="text" name="emailFront"/>@<input type="text" id="emailBack" name="emailBack">
			    <select id="emailBack_sel" name="emailBack_sel" onchange="email_change()">
				    <option value="">직접입력</option>
				    <option value="naver.com">naver.com</option>
				    <option value="gmail.com">gmail.com</option>
				    <option value="hanmail.net">hanmail.net</option>
				    <option value="nate.com">nate.com</option>
			    </select>
			    
			    <div>
			    	<input type="hidden" id="isOverlapCheck" value="not" />
				    <input type="button" onclick="emailOverlap();" value="이메일 중복확인"/>
				    <div id="emailOverlapFin" style="float: right;"><font color="red">이메일 중복확인을 해주세요.</font></div>
			    </div>
			    
			    <div>
				    <input type="button" onclick="emailAuth();" value="이메일인증"/>
				    <div id="emailAuthFin" style="float: right;"><font color="red">이메일 인증이 필요합니다.</font></div>
			    </div>
			    
			</td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type="text" name="name"/></td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td><input type="text" name="nickName"/></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="password"/></td>
		</tr>
		<tr>
			<td>비밀번호 확인</td>
			<td><input type="password" name="re_password"/></td>
		</tr>
		<tr>
			<td>핸드폰 번호</td>
			<td><input type="text" name="hp" placeholder="ex) 01012347890" maxlength="11"/></td>
		</tr>
		<tr>
			<td>생년월일</td>
			<td><input type="text" name="birthDate" maxlength="8" placeholder="ex) 19931121"/></td>
		</tr>
		<tr>
			<td>성별</td>
			<td>
				남<input type="radio" name="gender" id="male" value="M"/>
				여<input type="radio" name="gender" id="female" value="F"/>
			</td> 
		</tr>
	</table> 
	<input type="button" value="작성완료" onclick="validSubmit();"/>
</form>
</center>
</body>
<%@ include file="/WEB-INF/include/foot.jsp" %>
</html>