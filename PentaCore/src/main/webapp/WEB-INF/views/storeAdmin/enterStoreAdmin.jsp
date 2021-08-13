<%@ page language="java" contentType="text/html charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head> <meta charset="UTF-8">
<style type="text/css">

	.wrap {
		width: 100%;
		text-align: center;
	}
	
	.box {
		margin: 0 auto;
		display: inline-block;
		padding-top: 2%;
	}
	
	.btn {
		float: left;
	}

	#btn {
		width: 250px;
		height: 170px;
		margin: 3%;
	}
	
	.box2 {
		margin: 0 auto;
		display: inline-block;
		padding-top: 1%;
	}
	#btn2 {
		width: 825px;
		height: 50px;
		margin: 1%;
	}
	
	.btn-group-lg>.btn, .btn-lg {
    font-size: 12px;
    padding: 7px 16px;
	}

    #coupon-modal {
        display: none;
        width: 25%;
        padding: 30px 50px;
        background-color: #fefefe;
        border: 1px solid #888;
        border-radius: 3px;
    }

    #coupon-modal .modal_close_btn {
        position: absolute;
        top: 10px;
        right: 10px;
    }
    
    #coupon-modal .modal-body{
    	font-size: 10pt;
    }
    
   /*  .modal-header {
    	padding: 1em;
    } */
    td {
    text-align :center;
    }
    th {
    text-align :center;
    }
    
    input[type="text"] {
      background: white;
      border: 1px solid #5fd3e8;
      border-radius: 0.3em;
      width: 100%;
      height: 25px;
      padding: 5px;
   }

</style>

