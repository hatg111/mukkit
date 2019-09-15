<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include/header.jspf"%>
<style>
.select_img {
	margin-top : 20px;
}
.box-body{
	margin: 0 10px;
}
</style>
<form action="/feedback/Success" method="post" enctype="multipart/form-data">
	<!-- action="/main/dtpage" -->

	<div class="box-body">
		<div class="form-group">
			<label for="exampleInputEmail1">제목</label> <input type="text"
				id="title" name="title" class="form-control"
				placeholder="Enter Title">
		</div>

		<div class="form-group">
			<label for="exampleInputPassword1">리뷰내용</label>
			<textarea class="form-control" id="review" name="review" rows="3"
				placeholder="Enter ..."></textarea>
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
				placeholder="Enter Writer" value="${userVO.memberid}" readonly>
			<input type="hidden" name="storeid" class="form-control"
				placeholder="Enter Writer" value="${storevo.storeid}" readonly>

			<input type="file" id="imgname" name="file">
			<div class="select_img">
				<img src="" />
			</div>
			<script>
				$("#imgname").change(
						function() {
							if (this.files && this.files[0]) {
								var reader = new FileReader;
								reader.onload = function(data) {
									$(".select_img img").attr("src",
											data.target.result).width(300);
								}
								reader.readAsDataURL(this.files[0]);
							}
						});
			</script>
			<%-- <%=request.getRealPath("/")%>  --%>
		</div>

		<div class="box-footer">

			<input type="submit" value="작성완료" class="btn btn-primary">
		</div>
	</div>

</form>

<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<!-- <form method="get" action="/main/dtpage"></form> -->
<%@include file="/WEB-INF/include/footer.jspf"%>

