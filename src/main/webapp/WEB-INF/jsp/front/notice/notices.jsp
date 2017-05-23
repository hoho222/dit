<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ include file="/WEB-INF/include/gnb.jsp" %>
<%@ include file="/WEB-INF/include/top.jsp" %>
<%@ include file="/WEB-INF/include/head.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<center>
	<div id="" class="section">
		<div class="s-container">
			<h2 class="section-title" style="transform: translateY(0px); opacity: 1;">공지사항</h2>
		</div>
	</div>
	
   	<c:choose>
        <c:when test="${fn:length(list) > 0}">
            <c:forEach items="${list }" var="row">
            	<div class="container" style="padding-top:20px;text-align:center;">
	                <div class="panel panel-default">
                  		<div class="panel-body" >
                			<a href="${pageContext.request.contextPath}/notices/${row.IDX}">${row.TITLE }</a><br>
                			${row.HIT_CNT }<br>
                			${row.CREATE_DT }<br>
                			${row.WRITER_NAME }<br>
                		</div>
                	</div>
                </div>
               </c:forEach>
           </c:when>
           <c:otherwise>
           	조회된 결과가 없습니다.
           </c:otherwise>
       </c:choose>
	        
</center>

<%@ include file="/WEB-INF/include/foot.jsp" %>
</html>