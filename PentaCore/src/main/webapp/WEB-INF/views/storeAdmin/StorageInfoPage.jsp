<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
				$('#' + data[0].offer_code + data[0].storage_code).show();
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
	function unUseStorage(storage_code, store_code){
		$.ajax({
			url: 'offerInfo',
			dataType : 'JSON',
			data: {
				storage_code : storage_code,
				store_code : store_code
			},
			contentType: 'application/json; charset = UTF-8',
			success: function(data){
				// 눌렀을때 예약정보 조회가 없으면 modal숨기고 alert 창 띄우고
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


	#unUsedMember:visited {
		color: #F93407;
		font-weight: bold;
	}
	
	#unUsedMember:hover{
		color:  rgb(52, 152, 219);
		font-weight: bold;
	}
	
	.storageList {
		width: 30%; 
		border-radius: 5px;
		background-color: rgb(224, 224, 224);
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
</style>
</head>
<body>
	<input type="hidden" value="${store_code }" id="hiddenStoreCode">
	<div class="def-section services-1">
		<div class="container">
			<div class="my-btn my-btn-grey" onclick="location.href='home'" align="center">
					<div class="my-btn-bg-top"></div>
					<div class="my-btn-bg-bottom"></div>
					<div class="my-btn-text">
						돌아가기
					</div>	
			</div>
			<div class="my-btn my-btn-primary" data-toggle="modal" data-target="#temHumStore" style="margin: 0px 50px;">
					<div class="my-btn-bg-top"></div>
					<div class="my-btn-bg-bottom"></div>
					<div class="my-btn-text">
						온습도 관리
					</div>	
			</div>
			<div class="row" style="margin-top : 30px;">
				<h4 align="center">${stroeTemHumInfo.store_name } 스토리지 현황 (온도 : ${stroeTemHumInfo.humidity }°C / 습도 : ${stroeTemHumInfo.temperature }%)</h4>
				<c:forEach items="${storageName}" var="storageName">
					<div id="${storageName.storage_code}" class="col-lg-4 col-md-4 col-sm-4 col-xs-12 storageList">
						<div class="service-1">
							<div class="service-1-title">
								<h3>${storageName.storage_name}</h3>
							</div>
								<c:forEach items="${StorageInfoList}" var="storageInfoList">
									<c:if test="${storageInfoList.storage_name == storageName.storage_name}">
										<div class="service-1-text">
											<c:choose>
												<c:when test="${storageInfoList.info_use eq '미사용'}">
													<p>
														<a id="unUsedMember" onclick="unUseStorage('${storageInfoList.storage_code}','${store_code }')" data-toggle="modal" data-target="#unUsedStorage">
															${storageInfoList.storage_code}-${storageInfoList.info_num } ${storageInfoList.info_use}
														</a>
													</p>	
												</c:when>
												<c:otherwise>
													<p>
														<a id="useMember" onclick="useStorageInfo('${storageInfoList.offer_code}','${store_code }')" data-toggle="modal" data-target="#storageInfo">
															${storageInfoList.storage_code}-${storageInfoList.info_num } ${storageInfoList.info_use}
														</a>
													</p>
												</c:otherwise>
											</c:choose>
										</div>
									</c:if>
								</c:forEach>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<div class="def-section services-1">
		<div class="container">
			<div class="row">
				
			</div>
		</div>
	</div>
	
	<!-- 이용중인 회원 정보 Modal -->
	<div class="modal fade" id="storageInfo" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLongTitle">스토리지 정보</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        	<table id="infoStorage">
	        		<tr>
	        			<th style="width: 33%; font-size: 16pt; padding:30px;">고객명</th>
	        			<td id="memberId"></td>
	        		</tr>
	        		<tr>
	        			<th style="width: 33%; font-size: 16pt; padding:30px;">사용기간</th>
	        			<td id="memberUseDate"></td>
	        		</tr>
	        		<tr>
	        			<th style="width: 33%; font-size: 16pt; padding:30px;">보관물품</th>
	        			<td id='memberStorageInfo'></td>
	        		</tr>
	        	</table>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 이용중인 회원 정보 Modal -->
	<!-- 사용안하고 있는 스토리지 할당 Modal -->
	<div class="modal fade bd-example-modal-lg" id="unUsedStorage" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<table style="width: 100%; text-align: ceneter">
						<tr>
							<td style="font-size: 16pt; padding:30px; text-align: center">
								<h4>회원 ID</h4>
								<select name="member_id" id="memberIdSelect">
									<option>현재 비어있는 스토리지</option>
								</select>
							</td>
						</tr>
						<tr>
						<c:forEach items="${offerInfoList }" var="offerInfoList">
							<td style="font-size: 16pt; padding:30px; text-align: center" id="${offerInfoList.offer_code }${offerInfoList.storage_code}" class="do">
									
							</td>
						</c:forEach>
						</tr>
						<tr>
							<td style="width: 100%; font-size: 16pt; padding:30px; text-align: center">
							
								<h4>현재 비어있는 스토리지</h4>
								<input type="hidden" class="offerCode">
								<select name="info_num" id="unUseStorageList">
										<option>현재 비어있는 스토리지</option>
								</select>
							</td>
						</tr>
						<tr>
							<td id="hiddenTr">
								<!-- Append hidden offer_code -->
							</td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" id="modal_close_btn" class="btn btn-secondary" data-dismiss="modal">CLOSE</button>
					<button type="button" class="btn btn-primary" id="storageSaveBtn">SAVE</button>
				</div>
			</div>
		 </div>
	</div>
	<!-- 온습도 -->
	<div class="modal fade" id="temHumStore" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">${stroeTemHumInfo.store_name } 온습도 관리</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	    	<div class="modal-body" style="display: table; width: 100%">
	    		
	    		<div style="display: table-cell; width: 45%;">
					<!-- 여기오는 컨트롤러에 store테이블 온습도 정보 가져오기 -->
					<h5>현재 온도 : ${stroeTemHumInfo.humidity }°C</h5><br><br>
					<h5>현재 습도 : ${stroeTemHumInfo.temperature }%</h5>
	    		</div>
				<div style="display: table-cell; width: 45%; float: rigth; margin: 0px 50px;">
					<h5>변경하실 온습도</h5>
					온도 = <input type="number" id="humidityValue" style="margin:10px 0px;"><br>
					습도 = <input type="number" id="temperatureValue">
					<form action="temHumUpdate" id="temHumUpdate">
						<input type="hidden" name="store_code" value="${store_code }">
						<input type="hidden" name="humidity" id="hiddenHumidiry" value="">
						<input type="hidden" name="temperature" id="hiddenTemperature" value="">	
					</form>
				</div>
	      	</div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" id="temHumUpdateBtn">Save</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 온습도 -->
	<!-- DB처리 -->
	<form id="updateUseStorageTable" method="post" action="updateUseStorage">
		<input type="hidden" name="store_code" value="${store_code }">
		<input type="hidden" name="info_num" id="hiddenInfoNum" value="">
		<input type="hidden" name="offer_code" id="hiddenOfferCode" value="">
	</form>
</body>
</html>