<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스토리지 현황</title>
<script type="text/javascript">
	$(document).ready(function() {
		pageInitOfferInfoList();
       
         // 빈 스토리지 Select Option 바뀔때마다 value 값 변경
        $('#unUseStorageList').change(function() {
        	var info_num = $('#unUseStorageList').val();
        	$('#hiddenInfoNum').val(info_num);
        });
         
     	// member Select Option 바뀔때마다 보여지는 값 다르게
		$('#memberIdSelect').change(function() {
			// OfferInfoCode => 숨겨져있는 td안의 offer_product 와 start end 일
			var OfferInfoCode = $('#memberIdSelect').val();
			var offerCode = ($('#offerCode' + OfferInfoCode).val());
			$('#hiddenOfferCode').val(offerCode);
			$('.do').hide();
			$('#' + OfferInfoCode).show();
        });
     	
     	// use_storage DB Update 작업
     	$('#storageSaveBtn').click(function(){
     		if($('#hiddenInfoNum').val() == "" || $('#hiddenOfferCode').val() == ""){
     			alert("회원 ID 및 스토리지를 선택해주세요");
     			return false;
     		} else {
     			$('#updateUseStorageTable').submit();
     		}
     	});
     	
     	// 온도
     	$('input[id="humidityValue"]').change(function(){
     		var humidity = $(this).val()
     		$('#hiddenHumidiry').val(humidity);
     	});
     // 습도
     	$('input[id="temperatureValue"]').change(function(){
     		var temperature = $(this).val()
     		$('#hiddenTemperature').val(temperature);
     	});
     // 온습도 업데이트
     	$('#temHumUpdateBtn').click(function (){
     		if($('#hiddenTemperature').val() == "" || $('#hiddenHumidiry').val() == ""){
     			alert("온습도를 입력해주세요");
     			return false;
     		}else {
     			$('#temHumUpdate').submit();
     		}
     	})
	});
	
	// 페이지 로딩 후 현재 예약되어 있는 정보를 담아주는 function
	function pageInitOfferInfoList(){
		var store_code = $('#hiddenStoreCode').val();
		$.ajax({
			url: 'ajaxOfferInfoList',
			dataType: 'json',
			contentType: 'application/json; charset = UTF-8',
			data: {
				store_code : store_code
			},
			method: 'GET',
			success: function(data){
				for(var i = 0; i<data.length; i++){
					var tdTagId = '#' + data[i].offer_code + data[i].storage_code;
					$(tdTagId).html(
							'<p>보관물품 : '+ data[i].offer_product +'</p><br />'
							+'<p>이용기간 : '+ data[i].use_start +' - '+ data[i].use_end +'</p>'
					);
				}
				$('.do').hide();
				//$('#' + data[0].offer_code + data[0].storage_code).show();
			},
			error: function(err){
				console.log(err);
			}
		})
		
	}
	
	// 사용중인 스토리지 정보 출력 FUNCTION
	function useStorageInfo(offer_code, store_code){
		$.ajax({
			url: 'usedStorage',
			dataType: 'JSON',
			data: {
				offer_code : offer_code,
				store_code : store_code
			},
			contentType: 'application/json; charset = UTF-8',
			success: function(data){
				$('#memberId').html(data.member_name);
				$('#memberUseDate').html(data.use_start + '  ~  ' + data.use_end);
				$('#memberStorageInfo').html(data.offer_product);
			},
			error : function(err){
				console.log(err);
			}
		})
	};
	// 미사용 중인 스토리지 할당 FUNCTION
	function unUseStorage(storage_code, store_code, offer_code){
		console.log("왜 안나옴 : " + offer_code);
		$.ajax({
			url: 'offerInfo',
			dataType : 'JSON',
			data: {
				storage_code : storage_code,
				store_code : store_code,
				offer_code : offer_code
			},
			contentType: 'application/json; charset = UTF-8',
			success: function(data){
				// 눌렀을때 예약정보 조회가 없으면 modal숨기고 alert 창 띄우고
				console.log("길이 : " + data.selectOfferInfo.length)
				if(data.selectOfferInfo.length == 0){
					$("#unUsedStorage").modal("hide");
					alert("이 스토리지에 해당하는 예약이 없습니다");
					return false;
					// 예약정보가 있으면 select option 만들어주는 function 호출
				} else{
					assignment(data);
				};
			},
			error : function(err){
				console.log(err);
			}
		})
	}
	// offerInfo Ajax 성공 후 호출되는 함수
	function assignment(data){
		// 각 비어있는 스토리지 담을거
		var unUseStorageSelectOption = "";
		// DB 처리에 필요한 offer_code 구분화
		var hiddenOfferCode = "";
		// 그 스토리지에 해당되는 member_id
		var memberSelectOprion = "";
		// Empty Storage Select Option
		for(var i = 0; i<data.unUseStorage.length; i++){
			unUseStorageSelectOption += '<option selected="selected" value='+data.unUseStorage[i].info_num+'>'+ data.unUseStorage[i].storage_name + '</option>'
		}
		// memberId Select Option
		memberSelectOprion += '<option>ID를 선택하세요</option>'
		for(var j = 0; j<data.selectOfferInfo.length; j++){
			// member option 만들어주고
			memberSelectOprion += '<option value='+data.selectOfferInfo[j].offer_code + data.selectOfferInfo[j].storage_code+'>'+ data.selectOfferInfo[j].member_id + '</option>'
			// 그 밑에 td에 hidden 만들어서 member select 값 바뀔때 마다 form 안에 있는 offer_code를 바꾸어줌
			hiddenOfferCode += '<input type="hidden" class="offerCode" id=offerCode'+data.selectOfferInfo[j].offer_code + data.selectOfferInfo[j].storage_code+' value='+ data.selectOfferInfo[j].offer_code +'>'
		}
		// 예약 되어 있는 멤버 select Option Append
		$('#memberIdSelect').html(memberSelectOprion);
		// 미사용 select Option Append
		$('#unUseStorageList').html(unUseStorageSelectOption);
		$('#hiddenTr').html(hiddenOfferCode);
		// select option에 1개면 암만 눌러도 hidden 값 변경 안되서 0번째방의 값을 넣어줌
		$('#hiddenInfoNum').val(data.unUseStorage[0].info_num);
		$('#hiddenOfferCode').val(data.selectOfferInfo[0].offer_code);
		
	}
