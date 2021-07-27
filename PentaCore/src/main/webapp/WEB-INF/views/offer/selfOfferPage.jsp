<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>셀프견적</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.css"
	rel="stylesheet" />
<script>
	// bxSlider 이미지
	$(document).ready(function() {
		$('.bxslider').bxSlider({
			controls : true, // prev/next 버튼 노출 여부
		});

	});
</script>
<script type="text/javascript">
	// 카테고리 별 물품 이미지와 이름 출력하는 function 코드 날려서 그 division코드에 맞는 물품 리스트 출력
	/* function divisionCode(code) {
		console.log(code);
		var division_code = code;
		
		$.ajax({
					url : '',
					type : 'post',
					dataType : 'json',
					success : function(result) {
						for (var i = 0; i < result.length; i++) {
							$('#productList')
									.append(
											'<li class="divisionBtnliTag"><img src="${pageContext.request.contextPath }/resources/product_img/' + result[i].product_image + '"><br>'
													+ '<input type="text" class="name" id="productName" value="'+result[i].product_name+'"><br>'
													+ '</h5><input id="productCount" type="number" name="count"></li>');
						}
					},
					error : function(err) {
						console.log(err);
					}
				});
	}  */
	// 페이지 로딩 후 Product List 다 가져오기
	$(document).ready(function(){
		$.ajax({
			url : 'productList',
			type : 'post',
			dataType : 'json',
			success : function(result) {
				for (var i = 0; i < result.length; i++) {
					var division_code ='#'+ result[i].division_code;
					$(division_code).append(
										'<li class="divisionBtnliTag"><img src="${pageContext.request.contextPath }/resources/product_img/' + result[i].product_image + '"><br>'
												+ '<input type="text" class="name" id="productName" value="'+result[i].product_name+'"><br>'
												+ '</h5><input id="productCount" type="number" name="count"></li>');
						//arr = [result[i].product_name];
				}
				$('.do').hide();
				$('#DI001').show();
			},
			error : function(err) {
				console.log(err);
			}
		});
		$('#divisionBtn').click(function() {
			var division_code = $('#divisionBtn').val();
			console.log(division_code);
		})
	})

</script>
<style>
.def-section {
	padding-top: 20px;
	padding-bottom: 50px;
	position: relative;
}

.navbar-nav>li>.offerLabel {
	margin-left: 30px;
	margin-top: 10px;
}

#productName{
	width: 150px;
	margin : 0;
}

.divisionBtnliTag>.name {
	padding: 0;
	text-align: center;
	left: 0;
	bottom: 15px;
	width: 100%;
	color: #666;
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

.divisionBtn>li>button {
	background: #e1e1e1;
	display: inline-block;
	width: 30%;
	font-size: 16px;
	color: #666;
	text-align: center;
	border-bottom: 1px solid #ccc;
	border-right: 1px solid #ccc;
}

.divisionBtn>ul, .divisionBtnliTag {
	margin-left: 2%;
	list-style-type: none;
	float: left;
	list-style-type: none
}

.divisionBtnliTag>img {
	line-height: 2.5;
}

.service {
	float: left;
	display: inline-block;
}

input[type='number'] {
	width: 150px;
	color: #666;
	padding: 5px 5px;
	border: 1px solid #e1e1e1;
	text-align: center;
	font-family: Montserrat;
	background: #fff;
	border-radius: 3px;
	overflow: hidden;
}

.home-clients-carousel-item {
	width: 100%;
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
					<!-- 카테고리 별 물품 리스트 나오는 Tag -->
					<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12"
						style="width: 50%;">
						<ul class="nav divisionBtn">
							<c:forEach items="${divisionList }" var="division">
								<input type="hidden" id="divisionCode" name="division_code"
									value="${division.division_code }">
								<li class="divisionBtnliTag"><input type="button" id="divisionBtn"
									style="display: inline-block;" class="btn btn-primary btn-lg"
									value="${division.division_code }"></li>
							</c:forEach>
						</ul>
						<!-- AJAX 처리 후 Append 되는 물품 리스트 -->
						<c:forEach items="${divisionList }" var="division">
							<ul class="nav divisionBtn do" id="${division.division_code }">
								
							</ul>
						</c:forEach>
						<input type="button" id="insertBtn" value="저장"
							class="btn btn-primary btn-lg">
					</div>
					<!-- End Storage Tag -->
					<!-- 스토리지 출력 Tag -->
					<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
						<div class="home-clients">
							<!-- === 스토리지 정보 forEach === -->
							<ul class="bxslider">
								<c:forEach items="${storageList }" var="storage">
									<li>
										<h4 align="center">${storage.storage_name }</h4> <img
										alt="${storage.storage_name }"
										src="${pageContext.request.contextPath }/resources/storage_img/${storage.storage_image}">
										<h6 align="center">${storage.storage_content }</h6>
									</li>
								</c:forEach>
							</ul>
						</div>
						<!-- End Storage Tag -->
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>