<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@ include file="/WEB-INF/include/navi.jsp" %>

</head>
<body>

<center>
	<h3>공지사항 관리(일단 상세 페이지는 프론트껄로 보셈)</h3>
	<table class="boardlist" style="border:1px solid #ccc"  align="center">
		<colgroup>
		    <col width="30%"/>
		    <col width="15%"/>
		    <col width="20%"/>
		    <col width="20%"/>
		    <col width="20%"/>
		    <col width="40%"/>
		</colgroup>
		<thead>
		    <tr>
		        <th>제목</th>
		        <th>조회수</th>
		        <th>삭제여부</th>
		        <th>작성 어드민ID</th>
		        <th>작성 어드민이름</th>
		        <th>작성일</th>
		    </tr>
		</thead>
		<tbody>
	    	<c:choose>
		        <c:when test="${fn:length(list) > 0}">
		            <c:forEach items="${list }" var="row">
		                <tr>
		                    <td><a href="${pageContext.request.contextPath}/notices/${row.IDX}">${row.TITLE }</a></td>
		                    <td>${row.HIT_CNT }</td>
		                    <td>
			                    <c:choose>
			                    	<c:when test="${row.IS_DEL eq 'N'}">X</c:when>
			                    	<c:when test="${row.IS_DEL eq 'Y'}">O</c:when>
			                    	<c:otherwise>-</c:otherwise>
			                    </c:choose>
		                    </td>
		                    <td>${row.WRITER_ID }</td>
		                    <td>${row.WRITER_NAME }</td>
		                    <td>${row.CREATE_DT }</td>
		                    </tr>
	                </c:forEach>
	            </c:when>
	            <c:otherwise>
	                <tr>
	                    <td colspan="6">등록된 공지사항이 없습니다.</td>
	                </tr>
	            </c:otherwise>
	        </c:choose>
	        
	    </tbody>
	</table>
</center>

<a href="${pageContext.request.contextPath}/admin/noticesform"><input type="button" class="btn btn-primary" value="글 작성"/></a>

</body>
</html>