<%@page import="org.springframework.security.core.context.SecurityContext" %>
<%@page import="com.runtime6.web.common.mvc.model.dto.runtime6User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
// response.setHeader("Pragma", "no-cache");
// response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
// response.setDateHeader("Expires", 0);

if(session.getAttribute("SPRING_SECURITY_CONTEXT")!=null){

runtime6User userInfo = (runtime6User) ((SecurityContext)session
		.getAttribute("SPRING_SECURITY_CONTEXT")).getAuthentication().getPrincipal();
request.setAttribute("userInfo",userInfo);
}
%>
<%-- <c:set var="userInfo" value="${SPRING_SECURITY_CONTEXT.authentication.principal}" /> --%>
