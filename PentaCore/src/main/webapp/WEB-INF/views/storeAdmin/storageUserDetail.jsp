<%@ page language="java" contentType="text/html charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>이용고객 상세조회</h3>

<table>
<tr>
<td>
<div class="bs-example"
		style="width: 70%; margin-left: 15%; text-align: left;">
		<table class="table">
			<tbody>
				<tr>
				<th colspan="2">고객정보</th>
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
	<td>
	
<div class="bs-example"
		style="width: 70%; margin-left: 15%; text-align: left;">
		<table class="table">
			<tbody>
				<tr>
				<th colspan="2">고객정보</th>
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
	
	
	</tr>
</table>



<%-- 
<table>
   				<tr>
   				<th class="mo-tbl" style="width: 40% padding-top: 30px padding-bottom: 3%" colspan="2">    <h5>   고객 기본정보    </h5>    </th> 
   				<th class="mo-tbl" style="width: 40% padding-top: 30px padding-bottom: 3%" colspan="2">    <h5>   상담원 추가입력    <h5>    </th> 
   				<tr><th class="mo-tbl" style="width: 10% vertical-align:top">   "이름"   </th> 
   				<td class="mo-tbl">   a_name   </td> 
   				<th class="mo-tbl" style="vertical-align:top">   "신청코드"   </th> 
   				<td class="mo-tbl">   a_code   </td> 
   				<tr><th class="mo-tbl" style="vertical-align:top">   "연락처"   </th> 
   				<td class="mo-tbl">   a_tel   </td> 
   				<th class="mo-tbl" style="vertical-align:top">   "특이사항"   </th> 
   				<td class="mo-tbl">    <input type=\ text\  />    </td></tr> 
   				<tr><th class="mo-tbl" style="vertical-align:top">   "픽업일"   </th> 
   				<td class="mo-tbl">   a_start   </td> 
   				<th class="mo-tbl" style="vertical-align:top">   "운송차량"   </th> 
   				<td class="mo-tbl">    <input type=\ text\  />    </td></tr> 
   				<tr><th class="mo-tbl" style="vertical-align:top">   "운송일"   </th> 
   				<td class="mo-tbl">   a_end   </td> 
   				<th class="mo-tbl" style="vertical-align:top">   "기사배정"   </th> 
   				<td class="mo-tbl">    <input type=\ text\  />    </td></tr> 
   				<tr><th class="mo-tbl" style="vertical-align:top">   "이전주소"   </th> 
   				<td class="mo-tbl">   a_addr   </td> 
   				<th class="mo-tbl" style="vertical-align:top">   "배송주소"   </th> 
   				<td class="mo-tbl">    <input type=\ text\  />    </td></tr> 
   				<tr><th class="mo-tbl" style="vertical-align:top">   "지점명"   </th> 
   				<td class="mo-tbl">   a_store   </td> 
   				<th class="mo-tbl" style="vertical-align:top">   "스토리지"   </th> 
   				<td class="mo-tbl">   
   						 <select id="cuStorage" name="cuStorage">   
   							 <c:forEach items="${info_num}" var="info">   
   								 <option value="${info.info_num}">  ${info.storage_code}   </option> 
   							 </c:forEach> 
   						 </select></td></tr> 
   				<tr><th class="mo-tbl" style="vertical-align:top">   "이사규모"   </th> 
   				<td class="mo-tbl">   a_product   </td> 
   				<th class="mo-tbl"style="vertical-align:top">   "배송시간"   </th> 
   				<td class="mo-tbl">  
   						 <select id="convey_time" name="convey_time">  
   							 <option value="AM 11:00 ~ 12:00">   "AM 11:00 ~ 12:00"   </option>  
   							 <option value="PM 12:00 ~ 13:00">   "PM 12:00 ~ 13:00"   </option>  
   							 <option value="PM 13:00 ~ 14:00">   "PM 13:00 ~ 14:00"   </option>  
   							 <option value="PM 14:00 ~ 15:00">   "PM 14:00 ~ 15:00"   </option>  
   							 <option value="PM 15:00 ~ 16:00">   "PM 15:00 ~ 16:00"   </option>  
   							 <option value="PM 16:00 ~ 17:00">   "PM 16:00 ~ 17:00"   </option>  
   							 <option value="PM 17:00 ~ 18:00">   "PM 17:00 ~ 18:00"   </option>  
   							 <option value="PM 18:00 ~ 19:00">   "PM 18:00 ~ 19:00"   </option>  
   							 <option value="PM 19:00 ~ 20:00">   "PM 19:00 ~ 20:00"   </option>  
   						 </select></td></tr> 
   				<th class="mo-tbl" style="vertical-align:top" colspan="2"></th> 
   				<th class="mo-tbl" style="vertical-align:top" colspan="2">   "사후관리 (사진업로드)"   </th> 
   				
   				tbl.append(row) --%>

</body>
</html>