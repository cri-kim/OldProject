<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp" %>  
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">	
	<title><spring:message code="runtime6.itemform" /></title> 
	<link rel="stylesheet" href="<spring:url value="/css/style.css" />" type="text/css">
	<jsp:include page="/WEB-INF/view/com/meta.jsp" />
	<jsp:include page="/WEB-INF/view/com/favicon.jsp" />
	<jsp:include page="/WEB-INF/view/com/script.jsp" />
	<script src="<spring:url value="/js/ckeditor_4.3.1_standard/ckeditor/ckeditor.js" />"></script>

<script type="text/javascript">
function facheck(fa){
	   var k =window.open("",""," width=900,height=300");
	   k.document.open();
	   k.document.write("<html><body><img src='<spring:url value='../../"+fa+"' />' /><body></html>");
	   k.document.close();
	}

var cbFileUpload = CKEDITOR.tools.addFunction(function(item_f_no){
 	$("#item_f_no").attr('value',item_f_no[0]);
 	$("#img_name").attr('value',item_f_no[1]);
	$("#img_path").attr('value',item_f_no[2]);
});


$(function() {
	CKEDITOR.replace( 'content', {
        filebrowserUploadUrl: '<spring:url value="/file/upload" />?refFunc=' + cbFileUpload
    });
	

	<c:choose>
	<c:when test="${crtCnt == 0}">
		alert(validation.getMessage('msg.alert.error.general',['label.insert']));
		$("#title").val("${postParam.title}");
		$("#content").html("${postParam.content}");
	 </c:when>
	 <c:when test="${crtCnt == 1}">
		//성공
	alert(validation.getMessage('msg.alert.complete.general',['label.insert']));
	window.location.href = vs.config.contextRoot + "/business/itemlist/${userInfo.username}";
	</c:when>
	<c:otherwise>
		<c:if test="${err != null}">
			$("#item_name").val("${businessParam.item_name}");
			$("#content").html("${businessParam.content}");
			var err = ${err};
			validation.showMessage(err.data.error,'td#label_');
		</c:if>
		</c:otherwise>
	</c:choose>
		

		$("#list").bind('click', function() {
			window.location.href = "<spring:url value="/business/itemlist/${userInfo.username}" />"; 

		});
		$("#insert").bind('click', function() {
			if(!CKEDITOR.instances.content.getData()){
				alert("내용 및 이미지를 입력해주세요");
			} else{
				 if($("#businessForm").valid()){
					$("#businessForm").submit();
				}
			}
		});
		  $.validator.addMethod(
		          "regex",
		          function(value, element, regexp) {
		              var re = new RegExp(regexp);
		              if(value<= $("#maximum").val()*1){
		              	return this.optional(element) || re.test(value);
		              }
		          },
		          "<spring:message code="label.minimumcheck"/>"

		  );
		  $.validator.addMethod(
		          "regex1",
		          function(value, element, regexp) {
		              var re = new RegExp(regexp);
		              	return this.optional(element) || re.test(value);
		          },
		          "<spring:message code="label.charcheck"/>"

		  );
		$("#businessForm").validate({
		     rules : {
		    	 item_name : {
		           required : true,
		           rangelength : [5, 30]
		        },
		        item_type : {
		           required : true     
		        },
		        item_charge : {
		        	required : true,
		        	regex1 :  /^([0-9]+)$/
		        },
		        maximum : {
		           required : true,
		           regex1 :  /^([0-9]+)$/
		        },
		        minimum : {
			     required : true,
			     regex1 :  /^([0-9]+)$/,
			     regex :  /^([0-9]+)$/
			     
		        }
		     }, messages : {
		    	 item_name : {
		             <spring:message code="label.title" var="title" />
		             required : "<spring:message code="NotEmpty.general" arguments="${title}" />", 
		             rangelength : "<spring:message code="Length.general" arguments="${title},5,30"/>"
		          },
		          item_type : {
		             <spring:message code="label.prdType" var="prdType" />
		             required : "<spring:message code="NotEmpty.general" arguments="${prdType}" />"
		          },
		          item_charge : {
		        	  <spring:message code="label.charge" var="charge" />
		        	  required : "<spring:message code="NotEmpty.general" arguments="${charge}" />",
		        	  regex1 : "<spring:message code="label.charcheck" />"
		          },
		          maximum : {
		        	  <spring:message code="label.maximum" var="maximum" />
		        	  required : "<spring:message code="NotEmpty.general" arguments="${maximum}" />",
		        	  regex1 : "<spring:message code="label.charcheck"  />"
		          },
		          minimum : {
		        	  <spring:message code="label.minimum" var="minimum" />
		        	  required : "<spring:message code="NotEmpty.general" arguments="${minimum}" />",
		        	  regex1 : "<spring:message code="label.charcheck"  />",
		        	  regx : "<spring:message code="Length.max.general" arguments="${minimum}, label.maximum " />" 
		        	  
		          }
		       
		       }

		
		});
		
	});
