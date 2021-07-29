<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="pagination">
   <a href="javascript:goPage(${param.firstPageNo})" class="first">처음페이지</a>
   <a href="javascript:goPage(${param.prevPageNo})" class="prev">이전페이지</a>
   <span> <c:forEach var="i" begin="${param.startPageNo}"
         end="${param.endPageNo}" step="1">
         <c:choose>
            <c:when test="${i eq param.pageNo}">
               <a href="javascript:goPage(${i})" class="active">${i}</a>
            </c:when>
            <c:otherwise>
               <a href="javascript:goPage(${i})">${i}</a>
            </c:otherwise>
         </c:choose>
      </c:forEach>
   </span> <a href="javascript:goPage(${param.nextPageNo})" class="next">다음페이지</a>
   <a href="javascript:goPage(${param.finalPageNo})" class="last">마지막페이지</a>
</div>