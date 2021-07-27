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
	<div style="clear:both; width: 100%; height: 70px;"></div>
		
		<!-- === FAQ === -->
		<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12" style="width: 70%; margin-left: 15%;">
			<div class="home-faq">
				
				<!-- === TITLE GROUP === -->
				<div class="title-group">
					<h2> F A Q </h2>
					<div class="subtitle with-square">자주 물어보는 질문/답변</div>
				</div>
				
				<!-- === ACCORDION === -->
				<div class="panel-group" id="accordion">
					
					
				<c:forEach items="${faqSelectList }" var="vo">
					<!-- === ACCORDION ITEM === -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
									<b>${vo.faq_title }</b>
								</a>
							</h4>
						</div>
						<div id="collapseOne" class="panel-collapse collapse in">
							<div class="panel-body">
								<p><a>${vo.faq_content }</a></p>
							</div>
						</div>
					</div>
				</c:forEach>		
				
				</div>
			</div>
		</div>
	<div style="clear:both; width: 100%; height: 70px;"></div>
				
</body>
</html>