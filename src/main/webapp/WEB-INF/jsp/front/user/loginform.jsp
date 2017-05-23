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
					   alert("아이디 또는 비밀번호가 일치하지 않습니다!");
					   location.replace(f.contextPath.value + "/users/loginform");
				   }
			   },
			   error : function(xhr, status, e) {  
			   		alert("데이터 Access 실패! 다시 한번 로그인 해주세요.");
			   		console.log("로그인 처리 에러 원인 >> "+e);
			   }
			});  
	}
</script>

</head>



	
   <div id="login" class="contents-area">
		<div id="" class="section">
			<div class="s-container">
				<h2 class="section-title" style="transform: translateY(0px); opacity: 1;">LOGIN</h2>
				
			</div>
		</div>
	</div>
    
    <div class="login_field">
		<form name="loginFrm" method="post" id="form">
			<input type="hidden" name="contextPath" value="${pageContext.request.contextPath}">
			<div class="form-inputs">
				<p class="l_i_wrap"><input type="text" name="emailId" size="20" tabindex="1" placeholder="ID(E-mail)"></p>
				<p class="l_i_wrap"><input type="password" name="pwd" size="20" tabindex="2" placeholder="PASSWORD"></p>
				
				<p class="btn_login">
					<input type="button" onclick="validSubmit();" value="GO">
				</p>
				
				<p class="join_btn"><a href="${pageContext.request.contextPath}/users/joinform" class="join_txt1">회원가입</a></p>
			</div>
			
			
		</form>
		<!-- login_input End-->
		
	</div>
    <!-- login_field End-->
    
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
		      if(response.id == "undefined" || response.status == "unknown"){
		    	  alert("유효하지 않은 페이스북 회원이거나\n로그인이 성공적으로 이뤄지지 않았습니다!\n다시 시도해 주세요.");
		      } else {
			      //페이스북 로그인 최초 성공 시, 해당 페이스북 ID와 name 을 DB 처리 하기위한 ajax
			      $.ajax({
					   type : 'POST',  
					   data:"fbEmailId=" + response.email + "&fbId="+ response.id + "&fbName=" + response.name + "&fbJoin=OK",
					   dataType : 'text',
					   url : 'join',  
					   success : function(rData, textStatus, xhr) {
						   if(rData == "true"){
							   alert("페이스북 가입성공!\n페이스북으로 로그인 버튼을 한번 더 누르시면 로그인 됩니다.");
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
		      }
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
        	
        	if(response.status != "unknown"){
        		testAPI();
        	}
         });
    }
    </script>

	<center>
		<p class="sns_txt"><strong class="red">S</strong><strong class="grn">N</strong><strong class="blue">S</strong>로 로그인하세요.</p>
		
		<div><a onclick="checkFacebookLogin();"><img alt="페이스북으로 로그인" src="<c:url value='/resources/imgs/fbloginbtn.png'/>" style="width: 222px; height: 49px;" ></a></div>
		<!-- 페이스북 로긘 -->
		
		<!-- 카카오톡 로긘 -->
		<div id="kakaologin"><a id="kakao-login-btn"></a></div> <!-- 카카오톡계정으로 로그인 -->
		<div id="kakaologout"></div>
		<div id="statusKakao"></div>
		
		<a href="http://developers.kakao.com/logout"></a>
		<br>
	</center>
	
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
	    			  
	    		      //카카오톡 로그인 최초 성공 시, 해당 페이스북 ID와 name 을 DB 처리 하기위한 ajax
	    		      $.ajax({
	    				   type : 'POST',  
	    				   data:"kakaoEmailId=" + res.kaccount_email + "&kakaoId="+ res.id + "&kakaoName=" + res.properties.nickname + "&kakaoNickName=" + res.properties.nickname+ "(kakao_talk)" + "&kakaoJoin=OK",
	    				   dataType : 'text',
	    				   url : 'join',  
	    				   success : function(rData, textStatus, xhr) {
	    					   if(rData == "true"){
								   alert("카카오톡으로 가입성공!\n카카오계정으로 로그인 버튼을 한번 더 누르시면 로그인 됩니다.");
							   		window.location.href = "../users/login";
							   } else {
								   window.location.href = "../index";
							   }
	    					   
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
	

<%@ include file="/WEB-INF/include/foot.jsp" %>
</html>