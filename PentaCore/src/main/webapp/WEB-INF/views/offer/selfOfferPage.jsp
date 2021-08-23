<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>셀프견적</title>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
<!-- 이유는 모르겠는데 아래 5줄의 css, js 가져오는 것들 순서 바뀌면 Grid 작동 제대로 안해요 -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/v1.5.0/tui-code-snippet.js"></script>
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3a66ba8e60100e68a1df7756407ad0bb&libraries=services"></script>

<script type="text/javascript">
	//세탁 총 가격
	let totalLaundryPrice = 0;
	// 세탁물 배열
	let laundryArrayList = new Array();
	// 스토리지 코드마다의 이미지 data-index
	let storageImageIndex;
	// 스토리지 가격들
	let storage_price; 
	// 총 물품의 부피를 담는 변수
	let totalVolume = 0;
	// 각 물품의 볼륨을 담는 변수
	let product_volume;
	// 총 보관물품 (offer_product)
	let productArrayList = new Array();
	// ForEach Storage 의 Array 변수
	let list = new Array(); // storage_code
	let volume = new Array(); // storage_volume
	<c:forEach items="${storageList}" var="storage">
	   list.push("${storage.storage_code}");
	</c:forEach>
	
   // Swiper API 변수
   let slider;
   $(document).ready(function() {
      // ProductList Ajax
      pageInit();
      // CouponList Ajax
      couponList();
      // Swiper API 설정
      slider = new Swiper('.swiper-container',{
         spaceBetween : 30, // 슬라이드간 간격
         // ★동적로딩 설정
         lazy : {
            loadPrevNext : true // 이전, 다음 이미지는 미리 로딩
         },
         effect : 'cube',
         autoHeight : false,
         // 페이징 설정
         
         // 네비게이션 설정
         navigation : {
            nextEl : '.swiper-button-next', // 다음 버튼 클래스명
            prevEl : '.swiper-button-prev', // 이번 버튼 클래스명
         },
      }); // End Swiper
      
      // 프리미엄 서비스
      $("input[name='premium']").change(function(){
    	// Y일때 5000원추가
    	// 이거 너무 IF 많이 들어가야됌 일단 ㄱㄷ
    	$('#hiddenOfferPremium').val($(this).val());
    	 if($(this).val() == "Y"){
    		 // 라지 플러스일때는 그대로 5000원
    		 if($('.swiper-slide-active').data("index") == "f20"){
    			 	storage_price = 5000;
    			 	$('#hiddenOfferPrice').val(storage_price);
    	    		$('#hiddenOfferDiscountPrice').val(storage_price);
    	    		$('#fixedDiscountPrice').html("상담문의"); // 감산될 가격
    	            $('#fixedPrice').html("상담문의"); // 원래가격
    		 }else {
    			storage_price = storage_price + 5000;
    	    	$('#hiddenOfferPrice').val(storage_price);
    	    	$('#hiddenOfferDiscountPrice').val(storage_price);
    	    	$('#fixedDiscountPrice').html("스토리지이용가격 : " + storage_price + '원'); // 감산될 가격
    	        $('#fixedPrice').html("할인전가격" + storage_price + '원'); // 원래가격
    		 }
    	 } else {
	    		if($('.swiper-slide-active').data("index") == "f20"){
	    			storage_price = 0;
	 			 	$('#hiddenOfferPrice').val(storage_price);
	 	    		$('#hiddenOfferDiscountPrice').val(storage_price);
	 	    		$('#fixedDiscountPrice').html("상담문의"); // 감산될 가격
	 	            $('#fixedPrice').html("상담문의"); // 원래가격
				}
	    		else{
	    			storage_price =  storage_price - 5000;
	    			$('#hiddenOfferPrice').val(storage_price);
	     	    	$('#hiddenOfferDiscountPrice').val(storage_price);
	     	    	$('#fixedDiscountPrice').html("스토리지이용가격 : " + storage_price + '원'); // 감산될 가격
	     	        $('#fixedPrice').html("할인전가격" + storage_price + '원'); // 원래가격
	    		}
    	 }
      });
      
      // Laundry 신청 미신청 여부
      $('#laundryInfoList').hide();
      	$("input[name='wash']").change(function(){
      		//여기서 살포시 세탁물품 배열이랑 총 물품가격 다 초기화 시켜준 다음
      		laundryArrayList = new Array();
      		totalLaundryPrice = 0;
			if($(this).val() == 'N'){
				// 세탁서비스 정보 고르다가 갑자기 안한다고 하면 다 초기화 시켜줌 ㅅㅂ 개같네 여기 나중에 컨트롤러에 옮길때 value값 신경써야됌
				$('#hiddenOfferLaundryProduct').removeAttr("value");
				$('.totalLaundryCount').attr("value", " ");
				$('#memberTotalPrice').html("총 0 원");	
				$('#laundryInfoList').hide();
				$('#hiddenOfferWash').val("N");
				$('#fixedLaundry').html("세탁물품가격");
				$('#hiddenLaundryTotalPrice').val("0"); // 히든 세탁서비스 총 가격
			}else{
				// Y눌러도 일단 N누르고 Y눌렀을테니 바로 초기화 시켜버리기
				$('#hiddenOfferWash').val("Y");
				$('.totalLaundryCount').attr("value", "0");
				$('#memberTotalPrice').html("총 0 원");
				$('#laundryInfoList').show();
				$('#hiddenLaundryTotalPrice').val("0"); // 히든 세탁서비스 총 가격
			}
		});
      	
      	// Reset Button
      	$('#resetBtn').click(function(){
      		productArrayList = new Array();
        	$('#hiddenOfferPrice').attr("value", " "); // 현재가격 공백
        	$('#hiddenOfferDiscountPrice').attr("value", " "); // 감산 될 가격 공백
        	$('#hiddenOfferProduct').attr("value", productArrayList); // 물품 리스트 다시 초기화
        	$('#hiddenOfferRental').attr("value", " "); // 렌탈도 초기화
        	$('.count').attr("value", "0"); // $('input:number[class="count"]')'.val()초기화
        	$('#hiddenOfferStorageCode').attr('value','a10'); // storage_code 값 슬림으로 다시 초기화
        	totalVolume = 0; // 현재 고객 가격 다 초기화
        	slider.slideTo($('.swiper-slide').data("id")*1 , 1000); // index 0 으로 이동
        	$('#nowInfo').html('<br>총 물품 : 현재 아무것도 없습니다 <br /><br /> 고객님의 물품 총 부피는 = ' + totalVolume + 'cm³ 입니다');
        	$('#fixedStorageName').html("슬림 / " + $('#hiddenOfferDate').val() + '개월 약정'); // 
        	$('#fixedPrice').html("");
        	$('#fixedDiscountPrice').html("현재가격54000원");
        });
      	
      	// ---- 포장서비스 ---- // 
      	// 처음엔 다 숨겼다가
      	$('#pickupBoxCount').hide();
      	$('#pickupInfo').hide();
      	// 포장서비스 유무
      	$('input:radio[name="pickupService"]').change(function(){ // 저 name의 radio가 바뀔때 마다
      		if($(this).val() == 'Y'){
      			$('#pickupInfo').show();
      		}else { // N 도중에 누르면 다 초기화
      			$('#hiddenFloorValue').removeAttr("value");
      			$('#hiddenBoxCount').removeAttr("value");
      			$("#hiddenPickuptime").val("AM 08:00 ~ 12:00");
      			parseInt($('#floor').val(0));
      			parseInt($('#boxCount').val(0));
      			$("input:radio[name='pickupService']").removeAttr('checked');
			 	$("input:radio[name='boxService']").removeAttr('checked');
			 	$('#pickupInfo').hide();
			 	$('#pickupBoxCount').hide();
      		}
      	});
      	// 박스 카운트
      	$('input:radio[name="boxService"]').change(function(){
      		if($(this).val() == 'Y'){
      			$('#pickupBoxCount').show();
      		}else {
      			$('#pickupBoxCount').hide();
      			$('#hiddenBoxCount').removeAttr("value");
      			$('#boxCount').val("");
      			$('#fixedOther').html("기타")
      		}
	     });
      	// offer_date 넣어줄때 검증
      	$('input:radio[name="offerDate"]').change(function(){
      		if(($(this).val()) == 1){
  				$('#hiddenOfferDate').val("1");
  				$('#fixedStorageName').html($('.swiper-slide-active').data("name") + ' / ' + $('#hiddenOfferDate').val() + '개월 약정'); // 스토리지 이름 및 약정
  			} else if($(this).val() == 3) {
  				$('#hiddenOfferDate').val("3");
  				$('#fixedStorageName').html($('.swiper-slide-active').data("name") + ' / ' + $('#hiddenOfferDate').val() + '개월 약정'); // 스토리지 이름 및 약정
  			} else if($(this).val() == 6){
  				$('#hiddenOfferDate').val("6");
  				$('#fixedStorageName').html($('.swiper-slide-active').data("name") + ' / ' + $('#hiddenOfferDate').val() + '개월 약정'); // 스토리지 이름 및 약정
  			} else if($(this).val() == 12){
  				$('#hiddenOfferDate').val("12");
  				$('#fixedStorageName').html($('.swiper-slide-active').data("name") + ' / ' + $('#hiddenOfferDate').val() + '개월 약정'); // 스토리지 이름 및 약정
  			}
      	});
      	
      	// 견적서 뽑기
		$('#offerInsertBtn').click(function () {
           	// 이용기간 radio 체크 안되있을때
           	if($('#hiddenOfferDate').val() == "" || $('#hiddenOfferDate').val() == " " || $('#hiddenOfferStart').val() == ""){
           		alert("이용날짜 및 이용기간을 체크해주세요");
           		$('#datePick').focus();
           		return false;
           	}
           	
           	// product 비어있을때
   	        if($('#hiddenOfferProduct').val() == ""){
   	      		alert("선택 된 물품이 없습니다.");
   	      		$('.productName').focus();
				return false;
   	      	} else{
   	      		$('#offerProduct').html($('#hiddenOfferProduct').val());
   	      	}
           	// 세탁서비스 Y인데 물품 없을때
   	        if($('#hiddenOfferWash').val() == "Y"){
   	        	// 세탁서비스가 아무것도 없거나 삭제하고 지우고 값이 공백일때
           		if($('#hiddenOfferLaundryProduct').val() == "" || $('#hiddenOfferLaundryProduct').val() == " "){
           			alert("세탁서비스 신청상태에서 선택 된 세탁류가 없습니다");
           			$('.totalLaundryCount').focus();
           			return false;
           		}else {
           			$('#offerLaundry').html($('#hiddenOfferLaundryProduct').val());
           			$('#offerLaundryPrice').html($('#hiddenLaundryTotalPrice').val() + "원")// 세탁서비스 총 가격
           		}
           	} else{
           		$('#offerLaundry').html("신청 X");
           		$('#offerLaundryPrice').html("0원")// 세탁서비스 총 가격
           	}
           	
           	// 지점 선택 안했을때랑 선택했는데 쿠폰 선택을 안했을 경우
           	if($('#hiddenCouponCode').val() == "" || $('#hiddenCouponCode').val() == " "){
           		alert("지점 선택 후 쿠폰사용 유무를 입력해주세요.");
           		$('#normalPrice').focus();
           		return false;
           	} else{
           		if(($('.swiper-slide-active').data("index")) == "f20"){
           			$('#offerCoupon').html($('#hiddenCouponName').val()); 
   	      			$('#offerPrice').html("상담문의");
   	      			$('#offerFirstPrice').html("상담문의");
   	      		} else{
   	      			// 예상 월 이용금액
               		$('#offerPrice').html($('#hiddenOfferPrice').val() + "원");
               		// 예상 첫달 이용금액
               		$('#offerFirstPrice').html($('#hiddenOfferDiscountPrice').val() + "원");
               		// 쿠폰 이름
               		$('#offerCoupon').html($('#hiddenCouponName').val()); 
   	      		}
           	}
           	
           	// 픽업 서비스 신청했는데 층수가 0층일때 + 희망날짜 / 시간 설정안했을때 + 박스 신청했는데 갯수가 0일때 alert
           	if($('input:radio[name="pickupService"]:checked').val() == "Y"){
           		if(parseInt($('#floor').val()) == 0) {
           			alert("Error : 403 Forbidden");
           			$('#floor').focus();
           			return false;
           		} else if($('#hiddenPickuptime').val() == ""){
           			alert("픽업서비스 희망날짜와 시간을 선택해주세요.");
           			return false;
           		} else{
           			if($('input:radio[name="boxService"]:checked').val() == "Y"){
           				if(parseInt($('#boxCount').val()) == 0){
           					alert("박스 구매는 0개 이상부터 가능합니다");
           					return false;
           				}
           			}
           			pickupServiceFnc(); // 층수 + 박스value를 #hiddenOfferPickup에 Append 해줌
           			
           			$('#offerPickup').html('정보 및 수량 : ' + $('#hiddenOfferPickup').val() + ' / 희망날짜 : ' + $('#hiddenPickupDate').val() + ' / 희망시간 :  ' + $('#hiddenPickuptime').val());
           			$('#offerOtherPrice').html(parseInt($('#hiddenBoxPrice').val()) + "원"); 
           		}
           	} else {
           		$('#hiddenPickupDate').val("2999-12-31");
           		$('#hiddenPickuptime').val("");
           		$('#offerPickup').html("신청 X");
           	}
           	
           	// 렌탈용품 비어있을땐 렌탈 X
           	if($('#hiddenOfferRental').val() == "" || $('#hiddenOfferRental').val() == " "){
           		$('#offerRental').html("신청 X");
           	} else{
           		$('#offerRental').html($('#hiddenOfferRental').val());
           	}
           	
           	var useCountStorageCode = $('#hiddenOfferStorageCode').val();
           	var useCountStoreCode = $('#hiddenStoreCode').val();
           	// 여기서 스토리지 비어있나 검증하기
           	$.ajax({
				  url : 'useCountStorage',
				  data : {
					  store_code : useCountStoreCode,
					  storage_code : useCountStorageCode
				  },
				  dataType: "JSON",
				  method : "POST",
				  success : function(data){
					  console.log(data);
					  if(data.cnt == 0){
						  alert("해당 지점의 빈 스토리지가 남아있지 않습니다 상담문의 해주세요.");
						  return false;
					  } else {
						  	$('#offerModal').modal("show");
						  	var addr = $('#hiddenStoreAddr').val();
							var mapContainer2 = document.getElementById('modalInMap')// 지도를 표시할 div 
							mapOption2 = {
							center: new kakao.maps.LatLng(35.869095969748685, 128.59339734624666),
							      level: 4 // 지도의 확대 레벨
							  };  
							setTimeout(function() {
								// 지도를 생성합니다    
								var map2 = new kakao.maps.Map(mapContainer2, mapOption2); 
								
								// 주소-좌표 변환 객체를 생성합니다
								var geocoder2 = new kakao.maps.services.Geocoder();
								
								// 주소로 좌표를 검색합니다
								geocoder2.addressSearch(addr, function(result, status) {
								
								    // 정상적으로 검색이 완료됐으면 
								     if (status === kakao.maps.services.Status.OK) {
								
								        var coords2 = new kakao.maps.LatLng(result[0].y, result[0].x);
								
								        // 결과값으로 받은 위치를 마커로 표시합니다
								        var marker2 = new kakao.maps.Marker({
								            map: map2,
								            position: coords2
								        });
								
								        // 인포윈도우로 장소에 대한 설명을 표시합니다
								        var infowindow2 = new kakao.maps.InfoWindow({
								            content: '<div style="width:150px;text-align:center;padding:6px 0;">지점위치</div>'
								        });
								        infowindow2.open(map2, marker2);
								
								   	 // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
								    	    map2.setCenter(coords2);
									    }
									});
								}, 500);
								var storageTotalPrice = parseInt($('#hiddenOfferDiscountPrice').val()); // 스토리지이용 총 금액
								var laundryTotalPrice = parseInt($('#hiddenLaundryTotalPrice').val()); // 세탁서비스 총 금액
								var boxTotalPrice = parseInt($('#hiddenBoxPrice').val()); // 박스 총 가격
								$('#offerPremium').html($('#hiddenOfferPremium').val()); // 프리미엄 서비스 신청 유무
								// 세탁서비스 총 가격 + hiddenOfferPrice에 더해주기
								$('#offerTotalPrice').html($('#'))
								$('#storeWay').html("지하철 : " + $('#hiddenStoreWay').val()); // 오시는길
								$('#storeBus').html("버스 : " + $('#hiddenStoreBus').val()); // 버스
								$('#storeEmail').html("지점 이메일 : "+$('#hiddenStoreEmail').val()); // 지점 이메일
								$('#storeTel').html("전화번호 : "+$('#hiddenStoreTel').val()); //지점 전화번호
								$('#offerStorageSize').html($('.swiper-slide-active').data("name")); // 스토리지 이름
								$('#offerDate').html($('input:radio[name="offerDate"]:checked').val() + '개월'); // 이용기간
								$('#offerStore').html($('#hiddenStoreName').val()); // 이용지점
								// 총가격 보여주고 DB넣을때 다 더해주기
								$('#offerTotalPrice').html(storageTotalPrice + laundryTotalPrice + boxTotalPrice + '원'); // 세탁서비스 + 스토리지 이용금액
								$('#hiddenOfferDiscountPrice').val(storageTotalPrice + laundryTotalPrice + boxTotalPrice); // DB에 들어갈거
					  }
				  },
				  error: function(err){
					  console.log(err);
				  }
			  });
          	
			
            });
      	// 여기는 selectBox 및 date 바뀔때 value 바뀌는 함수들
      	
      	//offer_start
      	$('#datePick').change(function(){
      		$('#hiddenOfferStart').val($(this).val());
      		$('#hiddenPickupDate').val($(this).val());
      	})
      	
      	// pickup_time
      	$('#pickupTimeSelect').change(function() {
      		$('#hiddenPickuptime').val($(this).val());
      	})
      	
      	// DB 처리
      	$('#insertOfferBtn').click(function(){
      		$('#offerModal').modal('hide');
      		$('#frm').submit();
      	});

   });
   var resultPickupService = "";
   var floorService = "";
   $(document).ready(function(){
	   $('#floor').change(function(){
			var floor = parseInt($('#floor').val());
			if(floor < -2){
				alert("지하 2층 이하는 상담문의 부탁드립니다.");
				parseInt($('#floor').val(0));
				$('#hiddenOfferPickup').attr("value", " ");
			} else {
				floorService = "층수:" + floor + "층 ";
				$('#hiddenFloorValue').val(floorService);
			}
		});
	   
	   $('#boxCount').change(function(){
			var boxCount = parseInt($('#boxCount').val());
			var resultBoxCount = "";
			if(boxCount < 0){
				alert("0개 밑으론 신청할 수 없습니다.");
				parseInt($('#boxCount').val(0));
				$('#hiddenBoxCount').val("");
				$('#fixedOther').html("기타");
			} else {
				$('#fixedOther').html("기타 가격 : " + boxCount * 6600 + "원");
				$('#hiddenBoxPrice').val(boxCount * 6600);
				resultBoxCount = "박스갯수:" + boxCount + "개" ;
				$('#hiddenBoxCount').val(resultBoxCount)
			}
		});
   })
   // 견적뽑기 누르면 호출되는 함수 (포장서비스의 값들을 다 가공해줌)
   function pickupServiceFnc(){
	   var floor = $('#hiddenFloorValue').val();
	   var box = $('#hiddenBoxCount').val();
	   $('#hiddenOfferPickup').val(floor + box);
	   $('#hiddenPickuptime').val($('#pickupTimeSelect').val());
   }
   
   function couponList(){
	   $.ajax({
		   url: 'couponList',
		   dataType: 'json',
		   type: 'GET',
		   success: function(data){
			   for(var i = 0; i<data.length; i++){
				   	var store_code = '#' + data[i].store_code;
			 		// 결과 다 Append 후 Hide 작업
			/* 	   $(store_code).html(
						'<label class="offerLabel">일반요금<input type="radio" class="normal'+data[i].store_code+'" name="discount'+data[i].store_code+'" id="normalPrice" value="no" onclick="discount(\''+data[i].store_code+'\')"></label>'
					); */
			 		$(store_code).append(
			 			'<label class="offerLabel" style="margin-left: 30px;">'+data[i].coupon_name+''
			 			+'<input type="radio" class="discount'+data[i].store_code+'" name="discount'+data[i].store_code+'" id="discountPrice" value="yes" onclick="discount(\''+data[i].coupon_code+'\')"></label>'
						+ '<input type="hidden" id="hiddenDiscount'+ data[i].coupon_code +'" value="'+data[i].coupon_discount+'">'
						+ '<input type="hidden" id="couponCode'+ data[i].coupon_code +'" value="'+data[i].coupon_code+'">'
						+ '<input type="hidden" id="couponName'+data[i].coupon_code +'" value="'+data[i].coupon_name+'">'
			 		);
			 		
			   }
		 		// 전체 결과 일단 숨기고 kakao map 에서 누르면 보여줌
			   $('.coupon').hide();
		   },
		   error : function(err) {
               console.log(err);
            }
         });
	}
	
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
                                 '<li class="divisionBtnliTag" style="margin: 10px; width: 25%">'
                                    // 물품 별 이미지 
                                 +'<button id="deleteProduct'+result[i].product_code+'" class="deleteProduct" onclick="deleteProductList(\''+result[i].product_code+'\')"> - </button>'
                                 + '<img src="${pageContext.request.contextPath }/resources/product_img/' + result[i].product_image + '" onclick="intoProduct(\''+result[i].product_code+'\')">'
                                 + '<br>'
                                    // 물품 별 이름 input text
                                 + '<input type="text" name="offer_product" class="productName" id="productName'+result[i].product_code+'" value="'+result[i].product_name+'"><br>'
                                 + '</h5><input id="productCount'+result[i].product_code+'" class="count" type="number" name="count" value="0"  readonly="readonly" min="0" max="10"><br>' // 물품 별 갯수
                                 + '<input type="hidden" id="productVolume'+result[i].product_code+'" value="'+result[i].product_volume+'">' // 물품별 부피 hidden
                                 /* + '<input type="button" onclick="intoProduct(\'' // 담기 버튼 Onclick
                                 + result[i].product_code 
                                 + '\')" value="담기" class="btn btn-primary btn-lg">*/
                                 + '</li>');

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
  
   // 카테고리 별 물건들 담는 button 
   function intoProduct(product_code) {
      product_count = parseInt($('#productCount'+product_code).val()); // 물품별 갯수 count
      product_count = product_count + 1;
      $('#productCount'+product_code).attr('value', product_count);
      var product_name = $('#productName'+product_code).val(); // 물품별 이름
      product_volume = parseInt($('#productVolume' + product_code).val()); // 물품별 부피
      // 원래 있었던 물품과 담긴 물품의 총 부피를 담는 변수  (어짜피 눌러서 갯수 plus 되는거면 전역변수에 있던 총 부피에서 그 물품의 부피만 더해주면 되는 부분)
      totalVolume = totalVolume + product_volume;
      // 배열 물품 리스트
      var resetList = "";   
      // 배열의 value값 변수에 담기
      productArrayList[product_name] = product_name + ' ' + product_count +'개';
      
      for(insertProductList in productArrayList){
         resetList += productArrayList[insertProductList] + " "   
      }
      // 함수 밖의 전역함수에서 스토리지 코드 들고오기
      for(var i = 0; i < list.length; i++){
      // 슬림의 볼륨이 오바 되면 이미지 이동 후 input hidden 스토리지 value 변경 (이미지가 넘어가는 조건)
         if($('#storageVolumn'+list[i]).val() < totalVolume){
            slider.slideTo($('.swiper-slide').data("id")*1 + i+1, 1000);
         }
      };
      // 스토리지 가격 (현재 이미지의 Div 태그에data-Index 값 으로 구별해서 hidden에 담아주기)
      storageImageIndex = $('.swiper-slide-active').data("index");
      if(storageImageIndex == "f20"){ // 라지플러스 일때
    	  storage_price = 0;
    	  $('#fixedDiscountPrice').html("상담문의");
	      $('#fixedPrice').html("상담문의");
      } else{
    	  storage_price = parseInt($('#hiddenStoragePrice' + storageImageIndex ).val()) ;
    	  $('#fixedDiscountPrice').html("스토리지이용가격 : " + storage_price + '원'); // 감산될 가격
          $('#fixedPrice').html("할인전가격 : " + storage_price + '원'); // 원래가격
      };
     	$('#fixedStorageName').html($('.swiper-slide-active').data("name") + ' / ' + $('#hiddenOfferDate').val() + '개월 약정'); // 스토리지 이름 및 약정
    	$('#hiddenOfferProduct').val(resetList); 
      	$('#hiddenOfferStorageCode').val($('.swiper-slide-active').data("index"));
      	$('#hiddenOfferPrice').val(storage_price);
      	$('#hiddenOfferDiscountPrice').val(storage_price)
      	$('#nowInfo').html('<br>총 물품 : ' + $('#hiddenOfferProduct').val() + '<br /><br /> 고객님의 물품 총 부피는 = ' + totalVolume + 'cm³ 입니다')
   }
   
   // 삭제버튼 Function (매개변수 Product테이블의 product_code)
   function deleteProductList(product_code){
         var product_name = $('#productName'+product_code).val(); // 물품별 이름
         // 물건 부피 값
         product_volume = $('#productVolume' + product_code).val();
         // Int로 형변환 해주고
         product_del = parseInt($('#productCount'+product_code).val());
         // 누를때 마다 저장되어 있던 value에서 -1 씩 해주고
         if(product_del == 0){
	       	  alert("0개 이하는 불가능 합니다");
	    	  product_del = 0;
	    	  product_volume = 0;
         } else {
        	 product_del = product_del - 1;
         }
         
         // 삭제 된 결과를 Input number value에 담기
         $('#productCount'+product_code).attr('value', product_del);
         // 총 담겨져 있는 total 부피에서 그 물품의 부피만 빼기
         totalVolume = totalVolume - product_volume;
         
         // 현재 볼륨이 각 스토리지 볼륨보다 작아지게 되면 이미지 이동 후 input hidden 스토리지 value 변경 (이미지가 넘어가는 조건)
         if($('#storageVolumn'+list[0]).val() > totalVolume){
            slider.slideTo($('.swiper-slide').data("id")*1 , 1000); // index 0
         } else if ($('#storageVolumn'+list[1]).val() > totalVolume){
            slider.slideTo($('.swiper-slide').data("id")*1 + 1, 1000); // index 1
         } else if ($('#storageVolumn'+list[2]).val() > totalVolume){
            slider.slideTo($('.swiper-slide').data("id")*1 + 2, 1000); // index 2
         } else if ($('#storageVolumn'+list[3]).val() > totalVolume){
            slider.slideTo($('.swiper-slide').data("id")*1 + 3, 1000); // index 3
         } else if ($('#storageVolumn'+list[4]).val() > totalVolume){
            slider.slideTo($('.swiper-slide').data("id")*1 + 4, 1000); // index 4
         } else if ($('#storageVolumn'+list[4]).val() < totalVolume){
            slider.slideTo($('.swiper-slide').data("id")*1 + 5, 1000); // index 5
         }
         // insert 된 배열 삭제 처리
         // 배열 물품 리스트
         var delProduct = "";
         // 배열의 value값 변수에 담기
         productArrayList[product_name] = product_name + ' ' + product_del +'개';
         for(deleteItems in productArrayList){
        	 if (product_del >= 1){
        		 // 0이 안되면 계속 그 물품을 delProduct 변수에 담아주고
            	 delProduct += productArrayList[deleteItems] + " "
              } else if (product_del == 0){
            	  // 0이 되면 count가 0이 된 배열을 삭제시키고 그 삭제 시킨 결과를 delProduct를 담아줌
            	  delete productArrayList[product_name];
            	  productArrayList[product_name] = " ";
            	  delProduct += productArrayList[deleteItems] + "";
            	  $('#hiddenOfferProduct').val().replace();
              } 
         }
        
        storageImageIndex = ($('.swiper-slide-active').data("index"));
        storage_price = $('#hiddenStoragePrice' + storageImageIndex ).val();
     	// 스토리지 가격 (현재 이미지의 Div 태그에data-Index 값 으로 구별해서 hidden에 담아주기)
        storageImageIndex = $('.swiper-slide-active').data("index");
        if(storageImageIndex == "f20"){ // 라지플러스 일때
      	  storage_price = 0;
      	  $('#fixedDiscountPrice').html("상담문의");
  	      $('#fixedPrice').html("상담문의");
        } else{
      	  storage_price = parseInt($('#hiddenStoragePrice' + storageImageIndex ).val()) ;
      	  $('#fixedDiscountPrice').html("스토리지이용가격 : " + storage_price + '원'); // 감산될 가격
            $('#fixedPrice').html("할인전가격 : " + storage_price + '원'); // 원래가격
        };
        $('#fixedStorageName').html($('.swiper-slide-active').data("name") + ' / ' + $('#hiddenOfferDate').val() + '개월 약정'); // 스토리지 이름
         // 삭제 된 결과를 value에 담기
        $('#hiddenOfferStorageCode').val($('.swiper-slide-active').data("index"));
        $('#hiddenOfferProduct').val(delProduct);
        $('#hiddenOfferPrice').val(storage_price);
        $('#hiddenOfferDiscountPrice').val(storage_price);
        $('#nowInfo').html('총 물품 : ' + $('#hiddenOfferProduct').val() + '<br /><br /> 고객님의 물품 총 부피는 = ' + totalVolume + 'cm³ 입니다');
        
        
   };
   
   let rentalArrayList = new Array();
   // 렌탈용품 Button Function
   function rentalService(rental_code){
	   var rentalVolume = parseInt($('#rentalVolume' + rental_code).val()); // 렌탈 부피
	   var rentalList = ""; // 배열 담을 그릇
	   var rentalName = $('#rentalName' + rental_code).val(); // 렌탈물품 이름
	   var rentalCount = parseInt($('#rentalCount' + rental_code).val()); // 렌탈 코드
	   var rentalPrice = parseInt($('#rentalPrice' + rental_code).val());
	   rentalCount = rentalCount + 1;
	   // 렌탈 물품 추가시 전역 부피 계산
	   totalVolume = totalVolume + rentalVolume;
	   var rentalCode = $('#rental' + rental_code).val();
	   rentalArrayList[rentalName] = rentalName + ' '  + rentalCount + '개' ;
	   for(insertRentalList in rentalArrayList) {
			   rentalList += rentalArrayList[insertRentalList] + " ";
			   $('#rentalCount' + rental_code).attr("value", rentalCount);
		}
		// 함수 밖의 전역함수에서 스토리지 코드 들고오기
	    for(var i = 0; i < list.length; i++){
	    // 슬림의 볼륨이 오바 되면 이미지 이동 후 input hidden 스토리지 value 변경 (이미지가 넘어가는 조건)
	    	if($('#storageVolumn'+list[i]).val() < totalVolume){
	            slider.slideTo($('.swiper-slide').data("id")*1 + i+1, 1000);
	         }
	      };
	      // 스토리지 가격 (현재 이미지의 Div 태그에data-Index 값 으로 구별해서 hidden에 담아주기)
	      storageImageIndex = ($('.swiper-slide-active').data("index"));
	      if(storageImageIndex == "f20"){ // 라지플러스 일때
	    	  storage_price = 0;
	    	  $('#fixedDiscountPrice').html("상담문의");
		      $('#fixedPrice').html("상담문의");
	      } else{
	    	  storage_price = parseInt($('#hiddenStoragePrice' + storageImageIndex ).val()) + rentalCount * rentalPrice ;
	    	  $('#fixedDiscountPrice').html("스토리지이용가격 : " + storage_price + '원'); // 감산될 가격
	          $('#fixedPrice').html("할인전가격 : " + storage_price + '원'); // 원래가격
	      };
	      $('#fixedStorageName').html($('.swiper-slide-active').data("name") + ' / ' + $('#hiddenOfferDate').val() + '개월 약정'); // 스토리지 이름
		  $('#hiddenOfferStorageCode').val($('.swiper-slide-active').data("index"));
		  $('#hiddenOfferRental').val(rentalList);
		  $('#hiddenOfferPrice').val(storage_price);
		  $('#hiddenOfferDiscountPrice').val(storage_price);
		  $('#nowInfo').html('총 물품 : ' + $('#hiddenOfferProduct').val() + '<br /><br /> 고객님의 물품 총 부피는 = ' + totalVolume + 'cm³ 입니다');
   }
   // 렌탈물품 삭제 Btn
   function deleteRental(rental_code){
	   var rentalVolume = parseInt($('#rentalVolume' + rental_code).val()); // 렌탈 부피
	   var rentalPrice = parseInt($('#rentalPrice' + rental_code).val());
	   var rentalCount = parseInt($('#rentalCount' + rental_code).val());
	   var rentalName = $('#rentalName' + rental_code).val();
	   var rentalCode = $('#rental' + rental_code).val();
	   // 0개 이하로 가면 alert창 뜨고 값 더이상 안내려가게 막기
	   if(rentalCount == 0){
	       	alert("0개 이하는 불가능 합니다");
	       	rentalCount = 0;
	       	rentalVolume = 0;
      	} else {
    	  	rentalCount = rentalCount - 1;
      	}
	   	totalVolume = totalVolume - rentalVolume;
		$('#rentalCount' + rental_code).attr("value", rentalCount);
		// 스토리지 부피랑 총 렌탈 부피 + 물품부피까지 더한걸 비교해서 슬라이드 이미지 이동
		if($('#storageVolumn'+list[0]).val() > totalVolume){
            slider.slideTo($('.swiper-slide').data("id")*1 , 1000); // index 0
         } else if ($('#storageVolumn'+list[1]).val() > totalVolume){
            slider.slideTo($('.swiper-slide').data("id")*1 + 1, 1000); // index 1
         } else if ($('#storageVolumn'+list[2]).val() > totalVolume){
            slider.slideTo($('.swiper-slide').data("id")*1 + 2, 1000); // index 2
         } else if ($('#storageVolumn'+list[3]).val() > totalVolume){
            slider.slideTo($('.swiper-slide').data("id")*1 + 3, 1000); // index 3
         } else if ($('#storageVolumn'+list[4]).val() > totalVolume){
            slider.slideTo($('.swiper-slide').data("id")*1 + 4, 1000); // index 4
         } else if ($('#storageVolumn'+list[4]).val() < totalVolume){
            slider.slideTo($('.swiper-slide').data("id")*1 + 5, 1000); // index 5
         }
		var delRental = "";
        // 배열의 value값 변수에 담기
        rentalArrayList[rentalName] = rentalName + '' + rentalCount +'개';
        for(deleteItems in rentalArrayList){
       	 if (rentalCount >= 1){
       		 // 0이 안되면 계속 그 물품을 delRental 변수에 담아주고
           	 delRental += rentalArrayList[deleteItems] + ""
             }else if (rentalCount == 0){
           	  	// 0이 되면 count가 0이 된 배열을 삭제시키고 그 삭제 시킨 결과를 delRental를 담아줌
           	  	delete rentalArrayList[rentalName];
           	  	rentalArrayList[rentalName] = " ";
           	  	delRental += rentalArrayList[deleteItems] + ""
           		$('#hiddenOfferRental').val().replace();
             }
        }
        storageImageIndex = ($('.swiper-slide-active').data("index"));
        if(storageImageIndex == "f20"){
        	// 라지플러스면 price 상담문의로 변경
	    	storage_price = 0;
		  	$('#fixedDiscountPrice').html("상담문의");
		    $('#fixedPrice').html("상담문의");
	      } else{
	    	  // 나머지는 렌탈 count * 가격에서 현재 선택되어있는 스토리지 data-index값을 읽어서 더해줌
	    	  storage_price = parseInt($('#hiddenStoragePrice' + storageImageIndex ).val()) + rentalCount * rentalPrice ;
	    	  $('#fixedDiscountPrice').html("스토리지이용가격 : " + storage_price + '원'); // 감산될 가격
	          $('#fixedPrice').html("할인전가격 : " + storage_price + '원'); // 원래가격
	      };
        // 삭제 된 결과를 value에 담기
       $('#fixedStorageName').html($('.swiper-slide-active').data("name") + ' / ' + $('#hiddenOfferDate').val() + '개월 약정'); // 스토리지 이름
       $('#hiddenOfferRental').val(delRental);
       $('#hiddenOfferStorageCode').val($('.swiper-slide-active').data("index"));
       $('#hiddenOfferPrice').val(storage_price);
       $('#hiddenOfferDiscountPrice').val(storage_price);
       $('#nowInfo').html('총 물품 : ' + $('#hiddenOfferProduct').val() + '<br /><br /> 고객님의 물품 총 부피는 = ' + totalVolume + 'cm³ 입니다');
   }
   
