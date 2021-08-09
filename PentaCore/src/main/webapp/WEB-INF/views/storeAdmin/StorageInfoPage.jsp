<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스토리지 현황</title>
<style type="text/css">
	.storageList {
		width: 30%; 
		border-radius: 5px;
		background-color: rgb(224, 224, 224);
		margin: 10px 10px;
	}
	a:visited {
		color: #00c0e2;
	}
	a:hover {
		color:  rgb(52, 152, 219);
	}
</style>
</head>
<body>
	<div class="def-section services-1">
		<div class="container">
			<div class="row">
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
													<p>${storageInfoList.storage_code}-${storageInfoList.info_num } ${storageInfoList.info_use}</p>	
												</c:when>
												<c:otherwise>
													<p><a onclick="location.href='usedStorage?offer_code=${storageInfoList.offer_code}'" data-toggle="modal" data-target="#storageInfo">${storageInfoList.storage_code}-${storageInfoList.info_num } ${storageInfoList.info_use}</a></p>
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
	<!-- Modal -->
	<div class="modal fade" id="storageInfo" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        	
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>