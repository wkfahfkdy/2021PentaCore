<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>셀프견적</title>
<script type="text/javascript">
	// 카테고리 별 물품 이미지와 이름 출력하는 function 코드 날려서 그 division코드에 맞는 물품 리스트 출력
		function divisionCode(code) {
			console.log(code);
			var division_code = code;
			$.ajax({
				url : 'productList',
				type : 'post',
				dataType : 'json',
				data : {
					'division_code' : division_code
				},
				success : function(result) {
					$('#service').children().remove(); // 지우고 다시 리스트 출력
						for(var i = 0; i < result.length; i++){
							console.log(result[i].product_name);
							$('#service').append('<li>' + result[i].product_name + "</li>");
						}
						
				},
				error : function(err) {
					console.log(err);
				}
			});
		}
</script>
<style>
.def-section {
	padding-top: 20px;
	padding-bottom: 50px;
	position: relative;
}

.navbar-nav>li {
	margin-left: 30px;
	margin-top: 10px;
}

.offerLabel {
	min-width: 150px;
	border: 1px solid #e1e1e1;
	text-align: center;
	font-family: Montserrat;
	line-height: 23px;
	color: #666;
	padding: 10px 20px;
	cursor: pointer;
	background: #fff;
	border-radius: 3px;
	overflow: hidden;
}

.offerLabel:checked {
	color: #fff;
	border: 1px solid #5b87da;
	background: #5b87da;
}

input[type='text'] {
	width: 330px;
	margin-left: 30px;
	margin-top: 10px;
	min-width: 150px;
	border: 1px solid #e1e1e1;
	text-align: center;
	font-family: Montserrat;
	line-height: 23px;
	color: #666;
	padding: 10px 20px;
	cursor: pointer;
	background: #fff;
	border-radius: 3px;
	overflow: hidden;
}

.productList>li>button {
	background: #e1e1e1;
	display: inline-block;
	width: 40%;
	font-size: 16px;
	color: #666;
	text-align: center;
	border-bottom: 1px solid #ccc;
	border-right: 1px solid #ccc;
}

.productList>ul {
	width: 5%;
}

.service {
	float : left;
	
}
</style>
</head>
<body>
	<div style="width: 100%">
		<!-- 이용목적 칸 -->
		<section class="def-section" id="clients-section">
			<div class="container">
				<div class="row">
					<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12"
						style="width: 100%;">
						<div class="home-clients">
							<h3>셀프견적</h3>
							<br>
							<h4>이용정보 입력</h4>
							<h5>어떤 용도로 사용하세요? (복수선택 가능)</h5>
							<div class="collapse navbar-collapse main-menu main-menu-2"
								id="main-menu">
								<ul class="nav navbar-nav">
									<!-- === top menu item === -->
									<li class="active dropdown"><label class="offerLabel">
											<input type="checkbox">이삿짐 단기보관
									</label></li>
									<li class="active dropdown"><label class="offerLabel">
											<input type="checkbox">해외 출장
									</label></li>
									<li class="active dropdown"><label class="offerLabel">
											<input type="checkbox">작은 집
									</label></li>
									<li class="active dropdown"><label class="offerLabel">
											<input type="checkbox">취미용품 보관
									</label></li>
									<li class="active dropdown"><label class="offerLabel">
											<input type="checkbox">계절용품
									</label></li>
									<li class="active dropdown"><label class="offerLabel">
											<input type="checkbox">사업용도
									</label></li>
									<li class="active dropdown"><label class="offerLabel">
											<input type="checkbox">프라이버시
									</label></li>
									<li class="active dropdown"><label class="offerLabel">
											<input type="checkbox">기타
									</label></li>
									<input type="text" value="다락 사용 목적을 입력해주세요.">
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
	</div>
	</section>
	<section class="def-section" id="clients-section">
		<div class="container">
			<div class="row">
				<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12"
					style="width: 100%;">
					<div class="home-clients">
						<h4>얼마나 오래 사용하실 계획이세요?</h4>
						<div class="collapse navbar-collapse main-menu main-menu-2"
							id="main-menu">
							<ul class="nav navbar-nav">
								<!-- === top menu item === -->
								<li class="active dropdown"><label class="offerLabel">
										<input type="radio" name="offer_date">1개월 미만
								</label></li>
								<li class="active dropdown"><label class="offerLabel">
										<input type="radio" name="offer_date">1개월 이상
								</label></li>
								<li class="active dropdown"><label class="offerLabel">
										<input type="radio" name="offer_date">3개월 이상
								</label></li>
								<li class="active dropdown"><label class="offerLabel">
										<input type="radio" name="offer_date">6개월 이상
								</label></li>
								<li class="active dropdown"><label class="offerLabel">
										<input type="radio" name="offer_date">12개월 이상
								</label></li>
								<li class="active dropdown"><label class="offerLabel">
										<input type="radio" name="offer_date">지속적 이용
								</label></li>
								<li class="active dropdown"><label class="offerLabel">
										<input type="radio" name="offer_date">확실하지 않음 
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
	</section>
	<div class="home-clients">
		<div class="def-section services-1">
			<div class="container">
				<div class="row">

					<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12"
						style="width: 50%; margin: 50px auto;">
						<ul class="nav productList">
							<c:forEach items="${divisionList }" var="division">
								<input type="hidden" name="FDF"
									value="${division.division_code }">
								<li><input type="button" id="btn"
									class="btn btn-primary btn-lg"
									onclick="divisionCode('${division.division_code}')"
									value="${division.division_name }"></li>
							</c:forEach>
						</ul>
					</div>

					<!-- 물품 리스트 -->
					<div align="center">
						<ul class="service" id="service"></ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
</body>
</html>