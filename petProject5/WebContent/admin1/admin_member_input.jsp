<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<<<<<<< HEAD
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
=======
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
>>>>>>> b1e99634e43de79f9936b39c9781e52fd7d99698
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YamYamPet 관리자 모드</title>
<<<<<<< HEAD
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
     <jsp:include page="../include/admin_bottom.jsp"/>
     
</body>
</html>
=======
<script src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
//preview image 
$(document).ready(function(){
   var fileTarget = $('.filebox .upload-hidden');

    fileTarget.on('change', function(){
        if(window.FileReader){
            // 파일명 추출
            var filename = $(this)[0].files[0].name;
        } 

        else {
            // Old IE 파일명 추출
            var filename = $(this).val().split('/').pop().split('\\').pop();
        };

        $(this).siblings('.upload-name').val(filename);
    });

    //preview image 
    var imgTarget = $('.preview-image .upload-hidden');

    imgTarget.on('change', function(){
        var parent = $(this).parent();
        parent.children('.upload-display').remove();

        if(window.FileReader){
            //image 파일만
            if (!$(this)[0].files[0].type.match(/image\//)) return;
            
            var reader = new FileReader();
            reader.onload = function(e){
                var src = e.target.result;
                parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img src="'+src+'" class="upload-thumb"></div></div>');
            }
            reader.readAsDataURL($(this)[0].files[0]);
        }

        else {
            $(this)[0].select();
            $(this)[0].blur();
            var imgSrc = document.selection.createRange().text;
            parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img class="upload-thumb"></div></div>');

            var img = $(this).siblings('.upload-display').find('img');
            img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")";        
        }
    });
});
</script>
<style type="text/css">

	th {
		padding: 8px;
	}
	
	#ptitle {
		text-align: left;
		margin-left: 20%;
		line-height: 10%;
		border-style: solid; 
		border-width: 0 0 0 8px; 
		padding: 12px; 
		word-break: break-all;
		border-color: #F1BCAE;
	}

	.pinputbtn {
		background-color: #F1BCAE;
		color: white;
		font-size: 15px;
		margin: 10px 20px 15px 0px;
		padding: 5px 10px 5px 10px;
	}
	
	.pinputtable {
		border: 1px solid #dddddd;  
		font-size: 15px;
	}
	
	.pinputsrc {
		border: 1px solid #dddddd;
		padding-left: 3px;
	}
	
	#pinputcont {
		margin-top: 7px;
		margin-bottom: 7px;
	}
	
	.filebox input[type="file"] {
		position: absolute;
		width: 1px;
		height: 1px;
		padding: 0;
		margin: -1px;
		overflow: hidden;
		clip:rect(0,0,0,0);
		border: 0;
	}
	
	.filebox label {
		display: inline-block;
		padding: .2em .75em;
		color: #999;
		font-size: inherit;
		height: 30px;
		vertical-align: middle;
		background-color: #fdfdfd;
		cursor: pointer;
		border: 1px solid #ebebeb;
		border-bottom-color: #e2e2e2;
		border-radius: .25em;
	}
	
	/* named upload */
	.filebox .upload-name {
		display: inline-block;
		padding: .5em .75em;
		font-size: inherit;
		font-family: inherit;
		height: 30px;
		vertical-align: middle;
		background-color: #f5f5f5;
		border: 1px solid #ebebeb;
		border-bottom-color: #e2e2e2;
		border-radius: .25em;
		-webkit-appearance: none; /* 네이티브 외형 감추기 */
		-moz-appearance: none;
		appearance: none;
	}
	
	/* imaged preview */
	.filebox .upload-display {
		margin-bottom: 5px;
	}
	
	@media(min-width: 768px) {
	  .filebox .upload-display {
		display: inline-block;
		margin-right: 5px;
		margin-bottom: 0;
	  }
	}
	
	.filebox .upload-thumb-wrap {
		display: inline-block;
		width: 54px;
		padding: 2px;
		vertical-align: middle;
		border: 1px solid #ddd;
		border-radius: 5px;
		background-color: #fff;
	}
	
	.filebox .upload-display img {
		display: block;
		max-width: 100%;
		width: 100% \10;
		height: auto;
	}
	
	.filebox.bs3-primary label {
		color: #fff;
		background-color: #C9DECF;
		border-color: #C9DECF;
	}

	