$(function() {
	$("input[name=sub]").bind('click', function() {
			 	if($("#searchText1").val() == "Enter search query" || $("#searchText1").val().length==0){
        			alert("검색값을 입력하세요");
        		}
        		else{
        			var $searchText=$("#searchText1").val();
 					
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
                  <font size="3px" ><c:out value="${userInfo.username}" />님</font>
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
		
		
		
		<div class="body" align="center">
		<form name="businessForm" id="businessForm" method="POST" encType="multipart/form-data" action='<spring:url value="/business/itemdetail" />'>
		<input type="hidden" name="item_no" id="item_no" value="1" />
		<input type="hidden" name="vender_id" id="vender_id" value="${userInfo.username}" />
		<input type="hidden" name="item_f_no" id="item_f_no" />
		<input type="hidden" name="img_path" id="img_path" />
		<input type="hidden" name="img_name" id="img_name" />
		<table border="1" align="center" >
			<tr>
				<td width="20%" id="label_title"><spring:message code="label.title" /></td>
				<td><input type="text" name="item_name" id="item_name" /></td>
				<td width="20%"><spring:message code="label.writer" /></td>
				<td width="20%"><c:out value="${userInfo.username}" /></td>
			</tr>
			<tr>
				<td>타입</td>
				<td> 
					<select name="item_type" id="item_type" size="1">
					    	<option value=""  name="item_type" id="item_type">선택하세요</option>
					    	<option value="의류" name="item_type" id="item_type">의류</option>
					    	<option value="식품" name="item_type" id="item_type">식품</option>
					    	<option value="뷰티" name="item_type" id="item_type">뷰티</option>
					    	<option value="도서&문구" name="item_type" id="item_type">도서/문구</option>
					    	<option value="전자제품" name="item_type" id="item_type">전자제품</option>
					    	<option value="생활&주방" name="item_type" id="item_type">생활/주방</option>
					 </select>  
				 </td>
				 <td>가격</td>
				 <td><input type="text" name="item_charge" id="item_charge"  value=""/></td>
			</tr>
			<tr>
				<td>판매총개수</td>
				<td><input type="text" name="maximum" id="maximum"  /></td>
				<td>최소개수</td>
				<td><input type="text" name="minimum" id="minimum"" /></td>
			<tr>
			<tr height="300px" >
				<td valign="top" id="label_content">
				<spring:message code="label.content" /><br>
				(사진 2개이상 첨부시 마지막으로 업로드한 사진이 메인사진으로 등록됩니다.)
				</td>
				<td colspan="3" valign="top"><textarea style="width: 100%;height:100%" id="content" name="content"> </textarea></td>
			</tr>
		</table>
		</form>
		<div style="text-align: right;height:30px;">
			<input type="button" name="list" id="list" value="목록" />
			<c:choose>
			<c:when test="${business != null}">
			<input type="button" id="update" name="update" value="<spring:message code="label.update" />" />
			</c:when>
			<c:otherwise>
			<input type="button" id="insert" name="insert" value="<spring:message code="label.insert" />" />
			</c:otherwise>
			</c:choose>
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