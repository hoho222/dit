<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@ include file="/WEB-INF/include/gnb.jsp" %>
</head>


	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal">&times;</button>
		<center><h4 class="modal-title">패널티 상품 고르기</h4></center>
	</div>

	<div class="modal-body">
		<center>패널티 상품명을 선택하고 저장 버튼을 눌러주세요.</center>
		
		<c:choose>
	        <c:when test="${fn:length(penaltyList) > 0}">
	        
            	<!-- 카테고리 아코디언 메뉴 start -->
				<div class="accordion">영화</div>
				<div class="panel">
				  <c:forEach items="${penaltyList }" var="row">
					  <c:if test="${row.CATEGORY_BIG eq '영화'}">
					  	<p>
							${row.CATEGORY_SMALL} - ${row.NAME } (+${row.PRICE })&nbsp;<input type="radio" name="penaltySelector" onclick="setPenaltyGoods('${row.NAME }', '${row.PRICE }', '${row.IDX}');" />
						</p>
					  </c:if>
				  </c:forEach>
				</div>
				
				<div class="accordion">음료/커피</div>
				<div class="panel">
				  <c:forEach items="${penaltyList }" var="row">
					  <c:if test="${row.CATEGORY_BIG eq '음료/커피'}">
					  	<p>
							${row.CATEGORY_SMALL} - ${row.NAME } (+${row.PRICE })&nbsp;<input type="radio" name="penaltySelector" onclick="setPenaltyGoods('${row.NAME }', '${row.PRICE }', '${row.IDX}');" />
						</p>
					  </c:if>
				  </c:forEach>
				</div>
				
				<div class="accordion">치킨</div>
				<div class="panel">
				  <c:forEach items="${penaltyList }" var="row">
					  <c:if test="${row.CATEGORY_BIG eq '치킨'}">
					  	<p>
							${row.CATEGORY_SMALL} - ${row.NAME } (+${row.PRICE })&nbsp;<input type="radio" name="penaltySelector" onclick="setPenaltyGoods('${row.NAME }', '${row.PRICE }', '${row.IDX}');" />
						</p>
					  </c:if>
				  </c:forEach>
				</div>
				
				<div class="accordion">베이커리</div>
				<div class="panel">
				  <c:forEach items="${penaltyList }" var="row">
					  <c:if test="${row.CATEGORY_BIG eq '베이커리'}">
					  	<p>
							${row.CATEGORY_SMALL} - ${row.NAME } (+${row.PRICE })&nbsp;<input type="radio" name="penaltySelector" onclick="setPenaltyGoods('${row.NAME }', '${row.PRICE }', '${row.IDX}');" />
						</p>
					  </c:if>
				  </c:forEach>
				</div>
				<!-- 카테고리 아코디언 메뉴 end -->
	            	
            </c:when>
            <c:otherwise>
            	등록된 패널티 상품이 없습니다.
            </c:otherwise>
        </c:choose>
		
	</div>
	
	<script>
	var acc = document.getElementsByClassName("accordion");
	var i;
	
	for (i = 0; i < acc.length; i++) {
	  acc[i].onclick = function() {
	    this.classList.toggle("active");
	    var panel = this.nextElementSibling;
	    if (panel.style.maxHeight){
	      panel.style.maxHeight = null;
	    } else {
	      panel.style.maxHeight = panel.scrollHeight + "px";
	    } 
	  }
	}
	</script>
	
	<div class="modal-footer">
	        <button type="button" class="btn btn-primary" data-dismiss="modal">저장</button>
	</div>

</html>