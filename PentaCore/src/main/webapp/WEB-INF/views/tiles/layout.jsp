<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<!-- SITE TITLE -->
	<title>미니창고 MyStorage</title>
	
	<link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/img/favicon.ico">
	<!-- =========================
	     STYLESHEETS   
	============================== -->
	<!-- JQUERY -->
	<script src="${pageContext.request.contextPath }/resources/js/jquery-1.11.3.min.js"></script>
	<!-- STYLES FILE -->
	<!-- BOOTSTRAP -->
	<script src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
	<link href="${pageContext.request.contextPath }/resources/css/master.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath }/resources/js/smoothscroll.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/jquery.stellar.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/assets/slider-pro/js/jquery.sliderPro.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/scrollspy.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/wow.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/assets/owl-carousel/owl.carousel.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/metisMenu.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/theme.min.js"></script>
</head>
<body>
	<tiles:insertAttribute name="header" />
	<tiles:insertAttribute name="body" />
	<tiles:insertAttribute name="foot" />
</body>
</html>