<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<script>
		var storeid = "${feedbackvo.storeid}";
		self.location = "${pageContext.request.contextPath}/starUpdateAll";
		self.location = "/main/dtpage?storeid=" + storeid;
	</script>
</body>
</html>

