<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><spring:message code="label.qnadetail"/></title>
   <jsp:include page="/WEB-INF/view/com/meta.jsp" />
   <jsp:include page="/WEB-INF/view/com/favicon.jsp" />
   <jsp:include page="/WEB-INF/view/com/css.jsp" />
   <jsp:include page="/WEB-INF/view/com/script.jsp" />
<script type="text/javascript">
function facheck(fa){
	   var k =window.open("",""," width=900,height=300");
	   k.document.open();
	   k.document.write("<html><body><img src='<spring:url value='../../"+fa+"' />' /><body></html>");
	   k.document.close();
	}
   
   $(function(){
		   $("#replyForm").validate({
	  	     rules : {
	  	    	 title : {
	  	           required : true,
	  	           rangelength : [5, 50]
	  	        },
	  	        content : {
	  	           required : true,
	  	           rangelength : [5, 1000]
	  	        }
	  	        
	  	     },
		     messages : {
    	    	 title : {
    	           <spring:message code="label.title" var="title" />
    	           required : "<spring:message code="NotEmpty.general" arguments="${title}" />", 
    	           rangelength : "<spring:message code="Length.general" arguments="${title},5,50"/>"
    	        },
    	        content : {
    	           <spring:message code="label.content" var="content" />
    	           required : "<spring:message code="NotEmpty.general" arguments="${content}" />",
    	           rangelength : "<spring:message code="Length.general" arguments="${content},5,1000"/>"     
    	     	}
		     }
		  });
	   
	   
	   
	   
	   if("${userInfo.idtr}" != "관리자"){
		   $("input[name=remove]").show();
	   }  
	   if("${userInfo.idtr}" == "관리자"){
		   $("input[name=remove]").hide();
	   }
	   
	   
      $("input[name=list]").bind('click',function(){
         window.location.href="<spring:url value="/qna/list" />";
      });
      //삭제
      $("#remove").bind('click', function(){
         if(confirm(validation.getMessage('msg_confirm_remove_general',['label_post']))){

            $.ajax({
               url:'<spring:url value="/qna/detail/"/>${post.q_no}',
               type:'DELETE',
               success: function(data, textStatus, jqXHR){
                  
                  var code ="msg_alert_complete_general";
                  //삭제된 결과가 0이면 이미 삭제된 글이므로 메세지를 출력하고 리스트로 보낸다.
                  if(data.updCnt ==0) {
                     code= "msg_alert_error_general";
                  }
                  //삭제된 결과가 1이면 정상적으로 삭제되었으므로 메세지를 출력하고 리스트로 보낸다.
                  alert(validation.getMessage(code,['label_remove']));
                  
                  window.location.href = "<spring:url value="/qna/list" />";
               },
               error : function(jqXHR, textStatus, errorThrown){
                  alert(validation.getMessage("msg_alert_error_general"));
               }
            });
         }
      });
//       //수정부분
      $("#modify").bind('click',function(){

         	window.location.href = "<spring:url value="/qna/form/" />${post.q_no}";

      });

      $("#replySubmit").bind('click', function() {
    	  if($("#replyForm").valid()){
            	$("#replyForm").submit();
    	  }
      });
      
      
   });
   //답글등록
   function showform(obj){
      var show=document.getElementById(obj);
      show.style.display="block";
}
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
</center>
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
                  
                  <a>
                  <select onchange="window.open(value,'_self');" style="color:#134067;font-size:12px;line-height:24px;text-decoration:none;text-shadow:0 1px 0 #fde9c3;border-color:#FFFFFF">
                  <option selected="selected"  style="color:#134067;font-size:12px;line-height:24px;text-decoration:none;text-shadow:0 1px 0 #fde9c3;">마이페이지</option>
                  <c:if test="${userInfo !=null }">
                  <option value="<spring:url value="/mypage/myinfor/${userInfo.username} " />" style="color:#134067;font-size:12px;line-height:24px;text-decoration:none;text-shadow:0 1px 0 #fde9c3;">개인정보</option>
                     <c:choose>
                     <c:when test="${userInfo.idtr == '사용자'}">
                     <option value="<spring:url value="/mypage/buyinfor/${userInfo.username}" />" style="color:#134067;font-size:12px;line-height:24px;text-decoration:none;text-shadow:0 1px 0 #fde9c3;">구매목록</option>
                     </c:when>
                     <c:otherwise>
                     <option value="<spring:url value="/mypage/sellinfor/${userInfo.username}" />" style="color:#134067;font-size:12px;line-height:24px;text-decoration:none;text-shadow:0 1px 0 #fde9c3;">판매유저목록</option>
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
                  <li class="selected">
                     <a href="<spring:url value="/home" />"><span>Home</span></a>
                  </li>
                  <li>
                     <c:if test="${userInfo !=null }">                
                     <a href="<spring:url value="/business/itemlist/${userInfo.username}" /> "/></c:if><span>구매/등록</span></a>
                  </li>
                  <li>
                     <c:if test="${userInfo !=null }">
                     <a href="<spring:url value="/qna/list" />"></c:if><span>고객센터</span></a>
                  </li>
                  <li>
                     <c:if test="${userInfo !=null }">
                     <a href="<spring:url value="/freeboard/contact" />"></c:if><span>자유게시판</span></a>
                  </li>
               </ul>
               <form>
                  <input type="text" id="searchText" name="searchText"value="Enter search query">
                  <input type="button" id="sub" name="sub" value="">
               </form>
            </div>
         </div>
      </div>



