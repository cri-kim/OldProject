<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp" %>  
<!DOCTYPE html>
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">   
   <title><spring:message code="runtime6.itemlist" /></title>
   <link rel="stylesheet" href="<spring:url value="/css/style.css" />" type="text/css">
   <link rel="stylesheet" href="<spring:url value="/css/view/contact_list.css" />" type="text/css">
   <jsp:include page="/WEB-INF/view/com/meta.jsp" />
   <jsp:include page="/WEB-INF/view/com/favicon.jsp" />
   <jsp:include page="/WEB-INF/view/com/script.jsp" />
<style>
   .s1 {
   BORDER-TOP: #00005D 3px solid;
   font-size: 13px;
   line-height:40px;
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
   
   if((("${join.idtr}")!="ėŽėė")){
      $("input[name=insert]").hide();
   }
   
   $("input[name=insert]").bind('click', function() {
      window.location.href = "<spring:url value="/business/itemform/insert "/>";
   });
   
   $("input[name=searchText]").attr('disabled', true);

   $("input[name=searchButton]").bind('click', function() {
      search();
   });
   
   $("input[name=searchText]").bind('keypress', function(e) {
      if(e.keyCode == 13) {
         e.preventDefault();
         search();
      }
   });
   
   $("input[id=searchCondition1]").bind('click', function() {
      $("input[id=searchCondition2]").attr('checked', true);
      $("input[id=searchCondition2]").attr('checked', false);
      $("input[id=searchCondition3]").attr('checked', false);
   });
   $("input[id=searchCondition2]").bind('click', function() {
      $("input[id=searchCondition2]").attr('checked', true);
      $("input[id=searchCondition1]").attr('checked', false);
      $("input[id=searchCondition3]").attr('checked', false);
   });
   $("input[id=searchCondition3]").bind('click', function() {
      $("input[id=searchCondition3]").attr('checked', true);
      $("input[id=searchCondition1]").attr('checked', false);
      $("input[id=searchCondition2]").attr('checked', false);
   });
   
   $(":checkbox").bind('click', function(e) {
      $("input[name=searchText]").attr('disabled', $(":checked").length == 0);
      if ($(":checked").length == 0){
         $("input[name=searchText]").val("");
      }
   }); 
   

   search();
});

function search() {

    if ($("input[name=searchText]").val().length == 0
         && $("input[value=vender_id]:checked").length == 1) {
      alert("ėėąėëĨž ėë Ĩíėļė.");
      return;
   }
    if ($("input[name=searchText]").val().length == 0
            && $("input[value=item_charge]:checked").length == 1) {
         alert("ëđėĐė ėë Ĩíėļė.");
         return;
      }
    if ($("input[name=searchText]").val().length == 0
            && $("input[value=item_type]:checked").length == 1) {
         alert("íėė ėë Ĩíėļė.");
         return;
   }
    

   $.post("<spring:url value="/business/search" />",
         $("#searchForm").serialize(),
         function(result) {
         console.log(result);
         var d=new Date();
		 var today=d.getFullYear() + "-" +("00" + (d.getMonth() + 1)).slice(-2) + "-" +("00" + d.getDate()).slice(-2);
		
         $("#businessList").html("");
            $(result.businessList).each(function(index, business) {
               var $tr = $("<tr align='center' style='cursor:pointer;'>");
               if(today != business.final_date){
               $tr.append($("<td>").append("<img src=\"../../file/download/" + business.item_f_no + "\" style=\"width:100px;height:100px;\" />"));   
               $tr.append($("<td>").append(business.item_type));
               $tr.append($("<td>").append(business.item_name));
               $tr.append($("<td>").append(business.item_charge));
               $tr.append($("<td>").append(business.vender_id));
               $tr.append($("<td>").append(business.remainder));
               $tr.append($("<td>").append(business.final_date));
               $("#businessList").append($tr);   
               }
            
             $tr.bind('click', function() {
                 if(business.remainder ==0){
                	 alert("ėŽęģ ę° ėėĩëëĪ");
                 }
                 else{
            	 window.location.href = "<spring:url value="/business/itemdetail/"/>" + business.item_no; 
                 }
               });
              
               $tr.bind('mouseover', function() {
                  $tr.css("background", "#f0f5ff");
               });
               
               $tr.bind('mouseleave', function() {
                  $tr.css("background", "#ffffff");
               }); 
            });
            var $p = result.paging;
            
            var r = $p.currPageNo * $p.pageCnt;
            var pgSet = $p.pageCnt * $p.pageRows;  //=>25
            var endPageNo = (parseInt(r / pgSet) + (r % pgSet > 0 ? 1 : 0)) * $p.pageCnt;
            
            var startPageNo = endPageNo - $p.pageCnt + 1;
            if (endPageNo > $p.lastPageNo) {
               endPageNo = $p.lastPageNo;
               startPageNo = endPageNo - (endPageNo % $p.pageCnt) + 1;
            } 
                        
            var $pagingArea = $("#pagingArea");
            $pagingArea.html("");
            $pagingArea.append($("<td>")).append("<a href='#' onclick='goPage(" + $p.firstPageNo + ")'><img src='<spring:url value='../../images/first.png'  />' /></a>");
            $pagingArea.append($("<td>")).append("<a href='#' onclick='goPage(" + $p.prevPageNo + ")'><img src='<spring:url value='../../images/prev.png'  />' /></a>");

            for (var i = startPageNo; i <= endPageNo; i++) {
               if ($p.currPageNo == i) {
                  $pagingArea.append($("<td>")).append(i);
               } else {
                  $pagingArea.append($("<td>")).append(
                        "<a href='#' onclick='goPage(" + i
                              + ")'>" + i + "</a>");
               }
            }

            $pagingArea.append($("<td>")).append("<a href='#' onclick='goPage(" + $p.nextPageNo + ")'><img src='<spring:url value='../../images/next.png'  />' /></a>");
            $pagingArea.append($("<td>")).append("<a href='#' onclick='goPage(" + $p.lastPageNo + ")'><img src='<spring:url value='../../images/last.png'  />' /></a>");

         });
      }

            
