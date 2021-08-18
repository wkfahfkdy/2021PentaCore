<%@ page language="java" contentType="text/html charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 이유는 모르겠는데 아래 5줄의 css, js 가져오는 것들 순서 바뀌면 Grid 작동 제대로 안해요 -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/v1.5.0/tui-code-snippet.js"></script>
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<title>Insert title here</title>

<style>
	.wrap {
			margin: auto;
			text-align: center;
			padding: 50px 10px;
			width: 80%;
		}
		
   .apply-btn, #edit-btn {
    	background-color: #00c0e2;
		border-radius: 0.3em;
		color: white;
		font-size: 12pt;
		padding: 0.4em;
    }
		
	.back-btn, #del-btn {
    	background-color: #006DFC;
		border-radius: 0.3em;
		color: white;
		font-size: 12pt;
		padding: 0.4em;
    }
    
    #report-modal {
        display: none;
        width: 60%;
        padding: 30px 50px;
        background-color: #fefefe;
        border: 1px solid #888;
        border-radius: 3px;
    }

    #report-modal .modal_close_btn {
        position: absolute;
        top: 10px;
        right: 10px;
    }
    
    #report-modal .modal-body{
    	font-size: 10pt;
    }
    
    .modal-header {
    	padding: 1em;
    }
    
   	input[type="text"] {
		background: white;
		border: 1px solid #5fd3e8;
		border-radius: 0.3em;
		width: 80%;
		height: 2.5em;
		padding: 5px;
		margin: 1em 0em;
	}
	
	#cke_editor1 {	/* 시도때도 없이 나오는 CK에디터 머리 참수 */
		display: none;
	}
	
	div.modal-body img {	/* Modal창 안에 표시되는 내용의 이미지 사이즈 강제 조정*/
		max-width: 100%;
		height: auto;
	}
	.tui-grid-rside-area {
		width: 100%;
	}
</style>

<!-- 게시판 오픈소스 : ckEditor4 -->
<script src="//cdn.ckeditor.com/4.16.1/standard/ckeditor.js"></script>


<script>
$(function() {
	CKEDITOR.replace('condition_comment', {
		filebrowserUploadUrl:'${pageContext.request.contextPath }/fileUpload/imageUpload',
		enterMode : CKEDITOR.ENTER_BR,
		shiftEnterMode : CKEDITOR.ENTER_P,
		width: '100%'
	});
})
/* 
//CK 에디터 이미지 업로드시 업로드 탭으로 바로 시작하게 하기
CKEDITOR.on('dialogDefinition', function (ev) {
        var dialogName = ev.data.name;
        var dialog = ev.data.definition.dialog;
        var dialogDefinition = ev.data.definition;
       
        if (dialogName == 'image') {
            dialog.on('show', function (obj) {
                this.selectPage('Upload'); //업로드텝으로 시작
            });
            dialogDefinition.removeContents('advanced'); // 자세히탭 제거
            dialogDefinition.removeContents('Link'); // 링크탭 제거
        }
    });
 */
// 공지사항 수정 함수
function insertReport() {
	var data = $("form[id=frm]").serialize();
	//CK에디터 수정한 내용 받아오기...
	var myText = CKEDITOR.instances['condition_comment'].getData();
	console.log(data+myText);
	
	//condition_title, condition_comment, use_num
	
	if(confirm('입력하시겠습니까?')){
		$.ajax({
			url: 'insertReport',
			type: 'POST',
			data: data+myText,
			success: function(result) {
				console.log(result);
				alert('입력이 완료되었습니다.');
				location.reload();
			},
			
			error: function(xhr, status, msg) {
				alert('입력에 실패하였습니다. 광고차단앱 사용시 입력이 불가합니다. 상태값 : ' + status + '에러메시지 : ' + msg);
			}
		})
	} else {
		return false;
	}
}

/* // 컨디션보고서 삭제 함수
function deleteReport() {
	var use_num = $('#frm #use_num').val();  
	console.log(use_num);
	
	if(confirm('삭제하시겠습니까?')){
		$.ajax({
			url: 'deleteReport/'+use_num,
			type: 'GET',
			success: function(result) {
				console.log(result);
				alert('삭제가 완료되었습니다.');
				location.reload();
			},
			error: function(xhr, status, msg) {
				alert('삭제에 실패하였습니다. 상태값 : ' + status + '에러메시지 : ' + msg);
			}
		})
	} else {
		return false;
	}
} */
</script>

