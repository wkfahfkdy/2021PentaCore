<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html> <head> <meta charset="UTF-8">
<style type="text/css">

.wrap {
	width: 100%;
	height: 100%;
}

.wrap .box {
	margin: 0 auto;
	padding-top: 5%;
	width: 70%;
}

.use1 {
	width: 50%;
	text-align: left;
	float: left;
	padding-top: 5%;
}

.use2 {
	width: 50%;
	display: inline-block;
	text-align: left;
	float: left;
}

.useImg {
	width: 100%;
}

.useImg > button {
	margin: 10px;
}

.useImg > button > img {
	width: 50px;
}

.use2 > img {
	width:500px;

}

.swiper-container-cube .swiper-cube-shadow {

	background-color: #fff;

}

</style>

<script
   src="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.js"></script>
<link
   href="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.css"
   rel="stylesheet" />
<!-- 이 예제에서는 필요한 js, css 를 링크걸어 사용 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>

<script type="text/javascript">
 	
	//스와이퍼
   let slider;
	   
    $(document).ready(function(){
   	 slider = new Swiper('.swiper-container',{
   		lazy : {
   			loadPrevNext : true
   		},
   		effect : 'cube',
   		autoHeight : false,
   		pagination : {
   			el : '.swiper-pagination',
   			clickable : true,
   		},
   		navigation : {
   			nextEl : '.swiper-button-next',
   			prevEl : '.swiper-button-prev',
   		}
   	 })
    });
    
    //클릭시 스와이퍼 및 해당글 나오도록!
    
    //function aClick() {
    	
    //	var slim = document.getElementById('slim');
	 // 	var cube = document.getElementById('cube');
    	
   // 	if(slim.src.match("i_slim")) {
    //		slim.src = "${pageContext.request.contextPath }/resources/storage_img/slim_c.png";
    //		slider.slideTo($('.swiper-slide').data("id"))
    //	} else if (slim.src.match("slim_c")){
   // 		slim.src = "${pageContext.request.contextPath }/resources/storage_img/i_slim.png";
    //	} else if (cube.src.match("i_cube")) {
    //		cube.src = "${pageContext.request.contextPath }/resources/storage_img/cube_c.png";
    //	} else if (cube.src.match("cube_c")) {
    //		cube.src = "${pageContext.request.contextPath }/resources/storage_img/i_cube.png";
    //	}
    //}
    
    function storageImage(storage_code, image){
    	//console.log($('#testImage'+storage_code).parent().data("id"));
    	var imageIndex = parseInt($('#testImage'+storage_code).parent().data("id"));

    	console.log(imageIndex);
    	slider.slideTo($('.swiper-slide').data("id")*1 + imageIndex, 1000);
    	
    	console.log("123"+event.target);
    	
    	var et = event.target;
    	//var img = et.getElementById('image');
    	
  //  	if(imageIndex == 0 ) {
  //  		et.src = "${pageContext.request.contextPath }/resources/storage_img/slim_c.png";
   // 	} else if (imageIndex == 1) {
  //  		et.src = "${pageContext.request.contextPath }/resources/storage_img/cube_c.png";
   // 	} else if ()
    	
	   //이전 스토리지는 해제  ( c_ -> i_)
  	   console.log($("#image").attr("src").replace("c_", "i_"));
	   $(".s").removeClass("s").attr("src", $("#image").attr("src").replace("c_", "i_"));
  	
	   //이전 스토리지는 선택  ( i_ -> c_)
	  $(event.target).addClass("s");
	  $(".s").attr('src',"${pageContext.request.contextPath }/resources/storage_img/c_" + image);
	   
    }
    
    
      
</script>
</head>
<body>
	<div class="wrap" align="center">
	<div class="box">
		<div class="use1">
			<div> 
				<h1>나에게 맞는 유닛 크기를</h1><h1>직접 확인하세요</h1><br>
				<h5>MY STORAGE 슬림부터 라지플러스 까지! </h5>
				<h5>다양한 유닛을 확인해보세요</h5><br>
				<h5 style="color: #58ACFA">각 지점별 '쿠폰이벤트' 서비스 제공</h5>
			</div>
			<div class="useImg">
				<c:forEach items="${storageList }" var="storage" varStatus="status">
					<button onclick="storageImage('${storage.storage_code }', '${storage.storage_image}')">
						<img id="image" src="${pageContext.request.contextPath }/resources/storage_img/i_${storage.storage_image}">
					</button>
				</c:forEach>
			</div>
		</div>
		<div class="use2">
			<div >
			   <div class="home-clients">
			      <div class="swiper-container" >
			         <div class="swiper-wrapper" style="margin-bottom: 5%" style="background-color: #fff;">
			         <!-- === 스토리지 정보 forEach === -->
			            <c:forEach items="${storageList }" var="storage" varStatus="status">
			               <div class="swiper-slide" data-storagePrice="${storage.storage_price }" data-index="${storage.storage_code }" data-id="${status.index }">
			                  <h4 align="center">${storage.storage_name }</h4>
			                  <h6 align="center"> ${storage.storage_width } *  ${storage.storage_vertical } * ${storage.storage_height} cm³ (강남역기준)</h6>
			                  <img style="width: 100%; height: 50%;" data-src="${pageContext.request.contextPath }/resources/storage_img/${storage.storage_image}" class="swiper-lazy" id="testImage${storage.storage_code }">
			               </div>
			         	</c:forEach>
			         </div>
			         
			         <!-- 네비게이션 버튼 -->
			         <div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
			         <div class="swiper-button-prev"></div><!-- 이전 버튼 -->
			         <!-- 페이징 -->
			         <div class="swiper-pagination"></div>
			      </div>
			   </div>
			</div>
		</div>
		<div style="clear: both;"></div>
	</div>	
	</div>
</body>
</html>