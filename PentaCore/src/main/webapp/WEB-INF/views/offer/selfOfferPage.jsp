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
         pagination : {
            el : '.swiper-pagination',
            clickable : true, // 페이징을 클릭하면 해당 영역으로 이동, 필요시 지정해 줘야 기능 작동
         },
         // 네비게이션 설정
         navigation : {
            nextEl : '.swiper-button-next', // 다음 버튼 클래스명
            prevEl : '.swiper-button-prev', // 이번 버튼 클래스명
         },
      }); // End Swiper
      
      // Form Submit Button
      $('#offerInsertBtn').click(function () {
         console.log($('#hiddenOfferProduct').val());
      });
      
      // 프리미엄 서비스
      $("input[name='premium']").change(function(){
    	 $('#hiddenOfferPremium').val($(this).val());
    	 if($(this).val() == "Y"){
    		// Y일때 5000원추가
    		storage_price =  storage_price + 5000;
    		$('#hiddenOfferPrice').val(storage_price);
    		$('#hiddenOfferDiscountPrice').val(storage_price);
    	 } else {
    		 storage_price =  storage_price - 5000;
    		 $('#hiddenOfferPrice').val(storage_price);
    		 $('#hiddenOfferDiscountPrice').val(storage_price);
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
				$('.totalLaundryCount').attr("value", "");
				$('#memberTotalPrice').html("총 0 원");	
				$('#laundryInfoList').hide();
				$('#hiddenOfferWash').val("N");
			}else{
				// Y눌러도 일단 N누르고 Y눌렀을테니 바로 초기화 시켜버리기
				$('#hiddenOfferWash').val("Y");
				$('.totalLaundryCount').attr("value", "0");
				$('#memberTotalPrice').html("총 0 원");
				$('#laundryInfoList').show();
			}
		});
   });
   
   
   // 페이지 로딩 후 Coupon List 가져오기
   function couponList(){
	   $.ajax({
		   url: 'couponList',
		   dataType: 'json',
		   type: 'GET',
		   success: function(data){
			   for(var i = 0; i<data.length; i++){
				   	var store_code = '#' + data[i].store_code;
			 	// 결과 다 Append 후 Hide 작업
				   $(store_code).append(
						'<li class="couponSelectList" style="margin: 10px;">'
						+ '<h4>쿠폰 / 할인 선택</h4><p style="padding: 0"><b>쿠폰을 선택해주세요.</b></p>'
						+ '<label class="offerLabel">일반요금<input type="radio" class="normal'+data[i].store_code+'" name="discount'+data[i].store_code+'" id="normalPrice" value="no" onclick="discount(\''+data[i].store_code+'\')"></label>'
						+ '<label class="offerLabel" style="margin-left: 30px;">'+data[i].coupon_name+'<input type="radio" class="discount'+data[i].store_code+'" name="discount'+data[i].store_code+'" id="discountPrice" value="yes" onclick="discount(\''+data[i].store_code+'\')"></label>'
						+ '<input type="hidden" id="hiddenDiscount'+ data[i].store_code +'" value="'+data[i].coupon_discount+'">'
						+ '</li>'
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
      storageImageIndex = ($('.swiper-slide-active').data("index"));
      storage_price = $('#hiddenStoragePrice' + storageImageIndex ).val();
      console.log(storage_price);
      
    	$('#hiddenOfferProduct').val(resetList);
      	$('#hiddenOfferStorageCode').val($('.swiper-slide-active').data("index"));
      	$('#hiddenOfferPrice').val(storage_price);
      	$('#hiddenOfferDiscountPrice').val(storage_price)
     	console.log('Insert Function = 총 물품 : ' + $('#hiddenOfferProduct').val() + ' / 가격 : ' +  $('#hiddenOfferPrice').val());
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
            	  productArrayList[product_name] = "";
            	  delProduct += productArrayList[deleteItems] + "";
            	  $('#hiddenOfferProduct').val().replace();
              } 
         }
        
        storageImageIndex = ($('.swiper-slide-active').data("index"));
        storage_price = $('#hiddenStoragePrice' + storageImageIndex ).val();
         
         // 삭제 된 결과를 value에 담기
        $('#hiddenOfferStorageCode').val($('.swiper-slide-active').data("index"));
        $('#hiddenOfferProduct').val(delProduct);
        $('#hiddenOfferPrice').val(storage_price);
        $('#hiddenOfferDiscountPrice').val(storage_price);
        console.log('Delete Fnction = 총 물품 : ' + $('#hiddenOfferProduct').val() + ' / 가격 : ' +  $('#hiddenOfferPrice').val());
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
	      if(storageImageIndex == "f20"){
	    	  storage_price = 0;
	      } else{
	    	  storage_price = parseInt($('#hiddenStoragePrice' + storageImageIndex ).val()) + rentalCount * rentalPrice ;
	      };
	      console.log('총 비용 ' + storage_price + '원 ');
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
		console.log(rentalCount + ' ' + rentalCode);
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
           	  	rentalArrayList[rentalName] = "";
           	  	delRental += rentalArrayList[deleteItems] + ""
           		$('#hiddenOfferRental').val().replace();
             }
        }
        storageImageIndex = ($('.swiper-slide-active').data("index"));
        if(storageImageIndex == "f20"){
        	// 라지플러스면 price 상담문의로 변경
	    	  storage_price = 0;
	      } else{
	    	  // 나머지는 렌탈 count * 가격에서 현재 선택되어있는 스토리지 data-index값을 읽어서 더해줌
	    	  storage_price = parseInt($('#hiddenStoragePrice' + storageImageIndex ).val()) + rentalCount * rentalPrice ;
	      };
        // 삭제 된 결과를 value에 담기
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
	   console.log($('#laundryPrice' + laundry_code).val() + ' / ' + $('#laundryName' + laundry_code).val() + ' / ' + totalLaundryPrice);
	   $('#hiddenOfferLaundryProduct').val(resultLaundryList);
	   $('#hiddenLaundryCount').val(laundryCount);
	   $('#memberTotalPrice').html('총 ' + totalLaundryPrice + ' 원');
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
         		laundryArrayList[laundryName] = "";
         		delLaundry += laundryArrayList[deleteItems] + ""
         		$('#hiddenOfferLaundryProduct').val().replace();
           }
      }
      console.log($('input[name=wash]:checked').length);
  	    
	  console.log(laundryCount + " " +totalLaundryPrice);
	  $('#hiddenOfferLaundryProduct').val(delLaundry);	
	  $('#memberTotalPrice').html('총 ' + totalLaundryPrice + ' 원');
   }
	// 망할 쿠폰
  	function discount(store_code){
  		console.log(store_code);
  		var normalPrice = parseInt($('#hiddenOfferPrice').val()); // 기존의 가격
		var discountPrice = parseInt($('#hiddenOfferDiscountPrice').val()); // 할인율을 받는 가격 변수
		var discount = parseFloat($('#hiddenDiscount'+store_code).val()); // 지점별 할인율
		console.log("현재가격 : " + normalPrice + ' / 감산가격 : ' + discountPrice + ' / 여기 지점 할인율 : ' + discount);
		
  		$("input[name='discount"+store_code+"']").on("click", function(){
			console.log($(this).val());
				if($(this).val() == "no"){
					// 할인율 X
					$('#hiddenOfferDiscountPrice').val(normalPrice);
				}	else{
					$('#hiddenOfferDiscountPrice').val(discountPrice * discount);
					console.log("할인 됬3");
			 	}
		});
  	};
