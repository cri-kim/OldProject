<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp"%>
<!DOCTYPE html>
<!-- Website template by freewebsitetemplates.com -->

<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title><spring:message code="label.join" /></title>
<link rel="stylesheet" href="../css/style.css" type="text/css">
<link rel="stylesheet" href="../css/view/contact_list.css" type="text/css">
<jsp:include page="/WEB-INF/view/com/meta.jsp" />
<jsp:include page="/WEB-INF/view/com/favicon.jsp" />
<jsp:include page="/WEB-INF/view/com/script.jsp" />
<style>
textarea {
   border: solid 1;
   font-size: 9pt;
   color: black;
   background-color: white;
   border-color: #EAEAEA;
}

input {
   border: 2px groove #BDBDBD;
   color: black;
   background-color: white;
}

.bt1 {
   color: #000000;
   border-color: #EAEAEA;
   background-color: #EAEAEA;
   font-size: 8pt;
   font-family: Tahoma;
   height: 20px;
}

.bt2 {
   color: #000000;
   border-color: #EAEAEA;
   background-color: #EAEAEA;
   font-size: 8pt;
   font-family: Tahoma;
   height: 20px;
}

.s0 {
   BORDER-RIGHT: #EAEAEA 1px solid;
   BORDER-TOP: #EAEAEA 1px solid;
   BORDER-LEFT: #EAEAEA 1px solid;
   BORDER-BOTTOM: #EAEAEA 1px solid
}

.sss {
   font-size: 13px;
}

.s1 {
   BORDER-TOP: #00005D 3px solid;
   font-size: 13px;
}
.s4{
BORDER-BOTTOM: #00005D 3px solid;
   font-size: 13px;
}

.s2 {
   BORDER-TOP: #EAEAEA 1px solid;
   font-size: 13px;
   font-size: 8pt
}
.s3 {

   BORDER-TOP: #5d5d5d 4px solid;
   BORDER-BOTTOM: #5d5d5d 4px solid;

}
.cal{
font-size:8pt; 
line-height:15px;

}
.agree{
   font-size:12px;
   text-align:right;
}
/* e3bdc8 */
</style>
</head>
<script type="text/javascript">
function facheck(fa){
	   var k =window.open("",""," width=900,height=300");
	   k.document.open();
	   k.document.write("<html><body><img src=" + fa + "><body></html>");
	   k.document.close();
	}


