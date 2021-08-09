<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="pagination" style="font-size: 1.1em">
   <a href="javascript:goPage(${param.prevPageNo})" class="prev"> < </a> &nbsp; &nbsp;
   <span> <c:forEach var="i" begin="${param.startPageNo}"
         end="${param.endPageNo}" step="1">
         <c:choose>
            <c:when test="${i eq param.pageNo}">
               <a href="javascript:goPage(${i})" class="active">${i}&nbsp; &nbsp;</a> 
            </c:when>
            <c:otherwise>
               <a href="javascript:goPage(${i})">${i}&nbsp; &nbsp;</a>
            </c:otherwise>
         </c:choose>
      </c:forEach> 
   </span> &nbsp; <a href="javascript:goPage(${param.nextPageNo})" class="next"> > </a>
</div>