<!-- 세탁물 위탁날짜 입력 -->
<script>
$(function() {
	$('#laundryConsign').on('click', function()  {
		
		var getOffer_code = '${selectUserVO.offer_code }';
		var getLaundry_consign = $('#apply_start2').val();
		
		if(confirm('입력하시겠습니까?')){
		$.ajax({
			url : 'laundryConsignUpdate',
			data : {
				laundry_consign : getLaundry_consign,
				offer_code : getOffer_code
			},
			type : 'post',
			success : function(success) {
				alert('위탁날짜가 입력되었습니다.');
				location.reload();
			},
			error : function(err) {
				alert('에러가 발생했습니다. 관리자에게 문의해주세요.');
			}
		});
		} else {
			return false;
		}
	});
});

</script>

<!-- 세탁물 회수날짜 입력 -->
<script>
$(function() {
	$('#laundryCollect').on('click', function()  {
		
		var getOffer_code = '${selectUserVO.offer_code }';
		var getLaundry_collect = $('#apply_end2').val();
		
		if(confirm('입력하시겠습니까?')){
		$.ajax({
			url : 'laundryCollectUpdate',
			data : {
				laundry_collect : getLaundry_collect,
				offer_code : getOffer_code
			},
			type : 'post',
			success : function(success) {
				alert('회수날짜가 입력되었습니다.');
				location.reload();
			},
			error : function(err) {
				alert('에러가 발생했습니다. 관리자에게 문의해주세요.');
			}
		});
		} else {
			return false;
		}
	});
});

</script>


<!-- 세탁물 위탁날짜 수정 -->
<script>
$(function() {
	$('#laundryConsignChange').on('click', function()  {
		
		var getOffer_code = '${selectUserVO.offer_code }';
		var getLaundry_consign = $('#apply_start').val();
		
		if(confirm('수정하시겠습니까?')){
		$.ajax({
			url : 'laundryConsignUpdate',
			data : {
				laundry_consign : getLaundry_consign,
				offer_code : getOffer_code
			},
			type : 'post',
			success : function(success) {
				alert('위탁날짜가 수정되었습니다.');
				location.reload();
			},
			error : function(err) {
				alert('에러가 발생했습니다. 관리자에게 문의해주세요.');
			}
		});
		} else {
			return false;
		}
	});
});
</script>

<!-- 세탁물 회수날짜 입력 -->
<script>
$(function() {
	$('#laundryCollectChange').on('click', function()  {
		
		var getOffer_code = '${selectUserVO.offer_code }';
		var getLaundry_collect = $('#apply_end').val();
		
		
		if(confirm('수정하시겠습니까?')){
		$.ajax({
			url : 'laundryCollectUpdate',
			data : {
				laundry_collect : getLaundry_collect,
				offer_code : getOffer_code
			},
			type : 'post',
			success : function(success) {
				alert('회수날짜가 수정되었습니다.');
				location.reload();
			},
			error : function(err) {
				alert('에러가 발생했습니다. 관리자에게 문의해주세요.');
			}
		});
		} else {
			return false;
		}
	});
});

</script>



</head>
<body>

<!-- 
	//고객관리부분 offer
	private String offer_premium;
	private String offer_wash;
	private String laundry_consign;
	private String laundry_collect;
	
	//고객관리부분
	private String num;
	private String use_num;
	@JsonFormat(pattern = "yyyy-mm-dd")
	private Date use_start;
	@JsonFormat(pattern = "yyyy-mm-dd")
	private Date use_end;
	private String info_num;
	private String store_code;
	private String offer_code;
	private String member_id;
	private String member_tel;
	
	// Storage_Info
	private String info_use;
	private String storage_code;
	private String storage_name;
	private String offer_product;
	 -->

<div align="center">
<div style="text-align: center">
<h3 align="center">이용고객 상세조회</h3>
<br>
<br>
</div>
<form id="frm" action="" method="post" >
<table style="width: 70%">
<tr>
<td>
<div class="bs-example"
		style="width: 100%; height: 100%; text-align: left;">
		<table class="table">
				<tr style="background-color:#6BAAFA">
				<th colspan="2" style="color:white ; text-align:center">고객정보</th>
				</tr>
				<tr>
				<th>ID</th>
				<td>${selectUserVO.member_id }</td>
				</tr>
				<tr>
				<th>이름</th>
				<td>${selectUserVO.member_name }</td>
				</tr>
				<tr>
				<th>전화번호</th>
				<td>${selectUserVO.member_tel }</td>
				</tr>
				<%-- 
				<th>결제수단</th>
				<td>${selectUserVO. }</td>
				</tr>
 				--%>				
		</table>
			
	</div>
	</td>
	<td width="100em"></td>
	
	
	<td>
	
	 
