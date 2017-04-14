<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ include file="/WEB-INF/include/gnb.jsp" %>
<%@ include file="/WEB-INF/include/top.jsp" %>
<%@ include file="/WEB-INF/include/head.jsp" %>

<!-- 카카오톡 로긘 위한 js -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!--  로그인 여부 우선 파악하여, 로그인 되어있으면 index로 리다이렉트 -->
<%
	String sessionId = (String)session.getAttribute("loginId");
	
	if(sessionId==null||sessionId.equals("")){
		//세션에 id값이 안담겼을 때(로그인 안된상태) ---> 로그인 페이지 그대로 둠
	} else {
		//세션에 id값 담겼을때(로그인 된 상태) --> 인덱스 페이지로 이동시킴
		response.sendRedirect("../index"); 
	}
%>

<script type="text/javascript">
	function validSubmit() {
		var f = document.loginFrm;
		
		if(f.emailId.value == ""){
			alert("이메일을 입력해주세요");
			f.emailId.focus();
			return false;
		}
		
		if(f.pwd.value == ""){
			alert("비밀번호를 입력해주세요");
			f.pwd.focus();
			return false;
		}
		
		$.ajax({
			   type : 'POST',  
			   data:"emailId="+ f.emailId.value + "&pwd=" + f.pwd.value,
			   dataType : 'text',
			   url : 'login',  
			   success : function(rData, textStatus, xhr) {
				   if(rData == "true"){
					   
					   //로그인 성공하면 index 페이지로 리로드
					   location.replace(f.contextPath.value + "/index");
				   }else if(rData == "false"){
					   document.getElementById("loginResult").innerHTML = "<font color='red'>아이디 또는 비밀번호가 일치하지 않습니다.</font>";
				   }
			   },
			   error : function(xhr, status, e) {  
			   		alert("로그인 처리를 할 수 없습니다!");
			   		console.log("로그인 처리 에러 원인 >> "+e);
			   }
			});  
	}
</script>

</head>
<body>

