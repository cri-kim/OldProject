<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><spring:message code="runtime6.freeboarddetail" /></title>
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
      $("input[name=list]").bind('click',function(){
         window.location.href="<spring:url value="/freeboard/contact" />";
      });
      //삭제
      $("#remove").bind('click', function(){
         if(confirm(validation.getMessage('msg_confirm_remove_general',['label_post']))){
            $.ajax({
               url:'<spring:url value="/freeboard/detail/"/>${post.fb_id}',
               type:'DELETE',
               success: function(data, textStatus, jqXHR){
                  var code ="msg_alert_complete_general";
                  //삭제된 결과가 0이면 이미 삭제된 글이므로 메세지를 출력하고 리스트로 보낸다.
                  if(data.updCnt ==0) {
                     code= "msg_alert_error_general";
                  }
                  //삭제된 결과가 1이면 정상적으로 삭제되었으므로 메세지를 출력하고 리스트로 보낸다.
                  alert(validation.getMessage(code,['label_remove']));
                  
                  window.location.href = "<spring:url value="/freeboard/contact" />";
               },
               error : function(jqXHR, textStatus, errorThrown){
                  alert(validation.getMessage("msg_alert_error_general"));
               }
            });
         }
      });
//       //수정부분
      $("#modify").bind('click',function(){
         window.location.href = "<spring:url value="/freeboard/form/" />${post.fb_id}";
      });
      
      $("#commentForm").validate({
          rules : {
             comment : {
                required : true,
                rangelength : [10,200]
             }
          },   
          messages : {
             comment : {
            	<spring:message code="label.comment" var="comment" />
                required : validation.getMessage('NotEmpty.general',['label.comment']),
                rangelength : "<spring:message code="Length.general" arguments="${comment},10,200" />"
             }
          }
       });
      
      $("#regComment").css('cursor','pointer');
      //코멘트 등록
      $("#regComment").bind('click', function() {
         if($("#commentForm").valid()) {
            $.post(
            '<spring:url value="/cmt/comment" />',
            $("#commentForm").serialize(),
            function (result){
               
               if(result.error != undefined){
                  //실패
                  validation.showMessage(result.error, validation.getMessage('label.comment'));
               } else {
                  //성공
                  $("#comment").val("").focus();
                  loadComments("${post.fb_id}");
//                   $("#commentList").html("");
//                   $(result.commentList).each(function(index, comment){
//                   $ul = $("#commentList").append("<ul>");
//                   $ul.append("<li>").append("span").append(comment.cid);
//                   $ul.append("<li>").append("span").append(comment.comments);
//                   $ul.append("<li>").append("span").append(comment.crt_Dttm);
                  //여기서 내가 작성한 코멘트이면 버튼을 달아주면 된다.
//                   });
               }
            }
         );
         }
      });
      loadComments("${post.fb_id}");
   });
   
   var dBtnSrc = "<spring:url value="/img/icons/delete.png" />";

   function loadComments(fb_id){
      $.get(
         '<spring:url value="/cmt/comment" />/' + fb_id,
         function(result) {
            $("#commentList").html("");
            $(result.data.commentList).each(function(index, comment){
               var ul = $("<ul>").addClass("comment-ul").attr("id", comment.cmt_Num);
               var span = $("<span>").html(comment.cid);
               var li = $("<li>").append(span).addClass("comment-li");
               ul.append(li);
               
               span = $("<span>").html(comment.comments);
               li = $("<li>").append(span).addClass("comment-li");
               ul.append(li);
               
               span = $("<span>").html(comment.crt_Dttm);
               li = $("<li>").append(span).addClass("comment-li");
               ul.append(li);
               //여기서는 내가 작성한 코멘트이면 버튼을 달아주면 될듯
               if("${userInfo.username}" == comment.cid) {
                  var deleteBtn = $("<image>").addClass("button-small").attr("src", dBtnSrc);
                  span = $("<span>").append(deleteBtn);
                  li = $("<li>").append(span).addClass("comment-li");
                  ul.append(li);

                  deleteBtn.bind('click', function() {
                     deleteComment(comment.cmt_Num);
                  });
               }
               $("#commentList").append(ul);

            });
         });
      
   }
   /* function modifyComment(cmt_Num) {
      $("#commentList ul").each(function(idx, rowUl) {
         if($(rowUl).attr("id") != cmt_Num) {
            var contentSpan = $("span", ($("li",rowUl)[1]));
            var txtArea = $("textarea", contentSpan);
            if(txtArea.length>0) {
               contentSpan.html(txtArea.html());
               
               var mbtn = $("<image>").addClass("button-small").attr("src", mBtnSrc);
               var dbtn = $("<image>").addClass("button-small").attr("src", dBtnSrc);
               
               $("sapn>img", ($("li",rowUl)[3])).remove();
               $("span",($("li",rowUl)[3])).append(mbtn).append(dbtn);
               
               mbtn.bind('click', function() {
                  modifyComment($(rowUl).attr("id"), $("span", ($("li", rowUl)[3])));
               });
               dbtn.bind('click',function() {
                  deleteComment($(rowUl).attr("id"));
               });
            }
         }
         else {
            var  contentSpan = $("span", ($("li", rowUl)[1]));
            contentSpan.html("<textarea style='margin-left: 0px; margin-right: 0px; width: 471px; resize:none;' >" + contentSpan.html() + "</textarea>");
            var newBtn = $("<image>").addClass("button-small").attr("src", "<spring:url value="/img/icons/button06.png" />");
            $("span>img", ($("li", rowUl)[3])).remove();
            $("span", ($("li", rowUl)[3])).append(newBtn);
            
            
            
            
            newBtn.bind('click', function() {
               //길이 제한을 체크 해야 한다.....
 modifyComment($(rowUl).attr("id"), $("span", ($("li", rowUl)[3]))); 
               //alert("길이제한 각자 추가 하세요!")
       
               if($("#commentForm").valid()) {
               
               $.ajax({
                        url : "<spring:url value="/cmt/comment" />",
                        data : $("#commentForm").serialize(),
                        type : 'PUT',
                        success : function(result) {
                           alert("등록하자");
                           modifyComment(comment.comments);
                        }
                     });
           
               }                         
            });
         }
      });
   } */
   function deleteComment(cmt_Num) {
      $.ajax({
         url : "<spring:url value="/cmt/comment/" />" + cmt_Num,
         type : "DELETE",
         success : function(result) {
            if (result.data.delCnt == 1) {
               alert(validation.getMessage("msg.alert.complete.general", ["label.remove"]));
               $("#" + cmt_Num).remove();
            }
         }
      });
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


<c:if test="${userInfo.username == post.userId }">
<tr>
<td align="right">
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
   width:50px; 
   padding: 6px 0 6px; 
   text-align: center; 
   font-weight: bold;" value="<spring:message code="label.relist" />"/>
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
            <th><c:out value="${post.fb_title}" /></th>
            <th>작성자</th>
            <th><c:out value="${post.userId }"/></th>
         </tr>
         <tr height="200px">
         <%-- <td bgcolor="#FFFDFF"><spring:message code="label.content"/></td> --%>
         <th>내용</th>
         <td colspan="3" valign="top"><c:out value="${post.fb_content}" /></td>
      </tr>
      
      </thead>
      <tbody id="freeboardList">
      
      </tbody>
   </table>
</div>
   <div class="comment" style="width:80%; margin-top:10px">
      <form id="commentForm" name="commentForm">
      <input type="hidden" name="fb_id" value="${post.fb_id}" />
         <div id="commentList"></div>
         <div id="inputComment">
            <ul class="comment-ul">
             <li class="comment-li"><span>${userInfo.username}</span>&nbsp;&nbsp;
               <span class="wide"><textarea id="comment" name="comment" style="resize:none;"></textarea></span></li>
               <li class="comment-li"><span><img id="regComment" alt="comment" src="<spring:url value="/img/icons/button04.png" />" class="button" /></span></li>   
               
               
            </ul>
         </div>
      </form>
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
