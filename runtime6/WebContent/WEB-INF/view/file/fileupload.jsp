<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	window.parent.CKEDITOR.tools.callFunction(
			${uploadParam.CKEditorFuncNum}, '<spring:url value="/file/download1/"/>${business.item_f_no}', '파일이 업로드 되었습니다');
	
	window.parent.CKEDITOR.tools.callFunction(
			${uploadParam.refFunc}, ['${business.item_f_no}','${business.img_name}','${business.img_path}']);
</script>

</head>
<body>
</body>
</html>