<div class="bs-example"
		style="width: 100%; height: 100%; text-align: left;">
		<table class="table">
			<tbody>
				<tr style="background-color:#6BAAFA" >
				<th colspan="3" style="color:white ; text-align:center">사용중인 서비스</th>
				</tr>
				<tr>
				<th>스토리지</th>
				<td colspan="2">${selectUserVO.info_num }</td>
				</tr>
				<tr>
				<th>보관물품</th>
				<td colspan="2">${selectUserVO.offer_product }</td>
				</tr>
				<tr>
				<th>사용기간</th>
				<td colspan="2"><fmt:formatDate value="${selectUserVO.use_start }" pattern="yyyy-MM-dd" /></td>
				</tr>
				<tr>
				<th>사용종료</th>
				<td colspan="2"><fmt:formatDate value="${selectUserVO.use_end }" pattern="yyyy-MM-dd" /></td>
				</tr>
				<tr>
				<th>프리미엄</th>
				<td>${selectUserVO.offer_premium }</td>
				<td>
					<c:if test="${selectUserVO.offer_premium eq 'Y' }">
						<input type="hidden" id="hiddenMemberId" value="${selectUserVO.member_id }">
						<button type="button" class="btn btn-light" style="background-color:#6BAAFA; color:white;" id="premiumReportInsert" name="premiumReportInsert"><b>보고서 등록</b></button>
					</c:if>
				</td>
				</tr>
				
				<c:choose>
				<c:when test="${selectUserVO.offer_wash eq 'Y'}">
				
				<tr>
				<th>세탁관리</th>
				<td>${selectUserVO.offer_wash }</td>
				<td></td>
				</tr>
				
				<tr>
				<th>위탁날짜</th>
				
				<c:choose>
				
				<c:when test="${!empty selectUserVO.laundry_consign }">
				<td>
					<p>${selectUserVO.laundry_consign }</p>
					<div class="con-data"><input type="date" id="apply_start" name="apply_start" /></div>
				</td>
				<td>
				<button type="button" class="btn btn-light" style="background-color:#6BAAFA; color:white;" 
				id="laundryConsignChange" name="laundryConsignChange" value=""><b>수정</b></button>				    
				 </td>
				</c:when>
				
				
				<c:otherwise>
				<td>
				<div class="form-condata">
					<div class="con-data"><input type="date" id="apply_start2" name="apply_start2" /></div>	
					</div>
					</td>
					<td>
					<button type="button" class="btn btn-light" style="background-color:#6BAAFA; color:white;" 
				id="laundryConsign" name="laundryConsign" value=""><b>입력</b></button>
					</td>
				</c:otherwise>
				</c:choose>
				
				
				
				</tr>
				
				<tr>
				<th>회수날짜</th>
				
				
				
				<c:choose>
				<c:when test="${!empty selectUserVO.laundry_collect}">
				<td>
					<p>${selectUserVO.laundry_collect }</p>
					<div class="con-data"><input type="date" id="apply_end" name="apply_end" /></div>
				</td>
				<td>
				<button type="button" class="btn btn-light" style="background-color:#6BAAFA; color:white;" 
				id="laundryCollectChange" name="laundryCollectChange" value=""><b>수정</b></button>				    
				 </td>
				</c:when>
				
				
				<c:otherwise>
				<c:if test="${!empty selectUserVO.laundry_consign}">
				<td>
				<div class="form-condata">
					<div class="con-data"><input type="date" id="apply_end2" name="apply_end2" /></div>	
					</div>
					</td>
					<td>
					<button type="button" class="btn btn-light" style="background-color:#6BAAFA; color:white;" 
				id="laundryCollect" name="laundryCollect" value=""><b>입력</b></button>
					</td>
					</c:if>
				</c:otherwise>
				</c:choose>
				
				</tr>	
				
				</c:when>	
				
				
				
				<c:otherwise>
				
				<tr>
				<th>세탁관리</th>
				<td colspan="2">${selectUserVO.offer_wash }</td>
				</tr>
				
				</c:otherwise>
				
				</c:choose>	
		</table>
	</div>
	</td>
	
	
	</tr>
