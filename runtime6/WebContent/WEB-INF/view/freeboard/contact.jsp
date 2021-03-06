<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp"%>

<!DOCTYPE html>
<!-- Website template by freewebsitetemplates.com -->
<html>
<head>

<meta charset="UTF-8">
<title><spring:message code="runtime6.freeboardlist" /></title>

<link rel="stylesheet" href="<spring:url value="/css/style.css" />"
   type="text/css">
<link href="<spring:url value="/css/view/contact_list.css"/>"
   rel="stylesheet" type="text/css">
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

.s2 {
   BORDER-TOP: #EAEAEA 1px solid;
   font-size: 13px;
   font-size: 8pt
}

#searchForm {
   height: 50px;
}
</style>

<script type="text/javascript">
function facheck(fa){
	   var k =window.open("",""," width=900,height=300");
	   k.document.open();
	   k.document.write("<html><body><img src='<spring:url value='../"+fa+"' />' /><body></html>");
	   k.document.close();
	}
   $(function() {
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
      $("#newPost")
            .bind(
                  'click',
                  function() {
                     window.location.href = "<spring:url value="/freeboard/form/new" />";
                  });

      search();
   });

   function search() {
      if ($("input[name=searchText]").val().length == 0
            && $("input[value=name]:checked").length == 1) {
         alert("???????????? ???????????????.");
         return;
      }

      $
            .post(
                  "<spring:url value="/freeboard/search" />",
                  $("#searchForm").serialize(),
                  function(result) {
                     console.log(result);
                     //?????? ??????
                     //?????? ?????? ??????
                     $("#freeboardList").html("");
                     //????????? ????????? ??????
                     $(result.postList)
                           .each(
                                 function(index, post) {
                                    var $tr = $("<tr style='cursor:pointer;'>");
                                    $tr
                                          .append($(
                                                "<td bgcolor='#FFFFFF'>")
                                                .append(
                                                      post.fb_id));
                                    $tr.append($("<td>").append(
                                          post.fb_title));
        
                                    	$tr.append($("<td bgcolor='#FFFFFF'>").append(post.userId));
      
                                    $tr
                                          .append($(
                                                "<td bgcolor='#FFFFFF'>")
                                                .append(
                                                      post.fb_write_date));
                                    $("#freeboardList").append($tr);
                                    $tr
                                          .bind(
                                                'click',
                                                function() {
                                                   window.location.href = "<spring:url value="/freeboard/detail/"/>"
                                                         + post.fb_id;
                                                });
                                    $tr
                                          .bind(
                                                'mouseover',
                                                function() {
                                                   $tr
                                                         .css(
                                                               "background",
                                                               "#D9E5FF");
                                                });
                                    $tr
                                          .bind(
                                                'mouseleave',
                                                function() {
                                                   $tr
                                                         .css(
                                                               "background",
                                                               "#ffffff");
                                                });
                                 });

                     var $p = result.paging;
                     //????????? ??????
                     //$p.pageCnt
                     //?????? ?????????
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
      $("input[name=relist]").bind('click', function() {
         window.location.href = "<spring:url value="/freeboard/contact" />";
      });
   });
   $(function() {
      $("input[name=sub]").bind('click', function() {
                if($("#searchText1").val() == "Enter search query" || $("#searchText1").val().length==0){
                    alert("???????????? ???????????????");
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
                        ???????????? ?????? ????????? ???????????????.&nbsp;&nbsp;&nbsp;
                     </c:when>
                  </c:choose>
               <a id="logout" href="<spring:url value="/j_spring_security_logout" />">????????????</a> 
               </c:when>
               <c:otherwise>
               <a href="<spring:url value="/login" />">?????????</a> 
               </c:otherwise>
            </c:choose>
               <span>|</span>
               <c:if test="${userInfo ==null }">
                  <a href="<spring:url value="/join/index" />">????????????</a>
               </c:if>
               <c:if test="${userInfo !=null }">
                  <c:out value="${userInfo.username}" />???
               </c:if>
               <span>|</span>
            <c:choose>   
               <c:when test="${userInfo.email == '0'}">
               <a href="<spring:url value="/mypage/infor" />" >???????????????</a>
               </c:when>
               <c:otherwise>
                  
                  <a>
                  <select onchange="window.open(value,'_self');" style="color:#134067;font-size:12px;line-height:24px;text-decoration:none;text-shadow:0 1px 0 #fde9c3;border-color:#FFFFFF">
                  <option selected="selected"  style="color:#134067;font-size:12px;line-height:24px;text-decoration:none;text-shadow:0 1px 0 #fde9c3;">???????????????</option>
                  <c:if test="${userInfo !=null }">
                  <option value="<spring:url value="/mypage/myinfor/${userInfo.username} " />" style="color:#134067;font-size:12px;line-height:24px;text-decoration:none;text-shadow:0 1px 0 #fde9c3;">????????????</option>
                     <c:choose>
                     <c:when test="${userInfo.idtr == '?????????'}">
                     <option value="<spring:url value="/mypage/buyinfor/${userInfo.username}" />" style="color:#134067;font-size:12px;line-height:24px;text-decoration:none;text-shadow:0 1px 0 #fde9c3;">????????????</option>
                     </c:when>
                     <c:otherwise>
                     <option value="<spring:url value="/mypage/sellinfor/${userInfo.username}" />" style="color:#134067;font-size:12px;line-height:24px;text-decoration:none;text-shadow:0 1px 0 #fde9c3;">??????????????????</option>
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
               	 <c:if test="${userInfo.idtr == '?????????'}">
                  <a href="<spring:url value="/basket/list" />">????????????</a></c:if>
                  <c:if test="${userInfo.idtr != '?????????'}">
                  <a>????????????</a>
                  </c:if>
                  </c:when>
               <c:otherwise>
               <a>????????????</a>
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
                     <a href="<spring:url value="/business/itemlist/${userInfo.username}" /> "/></c:if><span>??????/??????</span></a>
                  </li>
                  <li>
                     <c:if test="${userInfo !=null }">
                     <a href="<spring:url value="/qna/list" />"></c:if><span>????????????</span></a>
                  </li>
                  <li>
                     <c:if test="${userInfo !=null }">
                     <a href="<spring:url value="/freeboard/contact" />"></c:if><span>???????????????</span></a>
                  </li>
               </ul>
               <form>
                  <input type="text" id="searchText1" name="searchText1"value="Enter search query">
                  <input type="button" id="sub" name="sub" value="">
               </form>
            </div>
         </div>
      </div>



      <div class="body">
         <div>
            <pre>                                                                                                                           <b>HOME ><font
                  color="#C90000"> ???????????????</font></b>
            </pre>
         </div>

         <div id="boardcss_list_add_button_table">
            <input type="button" class="relist" name="relist" id="relist"
               value="<spring:message code="label.relist"/>" /> <input
               class="newPost" type="button" name="newPost" id="newPost"
               value="<spring:message code="label.insert"/>" />
         </div>
         <br>
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
                     <th>??????</th>
                     <th>??????</th>
                     <th>?????????</th>
                     <th>????????????</th>
                  </tr>
               </thead>
               <tbody id="freeboardList">

               </tbody>
            </table>
         </div>

         <center>
            <table style="width: 500px; text-align: center;">
               <tr></tr><td>&nbsp; </td>
               <tr align="center" id="pagingArea"
                     style="font-size: 15px; color: #5D5D5D;">
               </tr>
            </table>
            <br>
            <br>
            <tfoot>
               <tr>

                  <td colspan="5" align="center">
                     <form id="searchForm">
                        <input type="hidden" name="currPageNo" id="currPageNo" value="1" />
                        <input type="checkbox" name="searchCondition" value="fb_title" />
                        <spring:message code="label.title" />
                        &nbsp; <input type="checkbox" name="searchCondition"
                           value="fb_content" />
                        <spring:message code="label.content" />
                        &nbsp; <input type="checkbox" name="searchCondition"
                           value="cid" />
                        <spring:message code="label.writer" />
                        &nbsp; <input type="text" name="searchText" maxlength="20" />&nbsp;
                        <input type="button" name="searchButton"
                           value="<spring:message code="label.click"/>" />
                     </form>
                  </td>
               </tr>
            </tfoot>
      </div>
      <br>
 <div class="footer">
          <div class="section">
                        <div>
                                 <ul class="asdf">
                                 <hr>
                                    <li><a onclick="facheck('images/fa/fa1.PNG')"><font color="#4C4C4C">??????
                                          ????????????</font></a><a> | </a> </span></li>
                                    <li><a onclick="facheck('images/fa/fa2.PNG')"><font color="#4C4C4C">??????
                                          ?????? ??????</font></a><a> | </a></li>
                                    <li><a  onclick="facheck('images/fa/fa3.PNG')"><font color="#4C4C4C">??????
                                          ??????</font></a><a> | </a></li>
                                           <li><a  onclick="facheck('images/fa/fa5.PNG')"><font color="#4C4C4C">??????
                                          ??????</font></a><a> | </a></li>
                                  <li><a  onclick="facheck('images/fa/fa6.PNG')"><font color="#4C4C4C">????????????
                                          ?????? ??????</font></a><a> | </a></li>
                                    <li><a onclick="facheck('images/fa/fa7.PNG')"><font color="#4C4C4C">????????????
                                          ?????? ??????</font></a><a> | </a></li>
                                    <li><a  onclick="facheck('images/fa/fa8.PNG')"><font color="#4C4C4C">????????????
                                          ??????</font></a><a> | </a></li>
                                    <li><a  onclick="facheck('images/fa/fa9.PNG')"><font color="#4C4C4C">?????????
                                          ?????? PC??????</font></a></li>
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
               <p>Runtime6??? ????????? ?????? ???????????? ????????? ?????? ??????, ?????? ??? ????????? ????????? ????????? ??? ?????? ????????? ????????????.<br>
                 (???)Runtime6Korea | ??????:????????? | ????????????????????? 115-29-29652 ????????? ????????? ????????? 63, 102 | ?????????????????????: ?????????<br>               
                 &#169; Copyright &#169; 2023.Company name all rights reserved<br>
                  <font color="#B70037"><b>Tel:</b></font> 070) 875-8037
               </p>
               
            </div>
         </div>
      </div>
   </div>
</body>
</html>