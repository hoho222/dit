<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ include file="/WEB-INF/include/gnb.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

	<div id="footer">
	     <div class="container">
	     	<div class="row">
				<div class="12u">
	
					<!-- Contact -->
						<section class="contact">
							<header>
								<h3><p>Copyright &copy; 경호원</p></h3>
							</header>
							<p>경호원</p>
						</section>
	
					<!-- Copyright -->
						<div class="copyright">
							<ul class="menu">
								<li>&copy; 경호원. All rights reserved.</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
							</ul>
						</div>
	
				</div>
	
			</div>
	     </div>
	     
	</div>

<!-- 이 밑의 </div>는 head에 있는 div id="page-wrapper" 닫는 div태그임 -->
</div>


<!-- js파일 -->
<%-- <script type="text/javascript" src="<c:url value='/js/jquery.min.js'/>"></script> --%>
<script type="text/javascript" src="<c:url value='/js/jquery.dropotron.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.scrolly.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.onvisible.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/skel.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/util.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/main.js'/>"></script>

</body>
</html>