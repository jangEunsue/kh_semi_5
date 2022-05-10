

// 홈피운용 스크립트

//------------------------------- 스틱메뉴 -----------------------------------------> 
$(document).ready(function() {
	"use strict";
  var win = $(window),
    nav = $('#navwrap_bg'),
    pos = nav.offset().top,
    sticky = function(){ 
      win.scrollTop() > pos ?
        nav.addClass('sticky')
      : nav.removeClass('sticky')
    };

win.scroll(sticky);
});


// ------------------------------- 스크롤탑 --------------------------------------- --> 

$(function() {
  $.fn.scrollToTop = function() {
    $(this).hide().removeAttr("href");
    if ($(window).scrollTop() != "0") {
      $(this).stop().fadeIn(1000);
    }
    var scrollDiv = $(this);
    $(window).scroll(function() {
      if ($(window).scrollTop() == "0") {
        $(scrollDiv).fadeOut(1000)
      } else {
        $(scrollDiv).fadeIn(1000)
      }
    });
    $(this).click(function() {
      $("html, body").animate({
        scrollTop: 0
      }, "slow")
    })
  }
});

$(function() {
  $("#scrollTop").scrollToTop();
});

// ------------------------------- 툴팁과 와우 초기화 --------------------------------------- --> 

$(function () {
	$('[data-toggle="tooltip"]').tooltip();
});

$(function () {
	var wow_ww = $(window).innerWidth();
	if (wow_ww > 922) {
		new WOW().init();	
	}
});
//------------------------------- 모바일버튼 ----------------------------------------->

$(document).ready(function(){
  
  $('.menu-icon-container').on('click', function(){
    $('.menu-icon').toggleClass('transformed');
  });

	$(".menu-icon-container").on('click', function(){
		$('#nav').slideToggle(200);
		}  );
});

// 

//------------------------------- 카피라이터 년도 ----------------------------------------->
$(document).ready(function(){
    var d = new Date();
    var n = d.getFullYear();
	$("#year").html(n);
});

//------------------------------- 블러 ----------------------------------------->


// 파일 이름: 공통스크립트 파일명: common 파일경로: {{$template}}/inc/common.js //

function bluring() {
try{
    if(event.srcElement.tagName=='A'||event.srcElement.tagName=='IMG') {
        document.body.focus();
    }
}catch( e ) { }
}
try{
document.onfocusin=bluring;
}catch( e ) { }

var rurl = location.href;
var purl = getUrl(rurl);

function getUrl(url_str)
{
    var real_url;
    if (url_str.indexOf('/') > 0)
    {
        real_url = url_str.split('/');
        real_url = real_url[0]+'//'+real_url[2]+'/'+real_url[3]+'/';
    }
    return real_url;
}

function goLocate(go_url)
{
  document.location = purl + go_url;
}




// JavaScript Document

// scrollBanner

function scrollBanner(config) {
	thistop = -($('.banner').offset().top-200);
	scrollPos = $(this).scrollTop()+thistop;

	config.bannerText.css({
		'margin-top' : -(scrollPos/3) + "px",
		'opacity' : 1-(scrollPos/300)
	});

	config.banner.css({
		'background-position': 'center ' + (-scrollPos/4) + "px"
	});

}

$(document).ready(function(){
	
	$(window).scroll(function() {

		scrollBanner({
			banner: $('.banner'),
			bannerText: $('.banner-text')
		});

	});

});