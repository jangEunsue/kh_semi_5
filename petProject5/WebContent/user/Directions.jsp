<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
*{
	padding:0;
	margin:0;
	box-sizing: border-box;
}
html,
body{
	width: 100%
}
.wrap p+p{
	margin-top: 10px;
}
.block{
	position: relative;
	padding-left: 16px;
	
}
.block::after{
	content: "";
	position: absolute;
	top:0;
	left:0;
	width:5px;
	height: 100%;
	background: blue;
}
.map-wrap{
margin-left: 16px;
}
.flex{
	display: inline-flex;
	align-items: flex-start;
}
.flex-wrap{
	display: flex;
	justify-content: center;
	padding-top: 24px;
}
img{
  
margin-right: 20px; 
margin-bottom: 10px;
}
#map{
width: 500px;
height: 400px;
}
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey="></script>
</head>
<body>
 <jsp:include page="../inc/pet_top.jsp" />

	<div class="flex-wrap">
        <div class="flex">
        	<div >
           		<img src="images/cat_and_dog.jpg" id="directionimg" width="600" alt=""/>
		   	</div>      
       </div>
       
		<div class="map-wrap">  
			<div class="wrap">   	
       			<p class="block">주소 : 서울특별시 중구 남대문로 120 대일빌딩 2F, 3F</p>
       			<p class="block">대표 번호 : 02-1544-9970</p>
       		</div> 
			<div id="map"></div>
  	 	</div> 
        
    </div> 
	

	
	 <jsp:include page="../inc/pet_bottom.jsp" />
</body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=52f6bc2a72fa71e0376e284f49962f1a"></script>
<script>
	var container = document.getElementById('map');
	var options = {
		center: new kakao.maps.LatLng(37.56790401, 126.9830046),
		level: 3
	};
	var map = new kakao.maps.Map(container, options);
</script>
</html>