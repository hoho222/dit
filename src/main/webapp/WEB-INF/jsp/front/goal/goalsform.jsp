<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ include file="/WEB-INF/include/top.jsp" %>
<%@ include file="/WEB-INF/include/head.jsp" %>
<%@ include file="/WEB-INF/include/gnb.jsp" %>

<style>
.w3-container
{
 padding: 10px 10px 10px 10px;
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script>

function validSubmit() {
	var f = document.Frm;
	var goalCheckPeriod = f.goalCheckPeriod.value;
	var startDateStr = f.startdate.value;
	var endDateStr = f.enddate.value;
	
	if(f.goalTitle.value == ""){
		alert("목표 타이틀을 입력해주세요!");
		f.goalTitle.focus();
		return false;
	}
	
	if(startDateStr == ""){
		alert("시작일을 입력해주세요!");
		f.startdate.focus();
		return false;
	}
	
	if(endDateStr == ""){
		alert("종료일을 입력해주세요!");
		f.enddate.focus();
		return false;
	}
	
	if(f.totalDays.value == ""){
		alert("총 일수 확인 버튼을 눌러 총 일수 값을 채워주세요!");
		return false;
	}
	
	if($("#has_goal_check_period").is(":checked") == false){
		//한번에 달성이 아닐경우
		var startDateArr = startDateStr.split("-");
		var endDateArr = endDateStr.split("-");
		
		var startDate = new Date(startDateArr[0], Number(startDateArr[1])-1, startDateArr[2]);
		var endDate = new Date(endDateArr[0], Number(endDateArr[1])-1, endDateArr[2]);
		
		var beetweenDay = ((endDate.getTime()+1) -  startDate.getTime())/1000/60/60/24;
		beetweenDay += 1;
		
		//입력한 주기일 수가 종료일-시작일 차이 일 수 보다 큰 경우는 불가능하므로 처리해줌.
		if(beetweenDay < goalCheckPeriod){
			alert("입력한 목표 체크 주기일 수는 시작일-종료일 총 일수 보다 적어야합니다.\n입력주기일수:"+goalCheckPeriod+" / 총 일수:"+Math.floor(beetweenDay));
			return false;
		}
		
		if(goalCheckPeriod == "" || goalCheckPeriod == "0"){
			alert("목표 체크 주기를 1 이상의 숫자로 입력해주세요!");
			f.goalCheckPeriod.focus();
			return false;
		}
	
	}
	
	if(f.has_penalty_yn.value == "Y"){
		//패널티 상품 있을경우
		if(f.penalty.value == ""){
			alert("하늘색의 '패널티 상품 선택' 버튼을 눌러 패널티 상품을 골라주세요!");
			f.penalty.focus();
			return false;
		}
		if(f.failReceiver.value == ""){
			alert("실패 시 상품 수령자를 입력해주세요.");
			f.failReceiver.focus();
			return false;
		}
		if(f.failReceiverPhone.value == ""){
			alert("실패 시 상품 수령자 핸드폰 번호를 입력해주세요.");
			f.failReceiverPhone.focus();
			return false;
		}
	}
	
	if(f.category.value == ""){
		alert("카테고리는 반드시 한가지를 선택해야합니다!");
		return false;
	}
	
	if(f.goalContents.value == ""){
		alert("구체적 목표와 계획을 입력해주세요.");
		f.goalContents.focus();
		return false;
	}
	
	if(f.has_goalchecker_yn.value == "Y"){
		//목표달성 확인자가 타인일 경우
		if(f.goalCheckerName.value == ""){
			alert("목표달성 확인자 명을 입력해주세요.");
			f.goalCheckerName.focus();
			return false;
		}
		if(f.goalCheckerEmail.value == ""){
			alert("목표달성 확인자 이메일을 입력해주세요.");
			f.goalCheckerEmail.focus();
			return false;
		}
	}
	
	if(f.kakao_notice_yn.value == "Y"){
		//카카오톡 알림을 받는 경우에는 작성자 핸드폰 번호를 반드시 입력해야함
		if(f.writerPhone.value == ""){
			alert("카카오톡 알림을 받는 경우에는 작성자 핸드폰 번호를 반드시 입력해야합니다.");
			f.writerPhone.focus();
			return false;
		}
	}
	
	if(f.kakao_notice_yn.value == ""){
		alert("카카오톡 알림 도움 동의 여부를 선택해주세요.");
		return false;
	}
	
	if(f.privacy_yn.value == "" || f.privacy_yn.value == "N"){
		alert("개인정보제공에 반드시 동의해주셔야 서비스를 이용하실 수 있습니다.");
		document.getElementById("privacy_Y").focus();
		return false;
	}
	
	f.enddate.value = endDateStr + " 23:59:59";
	f.action="goals"
	f.submit();
}

function setPenaltyGoods(name, price, idx) {
	document.getElementById("penaltyIdx").value = idx;
	document.getElementById("penalty").value = name;
	document.getElementById("penaltyPrice").innerHTML = "(+" +price+ "원)"; 
}

function InpuOnlyNumber(obj) 
{
    if (event.keyCode >= 48 && event.keyCode <= 57) { //숫자키만 입력
        return true;
    } else {
        event.returnValue = false;
    }
}

function checkBeetweenDay(){
	var startDateStr = document.getElementById("startdate").value;
	var endDateStr = document.getElementById("enddate").value;
	
	if(startDateStr == "" || endDateStr == "") {
		alert("시작일, 종료일을 모두 입력해주세요!");
		return false;
	}
	
	var startDateArr = startDateStr.split("-");
	var endDateArr = endDateStr.split("-");
	
	var startDate = new Date(startDateArr[0], Number(startDateArr[1])-1, startDateArr[2]);
	var endDate = new Date(endDateArr[0], Number(endDateArr[1])-1, endDateArr[2]);
	
	var beetweenDay = (endDate.getTime() -  startDate.getTime())/1000/60/60/24;
	beetweenDay += 1;
	
	if(Number(Math.floor(beetweenDay)) < 0){
		document.getElementById("beetweenDay").value = "";
		alert("시작일은 종료일보다 앞선 날짜로 입력해주세요!");
		return false;
	}
	
	document.getElementById("beetweenDay").value = Math.floor(beetweenDay);
	
	
}

$(function() {
    $( "#startdate" ).datepicker({ 
    	minDate: 0,
    	dateFormat: 'yy-mm-dd',
    	changeMonth: true, 
        changeYear: true,
        nextText: '다음 달',
        prevText: '이전 달' 
   	});
    
    $( "#enddate" ).datepicker({ 
    	minDate: 0,
    	dateFormat: 'yy-mm-dd',
   		changeMonth: true, 
        changeYear: true,
        nextText: '다음 달',
        prevText: '이전 달' 
   	});
    
    //모달 팝업창 열림
    $('#activeModal').on("click", function () {
        $.ajax({
        	 type: "GET",
        	 url: "penalty_modal",
        	 cache: false,
 
             success: function(data){
             },
             error: function(data, e){
            	 alert("패널티 상품 목록을 불러오지 못했습니다! 다시 시도해주세요.");
            	 console.log("패널티 상품 목록 불러오기 실패 원인 > "+e);
             }
        });
    });
    
    //한번에 달성
    $("#goalCheckPeriod").hide();
    $("#has_goal_check_period").change(function(){
		if($("#has_goal_check_period").is(":checked") == true) {
			document.getElementById("has_goal_check_period_value").value = "N";
			$("#goalCheckPeriod").hide();
			$("#goalCheckPeriodVal").val("");
		}  else {
			document.getElementById("has_goal_check_period_value").value = "Y";
			$("#goalCheckPeriod").show();
		}
    });	
    
    //실패시 패널티 상품 존재여부
    $("#penaltyGoodsView").hide();
    
    $("input[name=has_penalty_yn]").change(function(){
    	
    	//패널티 상품 없는 경우
		if($("#has_penalty_N").is(":checked") == true) {
		    $("#penaltyGoodsView").hide();
		    $("#penalty").val("");
		    $("#penaltyIdx").val("");
		    $("#failReceiverVal").val("");
		    $("#failReceiverPhoneVal").val("");
		}  
		//패널티 상품 있는 경우
		else if($("#has_penalty_Y").is(":checked") == true) {
		    $("#penaltyGoodsView").show();
		}
    });	
    
    //목표달성 확인자 존재여부
    $("#goalCheckerName").hide();
    $("#goalCheckerEmail").hide();
    $("input[name=has_goalchecker_yn]").change(function(){
		if($("#has_goalchecker_N").is(":checked") == true) {
			$("#goalCheckerName").hide();
			$("#goalCheckerEmail").hide();
			$("#goalCheckerName").val("");
			$("#goalCheckerEmail").val("");
		}  else if($("#has_goalchecker_Y").is(":checked") == true) {
			$("#goalCheckerName").show();
			$("#goalCheckerEmail").show();
		}
    });
});
</script>

</head>
<body>

<center>
	<div id="" class="section">
		<div class="s-container">
			<h2 class="section-title" style="transform: translateY(0px); opacity: 1;">목표 쓰기</h2>
		</div>
	</div>

	<form id="Frm" name="Frm" method="post">
		<input type="hidden" name="writerId" value="${sessionId}"/>
		<input type="hidden" name="writerIdx" value="${loginNo}"/> 
		
			
			<div class="w3-cell-row">
				<!-- chap1) 목표설정 -->
				<div class="w3-container w3-leftbar w3-border-yellow w3-pale-yellow w3-cell w3-mobile" style="width:20%;">
					<h1>01</h1><br>목표설정
				</div>
				<div class="w3-container w3-leftbar w3-border-yellow w3-cell w3-mobile" style="width:30%;">
					목표타이틀
					<br><input type="text" name="goalTitle"/>
					<br>시작일 ~ 종료일
					<br><input type="text" id="startdate" name="startdate" size="8" readonly="readonly"/> ~ <input type="text" id="enddate" name="enddate" size="8" readonly="readonly"/>
						<input type="button" onclick="checkBeetweenDay();" class="btn btn-success btn-xs" value="총 일수 확인"/>
						<p>
							총 일수 : 총 <input type="text" id="beetweenDay" name="totalDays" readonly="readonly"/>일
						</p>
					<br>목표 체크 주기 <font size="2">
					한번에 달성</font><input type="checkbox" id="has_goal_check_period" name="has_goal_check_period" checked/>
					<input type="hidden" id="has_goal_check_period_value" name="has_goal_check_period_value" value="N" />
					<div id="goalCheckPeriod">
						<input type="text" id="goalCheckPeriodVal" name="goalCheckPeriod" onkeyPress="InpuOnlyNumber(this);" style="ime-mode:disabled"/> 일에 한번
					</div>
				</div>
			
			
				<!-- chap2) 패널티설정 -->
				<div class="w3-container w3-leftbar w3-border-yellow w3-pale-yellow w3-cell w3-mobile" style="width:20%;">
					<h1>02</h1><br>패널티설정
				</div>
				<div class="w3-container w3-leftbar w3-border-yellow w3-cell w3-mobile" style="width:30%;">
					실패 시 패널티 상품
					<br>있음<input type="radio" id="has_penalty_Y" name="has_penalty_yn" value="Y"/> 없음<input type="radio" id="has_penalty_N" name="has_penalty_yn" value="N" checked/>
					
					<div id="penaltyGoodsView">
					<button type="button" class="btn btn-info btn btn-sm" data-toggle="modal" data-target="#myModal" id="activeModal" href="penalty_modal">패널티 상품 선택</button>
					<input type="text" id="penalty" name="penalty" readonly="readonly" placeholder="패널티 상품을 먼저 골라주세요" size="16"/> <span id="penaltyPrice"></span>
					<input type="hidden" id="penaltyIdx" name="penaltyIdx" value="0"/> <!-- 패널티 일련번호 저장 -->
					<br><div id="failReceiver">실패 시 상품 수령자<input type="text" id="failReceiverVal" name="failReceiver"/></div>
					<br><div id="failReceiverPhone">상품 수령자 핸드폰 번호<input type="text" id="failReceiverPhoneVal" name="failReceiverPhone"/></div>
					</div>
					<!-- 패널티 상품 고르는 모달 팝업 -->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
						<div class="modal-content">
						<!-- penaltymodal.jsp 내용이 여기로옴 -->
						</div>
					</div>
				</div>
			</div>
		
			<div class="w3-cell-row">
				<!-- chap3) 카테고리 -->
				<div class="w3-container w3-leftbar w3-border-top w3-border-bottom w3-border-yellow w3-pale-yellow w3-cell w3-mobile" style="width:20%;">
					<h1>03</h1><br>카테고리 
				</div>
				<div class="w3-container w3-leftbar w3-border-top w3-border-bottom w3-border-yellow w3-cell w3-mobile" style="width:80%; padding:40px 0 30px 0;">
					<center>
					체중조절<input type="radio" id="cate_1" name="category" value="체중조절"/>
					운동<input type="radio" id="cate_2" name="category" value="운동"/>
					취미<input type="radio" id="cate_3" name="category" value="취미"/>
					어학<input type="radio" id="cate_3" name="category" value="어학"/>
					봉사<input type="radio" id="cate_4" name="category" value="봉사"/>
					재테크<input type="radio" id="cate_5" name="category" value="재테크"/>
					<br>
					금연<input type="radio" id="cate_6" name="category" value="금연"/>
					종교<input type="radio" id="cate_7" name="category" value="종교"/>
					환경<input type="radio" id="cate_8" name="category" value="환경"/>
					학습<input type="radio" id="cate_9" name="category" value="학습"/>
					독서<input type="radio" id="cate_10" name="category" value="독서"/>
					기타<input type="radio" id="cate_11" name="category" value="기타"/>
					</center>
				</div>
			</div>
		
		
		
			<!-- chap4) 세부목표설정 -->
			<div class="w3-cell-row">
				<!-- chap4) 세부목표설정 -->
				<div class="w3-container w3-leftbar w3-border-yellow w3-pale-yellow w3-cell w3-mobile" style="width:20%;">
					<h1>04</h1><br>세부목표설정
				</div>
				<div class="w3-container w3-leftbar w3-border-yellow w3-cell w3-mobile" style="width:30%;">
					구체적 목표와 계획<input type="text" name="goalContents"/>
					<br>목표달성 확인자
					<br>본인<input type="radio" id="has_goalchecker_N" name="has_goalchecker_yn" value="N" checked/> 타인<input type="radio" id="has_goalchecker_Y" name="has_goalchecker_yn" value="Y"/>
					<br><input type="text" id="goalCheckerName" name="goalCheckerName" placeholder="목표달성 확인자 명"/>
					<br><input type="text" id="goalCheckerEmail" name="goalCheckerEmail" placeholder="목표달성 확인자 이메일"/>
					<br>
				</div>
			
			
				<!-- chap5) 알림도움 및 정보제공 동의 -->
				<div class="w3-container w3-leftbar w3-border-yellow w3-pale-yellow w3-cell w3-mobile" style="width:20%;">
					<h1>05</h1><br>알림도움 및 정보제공 동의
				</div>
				<div class="w3-container w3-leftbar w3-border-yellow w3-cell w3-mobile" style="width:30%;">
					알림 도움 동의 여부
					<br>옐로아이디(카카오톡) 알림으로 도움을 받으시겠습니까?
					<br>예 <input type="radio" id="kakao_notice_Y" name="kakao_notice_yn" value="Y"/>
					아니오 <input type="radio" id="kakao_notice_N" name="kakao_notice_yn" value="N"/>
					<br>작성자 핸드폰 번호(카톡 알림 받지 않는 경우에만 선택)<input type="text" name="writerPhone"/>
					<br>개인정보제공 동의
					<font size="1">
						<ul>
							<li>수집항목:수령자 정보 및 본인, 목표달성 확인자정보</li>
							<li>수집목적:목표달성글 작성 및 확인</li>
							<li>보유이용기간:회원탈퇴 시 즉시파기</li>
							<li>귀하는 개인정보 수집 및 이용에 거부할 수 있는 권리가 있으며, 동의 거부시 목표달성 서비스가 제한됩니다. 동의하시겠습니까?</li>
						</ul>
						예 <input type="radio" id="privacy_Y" name="privacy_yn" value="Y"/>
						아니오 <input type="radio" id="privacy_N" name="privacy_yn" value="N"/>
					</font>
				</div>
			</div>
		<input type="button" value="작성완료" onclick="validSubmit();"/>
	</form>
</center>

</body>
<%@ include file="/WEB-INF/include/foot.jsp" %>
</html>