<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp" %>
<%-- <%@ page import="com.runtime6.web.example.model.dto.JoinParam" %> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><spring:message code="runtime6.myinfor" /></title>
   <link rel="stylesheet" href="<spring:url value="/css/style.css" />" type="text/css">
   <link rel="stylesheet" href="<spring:url value="/css/view/contact_list.css" />" type="text/css">
   <jsp:include page="/WEB-INF/view/com/meta.jsp" />
   <jsp:include page="/WEB-INF/view/com/favicon.jsp" />
   <jsp:include page="/WEB-INF/view/com/script.jsp" />
   <style>
   .s1 {
   BORDER-TOP: #00005D 3px solid;
   font-size: 13px;
   line-height:32px;
}
.s2 {
   BORDER-TOP: #EAEAEA 1px solid;
   font-size: 13px;
   font-size: 8pt;
   text-align:left;
   line-height:32px;
}
</style>

<script type="text/javascript">
function facheck(fa){
	   var k =window.open("",""," width=900,height=300");
	   k.document.open();
	   k.document.write("<html><body><img src='<spring:url value='../../"+fa+"' />' /><body></html>");
	   k.document.close();
	}
$(function() {
	  $.validator.addMethod(
	          "regex",
	          function(value, element, regexp) {
	              var re = new RegExp(regexp);
	              return this.optional(element) || re.test(value);
	          },
	          "Please check your input."
	  );
	  $.validator.addMethod(
	          "regex4",
	          function(value, element, regexp) {
	              var re = new RegExp(regexp);
	              	return this.optional(element) || re.test(value);
	          },
	          "<spring:message code="label.charcheck"/>"
	  );
	
	$("#mypageForm").validate({
	     rules : {
	    	email : {
	           maxlength : 50,
	           email : true
	        },
	        cellPhone : {
	           maxlength : 15,
	           regex :  /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/
	        },
	        address : {
	     	   required : true,
	     	   maxlength : 30
	        },
	        bank_num : {
	            required : true,
	            rangelength : [10, 20],
	            regex4 :  /^([0-9]+)$/
	         },
	         bank_name : {
	         	required : true
	         },
	         buss_num : {
	         	 required : true,
	              rangelength : [10, 20],
	              regex4 :  /^([0-9]+)$/
	         },
	         address1: {	 
	      			regex4 : /^([0-9]{3,3})$/
	         	},
         	address2: {	 
      			regex4 : /^([0-9]{3,3})$/
         	}
	        
	     },
	     messages : {
	        email : {
	            <spring:message code="label.email" var="email" />
	            maxlength : "<spring:message code="Length.max.general" arguments="${email},50" />",
	            email : "<spring:message code="Email.email" />"
	         },
	         cellPhone : {
	            <spring:message code="label.cellphone" var="cellphone" />
	            maxlength : "<spring:message code="Length.max.general" arguments="${cellphone},15" />",
	            regex : "<spring:message code="Invalid.format.general" arguments="${cellphone}, 010-9876-1234" />"
	         },
	         address : {
	             <spring:message code="label.address" var="address" />
	             required : "<spring:message code="NotEmpty.general" arguments="${address}" />",
	             maxlength : "<spring:message code="Length.max.general" arguments="${address},30" />"
	         },
	         bank_num : {
	             <spring:message code="label.banknum" var="banknum" />
	              required : "<spring:message code="NotEmpty.general" arguments="${banknum}" />",
	              rangelength : "<spring:message code="label.value" arguments="10,20"/>",
	              regex4 : "<spring:message code="label.charcheck" />"
	           },
	           bank_name : {
	               <spring:message code="label.bankname" var="bankname" />
	                required : "<spring:message code="NotEmpty.general" arguments="${bankname}" />",
	           },
	           buss_num : {
	               <spring:message code="label.comnum" var="comnum" />
	                required : "<spring:message code="NotEmpty.general" arguments="${comnum}" />",
	                rangelength : "<spring:message code="label.value" arguments="10,20"/>",
	                regex4 : "<spring:message code="label.charcheck" />"
	           },
	           address1 : {
	        	   regex4 : "<spring:message code="label.charcheck" />"
	           },
	           address2 : {
	        	   regex4 : "<spring:message code="label.charcheck" />"
	           }
	         
	     }
	  });
	
	
	
	
	
	var loc= ("${join.address}").split(",");
	var $array1=loc[0];
	var $array2=loc[1];
	var $array3=loc[2];
	 $("input[id=address1]").attr("value",$array1);
	 $("input[id=address2]").attr("value",$array2);
	 $("input[id=address]").attr("value",$array3);
	
	 if($("option[id=bank_name1]").val() == ("${join.bank_name}")){
	 	$("select[name=bank_name] option:eq(1)").attr("selected","true"); 
	 } else if($("option[id=bank_name2]").val() == ("${join.bank_name}")){
		 $("select[name=bank_name] option:eq(2)").attr("selected","true");
	 } else if($("option[id=bank_name3]").val() == ("${join.bank_name}")){
		 $("select[name=bank_name] option:eq(3)").attr("selected","true");
	 } else{
		 $("select[name=bank_name] option:eq(0)").attr("selected","true");
	 }


	
    if("${join.bank_num}" !="${join.bank_name}" ){
      $("tr[name=idtr1]").show();
      $("tr[name=idtr2]").show();
      $("input[name=modify1]").hide();
      $("input[name=modify2]").show();
   }
    else{
       $("tr[name=idtr1]").hide();
       $("tr[name=idtr2]").hide();
       $("input[name=modify1]").show();
       $("input[name=modify2]").hide();
    }
   
   
     $("input[name=modify1]").bind('click',function(){
    	if($("#mypageForm").valid()){
    	 $("input[id=address1]").attr("name","address");
         $("input[id=address2]").attr("name","address");
    	 	$.ajax({
               url : '<spring:url value="/mypage/updUser" />',
               data : $("#mypageForm").serialize(),
               type: 'PUT',
               success : function(data,textStatus,jqXHR) {
                  var code = "msg_alert_complete_general";
                  if (data.updCnt == 0) {
                     code = "msg_alert_error_general";
                  }
                  alert(validation.getMessage(code, ['label_update']));
                  window.location.href = "<spring:url value="/home" />";
               },
               error : function(jqXHR, textStatus, errorThrown) {
                  alert(validation.getMessage('msg_alert_error_general'));
               }
         });
    	}
   });  
     
     
     $("input[name=modify2]").bind('click',function(){
    	 if($("#mypageForm").valid()){
    	 $("input[id=address1]").attr("name","address");
         $("input[id=address2]").attr("name","address"); 
    	 $.ajax({
               url : '<spring:url value="/mypage/updProvider" />',
               data : $("#mypageForm").serialize(),
               type: 'PUT',
               success : function(data,textStatus,jqXHR) {
                  var code = "msg_alert_complete_general";
                  if (data.updCnt == 0) {
                     code = "msg_alert_error_general";
                  }
                  alert(validation.getMessage(code, ['label_update']));
                  window.location.href = "<spring:url value="/home" />";
               },
               error : function(jqXHR, textStatus, errorThrown) {
                  alert(validation.getMessage('msg_alert_error_general'));
               }
         });
    	 }
   });  
     
     $("input[name=delete]").bind('click',function(){
          $.ajax({
               url : '<spring:url value="/mypage/stopUser" />',
               data : $("#mypageForm").serialize(),
               type: 'PUT',
               success : function(data,textStatus,jqXHR) {
                  var code = "msg_alert_complete_general";
                  if (data.updCnt == 0) {
                     code = "msg_alert_error_general";
                  }
                  alert(validation.getMessage(code, ['label_delete_userInfo']));
                  window.location.href = "<spring:url value="/login" />";
               },
               error : function(jqXHR, textStatus, errorThrown) {
                  alert(validation.getMessage('msg_alert_error_general'));
               }
         });
   });  
   

});
$(function() {
	$("input[name=sub]").bind('click', function() {
			 	if($("#searchText").val() == "Enter search query" || $("#searchText").val().length==0){
        			alert("검색값을 입력하세요");
        		}
        		else{
        			var $searchText=$("#searchText").val();
 					
   					window.location.href = "<spring:url value="/business/totalsearch=item_name="/>"+$searchText; 

        	}
      });
});

