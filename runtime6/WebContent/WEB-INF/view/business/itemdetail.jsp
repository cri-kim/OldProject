<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp" %>  
<!DOCTYPE html>
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
   <link rel="stylesheet" href="<spring:url value="/css/view/contact_list.css" />" type="text/css">   
   <title><spring:message code="runtime6.itemdetail" /></title> 
   <jsp:include page="/WEB-INF/view/com/meta.jsp" />
   <jsp:include page="/WEB-INF/view/com/favicon.jsp" />
   <jsp:include page="/WEB-INF/view/com/css.jsp" />
   <jsp:include page="/WEB-INF/view/com/script.jsp" />
</head>
<style>
.s1 {
   BORDER-TOP: #00005D 3px solid;
   font-size: 13px;
}

.s4{
BORDER-BOTTOM: #00005D 3px solid;
   font-size: 13px;
}
#commentList{
   text-align:left;
   margin-left:130px;
   width:960px;
}
</style>
<script type="text/javascript">
function facheck(fa){
	   var k =window.open("",""," width=900,height=300");
	   k.document.open();
	   k.document.write("<html><body><img src='<spring:url value='../../"+fa+"' />' /><body></html>");
	   k.document.close();
	}

$(function(){
   if(("${userInfo.idtr}") == "사용자");{
       $("input[name=buy]").show();
   }      
   if(("${userInfo.idtr}") != "사용자"){
      $("input[name=buy]").hide();
   }

   
   $("input[name=list]").bind('click',function(){
      window.location.href="<spring:url value="/business/itemlist/${userInfo.username}" />"; 
   });
   
    $("input[name=buy]").bind('click',function(){
    	if("${business.remainder}" <=0){
    		alert("품절되었습니다");
    	} 
    	else{
		    if ($("#basketForm").valid()) {
		         $.post('<spring:url value="/business/insertBasket/" />',
		               $("#basketForm").serialize(),
		               function (result) {
		                  if (result.data != null && result.data.error != undefined){
		                     console.log(result.data.error);
		                  } else {
		                     alert("<spring:message code="msg.buy.complete"/>");
		                     if (confirm("<spring:message code="msg.buy.question"/>")){
		                        window.location.href = "<spring:url value="/business/itemlist/${userInfo.username}" />";
		                     }
		                     else{
		                        //장바구니사이트로 이동
		                        window.location.href = "<spring:url value="/basket/list" />";
		                     }
		                  }
		            });   
		         } 
    	}
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
         '<spring:url value="/bcmt/bcomment" />',
         $("#commentForm").serialize(),
         function (result){
            if(result.error != undefined){
               //실패
               validation.showMessage(result.error, validation.getMessage('label.comment'));
            } else {
               //성공
               $("#comment").val("").focus();
               loadComments("${business.item_no}");
//                  $("#commentList").html("");
//                  $(result.commentList).each(function(index, comment){
//                  $ul = $("#commentList").append("<ul>");
//                  $ul.append("<li>").append("span").append(comment.cid);
//                  $ul.append("<li>").append("span").append(comment.comments);
//                  $ul.append("<li>").append("span").append(comment.crt_Dttm);
               //여기서 내가 작성한 코멘트이면 버튼을 달아주면 된다.
//                  });
            }
         }
      );
      }
   });
   loadComments("${business.item_no}");
});


var dBtnSrc = "<spring:url value="/img/icons/delete.png" />";

