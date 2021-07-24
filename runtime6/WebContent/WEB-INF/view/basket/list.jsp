<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp" %>  
<!DOCTYPE html>
<!-- Website template by freewebsitetemplates.com -->

<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">   
   <title><spring:message code="runtime6.basketlist" /></title>
   <link rel="stylesheet" href="<spring:url value="/css/style.css" />" type="text/css">
   <link rel="stylesheet" href="<spring:url value="/css/view/contact_list.css" />" type="text/css">
   <jsp:include page="/WEB-INF/view/com/meta.jsp" />
   <jsp:include page="/WEB-INF/view/com/favicon.jsp" />
   <jsp:include page="/WEB-INF/view/com/script.jsp" />
</head>
<style>
 
 
 
/* #basketList{
   BORDER-TOP:#D5D5D5 1px solid;
   BORDER-BOTTOM:#D5D5D5 1px solid;
 
 
} */
 
 
 
.s1 {
   BORDER-TOP: #00005D 3px solid;
   BORDER-BOTTOM: #D5D5D5 1px solid;
   font-size: 17px;
}
.s4{
BORDER-TOP: #D5D5D5 1px solid;
BORDER-BOTTOM: #00005D 3px solid;
   font-size: 17px;
   align:right;
   padding-left:485px;
}
 
.s2 {
   BORDER-TOP: #EAEAEA 1px solid;
   font-size: 13px;
   font-size: 8pt
}
.s3 {
 
   BORDER-TOP: #5d5d5d 4px solid;
   BORDER-BOTTOM: #5d5d5d 4px solid;
 
}
 
 
</style>
<script type="text/javascript">
function facheck(fa){
      var k =window.open("",""," width=900,height=300");
      k.document.open();
      k.document.write("<html><body><img src='<spring:url value='../"+fa+"' />' /><body></html>");
      k.document.close();
   }
var itemName;
var toTal;
var inDex;
var flag=0;

