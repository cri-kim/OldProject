<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!doctype html>
<html>
<head>
<title><spring:message code="label.qnaform"/></title>
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
$(function() {
<c:choose>
   <c:when test="${crtCnt == 0}">
      //실패
      alert(validation.getMessage('msg.alert.error.general', ['label.insert']));
      $("#title").val("${postParam.title}");
      $("#content").html("${postParam.content}");
   </c:when>
   <c:when test="${crtCnt == 1}">
      //성공
      alert(validation.getMessage('msg.alert.complete.general', ['label.insert']));
      window.location.href = vs.config.contextRoot + "/qna/list";
   </c:when>
   <c:otherwise>
      <c:if test="${err != null}">
            //server side validation 실패
            $("#title").val("${postParam.title}");
            $("#content").html("${postParam.content}");
            var err = ${err};
            validation.showMessage(err.data.error, 'td#label_');
      </c:if>
   </c:otherwise>
</c:choose>
      $("input[name=list]").bind('click', function() {
         window.location.href = "<spring:url value="/qna/list" />";
      });
      
      $("#postForm").validate({
    	     rules : {
    	    	 title : {
    	           required : true,
    	           rangelength : [5, 30]
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
    	           rangelength : "<spring:message code="Length.general" arguments="${title},5,30"/>"
    	        },
    	        content : {
    	           <spring:message code="label.content" var="content" />
    	           required : "<spring:message code="NotEmpty.general" arguments="${content}" />",
    	           rangelength : "<spring:message code="Length.general" arguments="${content},5,1000"/>"     
    	     }
    	   }
    	  });
      
      
      
   $("#update").bind('click', function() {
         if($("#postForm").valid()){
            $.ajax({
               url : '<spring:url value="/qna/detail/" />',
               data : $("#postForm").serialize(),
               type: 'PUT',
                  success : function(data,textStatus,jqXHR) {
                  var code = "msg_alert_complete_general";
                  /* window.location.href = "<spring:url value="/qna/list" />";  */
                  if(data.updCnt == 0) {
                     code = "msg_alert_error_general";
                  }
                  alert(validation.getMessage(code, ['label_update']));
                  window.location.href = "<spring:url value="/qna/list" />";
               },
               error : function(jqXHR, textStatus, errorThrown) {
                  alert("게시글 수정 에러남");
                  alert(validation.getMessage('msg.alert.error.general'));
               }
            });
         }
      });

      $("#insert").bind('click', function(){
    	  alert(1);
   			if(confirm("등록하시겠습니까?")){
            	$("#postForm").submit();
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



<div style="text-align: right; height: 30px; width:90%">
      <input type="button" name="list" style="cursor: pointer; 
   border: 1px solid #bebebe; 
   width: 50px; 
   padding: 6px 0 6px; 
   text-align: center; 
   font-weight: bold;" value="목록" />
      
      <c:choose>
         <c:when test="${post != null}">
<input type="button" id="update" name="update" style="cursor: pointer; 
   border: 1px solid #bebebe; 
   width: 50px; 
   padding: 6px 0 6px; 
   text-align: center; 
   font-weight: bold;"
               value="<spring:message code="label.update" />" />
         </c:when>
         <c:otherwise>

   <input type="button" id="insert" name="insert" style="cursor: pointer; 
   border: 1px solid #bebebe; 
   width: 50px; 
   padding: 6px 0 6px; 
   text-align: center; 
   font-weight: bold;"
               value="<spring:message code="label.insert" />" />
         </c:otherwise>
      </c:choose>
   </div>

   <form name="postForm" id="postForm" method="POST" action='<spring:url value="/qna/detail" />'>
      <input type="hidden" name="q_no" id="q_no" value="${post.q_no}" />
      <br>
      <div class="boardcss_list_table">

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
            <td><textarea style="resize:none;width: 100%; height: 100%" name="title" id="title" ><c:out value="${post.title}" 
/></textarea>

               </td>
            <th>작성자</th>
            <th><c:choose>
                  <c:when test="${post == null}">
                     <c:out value="${userInfo.username}" />
                  </c:when>
                  <c:otherwise>
                     <c:out value="${post.userId}" />
                  </c:otherwise>
               </c:choose>
                           <tr></tr></th>
         </tr>
         <tr height="200px">
      
         <th>내용</th>
   
         <td colspan="3" valign="top"><textarea
                  style="resize:none;width: 100%; height: 100%;" id="content" name="content"><c:out
                     value="${post.content}" /></textarea></td>
                     <tr></tr>

      </tr>      
         
      </thead>
      <tbody id="freeboardList">
      
      </tbody>
   </table>
</div>
      
      
      
      
   </form>
      <br><br><br><br><br>
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