// 여기부터 수정
   // 세탁서비스 function
   function laundryTableInsert(laundry_code){
	   var laundryName = $('#laundryName' + laundry_code).val(); // 이름
	   var laundryPrice = parseInt($('#laundryPrice' + laundry_code).val());  // 물품별 가격
	   var laundryCount = parseInt($('#laundryCount' + laundry_code).val()); // 세탁물 갯수
	   var resultLaundryList = "";
	   laundryCount = laundryCount + 1;
	   $('#laundryCount'+laundry_code).attr('value', laundryCount);
	   totalLaundryPrice = totalLaundryPrice + laundryPrice;	
	   laundryArrayList[laundryName] = laundryName + ' ' + laundryCount + '개';
	   for(insertLaundry in laundryArrayList) {
		   resultLaundryList += laundryArrayList[insertLaundry] + " ";
	   }
	   $('#fixedLaundry').html("세탁서비스 가격 : " + totalLaundryPrice + "원");
	   $('#hiddenOfferLaundryProduct').val(resultLaundryList);
	   $('#memberTotalPrice').html('총 ' + totalLaundryPrice + ' 원');
	   $('#hiddenLaundryTotalPrice').val(totalLaundryPrice); // 히든 세탁서비스 총 가격
   }
   
   function deleteLaundry(laundry_code){
	  var laundryName = $('#laundryName' + laundry_code).val(); // 이름
	  var laundryPrice = parseInt($('#laundryPrice' + laundry_code).val());  // 물품별 가격
	  var laundryCount = parseInt($('#laundryCount' + laundry_code).val());
	  if(laundryCount == 0){
	       	alert("이미 0 개 입니다");
	       	laundryCount = 0;
	       	laundryPrice = 0;
    	} else {
    		laundryCount = laundryCount - 1;
    	}
	  $('#laundryCount' + laundry_code).attr("value", laundryCount);
	  totalLaundryPrice = totalLaundryPrice - laundryPrice;
	  var delLaundry = "";
      // 배열의 value값 변수에 담기
      laundryArrayList[laundryName] = laundryName + ' ' + laundryCount +'개';
      for(deleteItems in laundryArrayList){
     	 if (laundryCount >= 1){
     		 // 0이 안되면 계속 그 물품을 delProduct 변수에 담아주고	
         	 delLaundry += laundryArrayList[deleteItems] + " "
           }else if (laundryCount == 0){
         	  // 0이 되면 count가 0이 된 배열을 삭제시키고 그 삭제 시킨 결과를 delProduct를 담아줌
         		delete laundryArrayList[laundryName];
         		laundryArrayList[laundryName] = " ";
         		delLaundry += laundryArrayList[deleteItems] + ""
         		$('#hiddenOfferLaundryProduct').val().replace();
           }
      }
      $('#fixedLaundry').html("세탁서비스 가격 : " + totalLaundryPrice + "원");
	  $('#hiddenOfferLaundryProduct').val(delLaundry);	
	  $('#memberTotalPrice').html('총 ' + totalLaundryPrice + ' 원');
	  $('#hiddenLaundryTotalPrice').val(totalLaundryPrice); // 히든 세탁서비스 총 가격
   }
	// 망할 쿠폰
  	function discount(coupon_code){
		var store_code = $('#hiddenStoreCode').val(); // 각 스토어 코드
  		var normalPrice = parseInt($('#hiddenOfferPrice').val()); // 기존의 가격
		var discountPrice = parseInt($('#hiddenOfferDiscountPrice').val()); // 할인율을 받는 가격 변수
		var discount = parseFloat($('#hiddenDiscount'+coupon_code).val()); // 지점별 할인율
		console.log(discount)
		var coupon_code = $('#couponCode' + coupon_code).val(); // 쿠폰코드
		var coupon_name = $('#couponName' + coupon_code).val();
		storageImageIndex = ($('.swiper-slide-active').data("index"));
  		$("input[name='discount"+store_code+"']").change(function(){
  			console.log($(this).val());
				if($(this).val() == "no"){
			        if(storageImageIndex == "f20"){
			        	// 라지플러스면 price 상담문의로 변경 (라지플러스인데 일반요금을 할때 바로 5000원으로 변경)
				    	storage_price = 5000;
				    	$('#hiddenOfferDiscountPrice').val(storage_price);
					  	$('#fixedDiscountPrice').html("상담문의");
					    $('#fixedPrice').html("상담문의");
				      } else{
				    	// 할인율 X (기존 있던 normalPrice를 감산될 가격에 넣어줌)
						$('#hiddenOfferDiscountPrice').val(normalPrice);
						$('#hiddenCouponCode').attr("value", " ");
						$('#fixedDiscountPrice').html("스토리지이용가격 : " + normalPrice + '원'); // 감산될 가격
					    $('#fixedPrice').html("할인전가격 : " + normalPrice + '원'); // 원래가격
				      };
				      $('#hiddenCouponName').val("일반쿠폰");
				} else{ // 쿠폰을 쓸때
					// 쓸때도 라지플러스이면 걍 5000원이고 아니면 감산 시켜주고
					if(storageImageIndex == "f20"){
			        	// 라지플러스면 price 상담문의로 변경 (라지플러스인데 일반요금을 할때 바로 5000원으로 변경)
				    	storage_price = 5000;
				    	$('#hiddenOfferDiscountPrice').val(storage_price);
				    	$('#hiddenCouponName').val(coupon_name);
					  	$('#fixedDiscountPrice').html("상담문의");
					    $('#fixedPrice').html("상담문의");
				    } else{
				    	$('#hiddenOfferDiscountPrice').val(Math.ceil(normalPrice * discount));
						$('#hiddenCouponName').val(coupon_name);
						$('#fixedDiscountPrice').html("스토리지이용가격 : " + Math.ceil(normalPrice * discount) + '원'); // 감산될 가격
						$('#fixedPrice').html("할인전가격 : " + normalPrice + '원'); // 원래가격
				    }
			 	}
			$('#hiddenCouponCode').val(coupon_code); // 쿠폰코드도 넣고
		});
  	};
  	
  	
