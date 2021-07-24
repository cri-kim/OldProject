<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp" %>
<%-- <%@ page import="com.runtime6.web.example.model.dto.JoinParam" %> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><spring:message code="runtime6.sellinfor" /></title>
	<link rel="stylesheet" href="<spring:url value="/css/style.css" />" type="text/css">
	<jsp:include page="/WEB-INF/view/com/meta.jsp" />
	<jsp:include page="/WEB-INF/view/com/favicon.jsp" />
	<jsp:include page="/WEB-INF/view/com/script.jsp" />
<script type="text/javascript">
function facheck(fa){
	   var k =window.open("",""," width=900,height=300");
	   k.document.open();
	   k.document.write("<html><body><img src='<spring:url value='../../"+fa+"' />' /><body></html>");
	   k.document.close();
	}
$(function() {	

	search();
});

function search() {
	
$.post("<spring:url value="/mypage/selllist" />",
$("#searchForm").serialize(),
function(result) {
		console.log(result);
		$("#sellList").html("");
		 var d=new Date();
		 var today=("00" + d.getDate()).slice(-2);
$(result.sellList).each(function(index, join) {
		var $tr = $("<tr align='center' style='cursor:pointer;'>");
		var loc=(join.p_dttm).split("-");
		/* 	 if(today!=loc[2]*1+7){  */
			 $tr.append($("<td>").append("<img src=\"../../file/download/" + join.item_f_no + "\" style=\"width:100px;height:100px;\" />"));
			 $tr.append($("<td>").append(join.item_name)); 
			 $tr.append($("<td>").append(join.cid));
		     $tr.append($("<td>").append(join.item_num));
		     $tr.append($("<td>").append(
		    		 join.item_num*join.item_charge));
		     $tr.append($("<td>").append(
		             join.p_dttm));
		     $("#sellList").append($tr);
		/* 	 } */
			 
	 
	
		$tr.bind('mouseover', function() {
			$tr.css("background", "#FFEBFF");
		});
		
		$tr.bind('mouseleave', function() {
			$tr.css("background", "#f0f5ff");
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
               <center>
                  <font color="gray" size="5"><h1><c:out value="${userInfo.username}"/>님의 판매목록</h1></font>
               </center>
            </div>
            <div>
               <table align="center" style="width: 860px">
                  <thead style="font-size: 20px">
                     <tr
                        style="text-align:center; background: #484848; height: 45px; color: #ffffff; font-family: Arial, Malgun Gothic, 맑은 고딕, sans-serif;">
                        <td height='50px'></td>
                        <td><b>상품명</b></td>
                        <td><b>구매자</b></td>
                        <td><b>수량</b></td>
                        <td><b>판매금액</b></td>
                        <td><b>판매날짜</b></td>
                     </tr>

                  </thead>
                  <tbody id="sellList" >

                  </tbody>


                  <tfoot>
                     <tr>
                        <td colspan="5">
                           <form id="searchForm">
                              <input type="hidden" name="currPageNo" id="currPageNo"
                                 value="1" />
                           </form>
                        </td>
                     </tr>
                  </tfoot>
               </table>
               <br>
               <br>
               <table align="center" style="width: 500px;">
                  <tr></tr><td>&nbsp; </td>
               <tr align="center" id="pagingArea"
                     style="font-size: 15px; color: #5D5D5D;">
               </tr>
               </table>
               

              
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