</script>
<style>
input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
#pickupService{
	width: 100%;
	height: 100%;
}

#pickupService >  td {
    font-family: Montserrat;
	font-weight: bold;
    font-size: 17px;
    width: 50%;
}

#pickupServiceThTag {
	padding: 20px;
    font-family: Montserrat;
	font-weight: bold;
    font-size: 17px;
    width: 20%;
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
			                           <li class="active dropdown"><label class="offerLabel">
			                                 <input  type="text" value="다락 사용 목적을 입력해주세요.">
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
			                  <ul class="nav divisionBtnAppend">
			                     <c:forEach items="${divisionList }" var="division">
			                        <li class="divisionBtnliTag"><input type="button"
			                           id="divisionBtn" style="display: inline-block;"
			                           class="btn btn-primary btn-lg"
			                           onclick="test('${division.division_code}')"
			                           value="${division.division_name }"></li>
			                     </c:forEach>
			                  </ul>
			                  <!-- AJAX 처리 후 Append 되는 물품 리스트 -->
			                  <div style="width: 100%; height:622px; overflow:auto; display: inline-block;">
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
			                              <div class="swiper-slide" data-storagePrice="${storage.storage_price }" data-index="${storage.storage_code }" data-id="${status.index }">
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
							<h5 id="nowInfo" style="width: 100%; display: block; float:left"></h5>
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
						   			<h5 style="display: inline-block; margin-bottom: 50px;">프리미엄 서비스	(* 월 요금 5000원 추가금 발생)
						   			<label class="offerLabel" style="margin-left: 70px;">
							   				신청<input type="radio" name=premium value="Y">
							   			</label>
							   			<label class="offerLabel" style="margin-left: 50px;">
							   				미신청<input type="radio" name=premium value="N" checked="checked">
							   			</label><br>
						   			</h5>
						   			<h5>세탁 서비스
							   			<label class="offerLabel" style="margin-left: 70px;">
							   				신청<input type="radio" id="washY" name="wash" value="Y">
							   			</label>
							   			<label class="offerLabel" style="margin-left: 50px;">
							   				미신청<input type="radio" id="washN" name="wash" value="N" checked="checked">
							   			</label>
						   			</h5>
						   		</div>
						   		
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
										<ul class="nav divisionBtn coupon" id="${coupon.store_code }">
											<!-- Append Coupon Information -->
										</ul>
									</c:forEach>
								</div>
				            </div>
						</div>
				</section>
				<section class="def-section" id="clients-section">
					<div class="container" style="width: 100%; padding: 0;	">
						<div class="row" style="border: 1px solid #e1e1e1; border-radius: 5px; padding: 33px 40px 40px;">
							<h4>픽업서비스</h4>
							<table border="0" id="pickupService">
								<tr>
									<th id="pickupServiceThTag">주소</th><td>${loginAddr  }</td>
								</tr>
								<tr>
									<th id="pickupServiceThTag">층수</th><td><input type="number" value="층수를 입력해주세요">&nbsp;&nbsp;<b>층</b></td>
								</tr>
								<tr>
									<th id="pickupServiceThTag">포장서비스</th>
									<td>
										<label class="offerLabel">YES &nbsp;&nbsp;<input type="radio" name="pickupService" value="Y"></label>
										<label class="offerLabel">NO &nbsp;&nbsp;<input type="radio" name="pickupService" value="N"></label>
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
							<div id="pickupBoxCount">
								<h4>박스 몇개노?</h4>
							</div>
						</div>
					</div>
				</section>
			      <div align="center" style="margin: 100px auto">
				         	<!-- 스토리지 Price는 스토리지 정보 forEach 에 있음-->
					         <button id="offerInsertBtn" class="my-btn my-btn-grey">견적 뽑기</button>
						     <input type="hidden" name="storage_code" id="hiddenOfferStorageCode">
						     <input type="hidden" name="offer_price" id="hiddenOfferPrice">
						     <input type="hidden" name="offer_price" id="hiddenOfferDiscountPrice">
						     <input type="hidden" name="offer_product" id="hiddenOfferProduct">
						     <input type="hidden" name="offer_rental" id="hiddenOfferRental">
						     <input type="hidden" name="offer_wash" id="hiddenOfferWash">
						     <input type="hidden" name="offer_premium" id="hiddenOfferPremium">
						     <input type="hidden" name="laundry_product" id="hiddenOfferLaundryProduct">
						     <input type="hidden" name="laundry_count" id="hiddenLaundryCount">
						     <input type="hidden" name="coupon_code" id="hiddenCouponCode">
						     <input type="hidden" name="member_addr" value="${loginAddr }">
		        	 </div>
	  			 </div>
	  		</div>
		</div>
  </div>
