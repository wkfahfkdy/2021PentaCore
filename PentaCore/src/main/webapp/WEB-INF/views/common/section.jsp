<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html><head><meta charset="UTF-8">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<!-- 온/습도 스와이프 -->
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
  <title>Document</title>
  <style>
  	/* 리뷰 이미지 */
  	.reviewContent > img {
  		width: 100%;
  		height: 500px;
  	}
  	/* 온/습도 스와이프 시작 */
    .swiper-container {
      width: 120%;
      height: 30px;
    }

    .swiper-slide {
      text-align: center;
      font-size: 14px;
      background: #fff;

      /* Center slide text vertically */
      display: -webkit-box;
      display: -ms-flexbox;
      display: -webkit-flex;
      display: flex;
      -webkit-box-pack: center;
      -ms-flex-pack: center;
      -webkit-justify-content: center;
      justify-content: center;
      -webkit-box-align: center;
      -ms-flex-align: center;
      -webkit-align-items: center;
      align-items: center;
    }

    .swiper-container-vertical>.swiper-pagination-bullets {
      top: unset !important;
      bottom: 10px;
      left: 0;
      width: 100%;
    }

    .swiper-container-vertical>.swiper-pagination-bullets .swiper-pagination-bullet {
      display: inline-block !important;
      margin: 6px 2px !important;
    }
    
    
  	/* 리뷰스와이프 */

  
  </style>