</table>
</form>
</div>


	<!-- 사후보고서 그리드 div -->
	<div style="margin: 50px auto; text-align: center; width: 50%" id="gridTag">
		<div id="grid"></div>
	</div>
	<div id="report-modal">
			<form id="frm">
			<input type="hidden" id="hiddenConditionNum" name="condition_num" value=""/>
				<a class="modal_close_btn">닫기</a>
				<div class="modal-header"></div>
				<div class="modal-body"></div>
				<textarea id="condition_comment" name="condition_comment"></textarea>
				<div class="modal-footer">
					<button id="edit-btn" type="button" onclick="updateReport()">수정</button>
				</div>
			</form>
		</div>
	<script src="//cdn.ckeditor.com/4.16.1/standard/ckeditor.js"></script>
	<!-- 동영 사후보고서 확인 Grid-->
	<script>
		
		
		//CK 에디터 이미지 업로드시 업로드 탭으로 바로 시작하게 하기
			CKEDITOR.on('dialogDefinition', function (ev) {
		            var dialogName = ev.data.name;
		            var dialog = ev.data.definition.dialog;
		            var dialogDefinition = ev.data.definition;
		           
		            if (dialogName == 'image') {
		                dialog.on('show', function (obj) {
		                    this.selectPage('Upload'); //업로드텝으로 시작
		                });
		                dialogDefinition.removeContents('advanced'); // 자세히탭 제거
		                dialogDefinition.removeContents('Link'); // 링크탭 제거
		            }
			});
		$(document).ready(function (){
			
			// 사후보고서 Grid 생성
			var member_id = $('#hiddenMemberId').val();
			$.ajax({
				url : 'premiumReportList',
				data : {member_id : member_id},
				dataType : 'JSON',
				success: function(data){
					// ajax 결과가 하나도 없으면 그냥 저거 적어주고
					if(data.length == 0){
						$('#grid').html("<h4 align='center'>아직 등록 된 보고서가 없습니다</h4>");
					} else {
						// 보고서 하나라도 있으면 그리드 생성
						var ReportGrid = new tui.Grid({
							el: document.getElementById('grid'), 
							data: data,
							columns: [ 
								{ 
									header: 'NO.', 
									name: 'condition_num', 
									align: 'center',
									width: 'auto',
									filter: 'select'
								}, 
								{ 
									header: 'Title', 
									name: 'condition_title', 
									align: 'center',
									width: 'auto',
									filter: 'select'
								},
								{ 
									header: '날짜', 
									name: 'condition_date', 
									align: 'center',
									width: 'auto',
									filter: 'select'
								} 
							],
							//페이징처리
							pagination: true,
							
							pageOptions: {
								// 무한 스크롤 혹은 페이징 처리 시 기능 사용한다는 옵션
								useClient: true,
								perPage: 4
							}
						});
						// 리포트 리스트 클릭할때 ajax 호출 (member_id, condition_num)
						ReportGrid.on("dblclick", function(ev) {
							var target = ev;
							var member_id = ReportGrid.getValue(ev.rowKey, 'member_id');
							var condition_num = ReportGrid.getValue(ev.rowKey, 'condition_num');
							$.ajax({
								url : 'premiumReportSelect',
								dataType : 'JSON',
								type : 'GET',
								data : {
									member_id : member_id,
									condition_num : condition_num
								},
								success : function(result){
									// 모달 생성 함수 호출
									showReport(result);
								},
								error : function(xhr,status,msg){
									alert("상태값 : "+status+" Http 에러메시지 : "+msg);
								}
							});
							// 모달 창에 ajax 결과 값 붙이기
							function showReport(data){
								
								modal('report-modal');
								var condition_num = data.condition_num;
								var condition_title = data.condition_title;
								var condition_text = data.condition_comment;
								var condition_date = data.condition_date;
								var member_id = data.member_id;
								var modalTitle = '<input type="text" id="condition_title" name="condition_title" value="'+condition_title+'">';
								
								var table =$('<table width="100%" />');
								var trTag = '<tr>';
								trTag += '<th style="width: 10%;">'+member_id+'님의 보고서</th>';
								table.append(trTag);
								
								$('.modal-header').append(modalTitle);
								$('.modal-body').append(table);
								// CK 에디터 기본 값 append
								console.log(condition_num);
								CKEDITOR.instances['condition_comment'].setData(condition_text);
								// update 용 condition_list 테이블의 condition_num (PK)를 hidden value에 넣어줌
								$('#hiddenConditionNum').val(condition_num);
								
							}
							
							function modal(id) {
							    var zIndex = 9999;
							    var modal = document.getElementById(id);
						
							    // 모달 div 뒤에 희끄무레한 레이어
							    var bg = document.createElement('div');
							    bg.setStyle({
							        position: 'fixed',
							        zIndex: zIndex,
							        left: '0px',
							        top: '0px',
							        width: '100%',
							        height: '100%',
							        overflow: 'auto',
							        // 레이어 색갈은 여기서 바꾸면 됨
							        backgroundColor: 'rgba(0,0,0,0.4)'
							    });
							    document.body.append(bg);
						
							    // 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
							    modal.querySelector('.modal_close_btn').addEventListener('click', function() {
							        bg.remove();
							        $('.modal-header').empty();
							        $('.modal-body').empty();
							        modal.style.display = 'none';
							    });
						
							    modal.setStyle({
							        position: 'fixed',
							        display: 'block',
							        boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',
						
							        // 시꺼먼 레이어 보다 한칸 위에 보이기
							        zIndex: zIndex + 1,
						
							        // div center 정렬
							        top: '50%',
							        left: '50%',
							        transform: 'translate(-50%, -50%)',
							        msTransform: 'translate(-50%, -50%)',
							        webkitTransform: 'translate(-50%, -50%)'
							    });
							}
						});
					}
				},
				error : function(err) {
					console.log(err);
				}
			});
		});
		// 사후보고서 수정
		function updateReport() {
			var data = $("form[id=frm]").serialize();
			//CK에디터 수정한 내용 받아오기...
			var myText = CKEDITOR.instances['notice_content'].getData();
			console.log(data+myText);
			
			if(confirm('수정하시겠습니까?')){
				$.ajax({
					url: 'editNotice',
					type: 'POST',
					data: data+myText,
					success: function(result) {
						console.log(result);
						alert('수정이 완료되었습니다.');
						location.reload();
					},
					
					error: function(xhr, status, msg) {
						alert('수정에 실패하였습니다. 상태값 : ' + status + '에러메시지 : ' + msg);
					}
				})
			} else {
				return false;
			}
		}
	</script>