</script>   
</head>   
<body>
   <div class="page">
      <div class="header">
         <a href="<spring:url value="/home" />" id="logo"><img src="<spring:url value="/img/runtime6.png" />" alt="logo"></a>
         <div>
            <div>
            
            <c:choose>
               <c:when test="${userInfo != null}">
                  <c:choose>
                     <c:when test="${userInfo.email =='0' }">
                        관리자님 께서 로그인 하셨습니다.&nbsp;&nbsp;&nbsp;
                     </c:when>
                  </c:choose>
               <a id="logout" href="<spring:url value="/j_spring_security_logout" />">로그아웃</a> 
               </c:when>
               <c:otherwise>
               <a href="<spring:url value="/login" />">로그인</a> 
               </c:otherwise>
            </c:choose>
               <span>|</span>
               <c:if test="${userInfo ==null }">
                  <a href="<spring:url value="/join/index" />">회원가입</a>
               </c:if>
               <c:if test="${userInfo !=null }">
                  <c:out value="${userInfo.username}" />님
               </c:if>
               <span>|</span> 
				
		
				
            <c:choose>   
               <c:when test="${userInfo.email == '0'}">
               <a href="<spring:url value="/mypage/infor" />" >회원리스트</a>
               </c:when>
               <c:otherwise>

                     <a> <select onchange="window.open(value,'_self');"
                        style="color: #134067; font-size: 12px; line-height: 24px; text-decoration: none; text-shadow: 0 1px 0 #fde9c3; border-color: #FFFFFF">
                           <option selected="selected"
                              style="color: #134067; font-size: 12px; line-height: 24px; text-decoration: none; text-shadow: 0 1px 0 #fde9c3;">마이페이지</option>
                           <c:if test="${userInfo !=null }">
                              <option
                                 value="<spring:url value="/mypage/myinfor/${userInfo.username} " />"
                                 style="color: #134067; font-size: 12px; line-height: 24px; text-decoration: none; text-shadow: 0 1px 0 #fde9c3;">개인정보</option>
                              <c:choose>
                                 <c:when test="${userInfo.idtr == '사용자'}">
                                    <option
                                       value="<spring:url value="/mypage/buyinfor/${userInfo.username}" />"
                                       style="color: #134067; font-size: 12px; line-height: 24px; text-decoration: none; text-shadow: 0 1px 0 #fde9c3;">구매목록</option>
                                 </c:when>
                                 <c:otherwise>
                                    <option
                                       value="<spring:url value="/mypage/sellinfor/${userInfo.username}" />"
                                       style="color: #134067; font-size: 12px; line-height: 24px; text-decoration: none; text-shadow: 0 1px 0 #fde9c3;">판매유저목록</option>
                                 </c:otherwise>
                              </c:choose>
                           </c:if>
                     </select>
                     </a>

                  </c:otherwise>
               </c:choose>
               <span>|</span>
              <c:choose>
               <c:when test="${userInfo !=null }">
               	 <c:if test="${userInfo.idtr == '사용자'}">
                  <a href="<spring:url value="/basket/list" />">장바구니</a></c:if>
                  <c:if test="${userInfo.idtr != '사용자'}">
                  <a>장바구니</a>
                  </c:if>
                  </c:when>
               <c:otherwise>
               <a>장바구니</a>
               </c:otherwise>
               </c:choose>
   
            </div>
            <div>
               <ul>
                  <li class="selected"><a href="<spring:url value="/home" />"><span>Home</span></a>
                  </li>
           
                  <li> <c:choose>
               			<c:when test="${userInfo !=null }">
                        <a href="<spring:url value="/business/itemlist/${userInfo.username}" /> " />
                        <span>구매등록</span></a>
                        </c:when>
                      <c:otherwise>  
                     <a><span>구매/등록</span></a>
                     </c:otherwise>
                      </c:choose></li>
                
                      
                      
                  <li> <c:choose>
                        <c:when test="${userInfo !=null }">
                  <a href="<spring:url value="/qna/list" />">
                        <span>고객센터</span></a>
                        </c:when>
                        <c:otherwise>
                     <a><span>고객센터</span></a></c:otherwise>
                     </c:choose></li>
                     
                  <li> <c:choose>
                        <c:when test="${userInfo !=null }">
                  <a href="<spring:url value="/freeboard/contact" />">
                        <span>자유게시판</span></a>
                        </c:when>
                        <c:otherwise>
                     <a><span>자유게시판</span></a>
                     	</c:otherwise>
                     </c:choose></li>
               </ul>
               
               
               <form>
                  <input type="text" id="searchText" name="searchText"
                     value="Enter search query"> <input type="button" id="sub"
                     name="sub" value="">
               </form>
            </div>
         </div>
      </div>
      
      
      
      
      <div class="body">
         <div class="home">
            
            <div class="section">
               <pre>                   <b>Login ><font color="#C90000"> 회원정보 수정</font></b>
                     </pre>
            </div>
            <div>
               
      <form id="mypageForm" name="mypageForm">
      <input type="hidden" name="cid" id="cid"  value="<c:out value="${join.cid}" />"/>
      <input type="hidden" name="enabled" id="enabled"  value="0"/>
       <table align="center">
       <tr>
        <td></td>
       </tr>
        
         <table align="center" border=0 cellpadding=5 cellspacing=0>
         <tr>
         <td align="left" class="s1" width=100><b><spring:message code="label.role" /></td>
         <td align="left"  class="s1"><c:out value="${join.idtr}" /></td>
         </tr>
         
         <tr>
          <td id="label_cid" align="right" class="s2"><b><spring:message code="label.id" /></td>
          <td class="s2"  align="left">
               <c:out value="${join.cid}" />
         </td>
         </tr> 
         
         <tr>
          <td id="label_name" class="s2"  align="right"><b><spring:message code="label.name" /></td>
          <td class="s2"  align="left">
           <c:out value="${join.name}"/>
           <td>
         </tr>
         
          <tr>
          <td id="label_email" class="s2"  align="right"><b><spring:message code="label.email" /></td>
          <td class="s2"  align="left"><input type="text" name="email" id="email" value="<c:out value="${join.email}" />"/></td>
        </tr>
      
         <tr>
          <td  id="label_cellPhone" class="s2"  align="right"><b><spring:message code="label.cellphone" /></td>
          <td class="s2"  align="left">
           <input type="text" name="cellPhone" id="cellPhone"  value="<c:out value="${join.cellPhone}" />"/></td>
         </tr>
                  
         <tr>
          <td id="label_address" class="s2"  align="right"><b><spring:message code="label.address" /></td>
           <td class="s2"  align="left">
           <input type="text" name="address1"  id="address1" size=3 maxlength=3> - <input type="text" name="address2"  id="address2" size=3 maxlength=3>
           <input type="text" size=30 name="address" id="address"  /></td>
        </tr> 
      
       <tr name="idtr1">
          <td id="label_bankinfo" class="s2"  align="right"><b><spring:message code="label.bankinfo" /></td>
          <td class="s2"  align="left">
          <select name="bank_name" id="bank_name" size="1" >
             <option value="" name="bank_name" id="bank_name">선택하세요</option>
             <option value="국민" name="bank_name" id="bank_name1">국민은행</option>
             <option value="신한" name="bank_name" id="bank_name2">신한은행</option>
             <option value="우리" name="bank_name" id="bank_name3">우리은행</option>
          </select>  
           <input type="text" size=20 name="bank_num" id="bank_num" value="<c:out value="${join.bank_num}" />"//>
           </td>
         </tr> 
         
         <tr name="idtr2">
          <td id="label_comnum" class="s2"  align="right"><b><spring:message code="label.comnum" /></td>
         <td class="s2"  align="left">
           <input type="text" name="buss_num" id="buss_num" value="<c:out value="${join.buss_num}" />"//></td>
         </tr>  
      
         <tr>
          <td colspan=2 class="s1" align=center>
           <input type="button" class="bt1" name="modify1" id="modify1" value="<spring:message code="label.modify.userInfo" />" />
           <input type="button" class="bt1" name="modify2" id="modify2" value="<spring:message code="label.modify.userInfo" />" />
           <input type="button" class="bt1" name="delete" id="delete" value="<spring:message code="label.delete.userInfo" />" />
           </td>
         </tr>
         </table>
       </table>
       </form>
       </div>
      </div>
   </div>
 <div class="footer">
          <div class="section">
                        <div>
                                 <ul class="asdf">
                                 <hr>
                                    <li><a onclick="facheck('images/fa/fa1.PNG')"><font color="#4C4C4C">회원
                                          가입안내</font></a><a> | </a> </span></li>
                                    <li><a onclick="facheck('images/fa/fa2.PNG')"><font color="#4C4C4C">상품
                                          주문 방법</font></a><a> | </a></li>
                                    <li><a  onclick="facheck('images/fa/fa3.PNG')"><font color="#4C4C4C">주문
                                          확인</font></a><a> | </a></li>
                                           <li><a  onclick="facheck('images/fa/fa5.PNG')"><font color="#4C4C4C">주문
                                          취소</font></a><a> | </a></li>
                                  <li><a  onclick="facheck('images/fa/fa6.PNG')"><font color="#4C4C4C">공동구매
                                          최소 갯수</font></a><a> | </a></li>
                                    <li><a onclick="facheck('images/fa/fa7.PNG')"><font color="#4C4C4C">개인정보
                                          취급 방법</font></a><a> | </a></li>
                                    <li><a  onclick="facheck('images/fa/fa8.PNG')"><font color="#4C4C4C">비밀번호
                                          분실</font></a><a> | </a></li>
                                    <li><a  onclick="facheck('images/fa/fa9.PNG')"><font color="#4C4C4C">쇼핑몰
                                          이용 PC사양</font></a></li>
                                 </ul>
                        </div>
         <div >
         <div class="connect">
        
                  <a href="http://www.facebook.com/" id="fb">facebook</a> <a
                     href="http://www.twitter.com/" id="twitter">twitter</a> <a
                     href="http://plus.google.com" id="googleplus">googleplus</a> <a
                     href="http://www.youtube.com" id="vimeo">vimeo</a>
               </div>
            <div>
               <ul>
                  <li></li>
                  <li></li>
                  <li></li>
                  <li></li>
               </ul>
               <p>Runtime6는 삼품에 직접 관여하지 않으며 상품 주문, 배송 및 환불의 외부의 책임은 각 판매 업체에 있습니다.<br>
                 (주)Runtime6Korea | 대표:홍상삼 | 사업자등록번호 115-29-29652 서울시 광진구 화양동 63, 102 | 개인정보담당자: 류현진<br>               
                 &#169; Copyright &#169; 2023.Company name all rights reserved<br>
                  <font color="#B70037"><b>Tel:</b></font> 070) 875-8037
               </p>
               
            </div>
         </div>
      </div>
   </div>
</body>
</html>