<center>
	
	<form name="loginFrm" method="post">
		<input type="hidden" name="contextPath" value="${pageContext.request.contextPath}"/>
		<input type="text" name="emailId" placeholder="아이디(이메일)" style="width:222px; height:49px;"/>
		<br>
		<input type="password" name="pwd" placeholder="비밀번호" style="width:222px; height:49px;"/>
		<div id="loginResult"></div>
		<input type="button" value="로그인" onclick="validSubmit();" style="width:222px; height:49px;"/>
		
	</form>
	
	<br>
	
	
	<!-- 페이스북 로긘 -->
	<div id="fb-root"></div>
	<script>

      window.fbAsyncInit = function() {
          FB.init({appId: '215782768897692', status: true, cookie: true, xfbml: true});

      };
      (function() {
        var e = document.createElement('script'); e.async = true;
        e.src = document.location.protocol +
          '//connect.facebook.net/en_US/all.js';
        document.getElementById('fb-root').appendChild(e);
      }());

    function fetchUserDetail()
    {
        FB.api('/me', function(response) {
                alert("Name: "+ response.name + "\nFirst name: "+ response.first_name + "ID: "+response.id);
            });
    }
    
    function testAPI() {
		  
	      console.log('Welcome!  Fetching your information.... ');
	      
	      FB.api('/me', {fields: 'email,name'}, function(response) {
		      
	    	  console.log('Successful FACEBOOK login for: ' + response.name);
		      
		      //페이스북 로그인 최초 성공 시, 해당 페이스북 ID와 name 을 DB 처리 하기위한 ajax
		      $.ajax({
				   type : 'POST',  
				   data:"fbEmailId=" + response.email + "&fbId="+ response.id + "&fbName=" + response.name + "&fbJoin=OK",
				   dataType : 'text',
				   url : 'join',  
				   success : function(rData, textStatus, xhr) {
					   if(rData == "true"){
					   		window.location.href = "../users/login";
					   } else {
						   window.location.href = "../index";
					   }
				   },
				   error : function(xhr, status, e) {  
				   		alert("페이스북 가입을 할 수 없습니다!");
				   		console.log("페이스북 가입 에러 원인 >> "+e);
				   }
				});  
	    	  
	    });
	  }

    function checkFacebookLogin() 
    {
        FB.getLoginStatus(function(response) {
          if (response.status === 'connected') {
        	  testAPI();
          } else {
            initiateFBLogin();
          }
         });
    }

    function initiateFBLogin()
    {
        FB.login(function(response) {
        	testAPI();
         });
    }
    </script>

	<div style="background-color: lightblue; width:222px; height:49px;"><a href="#" onclick="checkFacebookLogin();">페이스북계정으로 로그인</a></div>
	<!-- 페이스북 로긘 -->


	<!-- 카카오톡 로긘 -->
	<div id="kakaologin"><a id="kakao-login-btn"></a></div>
	<div id="kakaologout"></div>
	<div id="statusKakao"></div>
	
	<a href="http://developers.kakao.com/logout"></a>
	<script type='text/javascript'>
	  //<![CDATA[
	    // 사용할 앱의 JavaScript 키를 설정해 주세요.
	    Kakao.init('ad4f97203c50eac025a2742b89a1888e');
	    // 카카오 로그인 버튼을 생성합니다.
	    Kakao.Auth.createLoginButton({
	      container: '#kakao-login-btn',
	      success: function(authObj) {
	    	  Kakao.API.request({
	    		  url: '/v1/user/me',
	    		  success: function(res) {
	    			  
   					  //카카오톡 로그인 버튼 감추기
   					  document.getElementById('kakaologin').innerHTML = "";
   					  document.getElementById('kakaologout').innerHTML = "<input type='button' onclick='kakaoLogout()' value='카카오톡 로그아웃'/>";
   					  document.getElementById('statusKakao').innerHTML ="<font size=1> 카카오톡 :" + res.properties.nickname + "님";
	    			  
	    		      //카카오톡 로그인 최초 성공 시, 해당 페이스북 ID와 name 을 DB 처리 하기위한 ajax
	    		      $.ajax({
	    				   type : 'POST',  
	    				   data:"kakaoEmailId=" + res.kaccount_email + "&kakaoId="+ res.id + "&kakaoName=" + res.properties.nickname + "&kakaoNickName=" + res.properties.nickname+ "(kakao_talk)" + "&kakaoJoin=OK",
	    				   dataType : 'text',
	    				   url : 'join',  
	    				   success : function(rData, textStatus, xhr) {
	    					   window.location.href = "../index";
	    				   },
	    				   error : function(xhr, status, e) {  
	    				   		alert("카카오톡 가입(로그인)을 할 수 없습니다!");
	    				   		console.log("카카오톡 가입(로그인) 에러 원인 >> "+e);
	    				   }
    					});  
	    		  }
	    	  })
	        /* alert(JSON.stringify(authObj)); --> 이렇게 찍으면 object Object 형태도 내부를 알 수 있음 */
	      },
	      fail: function(err) {
	         alert(JSON.stringify(err));
	      }
	    });
	    
	    function kakaoLogout() {
	    	Kakao.Auth.logout(function () {
	    		setTimeout(function(){
	    			
	    			//카카오톡 로그인버튼 보이기
	    			document.getElementById('kakaologin').innerHTML = "<a id='kakao-login-btn'></a>";
	    			
	    			location.href = "login"
	    		}, 1000);
	    	});
	    }
	  //]]>
	</script>
	<!-- 카카오톡 로긘 -->
	
	<br>
	
	<a href="${pageContext.request.contextPath}/users/joinform">
		<input type="button" value="회원가입"/>
	</a>
</center>

</body>
<%@ include file="/WEB-INF/include/foot.jsp" %>
</html>