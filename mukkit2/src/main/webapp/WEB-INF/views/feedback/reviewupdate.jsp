<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include/header.jspf"%>

<form method="post">
	<!-- action="/main/dtpage" -->
	<input type="hidden" name="reviewid" value="${FeedbackVO.reviewid}" />

	<div class="box-body">
		<div class="form-group">
			<label for="exampleInputEmail1">제목</label> <input type="text"
				name="title" class="form-control" value="${FeedbackVO.title}">
		</div>

		<div class="form-group">
			<label for="exampleInputPassword1">리뷰내용</label>
			<textarea class="form-control" name="review" rows="3">${FeedbackVO.getReview}</textarea>
		</div>

		<div>
			 <input type="hidden" name="regdate"
				value="<fmt:formatDate value="${FeedbackVO.getRegdate}" pattern="yyyy-MM-dd" />"
				readonly="readonly" />
		</div>

		<div class="form-group">
		<label>맛</label>
			<input name="taste" type="radio" id="taste" value="1" />1 
			<input name="taste" type="radio" id="taste" value="2" />2
			<input name="taste" type="radio" id="taste" value="3" />3
			<input name="taste" type="radio" id="taste" value="4" />4
			<input name="taste" type="radio" id="taste" value="5" />5
				

		</div>

		<div class="form-group">
		<label>가성비</label>
			<input name="costef" type="radio" id="costef" value="1" />1 
			<input name="costef" type="radio" id="costef" value="2" />2
			<input name="costef" type="radio" id="costef" value="3" />3
			<input name="costef" type="radio" id="costef" value="4" />4
			<input name="costef" type="radio" id="costef" value="5" />5
		</div>
		

		<div class="form-group">
		<label>서비스</label>
			<input name="service" type="radio" id="service" value="1" />1 
			<input name="service" type="radio" id="service" value="2" />2
			<input name="service" type="radio" id="service" value="3" />3
			<input name="service" type="radio" id="service" value="4" />4
			<input name="service" type="radio" id="service" value="5" />5
		</div>

		<div class="form-group">
			<input type="hidden" name="memberid" class="form-control"
				placeholder="Enter Writer" value="${FeedbackVO.memberid}" readonly>
			<input type="hidden" name="storeid" class="form-control"
				placeholder="Enter Writer" value="${FeedbackVO.storeid}" readonly>
		</div>

		<div class="box-footer">
			<button type="submit">수정</button>
		</div>

	</div>
</form>

<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>

<!-- <form method="get" action="/main/dtpage"></form> -->
<%@include file="/WEB-INF/include/footer.jspf"%>