</body>

<!-- 보고서 모달 여는 script -->
<script>
$(function() {
	$('#premiumReportInsert').on('click', function showReport()  {
			
			
			modal('report-modal');
			
			var today = new Date();   
			var year = today.getFullYear(); // 년도
			var month = today.getMonth() + 1;  // 월
			var day = today.getDate();  // 날짜
			
			var member_name = '${selectUserVO.member_name }';
			var use_num = '${selectUserVO.use_num }';

			var title = '<input type="text" id="condition_title" name="condition_title" value="컨디션보고서" />';
			var date = year + "/" + month + "/" + day;
			
			var tbl =$('<table width="100%" />');
			var row = '<tr>';
			row += '<th style="width: 10%;">작성일자</th>';
			row += '<td style="text-align: left;">' + date + '</td></tr>';
			tbl.append(row);
			
			$(".modal-header").append(title);
			$(".modal-body").append(tbl);
			//CK에디터용 기본 값 붙이기
			//CKEDITOR.instances['condition_comment'].setData(noContent);
			// input type hidden value값 붙이기
			$('#use_num').attr('value',use_num);
		
			
	})

		function modal(id) {
		    var zIndex = 9999;
		    var modal = document.getElementById(id);
	
		    // 모달 div 뒤에 희끄무레한 레이어
		    var bg = document.createElement('div');
		    bg.setStyle({
		        position: 'fixed',
		        zIndex: zIndex,
		        left: '0px',
		        top: '0px',
		        width: '100%',
		        height: '100%',
		        overflow: 'auto',
		        // 레이어 색갈은 여기서 바꾸면 됨
		        backgroundColor: 'rgba(0,0,0,0.4)'
		    });
		    document.body.append(bg);
	
		    // 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
		    modal.querySelector('.modal_close_btn').addEventListener('click', function() {
		        bg.remove();
		        $('.modal-header').empty();
		        $('.modal-body').empty();
		        modal.style.display = 'none';
		    });
	
		    modal.setStyle({
		        position: 'fixed',
		        display: 'block',
		        boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',
	
		        // 시꺼먼 레이어 보다 한칸 위에 보이기
		        zIndex: zIndex + 1,
	
		        // div center 정렬
		        top: '50%',
		        left: '50%',
		        transform: 'translate(-50%, -50%)',
		        msTransform: 'translate(-50%, -50%)',
		        webkitTransform: 'translate(-50%, -50%)'
		    });
		}
	
		// Element 에 style 한번에 오브젝트로 설정하는 함수 추가
		Element.prototype.setStyle = function(styles) {
		    for (var k in styles) this.style[k] = styles[k];
		    return this;
		};
	});
</script>
</html>