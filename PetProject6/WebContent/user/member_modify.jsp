<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	int birthyy = (int)request.getAttribute("birthyy");
	int birthmm = (int)request.getAttribute("birthmm");
	int birthdd = (int)request.getAttribute("birthdd");
	
	int phone1 = (int)request.getAttribute("phone1");
	int phone2 = (int)request.getAttribute("phone2");
	int phone3 = (int)request.getAttribute("phone3");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YamYam PET</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!--  -->
<script type="text/javascript">
	$(function() {
		$("#sample6_postcode").val(null);
		$("#modifyAddr").hide();
		$("#modify_addr_btn").click(function(){
			$("#modifyAddr").toggle();
			$("#originAddr").toggle();
			$("#sample6_postcode").val(null).focus();
			$("#sample6_address").val(null);
			$("#sample6_extraAddress").val(null);
			$("#sample6_detailAddress").val(null);
		});
		$("#modify_addr_cancle_btn").click(function(){
			$("#modifyAddr").toggle();
			$("#originAddr").toggle();
			$("#sample6_postcode").val(null).focus();
			$("#sample6_address").val(null);
			$("#sample6_extraAddress").val(null);
			$("#sample6_detailAddress").val(null);
		});
	});
</script>
<script type="text/javascript">
        // 회원가입 화면의 입력값들을 검사한다.
        function checkValue()
        {
            var form = document.userInfo;
            
            if(!form.user_pwd.value){
                alert("비밀번호를 입력하세요.");
                return false;
            }
            
            // 비밀번호와 비밀번호 확인에 입력된 값이 동일한지 확인
            if(form.user_pwd.value != form.user_pwd_check.value ){
                alert("비밀번호를 동일하게 입력하세요.");
                return false;
            }    
            
            
            if(!form.user_email.value){
                alert("메일 주소를 입력하세요.");
                return false;
            }
            
            if(!form.user_phone1.value){
                alert("전화번호를 입력하세요.");
                return false;
            }
            if(isNaN(form.user_phone1.value)){
                alert("숫자만 입력가능합니다.");
                return false;
            }
            
            if(!form.user_phone2.value){
                alert("전화번호를 입력하세요.");
                return false;
            }
            if(isNaN(form.user_phone2.value)){
                alert("숫자만 입력가능합니다.");
                return false;
            }
            
            if(!form.user_phone3.value){
                alert("전화번호를 입력하세요.");
                return false;
            }
            if(isNaN(form.user_phone3.value)){
                alert("숫자만 입력가능합니다.");
                return false;
            }
            
            if(!form.user_addr.value){
                alert("주소를 입력하세요.");
                return false;
            }
        }
