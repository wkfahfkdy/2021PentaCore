<%@ page language="java" contentType="text/html charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
		
		$.ajax({
			url : 'laundryConsignUpdate',
			data : {
				laundry_consign : $('#apply_start2').val(),
				offer_code : ${selectUserVO.offer_wash }
			},
			type : 'post',
			success : function(success) {
				alert('위탁날짜가 입력되었습니다..');
			},
			error : function(err) {
				alert('에러가 발생했습니다. 관리자에게 문의해주세요.');
			}
		});
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
<div style="margin-right: 15%">
<h3>이용고객 상세조회</h3>
<br>
<br>
</div>
<table>
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
				<td colspan="2">${selectUserVO.use_start }</td>
				</tr>
				<tr>
				<th>사용종료</th>
				<td colspan="2">${selectUserVO.use_end }</td>
				</tr>
				<tr>
				<th>프리미엄</th>
				<td>${selectUserVO.offer_premium }</td>
				<td><button type="button" class="btn btn-light" style="background-color:#6BAAFA; color:white;" id="premiumReportInsert" name="premiumReportInsert"><b>보고서 등록</b></button></td>
				</tr>
				
				
				<c:choose>
				<c:when test="${selectUserVO.offer_wash eq 'Y'}">
				
				<tr>
				<th>세탁관리</th>
				<td>${selectUserVO.offer_wash }</td>
				<td><button type="button" class="btn btn-light" style="background-color:#6BAAFA; color:white;" id="laundryInfoInput" name="premiumReport"><b>확인</b></button></td>
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
				id="laundryConsignChange" name="laundryConsignChange" value="">수정</button>				    
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
				id="laundryConsign" name="laundryConsign" value="">입력</button>
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
				id="laundryCollectChange" name="laundryCollectChange" value="">수정</button>				    
				 </td>
				</c:when>
				
				
				<c:otherwise>
				<td>
				<div class="form-condata">
					<div class="con-data"><input type="date" id="apply_end2" name="apply_end2" /></div>	
					</div>
					</td>
					<td>
					<button type="button" class="btn btn-light" style="background-color:#6BAAFA; color:white;" 
				id="laundryCollect" name="laundryCollect" value="">입력</button>
					</td>
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
</div>


<div id="report-modal">
			<form id="frm">
			<input type="hidden" id="use_num" name="use_num" value="" />
				<a class="modal_close_btn">닫기</a>
				<div class="modal-header"></div>
				<div class="modal-body"></div>
				<textarea id="condition_comment" name="condition_comment"></textarea>
				<div class="modal-footer">
					<button id="edit-btn" type="button" onclick="insertReport()">입력</button>
				</div>
			</form>
		</div>

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

			var title = '<input type="text" id="condition_title" name="condition_title" value="'+ member_name + '님 컨디션보고서" />';
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