</style>
</head>
<body>

	
	<jsp:include page="../include/admin_top.jsp"/>


	<div align="center">
		<c:set var="productList" value="${ProductCategory }" />
		<c:set var="kindList" value="${KindCategory }" />
		<h5 id="ptitle">상품등록</h5>
		<br>
		
		<form method="post" enctype="multipart/form-data"
			action="<%=request.getContextPath() %>/admin_product_input_ok.do">
			
			<table cellspacing="0" width="45%" class="pinputtable">
				<tr class="pinputtr">
					<th>상품분류</th>
					<td>
						<select name="product_category" class="pinputsrc">
							<c:if test="${empty productList }">
								<option value="">:::카테고리 코드 없음:::</option>
							</c:if>
						
							<c:if test="${!empty productList }">
								<c:forEach items="${productList }" var="dto">
									<option value="${dto.getCategory_code() }">
										${dto.getCategory_name() } [${dto.getCategory_code() }]
									</option>
								</c:forEach>
							</c:if>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>상품명</th>
					<td><input name="p_name"  class="pinputsrc"></td>
				</tr>
				
				<tr class="filebox bs3-primary preview-image">
					<th>상품 이미지&nbsp;</th>
					<td>
					    <input class="upload-name" value="파일선택" disabled="disabled" style="width: 200px;" > &nbsp;
						<label for="input-file">업로드</label> 
						<input type="file" id="input-file" class="upload-hidden" name="p_image"> 
				    </td>
				</tr>

				
				<tr>
					<th>상품 가격</th>
					<td> <input name="p_price" maxlength="10" class="pinputsrc"></td>
				</tr>
				
				<tr>
					<th>상품 마일리지</th>
					<td><input name="p_point" class="pinputsrc"></td>
				</tr>	
				
				<tr>
					<th>재고 수량</th>
					<td>
						<input type="number" name="p_qty" class="pinputsrc"
							min="1" max="99999" value="1">
					</td>
				</tr>
				
				<%-- '습식','건식' --%>
				<tr>
					<th>습건식 여부</th>
					<td>
						<select name="p_wetdry" class="pinputsrc">
							<option value="전체">전체</option>							
							<option value="습식">습식</option>							
							<option value="건식">건식</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>반려동물 품종</th>
					<td>
						<select name="kind_category" class="pinputsrc">
							<c:if test="${empty kindList }">
								<option value="">:::카테고리 코드 없음:::</option>
							</c:if>
						
							<c:if test="${!empty kindList }">
								<c:forEach items="${kindList }" var="dto">
									<option value="${dto.getCategory_code() }">
										${dto.getCategory_name() } [${dto.getCategory_code() }]
									</option>
								</c:forEach>
							</c:if>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>반려동물 나이</th>
					<td>
						<select name="p_age" class="pinputsrc">
							<option value="전연령">전체</option>
							<option value="퍼피">퍼피</option>
							<option value="어덜트">어덜트</option>
							<option value="시니어">시니어</option>
						</select>
					</td>
				</tr>
				
				<%-- '초소형','소형','중형','대형','초대형' --%>
				<tr>
					<th>반려동물 크기</th>
					<td>
						<select name="p_size" class="pinputsrc">
							<option value="전체">전체</option>
							<option value="초소형">초소형</option>
							<option value="소형">소형</option>
							<option value="중형">중형</option>
							<option value="대형">대형</option>
							<option value="초대형">초대형</option>
						</select>
					</td>
				</tr>
				
				<%-- 'O','X' --%>
				<tr>
					<th>반려동물 중성화 여부</th>
					<td>
						<select name="p_neutering" class="pinputsrc">
							<option value="전체">전체</option>
							<option value="true">중성화 O</option>
							<option value="false">중성화 X</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>상품 소개</th>
					<td>
						<textarea rows="6" cols="50" name="p_content" id="pinputcont" class="pinputsrc"></textarea>
					</td>
				</tr>
						
				<tr>
					<th>제조사</th>
					<td><input name="p_company" class="pinputsrc"></td>
				</tr>
				
				<tr>
					<th>게시 종류</th>
					<td>
						<select name="p_spec" class="pinputsrc">
							<option value="none" >일반</option>
							<option value="hit" >인기</option>
							<option value="new" >최신</option>
							<option value="recommend" >추천</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="상품등록" class="pinputbtn">&nbsp;&nbsp;&nbsp;
						<input type="button" value="취 소" class="pinputbtn"
								onclick="history.back()">
					</td>				
				</tr>
			
			</table>
		</form>
		
	</div>
	<br>
	<jsp:include page="../include/admin_bottom.jsp"/>

</body>
</html>
>>>>>>> b1e99634e43de79f9936b39c9781e52fd7d99698
