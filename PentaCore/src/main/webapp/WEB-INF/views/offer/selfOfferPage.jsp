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
<!-- 이 예제에서는 필요한 js, css 를 링크걸어 사용 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>

<script type="text/javascript">
	let slider;
	$(document).ready(function() {
		pageInit();
		slider = new Swiper('.swiper-container',{
			spaceBetween : 30, // 슬라이드간 간격
			// ★동적로딩 설정
			lazy : {
				loadPrevNext : true // 이전, 다음 이미지는 미리 로딩
			},
			effect : 'cube',
			autoHeight : false,
			// 페이징 설정
			pagination : {
				el : '.swiper-pagination',
				clickable : true, // 페이징을 클릭하면 해당 영역으로 이동, 필요시 지정해 줘야 기능 작동
			},
			// 네비게이션 설정
			navigation : {
				nextEl : '.swiper-button-next', // 다음 버튼 클래스명
				prevEl : '.swiper-button-prev', // 이번 버튼 클래스명
			},
			
		});
	});
	// 페이지 로딩 후 Product List 다 가져오기
	function pageInit() {
		$
				.ajax({
					url : 'productList',
					dataType : 'json',
					type : 'GET',
					success : function(result) {
						for (var i = 0; i < result.length; i++) {
							var division_code = '#' + result[i].division_code;
							// 결과값 다 Append 시키고
							$(division_code)
									.append(
											'<li class="divisionBtnliTag"><img src="${pageContext.request.contextPath }/resources/product_img/' + result[i].product_image + '"><br>'
														// 물품 별 이름 input text
													+ '<input type="text" name="offer_product" class="productName" id="productName'+result[i].product_code+'" value="'+result[i].product_name+'"><br>'
													+ '</h5><input id="productCount'+result[i].product_code+'" type="number" name="count"><br>' // 물품 별 갯수
													+ '<input type="hidden" id="productVolume'+result[i].product_code+'" value="'+result[i].product_volume+'">' // 물품별 부피 hidden
													+ '<input type="button" onclick="intoProduct(\'' // 담기 버튼 Onclick
													+ result[i].product_code
													+ '\')" value="담기" class="btn btn-primary btn-lg"></li>');

						}
						$('.do').hide();
						$('#DI001').show(); // 로딩 후 DI001 인 것만 보여주고 나머지는 Hide
					},
					error : function(err) {
						console.log(err);
					}
				});
	}
	// 각 버튼별 Division_code 받아서 결과 Append
	function test(code) {
		var division_code = code;
		$('.do').hide();
		$('#' + division_code).show();
	}
	let totalVolume = 0;
	// 카테고리 별 물건들 담는 button 
	function intoProduct(product_code) {
		
		var product_count = $('#productCount'+product_code).val(); // 물품별 갯수 count
		var product_name = $('#productName'+product_code).val(); // 물품별 이름
		var product_volume = $('#productVolume' + product_code).val(); // 물품별 부피
		
		// 스토리지 코드 들고오기
		var list = new Array();
		var volume = new Array();
			<c:forEach items="${storageList}" var="storage">
				list.push("${storage.storage_code}");
				volume.push("${storage.storage_volume}");
			</c:forEach>
		// 결과값 길이 만큼 for 해서 각 Index 별 부피 출력
		// 각 스토리지 hidden value 읽어오고
		console.log($('#storageVolumn'+list[0]).val());
		var eachVolume = product_volume * product_count;
		console.log('물품 부피 : '+ eachVolume);
		var ImageIndex = $('#testImage').parent().data("index");
		totalVolume = eachVolume + totalVolume;
		
		console.log(totalVolume);
		console.log(ImageIndex);
		if($('#storageVolumn'+list[0]).val() < totalVolume){
			// 슬림의 볼륨이 오바 되면 이미지 이동 후 input hidden 스토리지 value 변경
			$("#storageVolumn"+list[0]).removeClass('active');
		    $(this).addClass('active');
			slider.slideTo($(this).data("id")*1 + 1, 1000);
		}// end if
		
		// 물품 최소한 하나 있을때 append
		if(product_count > 0) {
			// offer Table 의 offer_product
			$('#intoProductList').append(product_name + ' ' +product_count + '개 , ');
			console.log($('#intoProductList').html());
			var items = $('#intoProductList').html();
			$('#offer_product').val(items);
			console.log(offer_product);
			}else{
			alert("갯수를 기입해주세요!");
			}
		
	}
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

.divisionBtnliTag>.productName {
	border: 0;
	width: 150px;
	margin: 0;
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
								<li class="divisionBtnliTag"><input type="button"
									id="divisionBtn" style="display: inline-block;"
									class="btn btn-primary btn-lg"
									onclick="test('${division.division_code}')"
									value="${division.division_name }"></li>
							</c:forEach>
						</ul>
						<!-- AJAX 처리 후 Append 되는 물품 리스트 -->
						<c:forEach items="${divisionList }" var="division">
							<ul class="nav divisionBtn do" id="${division.division_code }">
								<!-- Append ProductList -->
							</ul>
						</c:forEach>
						<div id="productListDIV">
							<!-- 담기 눌렀을때 담는 곳 -->
							<h4 id="intoProductList"></h4>
							<input type="hidden" name="offer_product" id="offer_product">
						</div>
					</div>
					<!-- End Storage Tag -->
					<!-- 스토리지 출력 Tag -->
					<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
						<div class="home-clients">
							<div class="swiper-container">
								<div class="swiper-wrapper">
								<!-- === 스토리지 정보 forEach === -->
									<c:forEach items="${storageList }" var="storage" varStatus="status">
										<div class="swiper-slide" data-index="${storage.storage_code }" data-id="${status.index }">
											<img data-src="${pageContext.request.contextPath }/resources/storage_img/${storage.storage_image}" class="swiper-lazy" id="testImage">
											<input type="hidden" value="${storage.storage_volume }" id="storageVolumn${storage.storage_code }">
											<h4 align="center">${storage.storage_name }</h4> 
											<h6 align="center">${storage.storage_content }</h6>
										</div>
									</c:forEach>
								</div>
								<!-- 네비게이션 버튼 -->
								<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
								<div class="swiper-button-prev"></div><!-- 이전 버튼 -->
								<!-- 페이징 -->
								<div class="swiper-pagination"></div>
							</div>
						<!-- End Storage Tag -->
						</div>
					</div>
			</div>
		</div>
	</div>

</body>
</html>