</script>
<style>
.self-banner-bottom {
	padding: 30px 0;
    background: #6a9eff;
    box-shadow: 0 -2px 7px 0 rgb(0 0 0 / 17%);
    z-index: 10;
    color: #fff;
}

#modalTable {
	width: 80%;
	border-collapse: separate;
	border-spacing: 1px;
	text-align: left;
	line-height: 2.5em;
	border-top: 2px solid #ccc;
	border-bottom: 2px solid #ccc;
	margin : 20px 10px;
	font-size: 14px;
	vertical-align: middle;
}

#modalTable > #modalTrTag > td:nth-child(2) {
  width: 350px;
  padding: 10px;
  vertical-align: top;
  border-bottom: 1px solid #ccc;
}

#pickupService{
	width: 100%;
	height: 100%;
}

#pickupService >  td {
    font-family: Montserrat;
	font-weight: bold;
    font-size: 15px;
    width: 50%;
}

#pickupServiceThTag {
	padding: 20px;
    font-family: Montserrat;
	font-weight: bold;
    font-size: 15px;
    width: 30%;
    height: 20%;
}

 .store-pick {
    	display: table;
    	width: 100%;
}
.store-list {
   	display: table-cell;
   	width: 50%;
}
.map {
  	display: table-cell;
 	width: 50%;
}

