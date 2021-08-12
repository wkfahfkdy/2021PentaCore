<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html><head><meta charset="UTF-8">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
  <title>Document</title>
  <style>
    html,
    body {
      position: relative;
      height: 30px;
    }

    body {
      background: #eee;
      font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
      font-size: 14px;
      color: #000;
      margin: 0;
      padding: 0;
    }

    .swiper-container {
      width: 100%;
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
  </style>




</head>
<body>
	
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
				
				<!-- === slide overlay === -->	
				<div class="main-slider-overlay"></div>
				
				<!-- === slide image === -->	
                <img class="sp-image" src="resources/assets/slider-pro/css/images/blank.gif"
				data-src="resources/media/main-slider/1.jpg"
				data-retina="resources/media/main-slider/1.jpg" alt="" />
				
				<!-- === slide container === -->	
				<div class="container">
                    <div class="main-slider-content">
        				<h2 class="sp-layer"
                            data-position="centerCenter" data-vertical="-55"
        					data-show-transition="left" data-hide-transition="left" data-show-delay="200" data-hide-delay="200">
        					We are your reliable partner
        				</h2>
        
        				<h2 class="sp-layer color-primary"
                            data-position="centerCenter" data-vertical="10"
        					data-show-transition="left" data-hide-transition="left" data-show-delay="400" data-hide-delay="400">
        					Quality services of cargo
        				</h2>
            
                        <a class="sp-layer main-button-2" href="#"
                            data-position="centerCenter" data-vertical="280"
            				data-show-transition="left" data-hide-transition="left" data-show-delay="600" data-hide-delay="600">
							<div class="my-btn my-btn-primary">
								<div class="my-btn-bg-top"></div>
								<div class="my-btn-bg-bottom"></div>
								<div class="my-btn-text">
									GET A FREE QUOTE
								</div>
							</div>
						</a>
                         
                    </div>
                </div>
			</div>

            <!-- === SLIDER ITEM === -->	
			
			<div class="sp-slide">
				
				<!-- === slide overlay === -->	
				<div class="main-slider-overlay"></div>
				
				<!-- === slide image === -->	
                <img class="sp-image" src="resources/assets/slider-pro/css/images/blank.gif"
				data-src="resources/media/main-slider/2.jpg"
				data-retina="resources/media/main-slider/2.jpg" alt="" />
				
				<!-- === slide container === -->	
				<div class="container">
                    <div class="main-slider-content">
        				<h2 class="sp-layer"
                            data-position="centerCenter" data-vertical="-55"
        					data-show-transition="down" data-hide-transition="down" data-show-delay="600" data-hide-delay="600">
        					We are your reliable partner
        				</h2>
        
        				<h2 class="sp-layer color-primary"
                            data-position="centerCenter" data-vertical="10"
        					data-show-transition="down" data-hide-transition="down" data-show-delay="400" data-hide-delay="400">
        					Quality services of cargo
        				</h2>
            
                        <a class="sp-layer main-button-2" href="#"
                            data-position="centerCenter" data-vertical="280"
            				data-show-transition="down" data-hide-transition="down" data-show-delay="200" data-hide-delay="200">
							<div class="my-btn my-btn-primary">
								<div class="my-btn-bg-top"></div>
								<div class="my-btn-bg-bottom"></div>
								<div class="my-btn-text">
									GET A FREE QUOTE
								</div>
							</div>
						</a>
                         
                    </div>
                </div>
			</div>
   
            <!-- === SLIDER ITEM === -->	
			
			<div class="sp-slide">
				
				<!-- === slide overlay === -->	
				<div class="main-slider-overlay"></div>
				
				<!-- === slide image === -->	
                <img class="sp-image" src="resources/assets/slider-pro/css/images/blank.gif"
				data-src="resources/media/main-slider/3.jpg"
				data-retina="resources/media/main-slider/3.jpg" alt="" />
				
				<!-- === slide container === -->	
				<div class="container">
                    <div class="main-slider-content">
        				<h2 class="sp-layer"
                            data-position="centerCenter" data-vertical="-55"
        					data-show-transition="up" data-hide-transition="up" data-show-delay="200" data-hide-delay="200">
        					We are your reliable partner
        				</h2>
        
        				<h2 class="sp-layer color-primary"
                            data-position="centerCenter" data-vertical="10"
        					data-show-transition="up" data-hide-transition="up" data-show-delay="400" data-hide-delay="400">
        					Quality services of cargo
        				</h2>
            
                        <a class="sp-layer main-button-2" href="#"
                            data-position="centerCenter" data-vertical="280"
            				data-show-transition="up" data-hide-transition="up" data-show-delay="600" data-hide-delay="600">
							<div class="my-btn my-btn-primary">
								<div class="my-btn-bg-top"></div>
								<div class="my-btn-bg-bottom"></div>
								<div class="my-btn-text">
									GET A FREE QUOTE
								</div>
							</div>
							</a>
	                       
                    </div>
                </div>
			</div>

		</div>
    </div>
	<!-- =========================
		END MAIN SLIDER
	============================== -->
	
	
	<!-- swiper슬라이더 메인컨테이너 -->
	<div class="swiper-container">
	  <!-- 보여지는 영역 -->
		<div class="swiper-wrapper">
			<!-- div class="swiper-slide" 를 추가하면된다 -->
			<c:forEach items="${list}" var="list">
				<div class="swiper-slide"><b>${list.store_name } </b> &nbsp;  &nbsp;  온도 ${list.humidity } ℃ 습도 ${list.temperature } % </div>
			</c:forEach>
		</div>
	</div>
	  <script>
    const swiper = new Swiper('.swiper-container', {
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

</body>
</html>