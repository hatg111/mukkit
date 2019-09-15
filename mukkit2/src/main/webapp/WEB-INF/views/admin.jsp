<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/resources/dist/css/joinForm.css">
<style>
.tedury{
	width: 80%;	
	height: 90%;
	margin: 0 auto;
	
}
</style>
<%@ include file="/WEB-INF/include/header.jspf"%>


<div class="tedury">
<h2>관리자페이지</h2>
<br>
<%-- <h4><a href="${pageContext.request.contextPath}/starUpdateAll">별점 업데이트 처리</a></h4> --%>

<br>
<h4><a href="${pageContext.request.contextPath}/main/storeinsert">스토어 정보 추가하기</a></h4>

</div>


<%@ include file="/WEB-INF/include/footer.jspf"%>