.deleteProduct {
   width: 24px;
    height: 24px;
    background: #5b87da;
    color: #fff;
    font-size: 24px;
    float: right;
    margin-right: 10%;
}
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
			            <div class="row" style="border: 1px solid #e1e1e1; border-radius: 5px; padding: 33px 40px 40px;">
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
			                                이삿짐 단기보관 &nbsp;&nbsp;<input type="checkbox">
			                           </label></li>
			                           <li class="active dropdown"><label class="offerLabel">
											해외 출장 &nbsp;&nbsp;<input type="checkbox">
			                           </label></li>
			                           <li class="active dropdown"><label class="offerLabel">
			                                작은 집 &nbsp;&nbsp;<input type="checkbox">
			                           </label></li>
			                           <li class="active dropdown"><label class="offerLabel">
			                                취미용품 보관 &nbsp;&nbsp;<input type="checkbox">
			                           </label></li>
			                           <li class="active dropdown"><label class="offerLabel">
			                                계절용품 &nbsp;&nbsp;<input type="checkbox">
			                           </label></li>
			                           <li class="active dropdown"><label class="offerLabel">
			                                사업용도 &nbsp;&nbsp;<input type="checkbox">
			                           </label></li>
			                           <li class="active dropdown"><label class="offerLabel">
			                                프라이버시 &nbsp;&nbsp;<input type="checkbox">
			                           </label></li>
			                           <li class="active dropdown"><label class="offerLabel">
			                                기타 &nbsp;&nbsp;<input type="checkbox">
			                           </label></li>
			                           <li class="active dropdown"><label class="offerLabel" style="padding : 0">
			                                 <input  type="text" placeholder='아이디를 입력하세요.' style="margin:0; border:0; color: black; background: none;">
			                           </label></li>
			                            
			                        </ul>
			                     </div>
			                  </div>
			               </div>
			            </div>
			         </div>
			   
			   </section>
			   <!-- /이용 목적 -->
			   <!-- 이용 기간 -->
			   <section class="def-section" id="clients-section">
			      <div class="container">
			         <div class="row" style="border: 1px solid #e1e1e1; border-radius: 5px; padding: 33px 40px 40px;">
			            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12"
			               style="width: 100%;">
			               <div class="home-clients">
			                  <h4>얼마나 오래 사용하실 계획이세요? <input type="date" id="datePick" pattern="YYYY/MM/DD"></h4>
			                  <div class="collapse navbar-collapse main-menu main-menu-2"
			                     id="main-menu">
			                     <ul class="nav navbar-nav">
			                        <!-- === top menu item === -->
			                        <li class="active dropdown"><label class="offerLabel">
			                             1개월 미만 &nbsp;&nbsp;<input type="radio" name="offerDate" value="1">
			                        </label></li>
			                        <li class="active dropdown"><label class="offerLabel">
			                             1개월 이상 &nbsp;&nbsp;<input type="radio" name="offerDate" value="1">
			                        </label></li>
			                        <li class="active dropdown"><label class="offerLabel">
			                             3개월 이상 &nbsp;&nbsp;<input type="radio" name="offerDate" value="3">
			                        </label></li>
			                        <li class="active dropdown"><label class="offerLabel">
			                             6개월 이상 &nbsp;&nbsp;<input type="radio" name="offerDate" value="6">
			                        </label></li>
			                        <li class="active dropdown"><label class="offerLabel">
			                             12개월 이상 &nbsp;&nbsp;<input type="radio" name="offerDate" value="12">
			                        </label></li>
			                        <li class="active dropdown"><label class="offerLabel">
			                             지속적 이용 &nbsp;&nbsp;<input type="radio" name="offerDate" value="12">
			                        </label></li>
			                        <li class="active dropdown"><label class="offerLabel">
			                             확실하지 않음  &nbsp;&nbsp;<input type="radio" name="offerDate" value="12" checked="checked">
			                         </label></li>
			                     </ul>
			                  </div>
			               </div>
			            </div>
			         </div>
			      </div>
			   </section>
			   <!-- /이용기간 -->
			   <div class="home-clients">
			      <div class="def-section services-1">
			         <div class="container">
			            <div class="row" style="border: 1px solid #e1e1e1; border-radius: 5px; padding: 33px 40px 40px;">
			               <!-- 카테고리 별 물품 리스트 나오는 Tag -->
			               <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12"
			                  style="width: 60%;">
			                  <ul class="nav divisionBtnAppend" style="margin-left: 30px;">
			                     <c:forEach items="${divisionList }" var="division">
			                        <li class="divisionBtnliTag"><input type="button"
			                           id="divisionBtn" style="display: inline-block;"
			                           class="btn btn-primary btn-lg"
			                           onclick="test('${division.division_code}')"
			                           value="${division.division_name }"></li>
			                     </c:forEach>
			                  </ul>
			                  <!-- AJAX 처리 후 Append 되는 물품 리스트 -->
			                  <div style="width: 100%; height:622px; overflow:auto; display: inline-block; margin:30px auto;">
			                  	<c:forEach items="${divisionList }" var="division">
			                    	<ul class="nav divisionBtn do" id="${division.division_code }">
			                        	<!-- Append ProductList -->
			                     	</ul>
			                 	</c:forEach>
			                  </div>
			                  
			                  <div id="productListDIV">
			                     <!-- 담기 눌렀을때 담는 곳 -->
			                     <input type="hidden" id="hiddenProductList">
			                     <input type="hidden" name="offer_product" id="offer_product">
			                  </div>
			               </div>
			               <!-- End Storage Tag -->
			               <!-- 스토리지 출력 Tag -->
			               <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12" style="width: 40%; height: auto">
			                  <div class="home-clients">
			                     <div class="swiper-container">
			                        <div class="swiper-wrapper" style="margin-bottom: 5%">
			                        <!-- === 스토리지 정보 forEach === -->
			                           <c:forEach items="${storageList }" var="storage" varStatus="status">
			                              <div class="swiper-slide" data-storagePrice="${storage.storage_price }" data-index="${storage.storage_code }" data-id="${status.index }" data-name="${storage.storage_name }">
			                                 <h4 align="center">${storage.storage_name }</h4>
			                                 <h6 align="center"> ${storage.storage_width } *  ${storage.storage_vertical } * ${storage.storage_height} cm³ (강남역기준)</h6>
			                                 <h6 align="center">${storage.storage_content }</h6>
			                                 <img style="width: 100%; height: 50%;" data-src="${pageContext.request.contextPath }/resources/storage_img/${storage.storage_image}" class="swiper-lazy" id="testImage">
			                                 <input type="hidden" value="${storage.storage_volume }" id="storageVolumn${storage.storage_code }">
			                                 <input type="hidden"  id="hiddenStoragePrice${storage.storage_code }" value="${storage.storage_price }">
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
			                  <button class="btn btn-primary btn-lg" id="resetBtn">Reset</button>
			               </div>
			               <!-- End Storage Tag -->
							<h5 id="nowInfo" style="width: 100%; display: block; float:left; text-align: right; font-weight: bold; color: #5b87da;"></h5>
			         </div><br />
			         <!-- 렌탈물품 정보들 -->
			         <section class="def-section" id="clients-section">
				         <div class="container" style="width: 100%; padding: 0;	">
				            <div class="row" style="border: 1px solid #e1e1e1; border-radius: 5px; padding: 33px 40px 40px;">
				         		<div class="collapse navbar-collapse main-menu main-menu-2" id="main-menu" style="float: left; width: 100%">
							          <h4>렌탈 물품 추가</h4>
							         <ul class="nav navbar-nav">
							         	<li class="active dropdown">
							         	<c:forEach items="${rentalList }" var="rental">
								         	<label class="offerLabel" style="width: 25%; margin-left: 50px;">
								         			<input type="hidden" id="rental${rental.rental_code }" value="${rental.rental_code }">
								         			<input type="hidden" id="rentalVolume${rental.rental_code }" value="${rental.rental_volume }">
								         			<input type="hidden" id="rentalPrice${rental.rental_code }" value="${rental.rental_price }">
								         			<h6>${rental.rental_name }</h6>
									        		<button onclick="rentalService('${rental.rental_code}')" >
									        			<input type="hidden" id="rentalName${rental.rental_code }" value="${rental.rental_name }">
									        			<button id=deleteRental class="deleteProduct" onclick="deleteRental('${rental.rental_code }')"> - </button>
									        			<img style="width: 100%" src="${pageContext.request.contextPath }/resources/product_img/${rental.rental_image}" id="rentalProductCount${rental.rental_code }">
									        			<h5><fmt:formatNumber value="${rental.rental_price }" pattern="#,###"></fmt:formatNumber>원</h5>
									        			<input type="number" readonly="readonly" class="count" id="rentalCount${rental.rental_code }" style="width: 100px;" value="0">
									        		</button>
										     </label>
										</c:forEach>
								        </li>
							         </ul>
							         <!-- Offer Table Insert Button -->
						   		</div>
							</div>
						</div>
					</section>
			   		<!-- 렌탈물품 정보들 -->
			   		<section class="def-section" id="clients-section">
				         <div class="container" style="width: 100%; padding: 0;	">
				            <div class="row" style="border: 1px solid #e1e1e1; border-radius: 5px; padding: 33px 40px 40px;">
						   		<div class="collapse navbar-collapse main-menu main-menu-2" id="main-menu" style="float:left; width: 100%; maring: 0 auto; ">
						   			<h4>서비스 추가</h4>
						   			<h5 style="display: inline-block; margin-bottom: 50px; vertical-align: top;">프리미엄 서비스
						   				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#premiumComment" style="margin-left: 20px;">프리미엄 서비스란?</button>
						   				<label class="offerLabel" style="margin-left: 70px;">
							   				신청&nbsp;&nbsp;<input type="radio" name=premium value="Y">
							   			</label>
							   			<label class="offerLabel" style="margin-left: 50px;">
							   				미신청&nbsp;&nbsp;<input type="radio" name=premium value="N" checked="checked">
							   			</label>
						   			</h5>
						   			<h5>세탁 서비스
							   			<label class="offerLabel" style="margin-left: 70px;">
							   				신청&nbsp;&nbsp;<input type="radio" id="washY" name="wash" value="Y">
							   			</label>
							   			<label class="offerLabel" style="margin-left: 50px;">
							   				미신청&nbsp;&nbsp;<input type="radio" id="washN" name="wash" value="N" checked="checked">
							   			</label>
						   			</h5>
						   		</div>
						   		<!-- 프리미엄 서비스 상세보기 -->
								<div class="modal fade" id="premiumComment" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
									<div class="modal-dialog" role="document" style="width:55%">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal" aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											<div class="modal-body" style="text-align: center;">
												<img style="width: 100%; "src="${pageContext.request.contextPath }/resources/main/premiumService.jpg">
												<h5>매달 보관 중인 물품의 컨디션을 지점 관리자가 직접 체크하여 작성한 보고서를 받아보실 수 있습니다. </h5>
												<p style="text-align: right; margin-top: 30px;"><b style="color : red;">( * 월 요금 5000원 추가금 발생 )</b></p>
											</div>
											<div class="modal-footer">
													<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
											</div>
										</div>
									</div>
								</div>
								<!-- 프리미엄 서비스 상세보기 -->
						   		<div id="laundryInfoList">
						   			<!-- 세탁물품 담는곳 -->
						   			<ul class="nav navbar-nav" style="width: 50%;">
						   			<c:forEach items="${laundryInfoList }" var="laundry">
						   			<li class="divisionBtnliTag" style="margin:10px">
						   					<input type="hidden" id="laundryPrice${laundry.laundry_gubun }" value="${laundry.laundry_price }">
						   					<input type="hidden" id="laundryName${laundry.laundry_gubun}" value="${laundry.laundry_kind }">
						                    <input type="button" id="divisionBtn" style="display: inline-block;" class="btn btn-default btn-lg" onclick="laundryTableInsert('${laundry.laundry_gubun}')" value="${laundry.laundry_kind }">
						            </li>
								</c:forEach>
								</ul>
								<table class="table table-striped" style="width: 50%;  vertical-align: middle;">
									<tr>
										<th>세탁물종류</th><th>수량</th><th>가격<strong style="color: blue;">(*한벌당)</strong></th><th>기능</th>
						               </tr>
						               <c:forEach items="${laundryInfoList }" var="laundry">
							               <tr id="appendLaundry">
							               	<td id="laundryKind">${laundry.laundry_kind }</td>
							               	<td><input type="number" id="laundryCount${laundry.laundry_gubun }" readonly="readonly" value="0"  class="totalLaundryCount"></td>
							               	<td id="laundryPrice"><fmt:formatNumber value="${laundry.laundry_price }" pattern="#,###"></fmt:formatNumber>원</td>
							               	<td><button class="btn btn-default btn-lg" onclick="deleteLaundry('${laundry.laundry_gubun}')">삭제</button></td>
							               </tr>
						               </c:forEach>
						               	<tr>
							               	<th style="text-align: right;" colspan="4" id="memberTotalPrice"></th>
							               </tr>
								</table>
						   	</div>
			     		</div>
			     	</div>
			     </section>
				<section class="def-section" id="clients-section">
				        <div class="container" style="width: 100%; padding: 0;	">
				            <div class="row" style="border: 1px solid #e1e1e1; border-radius: 5px; padding: 33px 40px 40px;">
				            	<div class="store-pick">
									<div class="store-list">
										<h4 id= "choice-store" align="left" style="margin-top:10px; margin-bottom:6px;">지점 리스트&nbsp;&nbsp;&nbsp;
										<button type="button" id="choice-btn" style="font-size: 9pt; font-weight: normal;">지점선택</button>
										</h4>
										<div id="grid"></div>
									</div>
									<div class="map">
										<h4 align="left">지점 지도</h4>
										<div id="map" style="width:100%;height:400px;"></div>
									</div>
								</div>
								<div style="margin-top: 30px;">
									<c:forEach items="${couponeInfoList }" var="coupon">
										<ul class="nav divisionBtn coupon" id="ul${coupon.store_code }">
											<!-- Append Coupon Information -->
											<li class="couponSelectList" style="margin: 10px;" id="${coupon.store_code }">
												<h4>쿠폰 / 할인 선택</h4><p style="padding: 0"><b>쿠폰을 선택해주세요.</b></p>
												<label class="offerLabel">일반요금
													<input type="radio" class="normal${coupon.store_code }" name="discount${coupon.store_code }" id="normalPrice" value="no" onclick="discount('${coupon.coupon_code}')">
												</label>
											</li>
										</ul>
									</c:forEach>
								</div>
				            </div>
						</div>
				</section>
				<section class="def-section" id="clients-section">
					<div class="container" style="width: 100%; padding: 0;	">
						<div class="row" style="border: 1px solid #e1e1e1; border-radius: 5px; padding: 33px 40px 40px;">
							<h4>픽업서비스 신청</h4>
							<div>
								<p style="display: inline-block; font-family: Montserrat; font-weight: bold; font-size: 12pt;">포장서비스</p>
								<label class="offerLabel pickupYes">YES &nbsp;&nbsp;<input type="radio" name="pickupService" value="Y"></label>
								<label class="offerLabel pickupNo">NO &nbsp;&nbsp;<input type="radio" checked="checked" name="pickupService" value="N"></label>
							</div>
							<div style="padding: 0 85px;" id="pickupInfo">
								<table border="0" id="pickupService">
									<tr>
										<th id="pickupServiceThTag">주소</th><td>${loginAddr  }</td>
									</tr>
									<tr>
										<th id="pickupServiceThTag">층수</th><td><input type="number" id="floor" value="0">&nbsp;&nbsp;<b>층</b></td>
									</tr>
									<tr>
										<th id="pickupServiceThTag">희망시간</th>
										<td>
											<select id="pickupTimeSelect">
												<option value="AM 08:00 ~ 12:00">AM 08:00 ~ 12:00</option>
												<option value="PM 13:00 ~ 17:00">PM 13:00 ~ 17:00</option>
											</select>
										</td>
									</tr>
									<tr>
										<th id="pickupServiceThTag">박스구매</th>
										<td>
											<label class="offerLabel">YES &nbsp;&nbsp;<input type="radio" name="boxService" value="Y"></label>
											<label class="offerLabel">NO &nbsp;&nbsp;<input type="radio" name="boxService" value="N"></label>
										</td>
									</tr>
								</table>
							</div>
							
							<div align="center" style="padding: 0 85px;" id="pickupBoxCount">
								<input type="number" id="boxCount" value="0">&nbsp;&nbsp;<b>개</b>
								<h6 style="text-align: left; width:50%">박스 규격 : (48cm x 38cm x 34cm)<br/>
										고객님께서 직접 포장하시는 경우 박스를 출발지 주소로 택배 발송해 드립니다.<br/>
										박스구매는 운송신청 최소 5일전에 신청해 주시기 바랍니다.<br/>
										한묶음(10개)당 택배비용 6,600 원 발생<br/>
								</h6>
							</div>
						</div>
					</div>
				</section>
				<!-- JSTL 현재 날짜 들고오기 -->
				<c:set var="now" value="<%=new Date() %>"/>
			      <div align="center" style="margin: 100px auto">
			      	<div class="container">
						    <!-- Trigger the modal with a button -->
							<button type="button" id="offerInsertBtn" class="btn btn-info btn-lg" data-target="#offerModal" style="background: #478FEB; padd">견적서 출력</button>
							<!-- Modal -->
							<div class="modal fade" id="offerModal" role="dialog">
								<div class="modal-dialog" style="width: 70%">
							    <!-- Modal content-->
							    <div class="modal-content">
							    	<div class="modal-header">
							    		<button type="button" class="close" data-dismiss="modal">&times;</button>
							    		<h4 class="modal-title">견 적 서</h4>
							    	</div>
							    	<form>
								    	<div class="modal-body">
								    		<table id="modalTable">
								    			<tr id="modalTrTag">
								    				<td style="width: 30%; padding: 5px; font-weight: bold;">사이즈</td>
								    				<td id="offerStorageSize"></td>
								    			</tr>
								    			<tr>
								    				<td style="padding: 5px; font-weight: bold;">이용기간</td>
								    				<td id="offerDate"></td>
								    			</tr>
								    			<tr>
								    				<td style="padding: 5px; font-weight: bold;">이용지점</td>
								    				<td id="offerStore"></td>
								    			</tr>
								    			<tr>
								    				<td style="padding: 5px; font-weight: bold;">렌탈용품</td>
								    				<td id="offerRental"></td>
								    			</tr>
								    			<tr>
								    				<td style="padding: 5px; font-weight: bold;">보관용품</td>
								    				<td id="offerProduct"></td>
								    			</tr>
								    			<tr>
								    				<td style="padding: 5px; font-weight: bold;">프리미엄서비스 신청</td>
								    				<td id="offerPremium"></td>
								    			</tr>
								    			<tr>
								    				<td style="padding: 5px; font-weight: bold;">예상 월 이용금액</td>
								    				<td id="offerPrice"></td>
								    			</tr>
								    			<tr>
								    				<td style="padding: 5px; font-weight: bold;">예상 첫달 이용금액</td>
								    				<td id="offerFirstPrice"></td>
								    			</tr>
								    			<tr>
								    				<td style="padding: 5px; font-weight: bold;">세탁 서비스</td>
								    				<td id="offerLaundry"></td>
								    			</tr>
								    			<tr>
								    				<td style="padding: 5px; font-weight: bold;">세탁 서비스 총 가격</td>
								    				<td id="offerLaundryPrice"></td>
								    			</tr>
								    			<tr>
								    				<td style="padding: 5px; font-weight: bold;">픽업 서비스</td>
								    				<td id="offerPickup"></td>
								    			</tr>
								    			<tr>
								    				<td style="padding: 5px; font-weight: bold;">기타 가격 (박스)</td>
								    				<td id="offerOtherPrice"></td>
								    			</tr>
								    			<tr>
								    				<td style="padding: 5px; font-weight: bold;">쿠폰 / 할인</td>
								    				<td id="offerCoupon"></td>
								    			</tr>
								    			<tr>
								    				<td style="padding: 5px; font-weight: bold;">총 가격</td>
								    				<td id="offerTotalPrice"></td>
								    			</tr>
								    		</table>
								    		<div style="display: table; width: 80%; margin: 30px auto">
									    		<div class="modalInMap" style="width: 50%; display: table-cell;">
													<h4 align="center">지점 지도</h4>
													<div id="modalInMap" style="width:100%;height:400px; margin:auto"></div>
												</div>
												<div style="width:50%; display: table-cell; vertical-align: middle; line-height: 2.5">
													<h4>오시는 길 및 정보</h4>
													<h5 id="storeWay" style="padding: 30px"></h5>
													<h5 id="storeBus" style="padding: 30px"></h5>
													<h5 id="storeTel" style="padding:30px"></h5>
													<h5 id="storeEmail" style="padding: 30px"></h5>
												</div>
											</div>
								    	</div>
								    	<div class="modal-footer" style="margin:30px auto; width:100%; text-align: center">
								    		<button type="button" style="width: 40%" id="insertOfferBtn">
								    			<div class="my-btn my-btn-primary">
													<div class="my-btn-bg-top"></div>
													<div class="my-btn-bg-bottom"></div>
													<div class="my-btn-text">
														결정
													</div>
												</div>
								    		</button>
								    		<button type="button" data-dismiss="modal" style="width: 40%">
								    			<div class="my-btn my-btn-grey">
													<div class="my-btn-bg-top"></div>
													<div class="my-btn-bg-bottom"></div>
													<div class="my-btn-text">
														CLOSE
													</div>
												</div>
								    		</button>
								    	</div>
								    </form>
							    </div>
							    </div>
							  </div>
							</div>
				         	<!-- 스토리지 Price는 스토리지 정보 forEach 에 있음-->
				         	<!-- 모달 및 필요한 정보들의 hidden -->
				         	<input type="hidden" id="hiddenLaundryTotalPrice" value="0"> <!-- 세탁물 총 가격 -->
				         	<input type="hidden" id="hiddenBoxPrice" value="0"> <!-- 박스가격 -->
				         	<input type="hidden" id="hiddenStoreName"> <!-- 모달 지점 이름 넣어주기 위한 Hidden -->
				         	<input type="hidden" id="hiddenStoreAddr"> <!-- 주소값 -->
				         	<input type="hidden" id="hiddenStoreWay"> <!-- 오시는길 -->
				         	<input type="hidden" id="hiddenStoreBus"> <!-- 버스 -->
				         	<input type="hidden" id="hiddenStoreEmail"> <!-- 이메일 -->
				         	<input type="hidden" id="hiddenStoreTel"> <!-- 전화번호 -->
				         	<input type="hidden" id="hiddenCouponName">	<!-- 모달 지점 이름 넣어주기 위한 Hidden -->
				         	<input type="hidden" id="hiddenFloorValue"> <!-- 층수 받아오고 -->
						    <input type="hidden" id="hiddenBoxCount"> <!-- 박스 갯수 받아오고 -->
						    <input type="hidden" id="hiddenOfferPrice"> <!-- 일단 감산된거랑 name이 똑같으면 안되니까 바꿔주고 -->
						    <!-- DB에 들어가야 될 데이터를 가공해놓은 hidden들 -->
						    <form action="insertOffer" id="frm" method="post">
						    	<input type="hidden" name="storage_code" id="hiddenOfferStorageCode">
						    	<input type="hidden" name="store_code" id="hiddenStoreCode">
							    <input type="hidden" name="offer_price" id="hiddenOfferDiscountPrice"> <!-- 얘가 모달창에서 보여질 총 Total 가격 + 디비로 넘길거 -->
							    <input type="hidden" name="offer_product" id="hiddenOfferProduct">
							    <input type="hidden" name="pickup_date" id="hiddenPickupDate" value="">
							    <input type="hidden" name="pickup_time" id="hiddenPickuptime" value="AM 08:00 ~ 12:00">
							    <input type="hidden" name="offer_rental" id="hiddenOfferRental" value="">
							    <input type="hidden" name="offer_wash" id="hiddenOfferWash" value="N">
							    <input type="hidden" name="offer_premium" id="hiddenOfferPremium" value="N">
							    <input type="hidden" name="laundry_product" id="hiddenOfferLaundryProduct" value="">
							    <input type="hidden" name="coupon_code" id="hiddenCouponCode" value="">
							    <input type="hidden" name="offer_addr" value="${loginAddr }">
							    <input type="hidden" name="member_id" value="${loginId }">
							    <input type="hidden" name="offer_pickup" id="hiddenOfferPickup"> <!-- 여기에 픽업 정보 붙여줌 -->
							    <input type="hidden" name="offer_start" id="hiddenOfferStart" value="">
							    <input type="hidden" name="offer_date" id="hiddenOfferDate">
						    </form>
		        	 </div>
	  			 </div>
	  		</div>
		</div>
  </div>
  <div align="right" class="self-banner-bottom" style="position: fixed; bottom: 0px; width:100%; border-radius: 4px; padding: 10px 0; justify-content: space-between; z-index: 99">
		<div id="inner"  style="padding: 0px 20px;">
			<div style="float: left; width: 25%; text-align: center;">
				<h4 id="fixedStoreName" style="margin: 30px auto; font-size: 32px; font-weight: bold; ">중구점</h4> <!-- 지점이름 -->
				<h5 id="fixedStorageName" style="font-size: 20px;">슬림</h5> <!-- 스토리지 이름 / 약정 -->
			</div>
			<div style="float: right; width: 25%; text-align: left; line-height: 1.2">
				<h4 id="fixedDiscountPrice" style="display: inline-block; color: black; font-weight: bold; font-size: 22px;">현재가격54000원</h4> <!-- 감산된 가격-->
				<h5 id="fixedPrice"></h5> <!-- 원래가격 --> 
				<h5 id="fixedLaundry">세탁물품가격</h5>
				<h5 id="fixedOther">기타</h5>
			</div>
		</div>
  </div>