</script>
<style type="text/css">
	.wrap {
		margin: auto;
		width: 80%;
	}


	#unUsedMember:visited {
		color: #F93407;
		font-weight: bold;
	}
	
	#unUsedMember:hover{
		color:  rgb(52, 152, 219);
		font-weight: bold;
	}
		
	.storageList {
		width: 14%; 
		height: 240px;
		border-radius: 5px;
		background-color: #f4f4f4;
		margin: 10px 10px;
	}
	#useMember {
		color: red;
	}
	
	#useMember:visited {
		color: #00c0e2;
	}
	#useMember:hover {
		color:  rgb(52, 152, 219);
	}
	
	.service-1 p {
	    text-align: left;
	    padding-left: 10%;
	}


</style>
</head>
<body>
	<input type="hidden" value="${store_code }" id="hiddenStoreCode">
	<div class="def-section services-1" style="padding: 1em;">
		<div class="container">

			<div class="row" style="margin-top : 10px;">
				<div style="display: table; width: 100%">
					<div style="display:table-cell; width: 100%;">
						<h4 style=" margin-left: 10px;">${stroeTemHumInfo.store_name } 스토리지 현황 </h4>
						<h5 style=" margin-left: 10px;">온도 <input type="number" id="humidityValue" style="margin: 0; color: black; width: 40px;" value="${stroeTemHumInfo.humidity }"> °C / 
														습도 <input type="number" id="temperatureValue" style="margin: 0; color: black; width: 40px;" value="${stroeTemHumInfo.temperature }" > %  &nbsp;&nbsp;
						<div class="my-btn my-btn-primary" style="background-color: #478FEB; border-radius: 0.3em; color: white; font-size: 8pt; padding: 0.4em;" id="temHumUpdateBtn" >SAVE</div> </h5>
					</div>
				
					<div style="display: table-cell; width: 30%">
						<form action="temHumUpdate" id="temHumUpdate">
							<input type="hidden" name="store_code" value="${store_code }">
							<input type="hidden" name="humidity" id="hiddenHumidiry" value="">
							<input type="hidden" name="temperature" id="hiddenTemperature" value="">	
						</form>
					</div>
				</div>
				<c:forEach items="${storageName}" var="storageName">
					<div id="${storageName.storage_code}" class="col-lg-4 col-md-4 col-sm-4 col-xs-12 storageList">
						<div class="service-1">
							<div class="service-1-title">
								<h3 style="cursor: default;">${storageName.storage_name}</h3>
							</div>
								<c:forEach items="${StorageInfoList}" var="storageInfoList">
									<c:if test="${storageInfoList.storage_name == storageName.storage_name}">
										<div class="service-1-text" style="cursor: pointer;">
											<c:choose>
												<c:when test="${storageInfoList.info_use eq '미사용'}">
														<a style="color: #2b2b2b;" id="unUsedMember" onclick="unUseStorage('${storageInfoList.storage_code}','${store_code }','${storageInfoList.offer_code }')" data-toggle="modal" data-target="#unUsedStorage">
															${storageInfoList.storage_code}-${storageInfoList.info_num } ${storageInfoList.info_use},${storageInfoList.offer_code }
														</a>
												</c:when>
												<c:otherwise>
														<a id="useMember" onclick="useStorageInfo('${storageInfoList.offer_code}','${store_code }')" data-toggle="modal" data-target="#storageInfo">
															${storageInfoList.storage_code}-${storageInfoList.info_num } ${storageInfoList.info_use}
														</a>
												</c:otherwise>
											</c:choose>
										</div><br>
									</c:if>
								</c:forEach>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<div class="def-section services-1" style="padding: 1em;">
		<div class="container">
			<div class="row">
				<h4>스토리지 미할당 대기 고객</h4>
				<!-- 스토리지 할당 대기자 그리드 -->
				<div id="bookingGrid"></div> <br><br>
			</div>
			<div align="center">
			<div class="btn btn-primary btn-lg" onclick="location.href='${pageContext.request.contextPath }/home'"style="display: inline-block;"> 돌아가기
			</div></div>
		</div> <br><br>
	</div>
	
	<!-- 이용중인 회원 정보 Modal -->
	<div class="modal fade" id="storageInfo" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content" style="top: 250px;">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLongTitle">스토리지 정보</h5>
	      </div>
	      <div class="modal-body"  style="padding: 30px 0px;">
	        	<table id="infoStorage">
	        		<tr style=" margin-bottom:10px">
	        			<th style="padding-left: 50px;">고객명</th>
	        			<td  id="memberId"></td>
	        		</tr>
					<tr><td style="height: 20px;"></td></tr>
	        		<tr  style="height: 5px;">
	        			<th style="width: 33%; padding-left:50px;">사용기간</th>
	        			<td style="padding-right: 50px;" id="memberUseDate"></td>
	        		</tr> 
     				<tr><td style="height: 20px;"></td></tr>
	        		<tr style="height: 5px;">
	        			<th style="width: 33%; padding-left:50px;">보관물품</th>
	        			<td style="padding-right: 50px;" id='memberStorageInfo'></td>
	        		</tr> 
	        	</table>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal" style="border: 1px solid #dddddd;">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 이용중인 회원 정보 Modal -->
	<!-- 사용안하고 있는 스토리지 할당 Modal -->
	<div class="modal fade bd-example-modal-lg" id="unUsedStorage" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content" style="padding: 0 auto; top: 220px;">
				<div class="modal-header" >
					<h4 style="padding-left: 43px;">STORAGE 할당</h4>
				</div>
				<div class="modal-body" style="margin-bottom: 30px;">
					<table style="width: 100%; text-align: left;">
						<tr>
							<td style=" padding-left:50px; text-align: left;">
								<h5>회원 ID &nbsp;
								<select name="member_id" id="memberIdSelect">
									<option>현재 비어있는 스토리지</option>
								</select></h5>
							</td>
						</tr><br>
						<tr>
							<td style="width: 100%;  padding-left:50px; text-align: left">
								<h5>현재 비어있는 스토리지
								<input type="hidden" class="offerCode">
								<select name="info_num" id="unUseStorageList">
										<option>현재 비어있는 스토리지</option>
								</select> </h5>
							</td>
						</tr>
						<tr><td style="height: 20px;"></td></tr>
						<tr>
						<c:forEach items="${offerInfoList }" var="offerInfoList">
							<td style="padding-left:50px; text-align: left" id="${offerInfoList.offer_code }${offerInfoList.storage_code}" class="do">
									
							</td>
						</c:forEach>
						</tr>
						<tr>
							<td id="hiddenTr">
								<!-- Append hidden offer_code -->
							</td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="storageSaveBtn">SAVE</button>
					<button type="button" id="modal_close_btn" class="btn btn-secondary" data-dismiss="modal" style="border:1px solid #dddddd;">CLOSE</button>
				</div>
			</div>
		 </div>
	</div>
	<!-- DB처리 -->
	<form id="updateUseStorageTable" method="post" action="updateUseStorage">
		<input type="hidden" name="store_code" value="${store_code }">
		<input type="hidden" name="info_num" id="hiddenInfoNum" value="">
		<input type="hidden" name="offer_code" id="hiddenOfferCode" value="">
	</form>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script>
