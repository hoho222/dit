<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@ include file="/WEB-INF/include/gnb.jsp" %>
</head>
<body>

	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal">&times;</button>
		<center><h4 class="modal-title">패널티 상품 고르기</h4></center>
	</div>

	<div class="modal-body">
		<center>패널티 상품명을 클릭하고 저장 버튼을 눌러주세요.</center>
		<table class="boardlist" style="border:1px solid #ccc"  align="center">
		    	<c:choose>
			        <c:when test="${fn:length(penaltyList) > 0}">
			            <c:forEach items="${penaltyList }" var="row">
			            	<tr>
			                    <td>${row.CATEGORY_BIG }</td>
			                </tr>
			                
			                <tr>    
			                    <td>${row.CATEGORY_SMALL}</td>
			                </tr>
			                
			                <tr>
			                    <td>
			                    	<a onclick="setPenaltyGoods('${row.NAME }', '${row.PRICE }', '${row.IDX}');">${row.NAME } (+${row.PRICE })</a>
			                    </td>
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
	</div>
	
	<div class="modal-footer">
	        <button type="button" class="btn btn-primary" data-dismiss="modal">저장</button>
	</div>


</body>
<%@ include file="/WEB-INF/include/foot.jsp" %>
</html>