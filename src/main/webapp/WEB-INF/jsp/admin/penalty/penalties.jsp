<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ include file="/WEB-INF/include/navi.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript">

function itemChange(sVal) {
	var f = document.penaltyFrm;
	var opt = $("#categorySmall option").length;
	
	if(sVal == "영화"){
		num = new Array("CGV","롯데시네마");
		vnum = new Array("CGV","롯데시네마");
	} else if(sVal == "음료/커피"){
		num = new Array("스타벅스","커피빈","엔젤리너스");
		vnum = new Array("스타벅스","커피빈","엔젤리너스");
	} else if(sVal == "치킨"){
		num = new Array("굽네치킨","교촌치킨","호치킨");
		vnum = new Array("굽네치킨","교촌치킨","호치킨");
	} else if(sVal == "베이커리"){
		num = new Array("파리바게뜨","뚜레쥬르","크라운베이커리");
		vnum = new Array("파리바게뜨","뚜레쥬르","크라운베이커리");
	}
	
	for(var i=0; i<opt; i++){
		f.categorySmall.options[0] = null;
	}
	for(k=0; k<num.length; k++){
		f.categorySmall.options[k] = new Option(num[k], vnum[k]);
	}
}

function validSubmit() {
	var f = document.penaltyFrm;
	
	if(f.penaltyName.value == ""){
		alert("패널티 상품명 입력하셈");
		f.penaltyName.focus();
		return false;
	}
	
	if(f.penaltyPrice.value == ""){
		alert("패널티 상품 가격 입력하셈");
		f.penaltyPrice.focus();
		return false;
	}
	
	if(f.categoryBig.value == ""){
		alert("카테고리 대분류 입력하셈");
		f.categoryBig.focus();
		return false;
	}
	
	if(f.categorySmall.value == ""){
		alert("카테고리 소분류 입력하셈");
		f.categorySmall.focus();
		return false;
	}
	
	$.ajax({
		   type : 'POST',  
		   data:"name="+ f.penaltyName.value + "&price=" + f.penaltyPrice.value + "&categoryBig=" + f.categoryBig.value + "&categorySmall=" + f.categorySmall.value,
		   dataType : 'text',
		   url : 'penalty',  
		   success : function(rData, textStatus, xhr) {
			   if(rData == "true"){
				   
				   //로그인 성공하면 index 페이지로 리로드
				   location.replace(f.contextPath.value + "/admin/penalty");
			   }else if(rData == "false"){
				   alert("패널티 상품등록 실패! 다시 시도해주세요!!");
			   }
		   },
		   error : function(xhr, status, e) {  
		   		alert("패널티 상품등록 처리를 할 수 없습니다!");
		   		console.log("패널티 상품등록 에러 원인 >> "+e);
		   }
		});  
	
}
</script>

</head>


<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        패널티상품 관리
        <small>패널티로 지정할 상품을 등록/관리 합니다.</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>ADMIN</a></li>
        <li class="active">PENALTY</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">

		<center>
			<form name="penaltyFrm" method="post">
				<input type="hidden" name="contextPath" value="${pageContext.request.contextPath}"/>
				<!-- <input type="text" name="categoryBig" placeholder="대분류 카테고리명"/> > <input type="text" name="categorySmall" placeholder="소분류 카테고리명"/> -->
				카테고리 :
				<select id="categoryBig" name="categoryBig" onchange="itemChange(this.value);">
					<option value="">대분류</option>
					<option value="영화">영화</option>
				    <option value="음료/커피">음료/커피</option>
				    <option value="치킨">치킨</option>
				    <option value="베이커리">베이커리</option>
				    <option value="아이스크림">아이스크림</option>
				    <option value="문화상품권">문화상품권</option>
				    <option value="햄버거">햄버거</option>
				    <option value="피자">피자</option>
				    <option value="레스토랑">레스토랑</option>
			    </select>
				<select id="categorySmall" name="categorySmall">
					<option value="">소분류</option>
			    </select>
				
				<input type="text" name="penaltyName" placeholder="패널티상품명"/>
				<input type="text" name="penaltyPrice" placeholder="가격"/>
				<input type="button" value="등록" onclick="validSubmit();"/>
			</form>
		
			<br>
		
		
			<table class="w3-table-all">
			    <thead>
					<tr class="w3-blue">
						<th>패널티 상품명</th>
						<th>가격</th>
						<th>카테고리 (대분류 > 소분류)</th>
					</tr>
			    </thead>
			    <c:choose>
			        <c:when test="${fn:length(list) > 0}">
			            <c:forEach items="${list }" var="row">
			                <tr>
			                    <td>${row.NAME }</td>
			                    <td>${row.PRICE }</td>
			                    <td>${row.CATEGORY_BIG } > ${row.CATEGORY_SMALL }</td>
			                    </tr>
		                </c:forEach>
		            </c:when>
		            <c:otherwise>
		                <tr>
		                    <td colspan="4">등록된 패널티 상품이 없습니다.</td>
		                </tr>
		            </c:otherwise>
		        </c:choose>
			</table>
		</center>
	
	</section>
    <!-- /.content -->
  </div>

<%@ include file="/WEB-INF/include/bottom.jsp" %>
</html>