$(function() {  
	<c:choose>
	<c:when test="${crtCnt == 0}">
		//실패
		//파일업로드는 다시 선택되는건 할수없다.
		alert(validation.getMessage('msg.alert.error.general',['label.insert']));
		$("#cid").val("${joinParam.cid}");
	 </c:when>
	 <c:when test="${crtCnt == 1}">
		//성공
		alert(validation.getMessage('msg.alert.complete.general',['label.insert']));
		                                //sample
		window.location.href = vs.config.contextRoot + "/login";
	</c:when>
</c:choose>
	
	
  $("tr[name=j1]").hide();
  $("tr[name=j2]").hide();
  $("tr[name=j3]").hide();
  $("input[name=regBtn1]").hide();
  $("input[name=regBtn2]").show();
  $("input[id=name2]").attr("name","name");
  $("input[id=name1]").attr("name","name1");
  $.validator.addMethod(
          "regex",
          function(value, element, regexp) {
              var re = new RegExp(regexp);
              return this.optional(element) || re.test(value);
          },
          "Please check your input."
  );
  $.validator.addMethod(
          "regex1",
          function(value, element, regexp) {
        	var re = new RegExp(regexp);
        	 var d=new Date();
     		 var cur_year=d.getFullYear();
              if(value>=1950 && value<= cur_year){
              	return this.optional(element) || re.test(value);
              }
          },
          "Please check your input."
  );
  $.validator.addMethod(
          "regex2",
          function(value, element, regexp) {
        	  var re = new RegExp(regexp);
              if(value>=1 && value<=12){
              	return this.optional(element) || re.test(value);
              }
          },
          "Please check your input."
  );
  $.validator.addMethod(
          "regex3",
          function(value, element, regexp) {
        	  var re = new RegExp(regexp);
              if(value>=1 && value<=31){
              	return this.optional(element) || re.test(value);
              }
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

  
  $("#joinForm").validate({
     rules : {
        cid : {
           required : true,
           rangelength : [6, 18]
        },
        passwd : {
           required : true,
           rangelength : [6, 12]
        },
        repasswd : {
           equalTo : "#passwd"
        },
        name : {
           required : true,
           rangelength : [2, 20]
        },
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
        buss_file: {
	       	 required : true
    	},
    	year: {	 
    		regex1 : /^([1|2])([0-9]{3,3})$/
    	},
    	month: {	 
    		regex2 : /^([0-9]{1,2})$/
   		},
   		day: {	 
   			regex3 : /^([0-9]{1,2})$/
      	},
      	address1: {	 
   			regex4 : /^([0-9]{3,3})$/
      	},
      	address2: {	 
   			regex4 : /^([0-9]{3,3})$/
      	}
        
     },
     messages : {
        cid : {
           <spring:message code="label.id" var="cid" />
           required : "<spring:message code="NotEmpty.general" arguments="${cid}" />", 
           rangelength : "<spring:message code="Length.general" arguments="${cid},6,18"/>"
        },
        passwd : {
           <spring:message code="label.password" var="password" />
           required : "<spring:message code="NotEmpty.general" arguments="${password}" />",
           rangelength : "<spring:message code="Length.general" arguments="${password},6,12"/>"
        },
        repasswd : {
           equalTo : "<spring:message code="EqualTo.password" />",
        },
        name : {
           <spring:message code="label.name" var="name" />
           required : "<spring:message code="NotEmpty.general" arguments="${name}" />",
           rangelength : "<spring:message code="Length.general" arguments="${name},2,20"/>"
        },
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
        buss_file : {
            <spring:message code="label.validation" var="validation" />
             required : "<spring:message code="NotEmpty.general" arguments="${validation}" />",
       },
       year: {
    	   <spring:message code="label.year" var="year" />
    	   regex1 : "<spring:message code="Invalid.format.general" arguments="${year}, 1990년" />"	
       },
       month: {
    	   <spring:message code="label.month" var="month" />
    	   regex2 : "<spring:message code="Length.scope" arguments="${month},1,12"/>"
       },
       day: {
    	   <spring:message code="label.day" var="day" />
    	   regex3 : "<spring:message code="Length.scope" arguments="${day},1,31"/>"
       },  
       address1 : {
    	   regex4 : "<spring:message code="label.charcheck" />"
       },
       address2 : {
    	   regex4 : "<spring:message code="label.charcheck" />"
       }
     }
  });
  

	$("input[value=사용자]").bind('click', function(){
		$("tr[name=b1]").hide();
		$("tr[name=b2]").hide();
		$("tr[name=b3]").hide();
		$("tr[name=b4]").hide();
		$("input[name=regBtn2]").hide();
		$("input[name=regBtn1]").show();
		$("tr[name=j1]").show();
		$("tr[name=j2]").show();
		$("tr[name=j3]").show();
		$("input[id=name1]").attr("name","name");
	    $("input[id=name2]").attr("name","name2");
	});
	
	$("input[value=사업자]").bind('click', function(){
		$("tr[name=j1]").hide();
		$("tr[name=j2]").hide();
		$("tr[name=j3]").hide();
		$("input[name=regBtn1]").hide();
		$("tr[name=b1]").show();
		$("tr[name=b2]").show();
		$("tr[name=b3]").show();
		$("tr[name=b4]").show();
		$("input[name=regBtn2]").show();
		$("input[id=name2]").attr("name","name");
	    $("input[id=name1]").attr("name","name1");
	});
  
  
  
  
  $("input[name=cancel]").bind('click',function(){
     window.location.href = "<spring:url value="/home" />";         
  });

   
     $("input[name=regBtn1]").bind('click', function() {
    if( ($("input[value=agree]:checked").length == 1) && ($("input[value=agreecon]:checked").length == 1) ){ 
    if ($("#joinForm").valid() && $("input[value=사용자]")) {
    	 $("input[id=birth1]").attr("name","birth");
         $("input[id=birth2]").attr("name","birth");
         $("input[id=birth3]").attr("name","birth");
         $("input[id=address1]").attr("name","address");
         $("input[id=address2]").attr("name","address");
    	 $.get('<spring:url value="/join/checkValidation" />', 
           {"cid": $("#cid").val()},
           function(result) {
              if(!result.data.cid){
                 alert("<spring:message code="Duplicate.cid" />");
              } else {
                 //회원 가입 진행
                 $.post('<spring:url value="/join/createUser" />',
                       $("#joinForm").serialize(),
                       function (result) {
                          if (result.data != null && result.data.error != undefined){
                             console.log(result.data.error);
                             validation.showMessage(result.data.error, "td#label_");
                          } else {
                             alert("<spring:message code="label.joinsuccess"/>");
                             window.location.href = "<spring:url value="/login" />";
                          }
                 });
              }
           });
     	}
	    }
	    else{
	       alert("이용약관에 동의해주세요");
	    }
    
     });
     
	 $("input[name=regBtn2]").bind('click', function() {
		 if( ($("input[value=agree]:checked").length == 1) && ($("input[value=agreecon]:checked").length == 1) ){ 
		 if ($("#joinForm").valid() && $("input[value=사업자]")) {
			 $("input[id=address1]").attr("name","address");
	         $("input[id=address2]").attr("name","address");
			 $.get('<spring:url value="/join/checkValidation" />', 
				{"cid": $("#cid").val()},
				function(result) {
					if(!result.data.cid){
						alert("<spring:message code="Duplicate.cid" />");
					} else {
						//회원 가입 진행			
						 $.post('<spring:url value="/join/createProvider" />',
								$("#joinForm").serialize(),
								function (result) {
									if (result.data != null && result.data.error != undefined){
										console.log(result.data.error);
										validation.showMessage(result.data.error, "td#label_");
									} else {
										alert("<spring:message code="label.joinsuccess"/>");
										window.location.href = "<spring:url value="/login" />";
									}
						}); 
						 $("#joinForm").submit(); 	
					}
				});
			} 
		 	}
		    else{
		       alert("이용약관에 동의해주세요");
		    }
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
                     <c:otherwise>
                        <c:out value="${userInfo.username}" />님 께서 로그인 하셨습니다.&nbsp;&nbsp;&nbsp;
                     </c:otherwise>
                  </c:choose>
               <a id="logout" href="<spring:url value="/j_spring_security_logout" />">로그아웃</a> 
               </c:when>
               <c:otherwise>
               <a href="<spring:url value="/login" />">로그인</a> 
               </c:otherwise>
            </c:choose>
               <span>|</span>
               <c:choose>
               <c:when test="${userInfo ==null }">
               <a href="<spring:url value="/join/index" />">회원가입</a></c:when>
			  <c:otherwise>  
                 <a>회원가입</a>
                 </c:otherwise>
				</c:choose><span>|</span> 
				
		
				
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
         <form name="joinForm" id="joinForm" method="POST" encType="multipart/form-data" action="<spring:url value="/join/createProvider" />">
            <table width="800" height="30">

               <tr width="600" height="30">
                  <td align="center"><pre>                                                                  <b>HOME ><font color="#C90000"> 회원가입</font></b>
                     </pre></td>
               </tr>

               
               <table align="center" border=0 cellpadding=5 cellspacing=0>
                  
                  <tr>
                     <td align="left" class="s1" width=100><b><spring:message
                              code="label.role" /></td>
                     <td td align="left" class="s1" width=415><input type="radio"
                        name="idtr" id="idtr" value="사업자" checked> 사업자 <input
                        type="radio" name="idtr" id="idtr" value="사용자">사용자</td>
                     
                  </tr>

                  <tr>
                     <td id="label_cid" align="left" class="s2"><b><spring:message
                              code="label.id" /></td>
                     <td class="s2" align="left"><input type="text" name="cid"
                        id="cid" /> (영문,숫자만 허용됩니다.)</td>
                  </tr>

                  <tr>
                     <td id="label_passwd" align="left" class="s2"><b><spring:message
                              code="label.password" /></td>
                     <td class="s2" align="left"><input type="password"
                        name="passwd" id="passwd" />
                  </tr>


                  <tr>
                     <td align="left" class="s2"><b><spring:message
                              code="label.repassword" /></td>
                     <td class="s2" align="left"><input type="password"
                        name="repasswd" id="repasswd" />
                  </tr>

                  <tr name=j1>
                     <td id="label_name" class="s2" align="left"><b><spring:message
                              code="label.name" /></td>
                     <td class="s2" align="left"><input type="text" name="name"
                        id="name1" />
                     <td>
                  </tr>

                  <tr name=b1>
                     <td id="label_comname" class="s2" align="left"><b><spring:message
                              code="label.comname" /></td>
                     <td class="s2" align="left"><input type="text" name="name" id="name2" />
                     <td>
                  </tr>


                  <tr>
                     <td id="label_email" class="s2" align="left"><b><spring:message
                              code="label.email" /></td>
                     <td class="s2" align="left"><input type="text" name="email"
                        id="email" /></td>
                  </tr>

                  <tr>
                     <td id="label_cellPhone" class="s2" align="left"><b><spring:message
                              code="label.cellphone" /></td>
                     <td class="s2" align="left"><input type="text"
                        name="cellPhone" id="cellPhone" /></td>
                  </tr>

                  <tr>
                     <td id="label_address" class="s2" align="left"><b><spring:message
                              code="label.address" /></b></td>
                     <td class="s2" align="left"><input name="address1"
                        id="address1" size=3 maxlength=3> - <input name="address2"
                        id="address2" size=3 maxlength=3> <input size=35
                        name="address" id="address"></td>

                  </tr>



                  <tr name=j2>
                     <td id="label_sex" class="s2" align="left"><b><spring:message
                              code="label.sex" /></td>
                     <td class="s2" align="left"><input type="radio" name="sex"
                        id="sex" value="남성" checked> <spring:message
                           code="label.male" /> <input type="radio" name="sex" id="sex"
                        value="여성"> <spring:message code="label.female" /></td>
                  </tr>

                  <tr name=j3>
                     <td id="lable_birth" class="s2" align="left"><b><spring:message
                           code="label.birth" /></b></td>
                     <td class="s2" align="left"><input name="year" id="birth1"
                        size=4 maxlength=4> <spring:message code="label.year" />
                        <input name="month" id="birth2" size=2 maxlength=2> <spring:message
                           code="label.month" /> <input name="day" id="birth3" size=2
                        maxlength=2> <spring:message code="label.day" />
                        &nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="birth"
                        id="birth" value="양력" checked> <spring:message
                           code="label.yang" /> <input type="radio" name="birth"
                        id="birth" value="음력"> <spring:message code="label.um" /></td>
                  </tr>


                  <tr name=b2>
                     <td id="label_bankinfo" class="s2" align="left"><b><spring:message
                              code="label.bankinfo" /></td>
                     <td class="s2" align="left"><select name="bank_name"
                        id="bank_name" size="1">
                           <option value="" name="bank_name" id="bank_name">선택하세요</option>
                           <option value="국민" name="bank_name" id="bank_name">국민은행</option>
                           <option value="신한" name="bank_name" id="bank_name">신한은행</option>
                           <option value="우리" name="bank_name" id="bank_name">우리은행</option>
                     </select> <input type="text" size=20 name="bank_num" id="bank_num" /></td>
                  </tr>


                  <tr name=b3>
                     <td id="label_comnum" class="s2" align="left"><b><spring:message
                              code="label.comnum" /></td>
                     <td class="s2" align="left"><input type="text" name="buss_num"
                        id="buss_num" /></td>
                  </tr>



                  <tr name=b4>
                     <td id="label_validation" class="s4" align="left"><b><spring:message
                              code="label.validation" /></td>
                     <td class="s4" align="left"><img name="stampImg" src="<spring:url value="/images/validation.png" />"
                        width=80 height=80 border=1><br> 최적 format : 1MB 이하
                        용량의 파일<br> <input type=file name="buss_file" id="buss_file"
                        size=30></td>
                  </tr>




                  <tr>
                     <td class="s2" align="right"></td>
                  </tr>
               
                  
                  <tr>
                     <td><br><br></td>
                  </tr>
                                    
                  
                  <tr>
                     <td id="label.userole" class="s1" align="left"><b><spring:message
                              code="label.userole" /></td>
                     <td td align="left" class="s1" width=150></td>
                  </tr>
                  
                  <tr>
                     <td class="s2"><b><spring:message
                              code="label.agree" /></td>
                     <td class="s2" align="left"><textarea rows="8" cols="70" readonly="readonly" class="cal">제1조(목적)
이 약관은  runtime6(전자상거래 사업자)가 운영하는 runtime6(이하 “몰”이라 한다)에서 제공하는 인터넷 관련 서비스(이하 “서비스”라 한다)를 이용함에 있어 사이버 몰과 이용자의 권리?의무 및 책임사항을 규정함을 목적으로 합니다.
※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 이 약관을 준용합니다」
제2조(정의)
①“runtime6” 이란 OO 회사가 재화 또는 용역(이하 “재화등”이라 함)을 이용자에게 제공하기 위하여 컴퓨터등 정보통신설비를 이용하여 재화등을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이버몰을 운영하는 사업자의 의미로도 사용합니다.
②“이용자”란 “runtime6”에 접속하여 이 약관에 따라 “runtime6”이 제공하는 서비스를 받는 회원 및 비회원을 말합니다.
③ ‘회원’이라 함은 “runtime6”에 개인정보를 제공하여 회원등록을 한 자로서, “runtime6”의 정보를 지속적으로 제공받으며, “runtime6”이 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.
④ ‘비회원’이라 함은 회원에 가입하지 않고 “runtime6”이 제공하는 서비스를 이용하는 자를 말합니다.
제3조 (약관등의 명시와 설명 및 개정) 
① “runtime6”은 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호?모사전송번호?전자우편주소, 사업자등록번호, 통신판매업신고번호, 개인정보관리책임자등을 이용자가 쉽게 알 수 있도록 00 사이버몰의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.
② “runtime6은 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회?배송책임?환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.
③ “runtime6”은 전자상거래등에서의소비자보호에관한법률, 약관의규제에관한법률, 전자거래기본법, 전자서명법, 정보통신망이용촉진등에관한법률, 방문판매등에관한법률, 소비자보호법 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.
④ “runtime6”이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 몰의 초기화면에 그 적용일자 7일이전부터 적용일자 전일까지 공지합니다.
다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 "runtime6“은 개정전 내용과 개정후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.
⑤ “runtime6”이 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간내에 ‘몰“에 송신하여 ”runtime6“의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.
⑥ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래등에서의소비자보호에관한법률, 약관의규제등에관한법률, 공정거래위원회가 정하는 전자상거래등에서의소비자보호지침 및 관계법령 또는 상관례에 따릅니다.
제4조(서비스의 제공 및 변경) 
① “runtime6”은 다음과 같은 업무를 수행합니다.
1. 재화 또는 용역에 대한 정보 제공 및 구매계약의 체결
2. 구매계약이 체결된 재화 또는 용역의 배송
3. 기타 “runtime6”이 정하는 업무
②“runtime6”은 재화 또는 용역의 품절 또는 기술적 사양의 변경 등의 경우에는 장차 체결되는 계약에 의해 제공할 재화 또는 용역의 내용을 변경할 수 있습니다. 이 경우에는 변경된 재화 또는 용역의 내용 및 제공일자를 명시하여 현재의 재화 또는 용역의 내용을 게시한 곳에 즉시 공지합니다.
③“runtime6”이 제공하기로 이용자와 계약을 체결한 서비스의 내용을 재화등의 품절 또는 기술적 사양의 변경 등의 사유로 변경할 경우에는 그 사유를 이용자에게 통지 가능한 주소로 즉시 통지합니다.
④전항의 경우 “runtime6”은 이로 인하여 이용자가 입은 손해를 배상합니다. 다만, “몰”이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.
제5조(서비스의 중단) 
① “runtime6”은 컴퓨터 등 정보통신설비의 보수점검?교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.
②“runtime6”은 제1항의 사유로 서비스의 제공이 일시적으로 중단됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단, “몰”이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.
③사업종목의 전환, 사업의 포기, 업체간의 통합 등의 이유로 서비스를 제공할 수 없게 되는 경우에는 “runtime6”은 제8조에 정한 방법으로 이용자에게 통지하고 당초 “runtime6”에서 제시한 조건에 따라 소비자에게 보상합니다. 다만, “runtime6”이 보상기준 등을 고지하지 아니한 경우에는 이용자들의 마일리지 또는 적립금 등을 “runtime6”에서 통용되는 통화가치에 상응하는 현물 또는 현금으로 이용자에게 지급합니다.
제6조(회원가입) 
① 이용자는 “runtime6”이 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.
② “runtime6”은 제1항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각호에 해당하지 않는 한 회원으로 등록합니다.
1. 가입신청자가 이 약관 제7조제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우, 다만 제7조제3항에 의한 회원자격 상실후 3년이 경과한 자로서 “runtime6”의 회원재가입 승낙을 얻은 경우에는 예외로 한다.
2. 등록 내용에 허위, 기재누락, 오기가 있는 경우
3. 기타 회원으로 등록하는 것이 “runtime6”의 기술상 현저히 지장이 있다고 판단되는 경우
③ 회원가입계약의 성립시기는 “runtime6”의 승낙이 회원에게 도달한 시점으로 합니다.
④ 회원은 제15조제1항에 의한 등록사항에 변경이 있는 경우, 즉시 전자우편 기타 방법으로 “runtime6”에 대하여 그 변경사항을 알려야 합니다.
제7조(회원 탈퇴 및 자격 상실 등) 
① 회원은 “runtime6”에 언제든지 탈퇴를 요청할 수 있으며 “몰”은 즉시 회원탈퇴를 처리합니다.
② 회원이 다음 각호의 사유에 해당하는 경우, “runtime6”은 회원자격을 제한 및 정지시킬 수 있습니다.
1. 가입 신청시에 허위 내용을 등록한 경우
2. “runtime6”을 이용하여 구입한 재화등의 대금, 기타 “몰”이용에 관련하여 회원이 부담하는 채무를 기일에 지급하지 않는 경우
3. 다른 사람의 “runtime6” 이용을 방해하거나 그 정보를 도용하는 등 전자상거래 질서를 위협하는 경우
4. “몰”을 이용하여 법령 또는 이 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우
③ “몰”이 회원 자격을 제한?정지 시킨후, 동일한 행위가 2회이상 반복되거나 30일이내에 그 사유가 시정되지 아니하는 경우 “몰”은 회원자격을 상실시킬 수 있습니다.
④ “몰”이 회원자격을 상실시키는 경우에는 회원등록을 말소합니다. 이 경우 회원에게 이를 통지하고, 회원등록 말소전에 최소한 30일 이상의 기간을 정하여 소명할 기회를 부여합니다.
제8조(회원에 대한 통지)
① “몰”이 회원에 대한 통지를 하는 경우, 회원이 “몰”과 미리 약정하여 지정한 전자우편 주소로 할 수 있습니다.
② “몰”은 불특정다수 회원에 대한 통지의 경우 1주일이상 “몰” 게시판에 게시함으로서 개별 통지에 갈음할 수 있습니다. 다만, 회원 본인의 거래와 관련하여 중대한 영향을 미치는 사항에 대하여는 개별통지를 합니다.
제9조(구매신청)
“몰”이용자는 “몰”상에서 다음 또는 이와 유사한 방법에 의하여 구매를 신청하며, “몰”은 이용자가 구매신청을 함에 있어서 다음의 각 내용을 알기 쉽게 제공하여야 합니다. 단, 회원인 경우 제2호 내지 제4호의 적용을 제외할 수 있습니다.
1. 재화등의 검색 및 선택
2. 성명, 주소, 전화번호, 전자우편주소(또는 이동전화번호) 등의 입력
3. 약관내용, 청약철회권이 제한되는 서비스, 배송료?설치비 등의 비용부담과 관련한 내용에 대한 확인
4. 이 약관에 동의하고 위 3.호의 사항을 확인하거나 거부하는 표시(예, 마우스 클릭)
5. 재화등의 구매신청 및 이에 관한 확인 또는 “몰”의 확인에 대한 동의
6. 결제방법의 선택
제10조 (계약의 성립)
① “몰”은 제9조와 같은 구매신청에 대하여 다음 각호에 해당하면 승낙하지 않을 수 있습니다. 다만, 미성년자와 계약을 체결하는 경우에는 법정대리인의 동의를 얻지 못하면 미성년자 본인 또는 법정대리인이 계약을 취소할 수 있다는 내용을 고지하여야 합니다.
1. 신청 내용에 허위, 기재누락, 오기가 있는 경우
2. 미성년자가 담배, 주류등 청소년보호법에서 금지하는 재화 및 용역을 구매하는 경우
3. 기타 구매신청에 승낙하는 것이 “몰” 기술상 현저히 지장이 있다고 판단하는 경우
② “몰”의 승낙이 제12조제1항의 수신확인통지형태로 이용자에게 도달한 시점에 계약이 성립한 것으로 봅니다.
③ “몰”의 승낙의 의사표시에는 이용자의 구매 신청에 대한 확인 및 판매가능 여부, 구매신청의 정정 취소등에 관한 정보등을 포함하여야 합니다.
제11조(지급방법)
“몰”에서 구매한 재화 또는 용역에 대한 대금지급방법은 다음 각호의 방법중 가용한 방법으로 할 수 있습니다. 단, “몰”은 이용자의 지급방법에 대하여 재화 등의 대금에 어떠한 명목의 수수료도 추가하여 징수할 수 없습니다.
1. 폰뱅킹, 인터넷뱅킹, 메일 뱅킹 등의 각종 계좌이체 
2. 선불카드, 직불카드, 신용카드 등의 각종 카드 결제
3. 온라인무통장입금
4. 전자화폐에 의한 결제
5. 수령시 대금지급
6. 마일리지 등 “몰”이 지급한 포인트에 의한 결제
7. “몰”과 계약을 맺었거나 “몰”이 인정한 상품권에 의한 결제 
8. 기타 전자적 지급 방법에 의한 대금 지급 등
제12조(수신확인통지?구매신청 변경 및 취소)
① “몰”은 이용자의 구매신청이 있는 경우 이용자에게 수신확인통지를 합니다.
② 수신확인통지를 받은 이용자는 의사표시의 불일치등이 있는 경우에는 수신확인통지를 받은 후 즉시 구매신청 변경 및 취소를 요청할 수 있고 “몰”은 배송전에 이용자의 요청이 있는 경우에는 지체없이 그 요청에 따라 처리하여야 합니다. 다만 이미 대금을 지불한 경우에는 제15조의 청약철회 등에 관한 규정에 따릅니다.
제13조(재화등의 공급)
① “몰”은 이용자와 재화등의 공급시기에 관하여 별도의 약정이 없는 이상, 이용자가 청약을 한 날부터 7일 이내에 재화 등을 배송할 수 있도록 주문제작, 포장 등 기타의 필요한 조치를 취합니다. 다만, “몰”이 이미 재화 등의 대금의 전부 또는 일부를 받은 경우에는 대금의 전부 또는 일부를 받은 날부터 2영업일 이내에 조치를 취합니다. 이때 “몰”은 이용자가 재화등의 공급 절차 및 진행 사항을 확인할 수 있도록 적절한 조치를 합니다.
②“몰”은 이용자가 구매한 재화에 대해 배송수단, 수단별 배송비용 부담자, 수단별 배송기간 등을 명시합니다. 만약 “몰”이 약정 배송기간을 초과한 경우에는 그로 인한 이용자의 손해를 배상하여야 합니다. 다만 “몰”이 고의?과실이 없음을 입증한 경우에는 그러하지 아니합니다.
제14조(환급)
“몰”은 이용자가 구매신청한 재화등이 품절 등의 사유로 인도 또는 제공을 할 수 없을 때에는 지체없이 그 사유를 이용자에게 통지하고 사전에 재화 등의 대금을 받은 경우에는 대금을 받은 날부터 2영업일 이내에 환급하거나 환급에 필요한 조치를 취합니다.
제15조(청약철회 등)
①“몰”과 재화등의 구매에 관한 계약을 체결한 이용자는 수신확인의 통지를 받은 날부터 7일 이내에는 청약의 철회를 할 수 있습니다.
② 이용자는 재화등을 배송받은 경우 다음 각호의 1에 해당하는 경우에는 반품 및 교환을 할 수 없습니다.
1. 이용자에게 책임 있는 사유로 재화 등이 멸실 또는 훼손된 경우(다만, 재화 등의 내용을 확인하기 위하여 포장 등을 훼손한 경우에는 청약철회를 할 수 있습니다)
2. 이용자의 사용 또는 일부 소비에 의하여 재화 등의 가치가 현저히 감소한 경우
3. 시간의 경과에 의하여 재판매가 곤란할 정도로 재화등의 가치가 현저히 감소한 경우
4. 같은 성능을 지닌 재화등으로 복제가 가능한 경우 그 원본인 재화 등의 포장을 훼손한 경우
③ 제2항제2호 내지 제4호의 경우에 “몰”이 사전에 청약철회 등이 제한되는 사실을 소비자가 쉽게 알 수 있는 곳에 명기하거나 시용상품을 제공하는 등의 조치를 하지 않았다면 이용자의 청약철회등이 제한되지 않습니다.
④ 이용자는 제1항 및 제2항의 규정에 불구하고 재화등의 내용이 표시·광고 내용과 다르거나 계약내용과 다르게 이행된 때에는 당해 재화등을 공급받은 날부터 3월이내, 그 사실을 안 날 또는 알 수 있었던 날부터 30일 이내에 청약철회 등을 할 수 있습니다.
제16조(청약철회 등의 효과)
① “몰”은 이용자로부터 재화 등을 반환받은 경우 3영업일 이내에 이미 지급받은 재화등의 대금을 환급합니다. 이 경우 “몰”이 이용자에게 재화등의 환급을 지연한 때에는 그 지연기간에 대하여 공정거래위원회가 정하여 고시하는 지연이자율을 곱하여 산정한 지연이자를 지급합니다.
② “몰”은 위 대금을 환급함에 있어서 이용자가 신용카드 또는 전자화폐 등의 결제수단으로 재화등의 대금을 지급한 때에는 지체없이 당해 결제수단을 제공한 사업자로 하여금 재화등의 대금의 청구를 정지 또는 취소하도록 요청합니다.
③ 청약철회등의 경우 공급받은 재화등의 반환에 필요한 비용은 이용자가 부담합니다. “몰”은 이용자에게 청약철회등을 이유로 위약금 또는 손해배상을 청구하지 않습니다. 다만 재화등의 내용이 표시·광고 내용과 다르거나 계약내용과 다르게 이행되어 청약철회등을 하는 경우 재화등의 반환에 필요한 비용은 “몰”이 부담합니다.
④ 이용자가 재화등을 제공받을때 발송비를 부담한 경우에 “몰”은 청약철회시 그 비용을 누가 부담하는지를 이용자가 알기 쉽도록 명확하게 표시합니다.
제17조(개인정보보호)
①“몰”은 이용자의 정보수집시 구매계약 이행에 필요한 최소한의 정보를 수집합니다. 다음 사항을 필수사항으로 하며 그 외 사항은 선택사항으로 합니다. 
1. 성명
2. 주소
3. 전화번호
4. 희망ID(회원의 경우)
5. 비밀번호(회원의 경우)
6. 전자우편주소(또는 이동전화번호)
② “몰”이 이용자의 개인식별이 가능한 개인정보를 수집하는 때에는 반드시 당해 이용자의 동의를 받습니다.
③제공된 개인정보는 당해 이용자의 동의없이 목적외의 이용이나 제3자에게 제공할 수 없으며, 이에 대한 모든 책임은 　몰　이 집니다. 다만, 다음의 경우에는 예외로 합니다.
1. 배송업무상 배송업체에게 배송에 필요한 최소한의 이용자의 정보(성명, 주소, 전화번호)를 알려주는 경우
2. 통계작성, 학술연구 또는 시장조사를 위하여 필요한 경우로서 특정 개인을 식별할 수 없는 형태로 제공하는 경우
3. 재화등의 거래에 따른 대금정산을 위하여 필요한 경우
4. 도용방지를 위하여 본인확인에 필요한 경우
5. 법률의 규정 또는 법률에 의하여 필요한 불가피한 사유가 있는 경우
④“몰”이 제2항과 제3항에 의해 이용자의 동의를 받아야 하는 경우에는 개인정보관리 책임자의 신원(소속, 성명 및 전화번호, 기타 연락처), 정보의 수집목적 및 이용목적, 제3자에 대한 정보제공 관련사항(제공받은자, 제공목적 및 제공할 정보의 내용) 등 정보통신망이용촉진등에관한법률 제22조제2항이 규정한 사항을 미리 명시하거나 고지해야 하며 이용자는 언제든지 이 동의를 철회할 수 있습니다.
⑤이용자는 언제든지 “몰”이 가지고 있는 자신의 개인정보에 대해 열람 및 오류정정을 요구할 수 있으며 “몰”은 이에 대해 지체없이 필요한 조치를 취할 의무를 집니다. 이용자가 오류의 정정을 요구한 경우에는 “몰”은 그 오류를 정정할 때까지 당해 개인정보를 이용하지 않습니다.

⑥ “몰”은 개인정보 보호를 위하여 관리자를 한정하여 그 수를 최소화하며 신용카드, 은행계좌 등을 포함한 이용자의 개인정보의 분실, 도난, 유출, 변조 등으로 인한 이용자의 손해에 대하여 모든 책임을 집니다.
⑦ “몰” 또는 그로부터 개인정보를 제공받은 제3자는 개인정보의 수집목적 또는 제공받은 목적을 달성한 때에는 당해 개인정보를 지체없이 파기합니다.
제18조(“몰“의 의무)
① “몰”은 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에 따라 지속적이고, 안정적으로 재화?용역을 제공하는데 최선을 다하여야 합니다.
② “몰”은 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보(신용정보 포함)보호를 위한 보안 시스템을 갖추어야 합니다.
③ “몰”이 상품이나 용역에 대하여 「표시?광고의공정화에관한법률」 제3조 소정의 부당한 표시?광고행위를 함으로써 이용자가 손해를 입은 때에는 이를 배상할 책임을 집니다.
④ “몰”은 이용자가 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않습니다.
제19조(회원의 ID 및 비밀번호에 대한 의무)
① 제17조의 경우를 제외한 ID와 비밀번호에 관한 관리책임은 회원에게 있습니다.
② 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.
③ 회원이 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 “몰”에 통보하고 “몰”의 안내가 있는 경우에는 그에 따라야 합니다.
제20조(이용자의 의무)
이용자는 다음 행위를 하여서는 안됩니다.
1. 신청 또는 변경시 허위 내용의 등록
2. 타인의 정보 도용
3. “몰”에 게시된 정보의 변경
4. “몰”이 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시
5. “몰” 기타 제3자의 저작권 등 지적재산권에 대한 침해
6. “몰” 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위
7. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 몰에 공개 또는 게시하는 행위
제21조(연결“몰”과 피연결“몰” 간의 관계)
① 상위 “몰”과 하위 “몰”이 하이퍼 링크(예: 하이퍼 링크의 대상에는 문자, 그림 및 동화상 등이 포함됨)방식 등으로 연결된 경우, 전자를 연결 “몰”(웹 사이트)이라고 하고 후자를 피연결 “몰”(웹사이트)이라고 합니다.
②연결“몰”은 피연결“몰”이 독자적으로 제공하는 재화등에 의하여 이용자와 행하는 거래에 대해서 보증책임을 지지 않는다는 뜻을 연결“몰”의 초기화면 또는 연결되는 시점의 팝업화면으로 명시한 경우에는 그 거래에 대한 보증책임을 지지 않습니다.
제22조(저작권의 귀속 및 이용제한)
① “몰“이 작성한 저작물에 대한 저작권 기타 지적재산권은 ”몰“에 귀속합니다.
② 이용자는 “몰”을 이용함으로써 얻은 정보 중 “몰”에게 지적재산권이 귀속된 정보를 “몰”의 사전 승낙없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.
③ “몰”은 약정에 따라 이용자에게 귀속된 저작권을 사용하는 경우 당해 이용자에게 통보하여야 합니다.
제23조(분쟁해결)
① “몰”은 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해를 보상처리하기 위하여 피해보상처리기구를 설치?운영합니다.
② “몰”은 이용자로부터 제출되는 불만사항 및 의견은 우선적으로 그 사항을 처리합니다. 다만, 신속한 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 즉시 통보해 드립니다.
③“몰”과 이용자간에 발생한 전자상거래 분쟁과 관련하여 이용자의 피해구제신청이 있는 경우에는 공정거래위원회 또는 시·도지사가 의뢰하는 분쟁조정기관의 조정에 따를 수 있습니다.
제24조(재판권 및 준거법)
①“몰”과 이용자간에 발생한 전자상거래 분쟁에 관한 소송은 제소 당시의 이용자의 주소에 의하고, 주소가 없는 경우에는 거소를 관할하는 지방법원의 전속관할로 합니다. 다만, 제소 당시 이용자의 주소 또는 거소가 분명하지 않거나 외국 거주자의 경우에는 민사소송법상의 관할법원에 제기합니다.
②“몰”과 이용자간에 제기된 전자상거래 소송에는 한국법을 적용합니다.
부 칙(시행일) 이 약관은 년 월 일부터 시행합니다. </textarea></td>
                  </tr>
                  <tr>
                     <td></td>
                     <td class="agree">이용약관에 동의하십니까?&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="agreeCondition" value="agree"  /><spring:message code="label.agree1"/>&nbsp;<br><br></td>
                  </tr>
                                    
                  
                  <tr>
                     <td id="label.userole" class="s1" align="left"><b>개인정보 수집 및 동의</td>
                     <td td align="left" class="s1" width=150></td>
                  </tr>
                  
                  <tr>
                     <td class="s2"><b><spring:message
                              code="label.agree" /></td>
                     <td class="s2" align="left"><textarea rows="8" cols="70" readonly="readonly" class="cal"> 
1. 개인 정보 수집 목적 및 이용
은 회원님께 최대한으로 최적화되고 맞춤화된 서비스를 제공하기 위하여 다음과 같은 목적으로 개인정보를 수집하고 있습니다.
- 성명, 아이디, 비밀번호 : 회원제 서비스 이용에 따른 본인 식별 절차에 이용
- 이메일주소, 이메일 수신여부, 전화번호 : 고지사항 전달, 본인 의사 확인, 불만 처리 등 원활한 의사소통 경로의 확보, 새로운 서비스/신상품이나 이벤트 정보의 안내
- 주소, 전화번호 : 경품과 쇼핑 물품 배송에 대한 정확한 배송지의 확보
- 비밀번호 힌트용 질문과 답변 : 비밀번호를 잊은 경우의 신속한 처리를 위한 내용
- 그 외 선택항목 : 개인맞춤 서비스를 제공하기 위한 자료
단, 이용자의 기본적 인권 침해의 우려가 있는 민감한 개인정보(인종 및 민족, 사상 및 신조, 출신지 및 본적지, 정치적 성향 및 범죄기록, 건강상태 및 성생활 등)는 수집하지 않습니다
2. 개인 정보 수집 항목 및 보유, 이용 기간
귀하의 개인정보는 다음과 같이 개인정보의 수집목적 또는 제공받은 목적이 달성되면 파기됩니다. 단, 상법 등 관련법령의 규정에 의하여 다음과 같이 거래 관련 권리 의무 관계의 확인 등을 이유로 일정기간 보유하여야 할 필요가 있을 경우에는 일정기간 보유합니다.
- 회원가입정보의 경우, 회원가입을 탈퇴하거나 회원에서 제명된 경우 등 일정한 사전에 보유목적, 기간 및 보유하는 개인정보 항목을 명시하여 동의를 구합니다
- 계약 또는 청약철회 등에 관한 기록 : 5년
- 대금결제 및 재화등의 공급에 관한 기록 : 5년
- 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년
귀하의 동의를 받아 보유하고 있는 거래정보 등을 귀하께서 열람을 요구하는 경우 지체없이 그 열람,확인 할 수 있도록 조치합니다. </textarea></td>
                  </tr>
                  <tr>
                     <td></td>
                     <td class="agree">이용약관에 동의하십니까?&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="agreeCondition" value="agreecon"  /><spring:message code="label.agree1"/>&nbsp;<br><br></td>
                  </tr>

                  <tr>
                     <td colspan=2 class="s1" align=center>
                     <input type="button" class="bt1" name="regBtn1"value="<spring:message code="label.join.title" />" /> 
                     <input type="button" class="bt1" name="regBtn2" value="<spring:message code="label.join.title" />" />
                     <input
                        type="button" class="bt2" name="cancel"
                        value="<spring:message code="label.join.cancel" />" /></td>
                  </tr>
                  
               </table>
            
               
               
            
               
               
               

            
            
            </table>
         </form>

      </div>
<div class="footer">
          <div class="section">
                        <div>
                                 <ul class="asdf">
                                 <hr>
                                    <li><a onclick="facheck('../images/fa/fa1.PNG')"><font color="#4C4C4C">회원
                                          가입안내</font></a><a> | </a> </span></li>
                                    <li><a onclick="facheck('../images/fa/fa2.PNG')"><font color="#4C4C4C">상품
                                          주문 방법</font></a><a> | </a></li>
                                    <li><a  onclick="facheck('../images/fa/fa3.PNG')"><font color="#4C4C4C">주문
                                          확인</font></a><a> | </a></li>
                                           <li><a  onclick="facheck('../images/fa/fa5.PNG')"><font color="#4C4C4C">주문
                                          취소</font></a><a> | </a></li>
                                  <li><a  onclick="facheck('../images/fa/fa6.PNG')"><font color="#4C4C4C">공동구매
                                          최소 갯수</font></a><a> | </a></li>
                                    <li><a onclick="facheck('../images/fa/fa7.PNG')"><font color="#4C4C4C">개인정보
                                          취급 방법</font></a><a> | </a></li>
                                    <li><a  onclick="facheck('../images/fa/fa8.PNG')"><font color="#4C4C4C">비밀번호
                                          분실</font></a><a> | </a></li>
                                    <li><a  onclick="facheck('../images/fa/fa9.PNG')"><font color="#4C4C4C">쇼핑몰
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