</head>
<body>
	
	<!-- 메인이미지슬라이드 -->
	 <!-- =========================
		MAIN SLIDER
	============================== -->
	<div id="main-slider-2" class="main-slider main-slider-2">
		
		<!-- === SLIDER BUTTONS === -->
		
		<a class="main-slider-2-button-prev" href="#">
			<div class="my-btn my-btn-grey">
				<div class="my-btn-bg-top"></div>
				<div class="my-btn-bg-bottom"></div>
				<div class="my-btn-text">
					<i class="fa fa-angle-left"></i>
				</div>
			</div>
		</a>
		
		<a class="main-slider-2-button-next" href="#">
			<div class="my-btn my-btn-grey">
				<div class="my-btn-bg-top"></div>
				<div class="my-btn-bg-bottom"></div>
				<div class="my-btn-text">
					<i class="fa fa-angle-right"></i>
				</div>
			</div>
		</a>
		
		<div class="sp-slides">
			
			<!-- === SLIDER ITEM === -->	
			
			<div class="sp-slide">
				
				<!-- === slide image === -->	
                <img class="" src="${pageContext.request.contextPath }/resources/main/main1.png"
				data-src="resources/main/main1.png"
				data-retina="resources/main/main1.png" 
				style="height:100%; margin-left: px; margin-left:0;"alt="" />
				
				<!-- === slide container === -->	
				
			</div>

            <!-- === SLIDER ITEM === -->	
			
			<div class="sp-slide">
				
				
				<!-- === slide image === -->	
                <img class="sp-image" src="${pageContext.request.contextPath }/resources/main/main5.png"
				data-src="resources/main/main5.png"
				data-retina="resources/main/main5.png" 
				style="height:100%; margin-left: px; margin-left:0;"alt="" />
				
				<!-- === slide container === -->	
				<div class="container">
                    <div class="main-slider-content"></div>
                </div>
			</div>
   
            <!-- === SLIDER ITEM === -->	
			
			<div class="sp-slide">
				
				<!-- === slide image === -->	
                <img class="sp-image" src="${pageContext.request.contextPath }/resources/main/main6.png"
				data-src="resources/main/main6.png"
				data-retina="resources/main/main6.png" 
				style="height:100%; margin-left: px; margin-left:0;"alt="" />
				
				<!-- === slide container === -->	
				<div class="container">
                    <div class="main-slider-content"> </div>
                </div>
			</div>

		</div>
    </div>
	<!-- =========================
		END MAIN SLIDER
	============================== -->
	
	
	<!-- swiper슬라이더 메인컨테이너 온/습도 -->
	<div class="swiper-container" style="padding: 3%">
	  <!-- 보여지는 영역 -->
		<div class="swiper-wrapper">
			<!-- div class="swiper-slide" 를 추가하면된다 -->
			<c:forEach items="${list}" var="list">
				<div class="swiper-slide"><b>${list.store_name } </b> &nbsp;  &nbsp;  
					<img style="width: 15%; "src="${pageContext.request.contextPath }/resources/main/main_1.png">&nbsp;   ${list.humidity } ℃ &nbsp;  &nbsp;  
					<img style="width: 15%; "src="${pageContext.request.contextPath }/resources/main/main_2.png">&nbsp;   ${list.temperature } % </div>
			</c:forEach>
		</div>
	</div>
	<script>
	    var swiper = new Swiper('.swiper-container', {
	      //기본 셋팅
	      //방향 셋팅 vertical 수직, horizontal 수평 설정이 없으면 수평
	      direction: 'horizontal',
	      //한번에 보여지는 페이지 숫자
	      slidesPerView: 6,
	      //페이지와 페이지 사이의 간격
	      spaceBetween: 10,
	      //드레그 기능 true 사용가능 false 사용불가
	      debugger: true,
	      //마우스 휠기능 true 사용가능 false 사용불가
	      mousewheel: true,
	      //반복 기능 true 사용가능 false 사용불가
	      loop: true,
	      //선택된 슬라이드를 중심으로 true 사용가능 false 사용불가 djqt
	      centeredSlides: true,
	      // 페이지 전환효과 slidesPerView효과와 같이 사용 불가
	      // effect: 'fade',
	
	      //자동 스크를링
	      autoplay: {
	        //시간 1000 이 1초
	        delay: 1000,
	        disableOnInteraction: false,
	      },
	
	      //페이징
	      pagination: {
	        //페이지 기능
	        el: '.swiper-pagination',
	        //클릭 가능여부
	        clickable: false,
	      },
	    });
	</script>
	
	<!-- 메인img -->
	<div >
		<img style="width: 100%; "src="${pageContext.request.contextPath }/resources/main/main2.png">
		<img style="width: 100%; "src="${pageContext.request.contextPath }/resources/main/main3.png">
		<img style="width: 100%; "src="${pageContext.request.contextPath }/resources/main/main4.png">
	</div>
    <!-- 리뷰 -->
    <div class="swiper-container mySwiper" style="height: auto; width: 80%;">
    	<div class="swiper-wrapper">
			<c:forEach items="${reviewList}" var="reviewList" end="2">
				<div class="swiper-slide" style="width: 100%">
					<div class="media" style="width: 80%;  padding: 30px;">
						<div class="media-body" style="width:100%; display: block; ">
							<div class="media-body-top" style="width: 100%;">
								<div class="media-info">
									<h4 class="media-heading">${reviewList.review_title }</h4>
									<span class="media-date">${reviewList.review_date }</span>
								</div>
							<div class="media-reply">
								<a onclick="location.href='reviewDetail?review_num=${reviewList.review_num}'"><div class="my-btn my-btn-default">
									<div class="my-btn-bg-top"></div>
									<div class="my-btn-bg-bottom"></div>
									<div class="my-btn-text">
										자세히 보기
									</div>
								</div></a>
							</div>
							</div>
								${reviewList.review_content }
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
		<div class="swiper-button-next"></div>
		<div class="swiper-button-prev"></div>
		<div class="swiper-pagination"></div>
	</div>
    <!-- Swiper JS -->
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

    <!-- Initialize Swiper -->
    <script>
      var swiper = new Swiper(".mySwiper", {
        pagination: {
          el: ".swiper-pagination",
          type: "progressbar",
        },
        autoplay: {
            delay: 2500,
            disableOnInteraction: false,
        },
        navigation: {
          nextEl: ".swiper-button-next",
          prevEl: ".swiper-button-prev",
        },
      });
    </script>
</body>
</html>