<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.wrap{
		margin: auto 0;
		margin-top: 20px;
		width: 90%;
	}
	
	.notice-btns{	/*공지사항 및 기능버튼들 전체 div*/
		display: table;
		width: 90%;
	}
	
	.notice{
		display: tablecell;
		width: 50%;
	}
	
	.func-btns{
		display: tablecell;
		width: 50%;
	}
	
	.using-service{	/*이용 중인 서비스 div*/
		display: table;
		width: 90%;
	}
	
	.using-storage{
		display: tablecell;
		width: 70%;
	}
	
	.premium-service{
		display: tablecell;
		width: 30%;
	}
</style>
</head>
<body>
	<div class="wrap">
		<div>
			김이담 님:)
		</div><br>
		<div class="notice-btns">
			<div class="notice">
				<table>
					<caption>
						<button>공지사항</button>
					</caption>
					<tr>
						<th>no.</th><th>제목</th><th>작성일</th>
					</tr>
					<tr>
					
					</tr>
				</table>
			</div>
			<div class="func-btns">
				<button>나의 견적서</button>
				<button>물품운송신청 및 조회</button>
				<button>투어예약신청 및 조회</button>
				<button>회원정보수정</button>
				<button>1:1문의내역</button>
				<button>Coupon & Events</button>
			</div>
		</div>
		<div class="using-service">
			<div class="using-storage">
				
			</div>
			<div class="premium-service">
			
			</div>
		</div>
	</div>
</body>
</html>