<div class="body">

<center>
&nbsp;
<%-- <c:out value="${userInfo.username }"/> db의 아이디 --%>
<%-- <c:out value="${post.userId }"/> json의 userId --%>
<div style="text-align: right; height:30px; width:80% ">



<tr>
<td align="right">
<c:if test="${userInfo.username == post.userId }">
<input type="button" id="modify" name="modify" align="right" style="cursor: pointer; 
   border: 1px solid #bebebe; 
   width: 50px; 
   padding: 6px 0 6px; 
   text-align: center; 
   font-weight: bold;" value="<spring:message code="label.update" />" />
   
   <input type="button" id="remove" name="remove" align="right" style="cursor: pointer; 
   border: 1px solid #bebebe; 
   width: 50px; 
   padding: 6px 0 6px; 
   text-align: center; 
   font-weight: bold;" value="<spring:message code="label.remove" />" />

</c:if>

   <input type="button" name="list" align="right" style="cursor: pointer; 
   border: 1px solid #bebebe; 
   width: 50px;
   padding: 6px 0 6px; 
   text-align: center; 
   font-weight: bold;" value="<spring:message code="label.relist" />" />
   
   
</td>
</tr>
</div>
<br>
<div class="boardcss_list_table" style="width:80% ">

   <table class="list_table">
      <colgroup>
         <col width="15%" />
         <col width="55%" />
         <col width="15%" />
         <col width="15%" />
      </colgroup>
      <thead>
         <tr>
            <th>제목</th>
            <th><c:out value="${post.title}" /></th>
            <th>작성자</th>
            <th>
            <c:if test="${post.name == '관리자'}">
            <c:out value="${post.name}"/>
            </c:if>
            <c:if test="${post.name != '관리자'}">
            <c:out value="${post.userId}"/>
            </c:if></th>
         </tr>
         <tr height="200px">
         <%-- <td bgcolor="#FFFDFF"><spring:message code="label.content"/></td> --%>
         <th>내용</th>
         <td colspan="3" valign="top"><c:out value="${post.content}" /></td>
      </tr>
      
      </thead>
      <tbody id="qnaList">
      
      </tbody>
   </table>
   
   
   
</div>


<c:choose>
   <c:when test="${userInfo.username=='000000'}">
   <c:if test="${post.q_no % 2 == '0'}">
<form name="replyForm" id="replyForm" method="POST" action='<spring:url value="/qna/detail/reply" />' >
      <input type="hidden" name="q_no" id="q_no" value=${post.q_no}-1/>
      <input type="hidden" name="enabled" id="enabled" value="1"/>
         <script>
         var qno=${post.q_no}-1;
         var val=$('#q_no').val(qno);
         
         </script>
      <br>
		<div class="boardcss_list_table" style="width:80% ">
   <c:if test="${post.enabled != 1}" >  
   <table class="list_table">
      <colgroup>
         <col width="15%" />
         <col width="55%" />
         <col width="15%" />
         <col width="15%" />
      </colgroup>
      <thead>
         <tr>
            <th>제목</th>
            <td><textarea style="resize:none;width: 100%; height: 100%" name="title" id="title" readonly><c:out value="[답글]${post.title}" />
            </textarea>
               </td>
            <th>작성자</th>
            <th>
               <c:out value="${userInfo.username}" />
            </th>
         </tr>
         <tr height="200px">
      
         <th>내용</th>
   
         <td colspan="3" valign="top"><textarea
                  style="resize:none;width: 100%; height: 100%;" id="content" name="content"></textarea></td>

      </tr>      
         
      </thead>
         <tbody id="freeboardList" style="border-left:0px;">
      <tr align="right" ><td colspan='4'><input type="button" id="replySubmit" name="replySubmit"  style="cursor: pointer; 
   border: 1px solid #bebebe; 
   width: 50px;
   padding: 6px 0 6px; 
   text-align: center; 
   font-weight: bold;
   margin-left:800px;" value="등록" />
      </td></tr>
      </tbody>
   </table>
   </c:if>
</div>
   </form>
   </c:if>
   </c:when>
   </c:choose>
   </div>
   <br><br><br>
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
