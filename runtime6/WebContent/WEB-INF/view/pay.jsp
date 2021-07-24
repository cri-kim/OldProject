<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp"%>
<!DOCTYPE html>
<html>
<head>
   <jsp:include page="/WEB-INF/view/com/meta.jsp" />
   <jsp:include page="/WEB-INF/view/com/favicon.jsp" />
   <jsp:include page="/WEB-INF/view/com/script.jsp" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="runtime6.pay" /></title>
<link rel="stylesheet" href="<spring:url value="/css/pay.css" />" type="text/css">
<style>

</style>
</head>
<script type="text/javascript">
var itemName=opener.document.getElementById("item_name").value;
var toTal=opener.document.getElementById("total").value;
var inDex=opener.document.getElementById("inDex").value;

$(function(){
	$.validator.addMethod(
	        "regex4",
	        function(value, element, regexp) {
	            var re = new RegExp(regexp);
	            	return this.optional(element) || re.test(value);
	        },
	        "<spring:message code="label.charcheck"/>"
	);

	$("#card").validate({
	   rules :{
	       cardtext : {
	        required : true,
	        regex4 : /^([0-9]+)$/
	       }
	   },
	   messages  : {
	      cardtext : {
	         <spring:message code="label.comnum" var="comnum" />
	         required : "<spring:message code="NotEmpty.general" arguments="${comnum}" />",
	         regex4 : "<spring:message code="label.charcheck" />"
	      }
	   }
	  });
	
	
	
   $("#pay_title").val(itemName +" 외 " + inDex + "건" );
   $("#pay_total").val(toTal);      
   $("li[id=p2]").hide();
      $("#pay11").change(function(){ 
           var vv = $(this).val();
           if(vv == '무통장입금'){
              $("li[id=p1]").show();
              $("li[id=p2]").hide();
           }
           else{
              $("li[id=p1]").hide();
              $("li[id=p2]").show();
           }
       });
      $("input[id=final]").bind('click', function(){
         if($("#card").valid()){
    	  opener.PayMent();
          window.open('about:blank', '_self').close();
         }
       });
      $("input[id=cancel]").bind('click', function(){
    	  
         window.open('about:blank', '_self').close();
      });
      
});


</script>
<body>
<div class=body>
<div class="top">
<div id="first">인터넷안전결제</div><div id="second">(ISP)서비스</div>
</div>
<div class="paynae">
<div>  결제내역</div>
<div class="one">
   <ul>
    <li>주문상품</li>
    <li>금 액</li>
    <li>할부기간</li>
   </ul>
</div>
<div class="two">
   <ul>
   <li><input type="text" id="pay_title" value='' /></li>
   <li><input type="text" id="pay_total" value='' /></li>
   <li><input type="hidden" id="pay_inDex" value='' /></li>
   <li>
    <select name="installment" id="installment" size="1">
                      <option value="1개월"  name="installment" id="installment">일시불</option>
                      <option value="2개월" name="installment" id="installment">2개월</option>
                      <option value="3개월" name="installment" id="installment">3개월</option>
                      <option value="4개월" name="installment" id="installment">4개월</option>
                      <option value="5개월" name="installment" id="installment">5개월</option>
                      <option value="6개월" name="installment" id="installment">6개월</option>
    </select> 
    </li>
      </ul>
      </div>
      </div>
<div class="payment">
<div>결제하기</div>
<div class="payone">
<ul>
    <li>결제방법</li>
    <li id="p1" >계좌번호</li>
    <li id="p2" >카드번호</li>
</ul>
</div>
<div class="paytwo">
<form name="card" id="card">
<ul>
    <li> <select name="pay11" id="pay11" size="1">
                      <option value="무통장입금" id="pay11">무통장입금</option>
                      <option value="카드" id="pay11">카드</option>
    </select></li>
    <li id="p1">국민은행 288210483562 예금주 : runtime6</li>
    <li id="p2"><input type="text" name="cardtext" id="cardtext"/></li>
</ul>
</form>
</div>
</div>
<div class="bottom1">
<input type = "button" name="final" id="final" value="결제하기"></input>
<input type = "button" name="cancel" id="cancel" value="취소"></input>
</div>
</div>
</body>
</html>