</script>
</head>
<body>

	<jsp:include page="../inc/pet_top.jsp" />
    
    <div id="sub_wrap" class="webfont">
        <div id="aside">
            <div class="left_title">
                <p class="big_title">MEMBER</p>
                <p class="small_title">MyPage</p>
                <p class="bl_lt">▼</p>
            </div>
            <div class="mid_nav">
                <ul class="mid_menu">
                    <li><a href="<%=request.getContextPath() %>/pet_info.do?id=<%=(String)session.getAttribute("sessionID") %>" class="nav_on">
                    	<i class="fa fa-caret-right"></i>회원정보 수정</a>
                    </li>
                    <li><a href="<%=request.getContextPath() %>/selectSalesList.do">
                    	<i class="fa fa-caret-right"></i>구매내역확인</a>
                    </li>
                </ul>
            </div>
        </div>
      
      
        <div id="section">
    
            <div class="page_count_bg"> 
                <div id="page_count" class="clearfix">
                    <ul>
                        <li><i class="fa fa-home"></i> Home</li>
                        <li> <i class="fa fa-angle-right"></i> <strong>MyPage</strong></li>
                    </ul>
                </div>
            </div>
    
            <p class="sub_title">회원정보수정 <span class="sub_title2">MyPage</span></p>
            
            <!-- 본문 시작 -->
            <div id="sub_contents">
            
                <div id="login_wrap">
                	<c:set var="dto" value="${modify }"></c:set>
			        <fieldset class="j_info">
			            <legend>${dto.getM_id() } 님 정보수정</legend>
			            <form method="post" name="userInfo" onsubmit="return checkValue()"
			            	action="<%=request.getContextPath() %>/pet_modify_ok.do">
							<input type="hidden" name="user_num" value="${dto.getM_num() }">
							<input type="hidden" name="user_id" value="${dto.getM_id() }">
							
			                <table class="login_t">
			                	<tr>
			                       	<th><i class="fa fa-user-circle"></i></th>
			                       	<td> <input class="input_box" name="user_name" value="${dto.getM_name() }" readonly> </td>
			                    </tr>
			                    <tr>
			                       	<th><i class="fa fa-lock"></i></th>
			                       	<td> <input type="password" class="input_box" name="user_pwd" value="${dto.getM_pwd() }"> </td>
			                    </tr>
			                    <tr>
			                       	<th><i class="fa fa-lock"></i></th>
			                       	<td> <input type="password" class="input_box" name="user_pwd_check" placeholder="비밀번호 확인"> </td>
			                    </tr>
								<tr>
			                       	<th><i class="fa fa-birthday-cake"></i></th>
			                       	<td class="left">
			                       		<span class="text_lb">생년월일</span>
			                       		<select name="birthyy">
			                       			<c:set var="birthYear" value="<%=birthyy %>" />
			                       			<c:set var="now" value="<%=new java.util.Date()%>" />
											<c:set var="nowYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set> 
											<c:forEach var="i" begin="1920" end="${nowYear}" step="1" >
												<option value="${nowYear - i + 1920}" 
													<c:if test="${(nowYear - i + 1920) == birthYear}">
														selected
													</c:if>
												> ${nowYear - i + 1920} </option>
											</c:forEach>
			                       		</select>
				                        <select name="birthmm">
				                        	<%  for(int i=1; i<=9; i++){%>
				                        	<%		if(i == birthmm){ %>
				                        				<option selected="selected" value="<%=birthmm %>"><%=birthmm %></option>
				                        	<%		}else{ %>
				                        				<option value="0<%=i %>" > <%=i %> </option>
				                        	<%		}
				                        		} %>
				                        	<%  for(int i=10; i<=12; i++){%>
				                        			
				                        	<%		if(i == birthmm){ %>
				                        				<option selected="selected" value="<%=birthmm %>"><%=birthmm %></option>
				                        	<%		}else{ %>
				                        				<option value="<%=i %>" > <%=i %> </option>
				                        	<%		}
				                        		} %>
				                        </select>
				                        <select name="birthdd">
				                        	<%  for(int i=1; i<=9; i++){%>
				                        	<%		if(i == birthdd){ %>
				                        				<option selected="selected" value="<%=birthdd %>"><%=birthdd %></option>
				                        	<%		}else { %>
				                        				<option value="0<%=i %>" > <%=i %> </option>
				                        	<%		}
				                        		} %>
				                        	<%  for(int i=10; i<=31; i++){%>
				                        	<%		if(i == birthdd){ %>
				                        				<option selected="selected" value="<%=birthdd %>"><%=birthdd %></option>
				                        	<%		}else { %>
				                        				<option value="<%=i %>" > <%=i %> </option>
				                        	<%		}
				                        		} %>
				                        </select>
			                       	</td>
			                    </tr>
			                    <tr>
			                       	<th><i class="fa fa-envelope"></i></th>
			                       	<td> <input class="input_box" name="user_email" value="${dto.getM_email() }"> </td>
			                    </tr>
			                    <tr>
			                       	<th><i class="fa fa-mobile"></i></th>
			                       	<td class="left">
			                       		
			                       		<input class="input_border" name="user_phone1" value="010" size="6">
			                       		-
			                       		<input class="input_border" name="user_phone2" value="<%=phone2 %>" size="7">
			                       		-
			                       		<input class="input_border" name="user_phone3" value="<%=phone3 %>" size="7">
			                       	</td>
			                    </tr>
			                    <tr>
				                    <th><i class="fa fa-map-marker"></i></th>
				                    <td class="left">
				                    	<div class="" id="originAddr">
				                    		<input class="input_box" name="user_addr" value="${dto.getM_addr() }" readonly>
				                    		<div align="center">
				                    			<input type="button" class="input_btn" value="주소 변경하기" id="modify_addr_btn">
				                    		</div>	
				                    	</div>
				                    	<div class="fl_w" id="modifyAddr">
				                    		<input id="sample6_postcode" placeholder="우편번호" class="input_border" name="user_addr_no">
											<input type="button" class="input_btn" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
											<input id="sample6_address" placeholder="주소" style="width:75%;" class="input_border" name="user_addr1">
											<input id="sample6_extraAddress" placeholder="참고항목" style="width:20%;" class="input_border" size="5" name="user_addr3">
											<br>
											<input id="sample6_detailAddress" placeholder="상세주소" class="input_border" name="user_addr2">
											<input type="button" class="input_btn" id="modify_addr_cancle_btn" value="변경취소">
											
											<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
											<script>
											    function sample6_execDaumPostcode() {
											        new daum.Postcode({
											            oncomplete: function(data) {
											                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
											
											                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
											                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
											                var addr = ''; // 주소 변수
											                var extraAddr = ''; // 참고항목 변수
											
											                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
											                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
											                    addr = data.roadAddress;
											                } else { // 사용자가 지번 주소를 선택했을 경우(J)
											                    addr = data.jibunAddress;
											                }
											
											                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
											                if(data.userSelectedType === 'R'){
											                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
											                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
											                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
											                        extraAddr += data.bname;
											                    }
											                    // 건물명이 있고, 공동주택일 경우 추가한다.
											                    if(data.buildingName !== '' && data.apartment === 'Y'){
											                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
											                    }
											                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
											                    if(extraAddr !== ''){
											                        extraAddr = ' (' + extraAddr + ')';
											                    }
											                    // 조합된 참고항목을 해당 필드에 넣는다.
											                    document.getElementById("sample6_extraAddress").value = extraAddr;
											                
											                } else {
											                    document.getElementById("sample6_extraAddress").value = '';
											                }
											
											                // 우편번호와 주소 정보를 해당 필드에 넣는다.
											                document.getElementById('sample6_postcode').value = data.zonecode;
											                document.getElementById("sample6_address").value = addr;
											                // 커서를 상세주소 필드로 이동한다.
											                document.getElementById("sample6_detailAddress").focus();
											            }
											        }).open();
											    }
											</script>
				                    	</div>
				                    </td>
				                </tr>
			                </table>
			                <div id="login_menu">
					            <input type="submit" value="정보수정" class="login_b submit_b">
					            <input type="button" value="취소" class="login_b" 
					            	onclick="location.href='<%=request.getContextPath() %>/pet_info.do?id=<%=(String)session.getAttribute("sessionID") %>'">
					        </div>
			            </form>
			            
			        </fieldset>			
			        
			    </div>
                    
            </div>
    
        </div>
        <div class="clear"></div>
    </div sub_wrap>
    <jsp:include page="../inc/pet_bottom.jsp" />

</body>
</html>