<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YamYamPet 관리자 모드</title>
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
