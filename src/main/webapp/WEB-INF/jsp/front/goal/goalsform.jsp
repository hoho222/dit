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
			alert("패널티 상품을 골라주세요!");
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
	
	//23:59:59 이 종료일에 안 붙어있으면 붙여줌
	if((f.enddate.value).indexOf("23:59:59") == -1){
		f.enddate.readOnly = true;
		f.enddate.value = endDateStr + " 23:59:59";
	}
	
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
		    $("#penaltyIdx").val("0");
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
		
			<span style="font-family:'Hanna', serif;">
				<div class="w3-cell-row">
					
					<!-- chap1) 목표설정 -->
					<div class="w3-container w3-border-left w3-border-top w3-border-bottom w3-border w3-cell w3-mobile" style="width:20%; background-color: #f9d9e4; padding:10% 0 10% 0; padding:10% 0 10% 0;">
						<span style="font-size:xx-large; font-weight: bolder; color:#b72058;">01</span><br><span style="font-size:xx-large;">목표설정</span>
					</div>
					<div class="w3-container w3-border-left w3-border-top w3-border-bottom w3-border w3-cell w3-mobile" style="width:30%; padding:2% 2% 2% 2%;">
						<span class="glyphicon glyphicon-asterisk" style="color:#b72058;"></span><span style="font-size:large;">목표타이틀</span>
						<br><input type="text" name="goalTitle"/>
						<br><span class="glyphicon glyphicon-asterisk" style="color:#b72058;"></span><span style="font-size:large;">시작일 ~ 종료일</span>
						<br><input type="text" id="startdate" name="startdate" size="8" readonly="readonly"/> ~ <input type="text" id="enddate" name="enddate" size="8" readonly="readonly"/>
						<br><input type="button" onclick="checkBeetweenDay();" value="총 일수 확인"/>
							<input type="text" id="beetweenDay" name="totalDays" readonly="readonly" placeholder="총 일수 확인 버튼을 누르시면 자동으로 채워집니다."/>
						<br><span style="font-size:large;">목표 체크 주기</span> 
						<span style="font-size: x-small">
							한번에 달성
							<span class="w3-tooltip"><span class="glyphicon glyphicon-question-sign" style="font-size:medium; color:#e36092;"></span>
								<span class="w3-text w3-tag" style="background-color:#e36092;font-size:medium; ">
									<b><span style="color:white;">자격증취득 처럼 한번에 달성하는 목표일 경우에 체크</span>해주세요!<br>정기적으로 목표 체크를 원하면 체크를 해제하고<br>며칠에 한 번씩 체크할 것인지 주기 일수를 적어주세요!</b>
								</span>
							</span>
						</span>
						<input type="checkbox" id="has_goal_check_period" name="has_goal_check_period" checked/>
						
						<input type="hidden" id="has_goal_check_period_value" name="has_goal_check_period_value" value="N" />
						<div id="goalCheckPeriod">
							<input type="text" id="goalCheckPeriodVal" name="goalCheckPeriod" onkeyPress="InpuOnlyNumber(this);" style="ime-mode:disabled"/> 일에 한번
						</div>
					</div>
				
				
					<!-- chap2) 패널티설정 -->
					<div class="w3-container w3-border-left w3-border-top w3-border-bottom w3-border w3-cell w3-mobile" style="width:20%; background-color: #f9d9e4; padding:10% 0 10% 0;">
						<span style="font-size:xx-large; font-weight: bolder; color:#b72058;">02</span>
						<br>
						<span style="font-size:xx-large;">패널티설정</span>
					</div>
					<div class="w3-container w3-border-left w3-border-top w3-border-bottom w3-border w3-cell w3-mobile" style="width:30%; padding:4% 2% 2% 2%;">
						<span style="font-size:large;">실패 시 패널티 상품</span>
						<br>있음<input type="radio" id="has_penalty_Y" name="has_penalty_yn" value="Y"/> 없음<input type="radio" id="has_penalty_N" name="has_penalty_yn" value="N" checked/>
						<br><br>
						<div id="penaltyGoodsView">
						<!-- <button type="button" class="btn btn-sm" data-toggle="modal" data-target="#myModal" id="activeModal" href="penalty_modal" style="background-color: #b72058; margin:5% 2% 2% 2%;">패널티 상품 선택</button> -->
						<input type="text" id="penalty" name="penalty" readonly="readonly" placeholder="여기를 클릭하여 패널티 상품을 골라주세요." size="16" data-toggle="modal" data-target="#myModal" id="activeModal" href="penalty_modal"/> <span id="penaltyPrice"></span>
						<input type="hidden" id="penaltyIdx" name="penaltyIdx" value="0"/> <!-- 패널티 일련번호 저장 -->
						<br><div id="failReceiver"><span style="font-size:large;">실패 시 상품 수령자</span><input type="text" id="failReceiverVal" name="failReceiver"/></div>
						<br><div id="failReceiverPhone"><span style="font-size:large;">상품 수령자 핸드폰 번호</span><input type="text" id="failReceiverPhoneVal" name="failReceiverPhone"/></div>
						</div>
						<!-- 패널티 상품 고르는 모달 팝업 -->
						<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="height:450px;">
							<div class="modal-content">
							<!-- penaltymodal.jsp 내용이 여기로옴 -->
							</div>
						</div>
					</div>
				</div>
			
				<div class="w3-cell-row">
					<!-- chap3) 카테고리 -->
					<div class="w3-container w3-border-left w3-border-top w3-border-bottom w3-border w3-cell w3-mobile" style="width:20%; background-color: #f9d9e4; padding:10% 0 10% 0;"> 
						<span style="font-size:xx-large; font-weight: bolder; color:#b72058;">03</span>
						<br>
						<span class="glyphicon glyphicon-asterisk" style="color:#b72058; font-size: xx-large;"></span><span style="font-size:xx-large;">카테고리</span>
					</div>
					<div class="w3-container w3-border-left w3-border-top w3-border-bottom w3-border w3-cell w3-mobile" style="width:80%; padding:12% 2% 12% 2%;">
						<center>
						체중조절<input type="radio" id="cate_1" name="category" value="체중조절"/>
						운동<input type="radio" id="cate_2" name="category" value="운동"/>
						취미<input type="radio" id="cate_3" name="category" value="취미"/>
						어학<input type="radio" id="cate_3" name="category" value="어학"/>
						봉사<input type="radio" id="cate_4" name="category" value="봉사"/>
						금연<input type="radio" id="cate_6" name="category" value="금연"/>
						<br>
						재테크<input type="radio" id="cate_5" name="category" value="재테크"/>
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
					<div class="w3-container w3-cell w3-border-left  w3-border-top w3-border-bottom w3-border w3-mobile" style="width:20%; background-color: #f9d9e4; padding:10% 0 10% 0; border-style:solid; border-color:#b72058;">
						<span style="font-size:xx-large; font-weight: bolder; color:#b72058;">04</span>
						<br>
						<span style="font-size:xx-large;">세부목표설정</span>
					</div>
					<div class="w3-container w3-border-left  w3-border-top w3-border-bottom w3-border w3-cell w3-mobile" style="width:30%; padding:4% 2% 2% 2%;">
						<span class="glyphicon glyphicon-asterisk" style="color:#b72058;"></span><span style="font-size:large;">구체적 목표와 계획</span><input type="text" name="goalContents"/>
						<br><span style="font-size:large;">목표달성 확인자</span>
						<br>본인<input type="radio" id="has_goalchecker_N" name="has_goalchecker_yn" value="N" checked/> 타인<input type="radio" id="has_goalchecker_Y" name="has_goalchecker_yn" value="Y"/>
						<br><input type="text" id="goalCheckerName" name="goalCheckerName" placeholder="목표달성 확인자 명"/>
						<br><input type="text" id="goalCheckerEmail" name="goalCheckerEmail" placeholder="목표달성 확인자 이메일"/>
						<br>
					</div>
				
				
					<!-- chap5) 알림도움 및 정보제공 동의 -->
					<div class="w3-container w3-border-left w3-border-top w3-border-bottom w3-border w3-cell w3-mobile" style="width:20%; background-color: #f9d9e4; padding:10% 0 10% 0; border-style:solid; border-color:#b72058;">
						<span style="font-size:xx-large; font-weight: bolder; color:#b72058;">05</span>
						<br>
						<span style="font-size:xx-large;">알림도움 및 정보제공 동의</span>
					</div>
					<div class="w3-container w3-border-left w3-border-top w3-border-bottom w3-border w3-cell w3-mobile" style="width:30%; padding:10% 0 10% 0;">
						<span class="glyphicon glyphicon-asterisk" style="color:#b72058;"></span><span style="font-size:large;">알림 도움 동의 여부</span>
						<br>옐로아이디(카카오톡) 알림으로 도움을 받으시겠습니까?
						<br>예 <input type="radio" id="kakao_notice_Y" name="kakao_notice_yn" value="Y"/>
						아니오 <input type="radio" id="kakao_notice_N" name="kakao_notice_yn" value="N"/>
						<br><br><span style="font-size:large;">작성자 핸드폰 번호<span style="font-size:small;">(<span class="glyphicon glyphicon-asterisk" style="color:#b72058;"></span>카톡 알림 받는 경우에만 필수)</span></span><input type="text" name="writerPhone" placeholder="ex) 01012345678"/>
						<br><span class="glyphicon glyphicon-asterisk" style="color:#b72058;"></span><span style="font-size:large;">개인정보제공 동의</span>
						
						<ul>
							<span style="font-size: x-small">
								<li>수집항목:수령자 정보 및 본인, 목표달성 확인자정보</li>
								<li>수집목적:목표달성글 작성 및 확인</li>
								<li>보유이용기간:회원탈퇴 시 즉시파기</li>
								<li>귀하는 개인정보 수집 및 이용에 거부할 수 있는 권리가 있으며, 동의 거부시 목표달성 서비스가 제한됩니다. 동의하시겠습니까?</li>
							</span>
						</ul>
						예 <input type="radio" id="privacy_Y" name="privacy_yn" value="Y"/>
						아니오 <input type="radio" id="privacy_N" name="privacy_yn" value="N"/>
						
					</div>
				</div>
			</span>
		<input type="button" value="작성완료" onclick="validSubmit();"/>
	</form>
	
</center>

</body>
<%@ include file="/WEB-INF/include/foot.jsp" %>
</html>