function goPage(currPageNo) {
   $("#currPageNo").val(currPageNo);
   search();
}
$(function() {
	$("input[name=sub]").bind('click', function() {
			 	if($("#searchText1").val() == "Enter search query" || $("#searchText1").val().length==0){
        			alert("ęēėę°ė ėë Ĩíėļė");
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
                        ęīëĶŽėë ęŧė ëĄę·ļėļ íėĻėĩëëĪ.&nbsp;&nbsp;&nbsp;
                     </c:when>
                  </c:choose>
               <a id="logout" href="<spring:url value="/j_spring_security_logout" />">ëĄę·ļėė</a> 
               </c:when>
               <c:otherwise>
               <a href="<spring:url value="/login" />">ëĄę·ļėļ</a> 
               </c:otherwise>
            </c:choose>
              <span>|</span>
               <c:if test="${userInfo ==null }">
                  <a href="<spring:url value="/join/index" />">íėę°ė</a>
               </c:if>
               <c:if test="${userInfo !=null }">
                  <c:out value="${userInfo.username}" />ë
               </c:if>
               <span>|</span>
				
		
				
            <c:choose>   
               <c:when test="${userInfo.email == '0'}">
               <a href="<spring:url value="/mypage/infor" />" >íėëĶŽėĪíļ</a>
               </c:when>
               <c:otherwise>

                     <a> <select onchange="window.open(value,'_self');"
                        style="color: #134067; font-size: 12px; line-height: 24px; text-decoration: none; text-shadow: 0 1px 0 #fde9c3; border-color: #FFFFFF">
                           <option selected="selected"
                              style="color: #134067; font-size: 12px; line-height: 24px; text-decoration: none; text-shadow: 0 1px 0 #fde9c3;">ë§ėīíėīė§</option>
                           <c:if test="${userInfo !=null }">
                              <option
                                 value="<spring:url value="/mypage/myinfor/${userInfo.username} " />"
                                 style="color: #134067; font-size: 12px; line-height: 24px; text-decoration: none; text-shadow: 0 1px 0 #fde9c3;">ę°ėļė ëģī</option>
                              <c:choose>
                                 <c:when test="${userInfo.idtr == 'ėŽėĐė'}">
                                    <option
                                       value="<spring:url value="/mypage/buyinfor/${userInfo.username}" />"
                                       style="color: #134067; font-size: 12px; line-height: 24px; text-decoration: none; text-shadow: 0 1px 0 #fde9c3;">ęĩŽë§ĪëŠĐëĄ</option>
                                 </c:when>
                                 <c:otherwise>
                                    <option
                                       value="<spring:url value="/mypage/sellinfor/${userInfo.username}" />"
                                       style="color: #134067; font-size: 12px; line-height: 24px; text-decoration: none; text-shadow: 0 1px 0 #fde9c3;">íë§Īė ė ëŠĐëĄ</option>
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
               	 <c:if test="${userInfo.idtr == 'ėŽėĐė'}">
                  <a href="<spring:url value="/basket/list" />">ėĨë°ęĩŽë</a></c:if>
                  <c:if test="${userInfo.idtr != 'ėŽėĐė'}">
                  <a>ėĨë°ęĩŽë</a>
                  </c:if>
                  </c:when>
               <c:otherwise>
               <a>ėĨë°ęĩŽë</a>
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
                        <span>ęĩŽë§ĪëąëĄ</span></a>
                        </c:when>
                      <c:otherwise>  
                     <a><span>ęĩŽë§Ī/ëąëĄ</span></a>
                     </c:otherwise>
                      </c:choose></li>
                
                      
                      
                  <li> <c:choose>
                        <c:when test="${userInfo !=null }">
                  <a href="<spring:url value="/qna/list" />">
                        <span>ęģ ę°ėží°</span></a>
                        </c:when>
                        <c:otherwise>
                     <a><span>ęģ ę°ėží°</span></a></c:otherwise>
                     </c:choose></li>
                     
                  <li> <c:choose>
                        <c:when test="${userInfo !=null }">
                  <a href="<spring:url value="/freeboard/contact" />">
                        <span>ėė ęēėí</span></a>
                        </c:when>
                        <c:otherwise>
                     <a><span>ėė ęēėí</span></a>
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
      
      
      
      <div class="body">
   
      <div>
   
      <table align="center" >   
      <tr>
            <pre>                                                                                                               <b>Login ><font color="#C90000"> ëąëĄëŽží ëŠĐëĄ</font></b>
                     </pre>
         </tr>
            <thead align="center" style="font-size: 15px">
            <tr align="left"><td><input type="button" id="insert" name="insert" value="ëąëĄ"/></td></tr>
            <tr
                        style="text-align:center; background: #484848; height: 45px; color: #ffffff; font-family: Arial, Malgun Gothic, ë§ė ęģ ë, sans-serif;">
               
               <td></td>
               <td width="96px">íė</td>
               <td>ėíëŠ</td>
               <td width="96px">ęļėĄ</td>
               <td>íë§Īė</td>
               <td width="96px">ëĻėę°ė</td>
               <td>ë§ę°ėž</td>
            </tr>
            </thead>
         
             
             <tbody align="center" id="businessList">

            </tbody> 
            
            <tfoot>
            <tr><td>&nbsp;</td></tr>
            <tr align="center">
            
               <td colspan="5">
                  <form id="searchForm" >
                     <input type="hidden" name="currPageNo" id="currPageNo" value="1" />
                     <input type="checkbox" name="searchCondition" id="searchCondition1" value="item_type"  />ėííė&nbsp;
                     <input type="checkbox" name="searchCondition" id="searchCondition2" value="item_charge" />ę°ęēĐ&nbsp;
                     <input type="checkbox" name="searchCondition" id="searchCondition3" value="vender_id" /><spring:message code="label.writer"/>&nbsp;
                     <input type="text" name="searchText" maxlength="20" />&nbsp;
                     <input type="button" name="searchButton" value="<spring:message code="label.click"/>" />
                  </form>
               </td>
            </tr>
            </tfoot>
         </table>   
         </div>
         <div>
         <table  align="center" style="width:500px;">
         <tr><td>&nbsp;</td></tr>
         <tr align="center" id="pagingArea"
                     style="font-size: 15px; color: #5D5D5D;"></tr>
         </table>
         </div>
         </div>
         
 <div class="footer">
          <div class="section">
                        <div>
                                 <ul class="asdf">
                                 <hr>
                                    <li><a onclick="facheck('images/fa/fa1.PNG')"><font color="#4C4C4C">íė
                                          ę°ėėëī</font></a><a> | </a> </span></li>
                                    <li><a onclick="facheck('images/fa/fa2.PNG')"><font color="#4C4C4C">ėí
                                          ėĢžëŽļ ë°Đëē</font></a><a> | </a></li>
                                    <li><a  onclick="facheck('images/fa/fa3.PNG')"><font color="#4C4C4C">ėĢžëŽļ
                                          íėļ</font></a><a> | </a></li>
                                           <li><a  onclick="facheck('images/fa/fa5.PNG')"><font color="#4C4C4C">ėĢžëŽļ
                                          ė·Ļė</font></a><a> | </a></li>
                                  <li><a  onclick="facheck('images/fa/fa6.PNG')"><font color="#4C4C4C">ęģĩëęĩŽë§Ī
                                          ėĩė ę°Ŋė</font></a><a> | </a></li>
                                    <li><a onclick="facheck('images/fa/fa7.PNG')"><font color="#4C4C4C">ę°ėļė ëģī
                                          ė·Ļęļ ë°Đëē</font></a><a> | </a></li>
                                    <li><a  onclick="facheck('images/fa/fa8.PNG')"><font color="#4C4C4C">ëđë°ëēíļ
                                          ëķėĪ</font></a><a> | </a></li>
                                    <li><a  onclick="facheck('images/fa/fa9.PNG')"><font color="#4C4C4C">ėžíëŠ°
                                          ėīėĐ PCėŽė</font></a></li>
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
               <p>Runtime6ë ėžíė ė§ė  ęīėŽíė§ ėėžëĐ° ėí ėĢžëŽļ, ë°°ėĄ ë° íëķė ėļëķė ėąėė ę° íë§Ī ėėēīė ėėĩëëĪ.<br>
                 (ėĢž)Runtime6Korea | ëí:íėėž | ėŽėėëąëĄëēíļ 115-29-29652 ėėļė ęīė§ęĩŽ íėë 63, 102 | ę°ėļė ëģīëīëđė: ëĨíė§<br>               
                 &#169; Copyright &#169; 2023.Company name all rights reserved<br>
                  <font color="#B70037"><b>Tel:</b></font> 070) 875-8037
               </p>
               
            </div>
         </div>
      </div>
   </div>
</body>
</html>