<script>
//쿠폰 입력
function insertCoupon() {
	//var data = $("form[id=frm]").serialize();
	//data = decodeURIComponent(data);
	
	var coupon_name = $('#coupon_name').val();
	var store_name = $('#store_name').val();
	var coupon_discount = $('#coupon_discount1').val();
	var coupon_start = $('#coupon_start').val();
	var coupon_end = $('#coupon_end').val();
	

	
	if ($('#coupon_name').val() == "") {
		alert('쿠폰이름을 입력하세요.');
		$('#coupon_name').focus();
		return false;
	}
	
	if ($('#store_name').val() == "") {
		alert('지점이름을 입력하세요.');
		$('#store_name').focus();
		return false;
	}
	
	if ($('#coupon_discount').val() == "") {
		alert('쿠폰할인률을 입력하세요.');
		$('#coupon_discount').focus();
		return false;
	}
	
	if ($('#coupon_start').val() == "") {
		alert('쿠폰시작일을 입력하세요.');
		$('#coupon_start').focus();
		return false;
	}
	
	if ($('#coupon_end').val() == "") {
		alert('쿠폰종료일을 입력하세요.');
		$('#coupon_end').focus();
		return false;
	}
	
	if(confirm('입력하시겠습니까?')){
		$.ajax({
			url: 'insertCoupon',
			type: 'POST',
			data: { coupon_name:coupon_name,
				store_name:store_name,
				coupon_discount:coupon_discount,
				coupon_start:coupon_start,
				coupon_end:coupon_end,
			
			},
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
</script>

</head>
<body>
	<div class="wrap">
		<div class="box">
			<div class="btn">
				<button type="button" id="btn" class="btn btn-primary btn-lg" onclick="location.href='storageInfo?store_code=${employeeVO.store_code}'"><h2>스토리지 현황</h2></button>
			</div>
			<div class="btn">
				<button type="button" id="btn" class="btn btn-primary btn-lg" onclick="location.href='customerManage'">
					<h2>고객관리</h2></button>
			</div>
			<div class="btn">
				<button type="button" id="btn" class="btn btn-primary btn-lg" onclick="location.href=''">
					<h2>투어관리</h2></button>
			</div>
		</div>
		<div></div>
		<div class="box">
			<div class="btn">
				<button type="button" id="btn" class="btn btn-primary btn-lg" onclick="location.href='storeNotice'">
					<h2>공지사항</h2></button>
			</div>
			<div class="btn">
				<button type="button" id="btn" class="btn btn-primary btn-lg" onclick="location.href='store/supervisionAsk'">
					<h2>1:1 문의</h2></button>
			</div>
			<div class="btn">
				<button type="button" id="btn" class="btn btn-primary btn-lg" onclick="location.href=''">
					<h2>물품운송</h2></button>
			</div>
		</div>
		<div></div>
		<div class="box2">
			<div class="btn">
				<button type="button" id="btn2" class="btn btn-primary btn-lg" >
					<h4>쿠폰등록</h4></button>
			</div>
		</div>
		
		<div id="coupon-modal">
			<form id="frm">
				<a class="modal_close_btn">닫기</a>
				<div class="modal-header"></div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<button id="edit-btn" type="button" onclick="insertCoupon()">입력</button>
				</div>
			</form>
		</div>
		
	</div>
	
	
<!-- 보고서 모달 여는 script -->
<script>
$(function() {
	$('#btn2').on('click', function showCouponInsert()  {
			
			
			modal('coupon-modal');
			

			var title = '<h3 align="center">쿠폰등록</h3>';
			
			var tbl =$('<table width="100%" align="center"/>');
			
			//쿠폰이름
			var row = '<tr>';
			row += '<th style="width: 30%;">쿠폰이름</th>';
			row += '<td style="text-align: center;"><input type="text" name="coupon_name" id="coupon_name" value="☆☆점 오픈 프로모션 ☆% 할인" />';
			row +=	'</td>';
			row +=	'</tr>';
			
			row += '<br><br>';
			
			//적용지점
			row += '<tr>';
			row += '<th style="width: 30%;">적용지점</th>';
			row += '<td style="text-align: center;"><select class="custom-select" name="store_name" id="store_name">';
			row += '<option selected>지점을 선택하세요</option>';
			row += '<option value="중구점">중구점</option>';
			row += '<option value="청라언덕점">청라언덕점</option>';
			row += '<option value="상인점">상인점</option>';
			row += '<option value="시지점">시지점</option>';
			row += '<option value="경산영대점">경산영대점</option>';
			row += '</select></td>';
			row += '</tr>';
			
			row += '<br><br>';
			
			//할인율
			row += '<tr>';
			row += '<th style="width: 30%;">할인율</th>';
			row += '<td style="text-align: center;"><select class="custom-select" name="coupon_discount1" id="coupon_discount1">';
			row +='<option selected>할인율을 선택하세요</option>';
			row += '<option value="0.95">5프로 할인</option>';
			row += '<option value="0.9">10프로 할인</option>';
			row += '<option value="0.85">15프로 할인</option>';
			row += '<option value="0.8">20프로 할인</option>';
			row += '<option value="0.75">25프로 할인</option>';
			row += '<option value="0.7">30프로 할인</option>';
			row += '<option value="0.65">35프로 할인</option>';
			row += '<option value="0.6">40프로 할인</option>';
			row += '<option value="0.55">45프로 할인</option>';
			row += '<option value="0.5">50프로 할인</option>';
			row += '</select></td>';
			row +=	'</tr>';
			
			row += '<br><br>';
			
			//시작날짜
			row += '<tr>';
			row += '<th style="width: 30%;">시작날짜</th>';
			row += '<td style="text-align: center;"><div class="con-data"><input type="date" id="coupon_start" name="coupon_start" /></div>';
			row +=	'</td>';
			row +=	'</tr>';
			
			row += '<br><br>';
			
			//종료날짜
			row += '<tr>';
			row += '<th style="width: 40%;">종료날짜</th>';
			row += '<td style="text-align: center;"><div class="con-data"><input type="date" id="coupon_end" name="coupon_end" /></div>';
			row +=	'</td>';
			row +=	'</tr>';
			
			
			tbl.append(row);
			
			
			$(".modal-header").append(title);
			//$(".modal-body").append(title);
			$(".modal-body").append(tbl);
			//CK에디터용 기본 값 붙이기
			//CKEDITOR.instances['condition_comment'].setData(noContent);
			//
		
			
	});

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
	
</body>
</html>