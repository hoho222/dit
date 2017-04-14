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
<body>
<table class="boardlist" style="border:1px solid #ccc"  align="center">
	<colgroup>
	    <col width="10%"/>
	    <col width="30%"/>
	    <col width="15%"/>
	    <col width="20%"/>
	    <col width="20%"/>
	</colgroup>
	<thead>
	    <tr>
	        <th>글번호</th>
	        <th>제목</th>
	        <th>조회수</th>
	        <th>작성일</th>
	        <th>작성자</th>
	    </tr>
	</thead>
	<tbody>
    	<c:choose>
	        <c:when test="${fn:length(list) > 0}">
	            <c:forEach items="${list }" var="row">
	                <tr>
	                    <td>${row.IDX }</td>
	                    <td><a href="${pageContext.request.contextPath}/notices/${row.IDX}">${row.TITLE }</a></td>
	                    <td>${row.HIT_CNT }</td>
	                    <td>${row.CREATE_DT }</td>
	                    <td>${row.WRITER_NAME }</td>
	                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="4">조회된 결과가 없습니다.</td>
                </tr>
            </c:otherwise>
        </c:choose>
        
    </tbody>
</table>
</body>
<%@ include file="/WEB-INF/include/foot.jsp" %>
</html>