$(document).ready(function() {
const Grid = tui.Grid;
	
	const bookingData = [
					<c:forEach items="${offerInfoList}" var="list" varStatus="status">
					{
						offer_code: '${list.offer_code}',
						member_id: '${list.member_id}',
						storage_name: '${list.storage_name}',
						storage_code:'${list.storage_code}',
						use_start: '<fmt:formatDate value="${list.use_start}" pattern="yyyy-MM-dd" />',
						use_end: '<fmt:formatDate value="${list.use_end}" pattern="yyyy-MM-dd" />'
					}
					<c:if test="${not status.last}">,</c:if>
					</c:forEach>
				]
	
	console.log(bookingData);
	
	const bookingGrid = new Grid({
		el : document.getElementById('bookingGrid'),
		data: bookingData,
		columns : [
			{
				header: '견적서코드',
				name: 'offer_code',
				align: 'center',
				width: 100
			},
			{
				header:  '신청 고객',
				name: 'member_id',
				align: 'center',
				width: 100
			},
			{
				header: '창고 사이즈',
				name: 'storage_name',
				align: 'center',
			},
			{
				header: '사이즈 코드',
				name: 'storage_code',
				align: 'center',
			},
			{
				header: '이용 시작일',
				name: 'use_start',
				align: 'center',
			},
			{
				header: '이용 종료일',
				name: 'use_end',
				align: 'center',
			}
		],
		
		bodyHeight: 200,
		width: 'auto',
		pageOptions : {
			userClient: true,
			type: 'scroll'
		}
	});
})
</script>
</body>
</html>