</body>

	<script>
		// KakaoMap
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(35.869095969748685, 128.59339734624666), // 지도의 중심좌표 (default 값)
		        level: 3 // 지도의 확대 레벨
		    };  
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		var iwContent2 = '<div style="padding:5px; text-align:center; width:145px;">Yedam</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	    iwPosition2 = new kakao.maps.LatLng(35.869095969748685, 128.59339734624666), //인포윈도우 표시 위치입니다
	    iwRemoveable2 = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

		// 인포윈도우를 생성하고 지도에 표시합니다
		var infowindow2 = new kakao.maps.InfoWindow({
		    map: map, // 인포윈도우가 표시될 지도
		    position : iwPosition2, 
		    content : iwContent2,
		    removable : iwRemoveable2
		});
		
		$.ajax({
			url:'storeAddr',
			dataType:'json',
			success:function(data){
				// TOAST GRID
				
				const recruitGrid = new tui.Grid({
					el: document.getElementById('grid'), 
					data: data,
					columns: [ 
						{ 
							header: '지점명', 
							name: 'store_name', 
							align: 'center',
							width: 90,
							filter: 'select'
						}, 
						{ 
							header: '주소', 
							name: 'store_addr', 
							align: 'center',
							filter: 'select'
						}
					],
					
					// 무한 스크롤 - 그냥 페이징처리할땐 BodyHeight 필요없음
					bodyHeight: 357,
					pageOptions: {
						// 무한 스크롤 혹은 페이징 처리 시 기능 사용한다는 옵션
						useClient: true,
					    // 무한스크롤 옵션 
					    type: 'scroll'
					}
				});
				// GRID 클릭 시
				recruitGrid.on('click', function(ev) {
					// 새로운 지역 클릭시 새롭게 초기화
					$("input:radio[id='normalPrice']").removeAttr('checked');
				 	$("input:radio[id='discountPrice']").removeAttr('checked');
					var target = ev
					var discountPrice = parseInt($("#hiddenOfferDiscountPrice").val()); // 감산되고의 가격
					var normalPrice = parseInt($("#hiddenOfferPrice").val()); // 원래의 가격
					// 이제 여기서 만약 고객님이 "아 이 지점말고 다른거 하고싶은데?" 라고 생각이 드실때 감산된 가격이 본래의 가격으로 돌아가는 마술을 써준다.
					$("#hiddenOfferDiscountPrice").attr("value", normalPrice);
					$("#hiddenCouponCode").attr("value", " ");
					// 클릭 시 console에 지점 주소 출력
					var contents = recruitGrid.getValue(ev.rowKey,'store_addr');
					var store_name = recruitGrid.getValue(ev.rowKey,'store_name');
					var coupon_code = recruitGrid.getValue(ev.rowKey,'coupon_code');
					var store_way = recruitGrid.getValue(ev.rowKey,'store_subway');
					var store_bus = recruitGrid.getValue(ev.rowKey,'store_bus');
					var store_email = recruitGrid.getValue(ev.rowKey,'store_email');
					var store_code = recruitGrid.getValue(ev.rowKey,'store_code');
					var store_tel = recruitGrid.getValue(ev.rowKey,'store_tel');
				  	// 각 지점 코드
					
				  	// 이전에 있던 쿠폰 정보 hide 해주고
				  	$('.coupon').hide();
				  	// 지점 찍을때 id가 store_code인걸 보여줌
					$('#ul' + store_code).show();
				  	$('#hiddenStoreCode').val(store_code);
				  	$('#hiddenStoreBus').val(store_bus);
				  	$('#hiddenStoreEmail').val(store_email);
					$('#hiddenStoreWay').val(store_way);
				 	$('#hiddenStoreName').val(store_name);
				 	$('#hiddenStoreAddr').val(contents);
				 	$('#hiddenStoreTel').val(store_tel);
				 	
				 	$('#fixedStoreName').html(store_name);
				 	// 주소로 좌표를 검색합니다
					geocoder.addressSearch(contents, function(result, status) {
					
					    // 정상적으로 검색이 완료됐으면 
					     if (status === kakao.maps.services.Status.OK) {
					
					        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					
					        // 결과값으로 받은 위치를 마커로 표시합니다
					        var marker = new kakao.maps.Marker({
					            map: map,
					            position: coords
					        });
					
					        // 인포윈도우로 장소에 대한 설명을 표시합니다
					        var infowindow = new kakao.maps.InfoWindow({
					        	// 지도 마커에 적힌 내용 수정하는 곳
					            content: '<div style="width:150px;text-align:center;padding:6px 0;">지점 위치</div>'	
					        });
					        infowindow.open(map, marker);
					
					        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					        map.setCenter(coords);
					    } 
					}); 
				  // 여기서도 ajax로 스토리지 비어있나 검증하기
				  var storage_code =  $('#hiddenOfferStorageCode').val()
				  console.log(store_code + storage_code);
				   $.ajax({
					  url : 'useCountStorage',
					  data : {
						  store_code : store_code,
						  storage_code : storage_code
					  },
					  dataType: "JSON",
					  method : "POST",
					  success : function(data){
						  console.log(data);
						  if(data.cnt == 0){
							  $('#ul' + store_code).hide();
							  alert("해당 지점의 빈 스토리지가 남아있지 않습니다 상담문의 해주세요.");
							  return false;
						  } else{
							  alert("신청 가능한 지점입니다.");
						  }
					  },
					  error: function(err){
						  console.log(err);
					  }
				  });
				});
			}, // success 닫힘
			error: function(err){
				console.log(err);
			}
		});
		
	</script>
	<script>
		
	</script>
</html>