<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html> <head> <meta charset="UTF-8">
<style type="text/css">

.wrap {
	width: 100%;
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
	padding-top: 10%;
}

.use2 {
	width: 50%;
	text-align: left;
	float: left;
	padding: 7%;
}

.use3 {
	width: 50%;
	text-align: left;
	float: left;
	padding-top: 5%;
}

.use4 {
	width: 50%;
	text-align: left;
	float: left;
	padding-top: 5%;
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
	width:300px;

}

/* step */
.step input[type=radio] {
	display : none;
}

#tab-1:checked ~ .tab label:nth-child(1),
#tab-2:checked ~ .tab label:nth-child(2),
#tab-3:checked ~ .tab label:nth-child(3),
#tab-4:checked ~ .tab label:nth-child(4) {
	box-shadow: none;
}

.content > div {
	display: none;
}

#tab-1:checked ~ .content div:nth-child(1),
#tab-2:checked ~ .content div:nth-child(2),
#tab-3:checked ~ .content div:nth-child(3),
#tab-4:checked ~ .content div:nth-child(4) {
	display: block;
}

.tab {
	overflow : hidden;
}

.tab label {
	cursor: pointer;
	user-select : none;
	-webkit-user-select: none;
	padding-right: 15px;
}

.tab label:hover {
	color: #478FEB;
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
    function storageImage(storage_code, image){
    	//console.log($('#testImage'+storage_code).parent().data("id"));
    	var imageIndex = parseInt($('#testImage'+storage_code).parent().data("id"));

    	console.log(imageIndex);
    	slider.slideTo($('.swiper-slide').data("id")*1 + imageIndex, 1000);
    	
        //이전 스토리지는 해제  ( c_ -> i_)
        if(typeof $(".s").attr("src") !== 'undefined') {
           $(".s").attr("src", $(".s").attr("src").replace("c_", "i_"));         
        }
        $(".s").removeClass("s");
        
        //이전 스토리지는 선택  ( i_ -> c_)
       $(event.target).addClass("s");
       $(".s").attr('src',"${pageContext.request.contextPath }/resources/storage_img/c_" + image);
        
      }
    
    
    function loginChk(check) {
    	if (check == "no") {
        	var check = confirm("LOGIN 후 사용가능합니다!")
        	if (check == true) {
        		location.href = "memberLoginForm";
        	} else {
        		location.href = "infoUse";
        	}
    	} else {
    		location.href="selfOffer";
    	}
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
		   <div class="home-clients" >
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
		<div class="use3">
			<div>
				<img style="width: 100%;" 
					src="${pageContext.request.contextPath}/resources/img/use.png">
			</div>
		</div>
		<div class="use4">
			<div> 
				<h1>셀프견적부터</h1><h1>쉽고 편리한 이용까지</h1><br>
				<h5>맞춤 사이즈, 가격 확인에서 방문 예약까지 한번에! </h5>
				<h5>다양한 사용 형태를 고려한 개별 맞춤 서비스를 제공합니다.</h5><br>
			</div>
			<div class="step" style="padding-top: 5%;">
				<input type="radio" id="tab-1" name="show" checked />
				<input type="radio" id="tab-2" name="show" />
				<input type="radio" id="tab-3" name="show" />
				<input type="radio" id="tab-4" name="show" />
				<div class="tab">
					<label for="tab-1"><b>STEP 1</b></label>
					<label for="tab-2"><b>STEP 2</b></label>
					<label for="tab-3"><b>STEP 3</b></label>
					<label for="tab-4"><b>STEP 4</b></label>
				</div> 
				<div class="content" style="padding-top: 2%;" >
					<div class="content-dis">
						<h4>셀프 견적</h4>
						<h6>사이즈 추천을 위해 보관하시려는 물품을 선택해 주세요</h6>
					</div>
					<div class="content-dis">
						<h4>맞춤 상담</h4> 
						<h6>선택해 주신 짐의 종류와 양에 따라 적합한 공간 사이즈를 추천해 드립니다</h6>
					</div>
					<div class="content-dis">
						<h4>사용 신청</h4>
						<h6>이용선택해 주신 사이즈 및 기간을 설정하신 후 이용신청서를 확인해 주세요</h6>
					</div>
					<div class="content-dis">
						<h4>사용 시작</h4>
						<h6>365일 24시간 언제든 이용할 수 있어요</h6>
					</div>
				</div>
				<div style="padding-top: 5%;">
					<button><h4 style="color: #58ACFA"> ✔ 지금 시작해보세요 </h4></button>
				</div>
				<div><br>
					<button class="btn btn-primary btn-lg" type="button" onclick="loginChk('${chk}')"
						style="width: 70%;"">
						<h4>셀프견적 바로가기</h4></button>
				</div>
			</div>
		</div>
	</div>	
	</div>
	<div style="clear: both; padding-bottom: 10%"></div>
</body>
</html>