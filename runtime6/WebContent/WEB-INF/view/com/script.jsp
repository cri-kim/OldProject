<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.0.3.min.js"></script>
<script type="text/javascript" src="<spring:url value="/js/jquery/plugin/validation/jquery.validate.min.js"/>"></script>
<script type="text/javascript" src="<spring:url value="/js/jquery/plugin/storage/jquery.storageapi.min.js"/>"></script>
<script type="text/javascript">
// $.sessionStorage.set('test',{a:'val'});
	var key = 'messages.properties';
	if ($.sessionStorage.isEmpty(key)) {
		$.get('<spring:url value="/rsc/i18n"/>',
				{},
				function(response){
					$.sessionStorage.set(key,response);
				});
	}
	
// 	function getMessage(code) {
// 		var messages = $.sessionStorage.get(key);
// 		alert(message.label_name);
// 		return eval("messages." + code);
// 	}
// 	alert(getMessage("label_name"));

	var validation = {
			getMessage:function(code, args) {
				if(args == undefined){
				return eval("$.sessionStorage.get('" + key+ "')."+code.replace(/[.]/g,"_"));
				//return $.sessionStorage.get(key).label_name;
				}else {
					var msg = this.getMessage(code);
					for(var i=0; i<args.length; i++) {
						msg = msg.replace("{" + i + "}", isNaN(args[i]) ? this.getMessage(args[i]) : args[i]);
					}
					return msg;
				}
			},
			showMessage : function(errors, labelPrefix) {
// 				alert(this.getMessage("label_name"));	
				var parent = this;
				$(errors).each(function(index, error) {
					var args = error.arguments;
					var code = error.code;
					var field = error.field;
					var label = $(labelPrefix +  field).text().trim();
					label = label.length > 0 ? label : labelPrefix;
					var msg = parent.getMessage(code + "_general");
					//에러 매개변수와 갯수를 맞게 {0} 들을 치환한다.
						if(args.length == 3) {
							msg = msg.replace("{0}",label).replace("{1}",args[2]).replace("{2}",args[1]);
						}else if(args.length == 2){
							msg = msg.replace("{0}", label).replace("{1}", args[1]);
						} else {
							msg = msg.replace("{0}", label);
						}
					//해당 필드에 포커스를 준다.
					$("#" + field).focus();
						alert(msg);
						return false;
				});
			}
	};
// 	<c:set var="userInfo" value="${SPRING_SECURITY_CONTEXT.authentication.principal}" />
	var vs = {
			config : {
				contextRoot : "<spring:url value="/"/>"
			},
			session : {
				user: {
					id: "${userInfo.username}",
					name: "${userInfo.name}",
					cellPhone: "${userInfo.cellPhone}",
					email: "${userInfo.email}",
					role: [<c:forEach var="val" items="${userInfo.role}">'<c:out value="${val}"/>'</c:forEach>]
				}
			}
		}
</script>