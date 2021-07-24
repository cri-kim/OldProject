<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp"%>

<!DOCTYPE html>
<html>
<head>
   
<meta charset="UTF-8">
<title><spring:message code="label.qna"/></title>

<link rel="stylesheet" href="<spring:url value="/css/style.css" />" type="text/css">
<link href="<spring:url value="/css/view/contact_list.css"/>" rel="stylesheet" type="text/css">
<jsp:include page="/WEB-INF/view/com/meta.jsp" />
<jsp:include page="/WEB-INF/view/com/favicon.jsp" />
<jsp:include page="/WEB-INF/view/com/css.jsp" />
<jsp:include page="/WEB-INF/view/com/script.jsp" />
</head>


<script type="text/javascript">
function facheck(fa){
	   var k =window.open("",""," width=900,height=300");
	   k.document.open();
	   k.document.write("<html><body><img src='<spring:url value='../"+fa+"' />' /><body></html>");
	   k.document.close();
	}
$(function() {
	if("${userInfo.idtr}" == "관리자"){
		$("#newPost1").hide();
	}
	else{
		$("#newPost1").show();
	}
   $("input[name=searchText]").attr('disabled', true);

   $("input[name=searchButton]").bind('click', function() {
      search();
   });

   $("input[name=searchText]").bind('keypress', function(e) {
      if (e.keyCode == 13) {
         e.preventDefault();
         search();
      }
   });

   $(":checkbox").bind(
         'click',
         function(e) {
            $("input[name=searchText]").attr('disabled',
                  $(":checked").length == 0);
            if ($(":checked").length == 0) {
               $("input[name=searchText]").val("");
            }
         });
   $("#newPost1").bind('click', function() {
      window.location.href = "<spring:url value="/qna/form/new" />";
   });

   search();
});

function search() {
   if ($("input[name=searchText]").val().length == 0
         && $("input[value=name]:checked").length == 1) {
      alert("작성자를 입력하세요.");
      return;
   }

   $.post(
            "<spring:url value="/qna/search" />",
               $("#searchForm").serialize(),
               function(result) {
                  console.log(result);
                  //결과 처리
                  //기존 화면 제거
                  $("#qnaList").html("");
                  //새로운 리스트 추가
                  $(result.postList)
                        .each(
                              function(index, post) {
                                 var $tr = $("<tr style='cursor:pointer;'>");
                                 $tr.append($("<td bgcolor='#FFFFFF'>").append(post.q_no));
                                 $tr.append($("<td align='left'>").append(post.title));
                                 if(post.userId == 000000){
                                	 $tr.append($("<td bgcolor='#FFFFFF'>").append("관리자"));
                                 } else{
                                 	$tr.append($("<td bgcolor='#FFFFFF'>").append(post.userId));
                                 }
                                 $tr.append($("<td bgcolor='#FFFFFF'>").append(post.q_dttm));
                                 $("#qnaList").append($tr);
                                 
                                 $tr.bind('click',
                                       function() {
                                    window.location.href = "<spring:url value="/qna/detail/"/>"
                                                      + post.q_no;
                                             });
                                 $tr.bind('mouseover', function() {
                                                $tr.css("background", "#D9E5FF");
                                             });
                                 $tr.bind('mouseleave', function() {
                                                $tr.css("background", "#ffffff");
                                             });
                              });

                  var $p = result.paging;
                  //페이지 갯수
                  //$p.pageCnt
                  //현재 페이지
                  //$p.currPageNo
                  var r = $p.currPageNo * $p.pageCnt;
                  var pgSet = $p.pageCnt * $p.pageRows; //=>25
                  var endPageNo = (parseInt(r / pgSet) + (r % pgSet > 0 ? 1
                        : 0))
                        * $p.pageCnt;

                  var sartPageNo = endPageNo - $p.pageCnt + 1;

                  if (endPageNo > $p.lastPageNo) {
                     endPageNo = $p.lastPageNo;
                     startPageNo = endPageNo
                           - (endPageNo % $p.pageCnt) + 1;
                  }

                  var $pagingArea = $("#pagingArea");
                  $pagingArea.html("");
                  $pagingArea.append($("<td>")).append("<a href='#' onclick='goPage(" + $p.firstPageNo + ")'><img src='<spring:url value='../images/first.png'  />' /></a>");
                  $pagingArea.append($("<td>")).append("<a href='#' onclick='goPage(" + $p.prevPageNo + ")'><img src='<spring:url value='../images/prev.png'  />' /></a>");

                  for (var i = startPageNo; i <= endPageNo; i++) {
                     if ($p.currPageNo == i) {
                        $pagingArea.append($("<td>")).append(i);
                     } else {
                        $pagingArea.append($("<td>")).append(
                              "<a href='#' onclick='goPage(" + i
                                    + ")'>" + i + "</a>");
                     }
                  }

                  $pagingArea.append($("<td>")).append("<a href='#' onclick='goPage(" + $p.nextPageNo + ")'><img src='<spring:url value='../images/next.png'  />' /></a>");
                  $pagingArea.append($("<td>")).append("<a href='#' onclick='goPage(" + $p.lastPageNo + ")'><img src='<spring:url value='../images/last.png'  />' /></a>");

               });

}
function goPage(currPageNo) {
   $("#currPageNo").val(currPageNo);
   search();
}
$(function() {
   $("input[name=relist1]").bind('click', function() {
      window.location.href = "<spring:url value="/qna/list" />";
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

</center>



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
                  <input type="text" id="searchText1" name="searchText1"
                     value="Enter search query"> <input type="button" id="sub"
                     name="sub" value="">
               </form>
            </div>
         </div>
      </div>
      
<div class = "body">
<div class="home">
<div class="featured">
 <img src="<spring:url value="/images/contact.jpg"/>" width="860" height="350" align="middle"></div>
            <input type="button" class="relist1" name="relist1" id="relist1" value="<spring:message code="label.relist"/>" />
             <input class="newPost1" type="button" name="newPost1" id="newPost1" value="<spring:message code="label.insert"/>" />
<div class="boardcss_list_table">
   <table class="list_table">
      <colgroup>
         <col width="15%" />
         <col width="55%" />
         <col width="15%" />
         <col width="15s%" />
      </colgroup>
      <thead>
         <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일자</th>
         </tr>
      </thead>
      <tbody id="qnaList">
      
      </tbody>
   </table>
</div>
      <br>
      
         <br><br>
<center>
         <tfoot>
            <tr> 
            
               <td colspan="5" align="center">
                 <form id="searchForm" align="center">
                     <input type="hidden" name="currPageNo" id="currPageNo" value="1" />
                     <input type="checkbox" name="searchCondition" value="title" />
                     <spring:message code="label.title" />
                     &nbsp; <input type="checkbox" name="searchCondition"
                        value="content" />
                     <spring:message code="label.content" />
                     &nbsp; <input type="checkbox" name="searchCondition" value="cid" />
                     <spring:message code="label.writer" />
                     &nbsp; <input type="text" name="searchText" maxlength="20" />&nbsp;
                     <input type="button" name="searchButton"
                        value="<spring:message code="label.click"/>" />
                  </form>
               </td>
            </tr>
         </tfoot> 
   
      






<div class="pgarea" align="center">
<br>
      <table align="center" style="width: 500px;">
                  <tr></tr><td>&nbsp; </td>
               <tr align="center" id="pagingArea"
                     style="font-size: 15px; color: #5D5D5D;">
               </tr>
               </table>
   </div>   




</div></div>
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