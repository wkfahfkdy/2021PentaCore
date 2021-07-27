<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>1:1문의!</h1>
		<c:forEach items="${inquirySelectList }" var="vo">
		<h5>${vo.question_content } <a>${vo.store_code }</a></h5>
	</c:forEach>
</body>
</html>