$(function() {
   //등록
   $("#newPost").bind('click', function() {
      window.location.href = "<spring:url value="/basket/form/new "/>";
   });
   //로그아웃
   $("#logOut").bind('click',function(){
       window.location.href="<spring:url value="/login"  />"; 
   });
   
            var a=0;
            var b=0;
   $.post("<spring:url value="/basket/search" />",
         function(result) {
      //console.log(result);
            //결과 처리
            //기존 화면 제거
            $("#basketList").html("");
            //새로운 리스트 추가
            $(result.basketList).each(function(index, post) {
               var name;
            // id는 json에서 받아올때 name은 서버에서 서비스를 통해서 xml로 보낼때
            var $tr = $("<tr bgcolor='white'><td rowspan='4' align='center'>"
                  +"<input type='button' id='Remove' name='Remove' value='삭제' onclick='itemRemove("+post.c_no+")'></td>"
                  +"<td rowspan='4' id='item_f_no' align='center'><img src='../file/download/"
                  +post.item_f_no+"' style='width:100px; height:100px;'></td>"
                  +"<td colspan='7' rowspan='1' id='i_title' align='center'>"
                      +post.item_name+"<input type='hidden' id='item_name' name='item_name' value='"+post.item_name+"'>"+"</td>"
                      +"<td rowspan='4' id='i_sumcost' align='center'>"
                              +"<input type='text' id='sumcost-"+index+"' name='sumcost' value='' class='disableCtrl'></td>"
                              +"<tr bgcolor='white'><td colspan='5' rowspan='1' align='center'>금액<td colspan='2' rowspan='1' >"
                              +"<input type='text' id='item_charge_"+index+"' name='item_charge' value='"+post.item_charge+"' class='disableCtrl'></td>"
                              +"<tr bgcolor='white'><td colspan='5' rowspan='1' align='center'>수량<td colspan='2' rowspan='1'>"
                              +"<select name='item_num' id='selectBox-"+index+"' size='1' ><option value='1' name='option'>1</option>"
                              +"<option value='2' name='option'>2</option><option value='3' name='option'>3</option>"
                              +"<option value='4' name='option'>4</option><option value='5' name='option'>5</option></select>"
                              +"</td><tr bgcolor='white'><td colspan='5' rowspan='1' align='center'>판매자<td colspan='2' rowspan='1'>"
                              +post.vender_id+"<input type='hidden' name='vender_id' value='"+post.vender_id+"'>"
                              +"<input type='hidden' name='remainder' id='remainder-"+index+"'>"
                              +"<input type='hidden' name='item_no' value='"+post.item_no+"'>"+
                              "<input type='hidden' name='item_f_no' value='"+post.item_f_no+"'>"+"</td>");
            $("#basketList").append($tr);
            $("#sumcost-"+index).attr('value', $("#item_charge_"+index).val()*1);
            $("#item_num").attr('value',1);
            $('#remainder-'+index).attr('value', post.remainder- 1);
         
            $('#selectBox-'+index).bind('click', function(){
               if((post.remainder- $("#selectBox-"+index+" option:selected").val()) >=0 ){
               $("#sumcost-"+index).attr('value', $("#item_charge_"+index).val()*$("#selectBox-"+index+" option:selected").val());
               $("#item_num").attr('value',$("select[id|='selectBox']").val());
               $('#remainder-'+index).attr('value', post.remainder- $("#selectBox-"+index+" option:selected").val());
               
               b=0;
               for(a=0;a<$( "input[id|='sumcost']" ).length;a++){
                  b += $( "input[id|='sumcost']" )[a].value*1;
               }
               $("#total").attr('value', b);
               $("#total_charge").attr('value',$("#total").val()*1);
               toTal = $("#total").val();
               }
               else{
                  alert("재고개수가 부족합니다");
                  $("#selectBox-"+index+" option:eq(0)").attr("selected","true");
                  $("#sumcost-"+index).attr('value', $("#item_charge_"+index).val()*$("#selectBox-"+index+" option:selected").val());
                  b=0;
                   for(a=0;a<$( "input[id|='sumcost']" ).length;a++){
                      b += $( "input[id|='sumcost']" )[a].value*1;
                   }
                   $("#total").attr('value', b);
                   toTal = $("#total").val();
               }
            });
            itemName = post.item_name;

         });
            for(a=0;a<$( "input[id|='sumcost']" ).length;a++){
               b += $( "input[id|='sumcost']" )[a].value*1;
            }
            $("#total").attr('value', b);
            $("#total_charge").attr('value',$("#total").val()*1);
            toTal = $("#total").val();
            //같은속성은 클래스로 빼서 속성적용한다.
            $(".disableCtrl").attr('readonly', true);
            $(".disableCtrl").css('background-color', '#ffffff');
            
            inDex=result.basketList.length-1;
            $("#inDex").val(inDex);
   });

   
  
});
function PayMent(){
   $.ajax({
        url : '<spring:url value="/basket/updateRemainder" />',
        data : $("#paymentForm").serialize(),
        type : 'PUT',
        success : function( data, textStatus, jqXHR) {
           var code = "msg_alert_complete_general";
           if (data.updCnt == 0) {
              code = "msg_alert_error_general";
           }
        /*    alert(validation.getMessage(code, [ 'label_update' ])); */
        },
        error : function(  jqXHR,textStatus, errorThrown) {
           alert(validation.getMessage('msg_alert_error_general'));
        }
     });
      
if ($("#paymentForm").valid()){
   $.ajax({
      type: 'POST',
      url : '<spring:url value="/basket/list" />',
      data : $("#paymentForm").serialize(),
      success : function(data,textStatus,jqXHR) {
         
      /*    window.location.href = "<spring:url value="/basket/list" />"; */
      },
      error : function(jqXHR, textStatus, errorThrown) {
         alert("구매 처리가 실패되었습니다.");
      }
   });
 } 
alert("구매 처리가 완료되었습니다.");
   $.ajax({
   url:'<spring:url value="/basket/list"/>',
   type:'DELETE',
   success: function(data, textStatus, jqXHR){
      
      window.location.href = "<spring:url value="/mypage/buyinfor/${userInfo.username}" />";
   },
   error : function(jqXHR, textStatus, errorThrown){
   }
});
}
function itemRemove(c_no){
   if(confirm(validation.getMessage('msg_confirm_remove_general',['label_product']))){
      $.ajax({
         url:'<spring:url value="/basket/list/"/>'+c_no,
         type:'DELETE',
         success: function(data, textStatus, jqXHR){
            var code ="msg_alert_complete_general";
            //삭제된 결과가 0이면 이미 삭제된 글이므로 메세지를 출력하고 리스트로 보낸다.
            if(data.delCnt ==0) {
               alert(data);
               code= "msg_alert_error_general";
            }
            //삭제된 결과가 1이면 정상적으로 삭제되었으므로 메세지를 출력하고 리스트로 보낸다.
            alert("장바구니에서 상품이 삭제되였습니다.");
            
            window.location.href = "<spring:url value="/basket/list" />";
         },
         error : function(jqXHR, textStatus, errorThrown){
            alert(validation.getMessage("msg_alert_error_general"));
         }
      });
   }
};

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
var openWin = null;
function popUp(){
    var setting = "toolbar=0,directories=0,status=no,scrollbars=auto,resizable=no,height=500,width=500,left=0,top=0";
      openWin = window.open("/runtime6/pay", "pay_title", setting);
      openWin.document.getElementById('pay_title').value = itemName;
      openWin.document.getElementById('pay_total').value = toTal;
      openWin.document.getElementById('pay_inDex').value = inDex;
          }
</script>
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
                     value="Enter search query"> 
                     <input type="button" id="sub" name="sub" >
               </form>
            </div>
         </div>
      </div>

<form name="paymentForm" id="paymentForm" action="post" >
<input type="hidden" name="tmp" id="tmp" value=""/>      
      <div class="body">
         <div class="home">

            <div class="basket">
               <table width="800px" align="center" bgcolor="#EAEAEA"
                  cellpadding="5" cellspacing="1">
                  <thead>
                     <tr>
                        <td class = "s1" colspan="9" align="center"><font color="#000000"><b>상품정보</b></font></td>
                        <td class = "s1" align="center"><font color="#000000"><b>상품금액</b></font></td>
                     </tr>
                  </thead>

                  <tbody id="basketList">
                  </tbody>

                  <tfoot id="basketTotal">
                  <tr>
                  <td class = "s4" colspan="10"><b>총상품금액 : </b><input type="text" id="total" name="total_charge" value="" class='disableCtrl'></td>
                  </tr>
                  </tfoot>
               </table>
               <table align="center">
                  <tr>
                     <td><input type="button" name="payment" id="payment" value="구매" onclick="popUp()"/>
                     <input type="hidden" name="inDex" id="inDex" value=''/>
                     <input type="hidden" name="final_parents" id="final_parents" value=''/></td>
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