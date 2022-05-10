<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
/* FAQ */
.faq{border-bottom:0px solid #ddd;
	margin:1em 0;
	width: 70%;
	margin-right: 15%;
	}
.faq .faqHeader{position:relative;
	zoom:1}
.faq .faqHeader .showAll{position:absolute;
	bottom:0;
	border:0;
	padding:0;
	overflow:visible;
	background:none;
	cursor:pointer}
/*.faq .faqBody{margin:0;
	padding:0}*/
.faq .faqBody .article{list-style:none}
.faq .q{margin:}
.faq .q a{display:block;text-align:left;
	text-decoration: none; 
    background:url("faq1_icon_q.png") no-repeat 0 0;
    padding:0 0 0 35px;
    font-size:18px;
    color:#5e5e5e;
    font-weight:bold;
    line-height: 27px;
    cursor:pointer;
    margin: 10px 0; !important}
.faq .q a:hover, .faq .q a:active, .faq .q a:focus{}
.faq .a{background:#C9DECF  url("faq1_icon_a.png") no-repeat 40px 10px;
	padding: 10px 75px 10px 75px;
    font-size: 16px;
    color: black;
    line-height: 22px;
    border-top: 1px solid #bdbdbd;
    margin:5px 0 0 0;}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-latest.js"></script>

</head>

<body>
<jsp:include page="../inc/pet_top.jsp"/>

<div align="center">

	<h3>자주 묻는 질문</h3>
