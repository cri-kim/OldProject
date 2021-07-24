<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title><spring:message code="runtime6.home" /></title>
<link rel="stylesheet" href="<spring:url value="/css/style.css" />"
   type="text/css">
<jsp:include page="/WEB-INF/view/com/meta.jsp" />
<jsp:include page="/WEB-INF/view/com/favicon.jsp" />
<jsp:include page="/WEB-INF/view/com/script.jsp" />
</head>
<style>
.rightbanner {
   position: top;
   width: 90px;
   align: right;
   right: 0;
   height: 1300px;
   top: 50px;
   margin: top;
   position: relative;
   z-index: 1
}
</style>
<script type="text/javascript">
var u;
var angle=0;
var canvas1;
var ctx1;
var canvas2;
var ctx2;
var canvas3;
var ctx3;
var canvas4;
var ctx4;
var viewpic;
var a=10;
var b=0;
var Mx;
var My;
var cal = 0;
var cal1 = 0;

var tt;

var timeflow1;
var time1=0;
var flow1;
var width = 600;  // canvas width
var height = 200;  // canvas height

var line1;   // 게임스크린
var line1X =0;
var line1Y = 0;
var line1X2 = 2700;



function init() {
  canvas1 = document.getElementById('canvas1');
  ctx1 = canvas1.getContext('2d');

  canvas1.addEventListener("click", clickFunc1, false);

  
  line1 = new Image();
  line1.src = 'images/line_1.jpg';


flow1= setInterval( "drawline1()", 1);
timeflow1= setInterval( "timecheck1()", 1);


}
function clickFunc1(ev) {
   
   Mx = ev.layerX;
   cal = Mx + time1 ;
   if(cal < 300)
   {
      url = "<spring:url value="/business/itemdetail/65 "/>";
   }
   else if(cal < 600)
   {
	   url = "<spring:url value="/business/itemdetail/61 "/>";
   }
   else if(cal < 900)
   {
	   url = "<spring:url value="/business/itemdetail/64 "/>";
   }
   else if(cal < 1200)
   {
	   url = "<spring:url value="/business/itemdetail/56 "/>";
   }
   else if(cal < 1500)
   {
	   url = "<spring:url value="/business/itemdetail/62 "/>";
   }
   else if(cal < 1800)
   {
	   url = "<spring:url value="/business/itemdetail/63 "/>";
   }
   else if(cal < 2100)
   {
	   url = "<spring:url value="/business/itemdetail/49 "/>";
   }
   else if(cal < 2400)
   {
	   url = "<spring:url value="/business/itemdetail/53 "/>";
   }
   else if(cal < 2700)
   {
	   url = "<spring:url value="/business/itemdetail/45 "/>";
   }
   else if(cal < 3000)
   {
	   url = "<spring:url value="/business/itemdetail/65 "/>";
   }
   else if(cal < 3300)
   {
	   url = "<spring:url value="/business/itemdetail/61 "/>";
   }


   a=Mx+250;
   tt = setInterval( "gogo()", 10);
}

function gogo(){
      window.location.href = url;
      clearInterval(tt);
}
function drawline1() {

 ctx1.drawImage(line1,line1X,line1Y);
  ctx1.drawImage(line1,line1X2,line1Y);
  if (line1X < -2700) {
     line1X = 600;
  }

  if (line1X2 < -2700) {
     line1X2 = 600;
  }
  line1X -= 1;
  line1X2 -= 1;

}

window.onload=init;

function mouseover1()
{
clearInterval(flow1);
clearInterval(timeflow1);

}

function mouseout1()
{
flow1= setInterval( "drawline1()", 1);
timeflow1 = setInterval("timecheck1()",1);
}

function timecheck1(){
   time1++;
   if(time1 == 2700)
   time1 = 0;
   }


function facheck(fa){
   var k =window.open("",""," width=900,height=300");
   k.document.open();
   k.document.write("<html><body><img src='<spring:url value='"+fa+"' />' /><body></html>");
   k.document.close();
}