</body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3a66ba8e60100e68a1df7756407ad0bb&libraries=services"></script>
	<script>
		// KakaoMap
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표 (default 값)
		        level: 3 // 지도의 확대 레벨
		    };  
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		$.ajax({
			url:'storeInfo',
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
					console.log('discountPrice : '+ discountPrice);
					console.log('normalPrice : '+ normalPrice);
					// 이제 여기서 만약 고객님이 "아 이 지점말고 다른거 하고싶은데?" 라고 생각이 드실때 감산된 가격이 본래의 가격으로 돌아가는 마술을 써준다.
					$("#hiddenOfferDiscountPrice").attr("value", normalPrice);
					
					// 클릭 시 console에 지점 주소 출력
					var contents = recruitGrid.getValue(ev.rowKey,'store_addr');
					var coupon_code = recruitGrid.getValue(ev.rowKey,'coupon_code');
				  	// 각 지점 코드
					var store_code = recruitGrid.getValue(ev.rowKey,'store_code');
				  	// 이전에 있던 쿠폰 정보 hide 해주고
				  	$('.coupon').hide();
				  	// 지점 찍을때 id가 store_code인걸 보여줌
					$('#' + store_code).show();
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
				  
				});
			}, // success 닫힘
			error: function(err){
				console.log(err);
			}
		})
	</script>
</html>