</div>
<div class="faq" align="center">
    <div class="faqHeader">
        <!--button type="button" class="showAll">답변 모두 여닫기</button-->
    </div>
    <ul class="faqBody">
        <li class="article" id="a1">
            <p class="q"><a href="#a1">배송이 얼마나 걸리나요?</a></p>
            <p class="a" align="left">평균적으로 상품 출고일로부터 2~3일 걸립니다.</p>
        </li>
        <li class="article" id="a2">
            <p class="q"><a href="#a2">제품을 교환받고 싶습니다 </a></p>
            <p class="a" align="left">교환은 배송 완료 후 7일 이내에 가능하며,<br> Q&A 또는 고객상담실(080-041-5161)로 연락주시면 교환 도와드리겠습니다.</p>
        </li>
        <li class="article" id="a3">
            <p class="q"><a href="#a3">반려동물에게 급여하는 사료양은 어떻게 알 수 있나요?</a></p>
            <p class="a" align="left">제품별로 하루 권장 급여량이 다르기 때문에, 제품 포장지 뒷면의 권장 급여량 표를 참고하시기
					바랍니다.<BR> 반려동물의 나이나 몸무게, 활동량 등에 따라 하루 권장 급여량이 안내되어 있으며, <br>이를 하루에
					2~3회에 나누어 급여하는 것을 권장합니다. <br> 급여량은 전자저울이나 계량컵을 사용하여 계량하시기
					바랍니다. 반려동물들은 급여량이 조금만 달라져도 칼로리 섭취량이 크게 변화할 수 있기 때문에, 되도록 정확하게 사료를
					계량하여 급여하는 것을 권장합니다.</p>
        </li>
        <li class="article" id="a4">
            <p class="q"><a href="#a4">반려동물이 갑자기 사료를 먹지 않습니다 </a></p>
            <p class="a" align="left">반려동물이 갑자기 사료 섭취를 거부하는 경우, 아래 사항을 확인해 보시기 바랍니다. <br><br>
					<b>1.</b>  건사료 제품의 기호성은 개봉 후에 한 달 이내가 가장 좋습니다. <br>&nbsp; 이후에는 기호성을 결정하는 제품 고유의 냄새가 소실
					되어 기호성이 감소할 수 있습니다.<br>&nbsp; 개봉한 이후에는 반드시 지퍼락을 잘 닫아 보관하시기 바랍니다.<br> <b>2.</b>
					새로운 제품으로 바꾼 경우 반려동물이 낯설게 느끼고 먹지 않으려 할 수 있습니다.<br>&nbsp; 따라서 사료를 교체하실 때에는 일주일
					정도 시간을 두고 점진적으로 새로운 사료에 익숙해질 수 있도록 <br>&nbsp; 도와주는 것이 좋습니다. <br> <b>3.</b> 반려동물의
					건강에 이상이 있을 때 식욕이 감소하기도 합니다. <br>&nbsp; 사료나 간식을 거부하는 경우, 혹시 건강에 이상이 생긴 것은 아닌지
					수의사 선생님에게 진료 및 검진을 <br>&nbsp; 받아 보시기를 권장합니다. <br> &nbsp; 제품 급여가 어려워 교환 및 환불을
					원하시는 경우 Q&A로 문의하시거나 고객상담실(080-041-5161)로 <br>&nbsp; 연락해 주시기 바랍니다.</p>
        </li>
        <li class="article" id="a5">
            <p class="q"><a href="#a5">사료의 신선함은 얼마나 유지되나요? </a></p>
            <p class="a" align="left">건사료의 기호성은 개봉 후 1개월까지가 가장 좋습니다.<br> 포장지 채로 밀폐 용기에 담아 서늘하고
					건조한 곳에서 보관하는 경우, 개봉 후 2개월까지 신선도를 유지할 수도 있습니다.<br> 습식 사료는 개봉한
					후에는 포장지 채로 밀폐 용기에 담아 냉장 보관하시고, 48시간 이내에 모두 급여하는 것을 권장합니다.<br> 그릇에 덜어
					급여한 습식 사료는 한 시간 이내에 모두 섭취할 수 있도록 해 주시고, 오랜 시간 그릇에 남아 있는 사료는 변질될 우려가
					있기 때문에 재급여하지 말고 폐기하시기 바랍니다.</p>
        </li>
        <li class="article" id="a6">
            <p class="q"><a href="#a6">대용량 제품과 소용량 제품에 성분차이가 있나요? </a></p>
            <p class="a" align="left">동일한 제품은 동일한 레시피와 포뮬러로 생산됩니다. 실제로 동일한 생산 라인에서 생산되며,<br>
					포장 단계에서 각기 다른 규격의 패키지에 담겨 포장됩니다.</p>
        </li>
        <li class="article" id="a7">
            <p class="q"><a href="#a7">유통기한은 어떻게 표시되나요? </a></p>
            <p class="a" align="left">건사료는 제품 뒷면 중앙 하단에 유통기한을 일/월/년 순서로 두 자리 숫자로 표기하고
					있습니다.<br> 예를 들어 18/01/21로 표시된 경우 유통기한은 2021년 1월 18일입니다.<br>
					캔과 파우치 제품은 일(두 자리) 월(두 자리) 년(네 자리)으로 표시하며,<br> 18 01 2021로 표시된 제품의
					유통기한은 2021년 1월 18일입니다. <br> 액상 형태인 리퀴드 제품은 건사료와 마찬가지로 일/월/년
					순서로 두 자리씩 표시합니다.</p>
        </li>
    </ul>
</div>


<script>
jQuery(function($){
    // Frequently Asked Question
    var article = $('.faq>.faqBody>.article');
    article.addClass('hide');
    article.find('.a').hide();
    article.eq(0).removeClass('hide');
    article.eq(0).find('.a').show();
    $('.faq>.faqBody>.article>.q>a').click(function(){
        var myArticle = $(this).parents('.article:first');
        if(myArticle.hasClass('hide')){
            article.addClass('hide').removeClass('show');
            article.find('.a').slideUp(100);
            myArticle.removeClass('hide').addClass('show');
            myArticle.find('.a').slideDown(100);
        } else {
            myArticle.removeClass('show').addClass('hide');
            myArticle.find('.a').slideUp(100);
        }
        return false;
    });
    $('.faq>.faqHeader>.showAll').click(function(){
        var hidden = $('.faq>.faqBody>.article.hide').length;
        if(hidden > 0){
            article.removeClass('hide').addClass('show');
            article.find('.a').slideDown(100);
        } else {
            article.removeClass('show').addClass('hide');
            article.find('.a').slideUp(100);
        }
    });
});
</script>

<jsp:include page="../inc/pet_bottom.jsp"/>
</body>
</html>
					
					
					
