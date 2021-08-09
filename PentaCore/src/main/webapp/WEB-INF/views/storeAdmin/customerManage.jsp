<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- private String num;
	private String use_num;
	private Date use_start;
	private Date use_end;
	private String info_num;
	private String store_code;
	private String offer_code;
	private String member_id;
	private String member_name;
	 -->
<script>

$.ajax({
	url:'storeAddr',	// HomeController > 나중에 위치 변경
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
					width: 200,
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
			//bodyHeight: 200,
			pageOptions: {
				// 무한 스크롤 혹은 페이징 처리 시 기능 사용한다는 옵션
				useClient: true,
			    // 무한스크롤 옵션 
			    //type: 'scroll'
			}
		});


	function formCheck(chk, gubun) {
		if (gubun == "quiry") {
			if (frm.question_content.value == "") {
				alert("문의 댓글을 남겨주세요!");
				frm.question_content.focus();

				return false;
			}

			if (chk == "no") {
				var check = confirm("LOGIN 후 문의해주세요!")
				if (check == true) {
					location.href = "memberLoginForm";
				} else {
					frm.question_content.focus();
				}
			} else {
				frm.submit();
			}
		} else if (gubun == "reply") {
			if (chk == "no") {
				var check = confirm("LOGIN 후 클릭해주세요!")
				if (check == true) {
					location.href = "memberLoginForm";
				}
			} else {
				location.href="replyList";
			}
		}
	}

	function goPage(page) {
		location.href = "customerManage?page=?" + page "page2=?" + page2;
	}
</script>
</head>
<body>


	<div class="title-group" style="margin-top: 70px;">
		<div class="subtitle with-square"><h5>이용중인 고객 리스트</h5></div>
	</div>

	<div style="clear: both; width: 100%; height: 20px;"></div>

	<!-- === TABLE DEFAULT === -->

	<div class="bs-example"
		style="width: 70%; margin-left: 15%; text-align: left;">
		<table class="table">
			<tbody>
				<tr>
				<td>NO.</td>
				<td>NAME</td>
				<td>스토리지 지정상태</td>
				</tr>
				<c:choose>
							<c:when test="${usingStorageList eq null}">
								<td>이용중인 고객이 없습니다.</td>
							</c:when>
						
				<c:otherwise>	
				<c:forEach items="${usingStorageList }" var="vo">
					<tr>
						<td>${vo.num }</td>
						<td>${vo.member_name }</td>
						<td>${vo.info_num }</td>
					</tr>
					</c:forEach>
				</c:otherwise>	
				</c:choose>
				
		</table>
		<!-- 페이징 -->
		<div align="center">
			<jsp:include page="../storeAdmin/paging.jsp" flush="true">
				<jsp:param value="${paging.firstPageNo }" name="firstPageNo" />
				<jsp:param value="${paging.prevPageNo }" name="prevPageNo" />
				<jsp:param value="${paging.startPageNo }" name="startPageNo" />
				<jsp:param value="${paging.pageNo }" name="pageNo" />
				<jsp:param value="${paging.endPageNo }" name="endPageNo" />
				<jsp:param value="${paging.nextPageNo }" name="nextPageNo" />
				<jsp:param value="${paging.finalPageNo }" name="finalPageNo" />
			</jsp:include>
			
			
		</div>
	</div>
	
	
	
	<div class="bs-example"
		style="width: 70%; margin-left: 15%; text-align: left;">
		<table class="table">
			<tbody>
				<tr>
				<td>NO.</td>
				<td>NAME</td>
				<td>스토리지 지정상태</td>
				</tr>
				<c:choose>
							<c:when test="${usingStorageList eq null}">
								<td>이용중인 고객이 없습니다.</td>
							</c:when>
						
				<c:otherwise>	
				<c:forEach items="${usingStorageList }" var="vo">
					<tr>
						<td>${vo.num }</td>
						<td>${vo.member_name }</td>
						<td>${vo.info_num }</td>
					</tr>
					</c:forEach>
				</c:otherwise>	
				</c:choose>
				
		</table>
		<!-- 페이징 -->
		<div align="center">
			<jsp:include page="../storeAdmin/paging.jsp" flush="true">
				<jsp:param value="${paging.firstPageNo }" name="firstPageNo" />
				<jsp:param value="${paging.prevPageNo }" name="prevPageNo" />
				<jsp:param value="${paging.startPageNo }" name="startPageNo" />
				<jsp:param value="${paging.pageNo }" name="pageNo" />
				<jsp:param value="${paging.endPageNo }" name="endPageNo" />
				<jsp:param value="${paging.nextPageNo }" name="nextPageNo" />
				<jsp:param value="${paging.finalPageNo }" name="finalPageNo" />
			</jsp:include>
			
			
		</div>
	</div>
	
	

</body>
</html>