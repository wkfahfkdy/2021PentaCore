<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
					<c:forEach items="${noticeList }" var="nt" end="5">
					<tr>
						<td>
							${nt.notice_num }
						</td>
						<td>
							${nt.notice_title }
						</td>
						<td>
							${nt.notice_date }
						</td>
					</tr>
					</c:forEach>
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
			<c:forEach items="usingInfo" var="useInfo">
				<div class="using-storage">
					<table>
						<tr>
							<td colspan="4"></td>
							<td><h3>사용기간 : ${useInfo.use_start }~${useInfo.use_end }</h3></td>
							<td colspan="4"><button>Review</button></td>
						<tr>
						<tr>
							<td>${useInfo.store_name } ${useInfo.info_num } ${useInfo.storage_name } ${useInfo.storage_width }*${useInfo.storage_height }*${useInfo.storage_vertical } 이용중 </td>
						</tr>
						<tr>
							<td>
								이용 중인 물품 : ${useInfo.offer_product }
							</td>
						</tr>
						<tr>
							<td>
								이용 중인 서비스 : 
								<c:choose>
									<c:when test="${useInfo.offer_wash eq 'N' }">
										
									</c:when>
									<c:otherwise>
									
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</table>
				</div>
				<div class="premium-service">
				
				</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>