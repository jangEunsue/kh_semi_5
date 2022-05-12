<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YamYamPet 관리자 모드</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function() {
		$("#user_id").keyup(function(){
			let user_id = $("#user_id").val();
			
			// 입력 길이 체크
			if($.trim($("#user_id").val()).length < 4) {
				let warningTxt = '<span style="color:pink"> ! 아이디는 4자 이상이어야 합니다</span>';
				$("#idcheck").text(''); // idcheck영역()
				$("#idcheck").show();
				$("#idcheck").append(warningTxt);
				return false;
			}else if ($.trim($("#user_id").val()).length > 16) {
				let warningTxt = '<span style="color:pink;"> ! 아이디는 16자 이하이어야 합니다</span>';
				$("#idcheck").text(''); // idcheck영역()
				$("#idcheck").show();
				$("#idcheck").append(warningTxt);
				$("#user_id").val('').focus();
				return false;
			}else {
				$("#idcheck").text('')
			}
			
		});
	});
</script>
<script type="text/javascript">
        // 회원가입 화면의 입력값들을 검사한다.
        function checkValue()
        {
            var form = document.userInfo;
        
            if(!form.user_id.value){
                alert("아이디를 입력하세요.");
                return false;
            }
            
            if(form.user_idDuplication.value != "idCheck"){
                alert("아이디 중복체크를 해주세요.");
                return false;
            }
            
            if(!form.user_pwd.value){
                alert("비밀번호를 입력하세요.");
                return false;
            }
            
            // 비밀번호와 비밀번호 확인에 입력된 값이 동일한지 확인
            if(form.user_pwd.value != form.user_pwd_check.value ){
                alert("비밀번호를 동일하게 입력하세요.");
                return false;
            }    
            
            if(!form.user_name.value){
                alert("이름을 입력하세요.");
                return false;
            }
            
            if(!form.user_birthyy.value){
                alert("년도를 입력하세요.");
                return false;
            }
            
            if(isNaN(form.user_birthyy.value)){
                alert("년도는 숫자만 입력가능합니다.");
                return false;
            }
            
            if(form.user_birthmm.value == "00"){
                alert("월을 선택하세요.");
                return false;
            }
            
            if(!form.user_birthdd.value){
                alert("날짜를 선택하세요.");
                return false;
            }
            
            if(isNaN(form.user_birthdd.value)){
                alert("날짜는 숫자만 입력가능합니다.");
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
            
            if(!form.user_addr_no.value){
                alert("주소를 입력하세요.");
                return false;
            }
        }
 
        // 아이디 입력창에 값 입력시 hidden에 idUncheck를 세팅한다.
        // 이렇게 하는 이유는 중복체크 후 다시 아이디 창이 새로운 아이디를 입력했을 때
        // 다시 중복체크를 하도록 한다.
        function inputIdChk(){
            document.userInfo.idDuplication.value ="idUncheck";
        }
        
   </script>
   <script type="text/javascript">
        var httpRequest = null;
        
        // httpRequest 객체 생성
        function getXMLHttpRequest(){
            var httpRequest = null;
        
            if(window.ActiveXObject){
                try{
                    httpRequest = new ActiveXObject("Msxml2.XMLHTTP");    
                } catch(e) {
                    try{
                        httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
                    } catch (e2) { httpRequest = null; }
                }
            }
            else if(window.XMLHttpRequest){
                httpRequest = new window.XMLHttpRequest();
            }
            return httpRequest;    
        }
        
        // 아이디 중복체크
        function idCheck(){
            var id = document.getElementById("user_id").value;
 
            if (!id) {
                alert("아이디를 입력하지 않았습니다.");
                return false;
            } 

            else
            {
                var param="id="+id
                httpRequest = getXMLHttpRequest();
                httpRequest.onreadystatechange = callback;
                httpRequest.open("POST", "pet_id_check.do", true);    
                httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); 
                httpRequest.send(param);
            }
        }
        
        function callback(){
            if(httpRequest.readyState == 4){
                // 결과값을 가져온다.
                var resultText = httpRequest.responseText;
                if(resultText != 0){
                    alert("중복된 아이디입니다.");
                    document.getElementById("idcheck").innerHTML ="다른 아이디를 입력해주세요";
                    document.getElementById("idcheck").style.visibility='visible';
                } 
                else if(resultText == 0){ 
                    document.getElementById("idcheck").innerHTML = "사용 가능한 아이디입니다.";
                	document.getElementById("idcheck").style.visibility='visible';
                }
            }
        }  
   </script>
   