$(document).ready(function(){
      
    //var boxtop = $('.quickmenu').offset().top;

    var boxtop =50 ;



    $(window).scroll(function(){

      var newtop = Math.max(document.documentElement.scrollTop, document.body.scrollTop);

      $('.rightbanner').stop();

      $('.rightbanner').animate({"top": newtop - boxtop -500}, 100);

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

$(function() {
	   
    $.post("<spring:url value="/home/search" />",
            function(result) {
               $("#bestItem").html("");
               $(result.homeList).each(function(index, business) {
               var $ul = $("<ul style='width:100px; height:250px; text-align:center; float:left; boarder:none;'>");//
               $ul.append($("<h4>").append($("<li width:100px; height:20px; display:inline;>").append("Best")));
               $ul.append($("<h1>").append($("<li width:100px; height:100px;>").append(index*1+1)));
               $ul.append($("<h5>").append($("<li width:100px; height:20px;>").append(business.maximum*1-business.remainder*1+"명 구매")));
               $("#bestItem").append($ul);
               var $ul1 = $("<ul style='width:250px; height:250px; text-align:center; float:left;border:2px solid;border-color:#D5D5D5; border-right:none;'>");//border:none;
                $ul1.append($("<a href='<spring:url value='/business/itemdetail/"+business.item_no+"' />' id='bestImage"+index+"'><img src='file/download/"+business.item_f_no+"' style='width:250px; height:250px;' /></a>"));
               $("#bestItem").append($ul1);
               var $ul2 = $("<ul style='width:330px; height:250px;border:2px solid; border-color:#D5D5D5;border-left:none; '>");
               $ul2.append($("<li style='text-align:right';width:300px; height:40px; dispaly:inline;>").append("<font size='2px'>마감 날짜:  </font>").append("<font size='2px'>"+business.final_date+"</font>"));
               $ul2.append($("<li width:300px; height:40px; dispaly:inline;>").append("<font size='4px'; color='#750028'>"+business.item_type+"</font>"));
               $ul2.append($("<h1>").append($("<a href='<spring:url value='/business/itemdetail/"+business.item_no+"' />'style='text-decoration:none;' id='bestTitle"+index+" '><li width:300px; height:40px; dispaly:inline;>").append("<font size='6px'; color='#000093'>"+business.item_name+"</font></a><br><br><hr>")));
               $ul2.append($("<li style='text-align:right'; width:300px; height:40px; dispaly:inline; >").append("가격 ").append(business.item_charge).append("원"));
               $ul2.append($("<br>"));
               $ul2.append($("<li style='text-align:right';width:300px; height:40px; dispaly:inline; margin:3px;>").append("남은 수량 ").append(business.remainder));
               $("#bestItem").append($ul2);
               var $br = $("<br><br>");
               $("#bestItem").append($br);
               
            });
   });
   $.post("<spring:url value="/home/search2" />",
            function(result) {
            $("#newItem").html("");
             $(result.homeList2).each(function(index, business) {
             var $ul = $("<ul style='width:100px; height:250px; text-align:center; float:left; boarder:none;'>");//
             $ul.append($("<h4>").append($("<li width:100px; height:20px; display:inline;>").append("New")));
             $ul.append($("<h1>").append($("<li width:100px; height:100px;>").append(index*1+1)));
             $ul.append($("<h5>").append($("<li width:100px; height:20px;>").append(business.maximum*1-business.remainder*1+"명 구매")));
             $("#newItem").append($ul);
             var $ul1 = $("<ul style='width:250px; height:250px; text-align:center; float:left;border:2px solid;border-color:#D5D5D5; border-right:none;'>");//border:none;
              $ul1.append($("<a href='<spring:url value='/business/itemdetail/"+business.item_no+"' />' id='newImage"+index+"'><img src='file/download/"+business.item_f_no+"' style='width:250px; height:250px;' /></a>"));
             $("#newItem").append($ul1);
             var $ul2 = $("<ul style='width:330px; height:250px;border:2px solid; border-color:#D5D5D5;border-left:none; '>");
             $ul2.append($("<li style='text-align:right';width:300px; height:40px; dispaly:inline;>").append("<font size='2px'>등록 날짜:  </font>").append("<font size='2px'>"+business.final_date+"</font>"));
             $ul2.append($("<li width:300px; height:40px; dispaly:inline;>").append("<font size='4px'; color='#750028'>"+business.item_type+"</font>"));
             $ul2.append($("<h1>").append($("<a href='<spring:url value='/business/itemdetail/"+business.item_no+"' />'style='text-decoration:none;' id='newTitle"+index+" '><li width:300px; height:40px; dispaly:inline; >").append("<font size='6px'; color='#000093'>"+business.item_name+"</font></a><br><br><hr>")));
             $ul2.append($("<li style='text-align:right'; width:300px; height:40px; dispaly:inline; >").append("가격 ").append(business.item_charge).append("원"));
             $ul2.append($("<li style='text-align:right';width:300px; height:40px; dispaly:inline; margin:3px;>").append("남은 수량 ").append(business.remainder));
             $("#newItem").append($ul2);
             var $br = $("<br><br>");
             $("#newItem").append($br);
            });
      });
});
</script>
<!--관리자 아이디:000000 비밀번호:관리자  -->
<body>
   <div class="page">
      <div class="header">
         <a href="<spring:url value="/home" />" id="logo"><img
            src="<spring:url value="/img/runtime6.png" />" alt="logo"></a>
         <div>
            <div>

               <c:choose>
                  <c:when test="${userInfo != null}">
                     <c:choose>
                        <c:when test="${userInfo.email =='0' }">
                        관리자님 께서 로그인 하셨습니다.&nbsp;&nbsp;&nbsp;
                     </c:when>
                        
                     </c:choose>
                     <a id="logout"
                        href="<spring:url value="/j_spring_security_logout" />">로그아웃</a>
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
                     <a href="<spring:url value="/mypage/infor" />">회원리스트</a>
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
                  <li><c:choose>
                        <c:when test="${userInfo !=null }">
                        <a href="<spring:url value="/business/itemlist/${userInfo.username}" /> ">
                        <span>구매/등록</span></a>
                        </c:when>
                        <c:otherwise>
                     <a><span>구매/등록</span></a></c:otherwise>
                     </c:choose></li>
                  <li><c:choose>
                        <c:when test="${userInfo !=null }">
						<a href="<spring:url value="/qna/list" />">
                        <span>고객센터</span></a>
                        </c:when>
                        <c:otherwise>
                     <a><span>고객센터</span></a></c:otherwise>
                     </c:choose>
                  <li>
                  <c:choose>
                        <c:when test="${userInfo !=null }">
						<a href="<spring:url value="/freeboard/contact" />">
                        <span>자유게시판</span></a>
                        </c:when>
                        <c:otherwise>
                     <a><span>자유게시판</span></a></c:otherwise>
                     </c:choose>
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
            <table width="1100px">
               <tr>
                  <td width="950px" height="1500px">
                     <div class="featured">
                        <font size=40 color=black> <b>Today's ITEM</b></font>

                        <div class="leftside">
                           <font color="#C90000" size="4">Category</font><br>
                           <br>
                           <c:choose>
                        <c:when test="${userInfo !=null }">
                  <a href="<spring:url value="/business/totalsearch=item_type=의류"/>" >
                        <span>-의류</span></a>
                        </c:when>
                        <c:otherwise>
                     <a><span>-의류</span></a>
                     </c:otherwise>
                     </c:choose>
                     </br>
                     <c:choose>
                        <c:when test="${userInfo !=null }">
                  <a href="<spring:url value="/business/totalsearch=item_type=식품" /> ">
                        <span>-식품</span></a>
                        </c:when>
                        <c:otherwise>
                     <a><span>-식품</span></a>
                     </c:otherwise>
                     </c:choose>
                     </br>
                     <c:choose>
                        <c:when test="${userInfo !=null }">
                      <a href="<spring:url value="/business/totalsearch=item_type=뷰티" /> " >
                        <span>-뷰티</span></a>
                        </c:when>
                        <c:otherwise>
                     <a><span>-뷰티</span></a>
                     </c:otherwise>
                     </c:choose>
                           </br>
                            <c:choose>
                        <c:when test="${userInfo !=null }">
                  <a href="<spring:url value="/business/totalsearch=item_type=도서&문구" /> " >
                        <span>-도서/문고</span></a>
                        </c:when>
                        <c:otherwise>
                     <a><span>-도서/문고</span></a>
                     </c:otherwise>
                     </c:choose>
                     </br>
                         <c:choose>
                        <c:when test="${userInfo !=null }">
                  <a href="<spring:url value="/business/totalsearch=item_type=전자제품" /> " >
                        <span>-전자제품</span></a>
                        </c:when>
                        <c:otherwise>
                     <a><span>-전자제품</span></a>
                     </c:otherwise>
                     </c:choose>
                           <br>
                           <c:choose>
                        <c:when test="${userInfo !=null }">
                  <a href="<spring:url value="/business/totalsearch=item_type=생활&주방" /> " >
                        <span>-생활&주방</span></a>
                        </c:when>
                        <c:otherwise>
                     <a><span>-생활&주방</span></a>
                     </c:otherwise>
                     </c:choose>
                           <br>
                           <br>
                           <br> <font color="#C90000" size="4">Banking Info</font><br>
                           <br> 신한 110.228.123456<br>
                           <br> 홍상삼(Runtime6)<br>
                           <br>

                        </div>
                           <div>
                              <div onmouseover=mouseover1() onmouseout=mouseout1() >
                                 <canvas id="canvas1" width="600" height="200"></canvas>
                              </div>
                           </div>

                        <div>
                           <div>
                              <p></p>
                              <a href="about.html"></a>
                           </div>
                        </div>
                     </div>
                     <div id="bestItemTitle">
                        <h4>ζ Best</h4>
                     </div>
                     <div id="bestItem">
                     </div>
                     <div id="newItemTitle">
                        <h4>ζ New</h4>
                     </div>
                     <div id="newItem">
                     </div>
                     </div>
                  </td>

                  <td align="right" width="150px">
                     <div class="rightbanner">
                        <img src="img/banner1.jpg" alt=""> <img
                           src="img/banner2.jpg" alt=""> <img src="img/banner3.jpg"
                           alt="">
                     </div>
                  </td>
               </tr>
            </table>
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