function loadComments(item_no){
   $.get(
      '<spring:url value="/bcmt/bcomment" />/' + item_no,
      function(result) {
         $("#commentList").html("");
         $(result.data.commentList).each(function(index, comment){
            var ul = $("<ul>").addClass("comment-ul").attr("id", comment.cmt_num);
            var span = $("<span>").html(comment.cid);
            var li = $("<li>").append(span).addClass("comment-li");
            ul.append(li);
            
            span = $("<span>").html(comment.comments);
            li = $("<li>").append(span).addClass("comment-li");
            ul.append(li);
            
            span = $("<span>").html(comment.crt_dttm);
            li = $("<li>").append(span).addClass("comment-li");
            ul.append(li);
            //여기서는 내가 작성한 코멘트이면 버튼을 달아주면 될듯
            if("${userInfo.username}" == comment.cid) {

               var deleteBtn = $("<image style='width:20px;height:20px'>").addClass("button-small").attr("src", dBtnSrc);
               span = $("<span>").append(deleteBtn);
               li = $("<li>").append(span).addClass("comment-li");
               ul.append(li);

               deleteBtn.bind('click', function() {
                  deleteComment(comment.cmt_num);
               });
            }
         $("#commentList").append(ul);

      });
   });   
} 
/*  function modifyComment(cmt_num) {
   $("#commentList ul").each(function(idx, rowUl) {
      if($(rowUl).attr("id") != cmt_num) {
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
         contentSpan.html("<textarea>" + contentSpan.html() + "</textarea>");
         
         var newBtn = $("<image>").addClass("button-small").attr("src", "<spring:url value="/img/icons/button06.png" />");
         $("span>img", ($("li", rowUl)[3])).remove();
         $("span", ($("li", rowUl)[3])).append(newBtn);
         newBtn.bind('click', function() {
            //길이 제한을 체크 해야 한다.....
            //alert("길이제한 각자 추가 하세요!")
            $.ajax({
               url : "<spring:url value="/bcmt/bcomment" />",
               type : "PUT",
               data : {"item_no" : "${business.item_no}", "cmt_num" : cmt_num, "comments" : $("textarea", contentSpan).val()},
               success : function(result){
                  
               }
            });
         });
      }
   });
}  */
function deleteComment(cmt_num) {
   $.ajax({
      url : "<spring:url value="/bcmt/bcomment/" />" + cmt_num,
      type : "DELETE",
      success : function(result) {
         if (result.data.delCnt == 1) {
            alert(validation.getMessage("msg.alert.complete.general", ["label.remove"]));
            $("#" + cmt_num).remove();
         }
      }
   });
}
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
      



      <form name="basketForm" id="basketForm">
      <input type="hidden" name="cid" id="cid" value="<c:out value="${userInfo.username}"/>" />
      <input type="hidden" name="item_name" id="item_name" value="<c:out value="${business.item_name}"/>" />
      <input type="hidden" name="item_charge" id="item_charge" value="<c:out value="${business.item_charge}"/>" />
      <input type="hidden" name="item_f_no" id="item_f_no" value="<c:out value="${business.item_f_no}"/>" />
      <input type="hidden" name="vender_id" id="vender_id" value="<c:out value="${business.vender_id}"/>" />
      <input type="hidden" name="item_no" id="item_no" value="<c:out value="${business.item_no}"/>" />
      </form>
      
      
      <div class="body" align="center">
         <div style="text-align: right; height:30px; width:50%   ">
         <pre>                                                                                         <b>Login ><font color="#C90000"> 상품 상세내용</font></b>
                        
                     </pre>
                    
         </div><br><br>
   
      <table border="0" cellpadding="0" cellspacing="0" width="1000px">
         <tr>
                   <td  class="s1" bgcolor="#D5D5D5" width="50" nowrap style="padding-left:15px" height="2"></td>
                   <td  class="s1" bgcolor="#D5D5D5" colspan="4"></td>
           </tr>
         <tr>
            <td width="134px" bgcolor="#EAEAEA" height="30"><b><font size="2px"><spring:message code="label.title"/></b></font></td>
            <td  bgcolor="#fcfcfc" ><c:out value="${business.item_name}" /></td>
            
            <td width="134px" bgcolor="#EAEAEA" height="30"><b><font size="2px"><spring:message code="label.writer" /></b></font></td>
            <td  bgcolor="#fcfcfc" ><c:out value="${business.vender_id}"/>
         </tr>
         <tr>
                   <td width="50" nowrap style="padding-left:15px" bgcolor="#D5D5D5" height="2"></td>
                   <td bgcolor="#D5D5D5" colspan="4"></td>
           </tr>
         <tr>
         <td width="134px" bgcolor="#EAEAEA" height="30"><b><font size="2px">유형</b></font></td>
         <td bgcolor="#fcfcfc"><c:out value="${business.item_type}"/></td>
         <td width="134px" bgcolor="#EAEAEA" height="30"><b><font size="2px">최소개수</b></font></td>
         <td bgcolor="#fcfcfc"><c:out value="${business.minimum}"/></td>
         </tr>
         <tr>
                   <td width="50" nowrap style="padding-left:15px" bgcolor="#D5D5D5" height="2"></td>
                   <td bgcolor="#D5D5D5" colspan="4"></td>
           </tr>
         <tr>
         <td width="134px" bgcolor="#EAEAEA" height="30"><b><font size="2px">남은 판매량</b></font></td>
         <td bgcolor="#fcfcfc">${business.remainder}</td>
         <td width="134px" bgcolor="#EAEAEA" height="30"><b><font size="2px">판매 가격</b></font></td>
         <td  bgcolor="#fcfcfc" colspan="3">${business.item_charge}</td>
         
         </tr>
         <tr>
                   <td width="50" nowrap style="padding-left:15px" bgcolor="#D5D5D5" height="2"></td>
                   <td bgcolor="#D5D5D5" colspan="4"></td>
           </tr>
         <tr height="500px">
            <td width="134px" bgcolor="#EAEAEA" height="30" class="s4"><b><font size="3px"><spring:message code="label.content"/></b></font></td>
            <td colspan="3" valign="top"  bgcolor="#fcfcfc" class="s4"><c:out value="${business.content}"  escapeXml="false"/>
            <%-- <img src="../../file/download/${business.item_f_no}"  style="width:300px;height:800px;" /> --%></td>      
         </tr>
         <tr>
                   <td width="50" nowrap style="padding-left:15px" height="2"></td>
                   <td  colspan="4"></td>
           </tr>
         
         <tr>
                   <td width="50" nowrap style="padding-left:15px" bgcolor="#D5D5D5" height="2"></td>
                   <td bgcolor="#D5D5D5" colspan="4"></td>
           </tr>
         </div>
         </table>
         
         
      <div style="text-align: right; height:30px;   ">
         <input type="button" name="buy"style="cursor:pointer;
         border:1px solid #bebebe;
         width:60px;
         height:27px;
         text-align:center;
         font-weight:bold;"
          value="<spring:message code="label.buy" /> " />
         <input type="button" name="list" style="cursor:pointer;
         border:1px solid #bebebe;
         width:50px;
         height:27px;
         text-align:center;
         font-weight:bold;"value="<spring:message code="label.relist" />" />      
      </div>
      
      <div>
      <form id="commentForm" name="commentForm" align="center">
      <input type="hidden" name="item_no" id="item_no" value="${business.item_no}" />
         <div id="commentList"> </div>
         <div id="inputComment">
            <ul class="comment-ul">
             <li class="comment-li"><span>${userInfo.username}</span>&nbsp;&nbsp;
               <span class="wide"><textarea id="comment" name="comment" style="resize:none;"></textarea></span></li>
               <li class="comment-li"><span><img id="regComment" alt="comment" src="<spring:url value="/img/icons/button04.png" />" class="button" style="width:40px; height:30px;"/></span></li>         
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