</head>
<body>

    <jsp:include page="../include/admin_top.jsp"/>
    
    <div id="section" align="center">
    
            <div class="page_count_bg"> 
                <div id="page_count" class="clearfix">
                   
                </div>
            </div>  
       
            
            <!-- 본문 시작 -->
            <div id="sub_contents">
            
                <div id="login_wrap">
			        <fieldset class="j_info">
			            <legend>필수 입력 사항</legend>
			            
			            <form method="post" name="userInfo" onsubmit="return checkValue()" action="<%=request.getContextPath() %>/pet_join_ok.do">
			                <table class="login_t">
			                    <tr>
			                       	<th><i class="fa fa-user"></i></th>
			                       	<td> 
			                       		<div class="fl_w">
			                       			<input class="input_box2" name="user_id" id="user_id" onkeydown="inputIdChk()" placeholder="아이디">
			                       			<input type="button" class="input_btn" value="중복확인" onclick="idCheck()"> 
			                       		</div>
			                       		<input type="hidden" name="idDuplication" value="idUncheck" >
			                       		<p id="idcheck"></p>
			                       		 
			                       	</td>
			                    </tr>
			                    
			                    <tr>
			                       	<th><i class="fa fa-lock"></i></th>
			                       	<td> <input type="password" class="input_box" name="user_pwd" placeholder="비밀번호"> </td>
			                    </tr>
			                    <tr>
			                       	<th><i class="fa fa-lock"></i></th>
			                       	<td> <input type="password" class="input_box" name="user_pwd_check" placeholder="비밀번호 확인"> </td>
			                    </tr>
			                    <tr>
			                       	<th><i class="fa fa-user-circle"></i></th>
			                       	<td> <input class="input_box" name="user_name" placeholder="이름"> </td>
			                    </tr>
								<tr>
			                       	<th><i class="fa fa-birthday-cake"></i></th>
			                       	<td class="left">
			                       		<span class="text_lb">생년월일</span>
			                       		<select name="birthyy">
			                       			<c:set var="now" value="<%=new java.util.Date()%>" />
											<c:set var="nowYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set> 
											<c:forEach var="i" begin="1920" end="${nowYear}" step="1" >
												<option value="${nowYear - i + 1920}"> ${nowYear - i + 1920} </option>
											</c:forEach>
			                       		</select>
				                        <select name="birthmm">
				                        	<option value="00">월</option>
				                        	<%  for(int i=1; i<=9; i++){%>
				                        			<option value="0<%=i %>" > <%=i %> </option>
				                        	<%	} %>
				                        	<%  for(int i=10; i<=12; i++){%>
				                        			<option value="<%=i %>" > <%=i %> </option>
				                        	<%	} %>
				                        </select>
				                        <select name="birthdd">
				                        	<option value="00">일</option>
				                        	<%  for(int i=1; i<=9; i++){%>
				                        			<option value="0<%=i %>" > <%=i %> </option>
				                        	<%	} %>
				                        	<%  for(int i=10; i<=31; i++){%>
				                        			<option value="<%=i %>" > <%=i %> </option>
				                        	<%	} %>
				                        </select>
			                       	</td>
			                    </tr>
			                    <tr>
			                       	<th><i class="fa fa-envelope"></i></th>
			                       	<td> <input class="input_box" name="user_email" placeholder="이메일"> </td>
			                    </tr>
			                    <tr>
			                       	<th><i class="fa fa-mobile"></i></th>
			                       	<td class="left">
			                       		<input class="input_border" name="user_phone1" placeholder="연락처(010)" size="6">
			                       		-
			                       		<input class="input_border" name="user_phone2" placeholder="" size="7">
			                       		-
			                       		<input class="input_border" name="user_phone3" placeholder="" size="7">
			                       	</td>
			                    </tr>
			                    <tr>
				                    <th><i class="fa fa-map-marker"></i></th>
				                    <td class="left">
				                        <input id="sample6_postcode" placeholder="우편번호" class="input_border" name="user_addr_no">
										<input type="button" class="input_btn" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
										<input id="sample6_address" placeholder="주소" style="width:75%;" class="input_border" name="user_addr1">
										<input id="sample6_extraAddress" placeholder="참고항목" style="width:20%;" class="input_border" size="5" name="user_addr3">
										<br>
										<input id="sample6_detailAddress" placeholder="상세주소" class="input_border" name="user_addr2">
										
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
				                    </td>
				                </tr>
			                </table>
			                <div id="login_menu">
					            <input type="submit" value="동의하고 가입하기" class="login_b submit_b">
					         </div>
			            </form>
			            
			        </fieldset>			
			        
			    </div>
                    
            </div>
    
        </div>
        <br>
     <jsp:include page="../include/admin_bottom.jsp"/>
     
     <br>
     
</body>
</html>
