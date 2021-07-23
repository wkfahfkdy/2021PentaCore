/*=== "use strict" mode on ===*/
"use strict";

$(window).on('load', function () {
	
	var windowWidth = $(window).width();
	
	/*=== main slider height ===*/
	var slider_1_height = 1280;
	var slider_2_height = 1080;
	
	if(windowWidth > 640){
		slider_1_height = 1280;
		slider_2_height = 1080;
	}else{
		slider_1_height = 2000;
		slider_2_height = 1480;
	}
	
	/*=== main slider 1 intializate ===*/
	
	$('#main-slider-1').sliderPro({
		width: 2560,
		height: slider_1_height,
        fade: true,
		arrows: false,
		buttons: false,
		waitForLayers: true,
		autoplay: true,
        autoplayDelay: 8000,
        autoplayOnHover: 'pause',
		autoScaleLayers: false,
	});
    
    var mainSlider1 = $('#main-slider-1').data('sliderPro');
    
	/*=== main slider 1 nav buttons ===*/
	
    $('.main-slider-button-prev').on('click', function () {
        mainSlider1.previousSlide();
        
        return false;
    });
    
    $('.main-slider-button-next').on('click', function () {
        mainSlider1.nextSlide();
        
        return false;
    });
	
	/*=== main slider 2 intializate ===*/
	
	$('#main-slider-2').sliderPro({
		width: 2560,
		height: slider_2_height,
        fade: true,
		arrows: false,
		buttons: false,
		waitForLayers: true,
		autoplay: false,
        autoplayDelay: 8000,
        autoplayOnHover: 'pause',
		autoScaleLayers: false,
	});
	
	 var mainSlider2 = $('#main-slider-2').data('sliderPro');
    
	/*=== main slider 2 nav buttons ===*/
	
    $('.main-slider-2-button-prev').on('click', function () {
        mainSlider2.previousSlide();
        
        return false;
    });
    
    $('.main-slider-2-button-next').on('click', function () {
        mainSlider2.nextSlide();
        
        return false;
    });

	/*=== hide pre loader ===*/
    
    $('#preloader').fadeOut( "500", function() {
        $(this).remove();
    });
	
	/*=== Stellar.js parallax plugin init ====*/
	$.stellar({
		horizontalScrolling: false,
		verticalOffset: 0,
	});
    
});

/*=== WOW plugin init ====*/
new WOW().init();

(function ($) {   
    
	var windowWidth = $(window).width();
	$('#main-slider-1').height(windowWidth/2 + 'px');
	
	/*=== show main search ===*/
	
    $('#show-search').on('click', function() {
        $('#main-logo, #main-menu li, #show-search, #show-menu').fadeOut( "300", function() {
            setTimeout(function() { 
                $('#main-search-input, #close-search').fadeIn(300);
                $('#main-search').focus();
                $('#main-navbar').css('border-bottom', '1px solid');
            }, 400)	
        });
        return false;
    });
    
	/*=== close main search ===*/
	
    $('#close-search').on('click', function() {
        $('#main-navbar').css('border-bottom', 'none');
        $('#main-search-input, #close-search').fadeOut( "300", function() {
            setTimeout(function() { 
                $('#main-logo, #main-menu li, #show-search, #show-menu').fadeIn(300); 
            }, 400)	
        });
        return false;
    });
    
   /*=== service mark animate at scroll ===*/

	if($('*').is('#service-mark')) {
	
		$('#service-mark').on('scrollSpy:enter', function() {
			
			$('#service-mark').children(".service-mark-border-top").css('left', '0');
			setTimeout(function() { $('#service-mark').children(".service-mark-border-right").css('top', '0');	}, 300)			
			setTimeout(function() { $('#service-mark').children(".service-mark-border-bottom").css('right', '0'); }, 600)
			setTimeout(function() { $('#service-mark').children(".service-mark-border-left").css('bottom', '0'); }, 900)
            setTimeout(function() { $('#service-mark').addClass('service-mark'); }, 1200)
									
		});
		
		$('#service-mark').scrollSpy();
	
	}
 
     /*=== Number animation in stats section at scroll ====*/
     
    if($('*').is('#home-stats')) {
    	$('#home-stats').on('scrollSpy:enter', function() {
    		
    		$('#num1').animate({ num: 450 - 3 }, {
    				duration: 3000,
    				step: function (num){
    					this.innerHTML = (num + 3).toFixed(0)
    				}
    			});
    			$('#num2').animate({ num: 150 - 3 }, {
    				duration: 3300,
    				step: function (num){
    					this.innerHTML = (num + 3).toFixed(0)
    				}
    			});
    			$('#num3').animate({ num: 120 - 3 }, {
    				duration: 3600,
    				step: function (num){
    					this.innerHTML = (num + 3).toFixed(0)
    				}
    			});
    			$('#num4').animate({ num: 14 - 3 }, {
    				duration: 3900,
    				step: function (num){
    					this.innerHTML = (num + 3).toFixed(0)
    				}
    			});
    		
    	});
    	$('#home-stats').scrollSpy();
    }
 
    
	/*=== Play and pause video section ====*/
	var video =  document.getElementById('aboutvideo');
	
	var play_video = $('#play-video');
	var stop_video = $('#stop-video');
	
	play_video.on('click', function(){
		  video.play();
		  play_video.css('display', 'none');
		  stop_video.css('display', 'block');
		  
		  return false;
	});
	
	stop_video.on('click', function(){
		  video.pause();
		  stop_video.css('display', 'none');
		  play_video.css('display', 'block');
		  
		  return false;
	});
	
	/*=== Review carousel ====*/
	
    var owl = $("#owl-review");
		owl.owlCarousel({
		items: 1, //1 items above 1000px browser width
        itemsDesktop: [1000, 1], //1 items between 1000px and 901px
        itemsDesktopSmall: [900, 1], // betweem 900px and 601px
        itemsTablet: [600, 1], //1 items between 600 and 0
		
	});
	
	/*=== Clients carousel ====*/
	
    var owl1 = $("#owl-clients");
		owl1.owlCarousel({
		items: 1, //1 items above 1000px browser width
        itemsDesktop: [1000, 1], //1 items between 1000px and 901px
        itemsDesktopSmall: [900, 1], // betweem 900px and 601px
        itemsTablet: [600, 1], //1 items between 600 and 0
		pagination: false,
	});
 
    // Custom Navigation Events
    $('#next-clients').on('click', function(){
		owl1.trigger('owl.next');
		return false;
	});
	$('#prev-clients').on('click', function(){
		owl1.trigger('owl.prev');
	    return false;
	});
	
	
	/*=== Accordion slide menu ====*/
	
	$('#left-menu').metisMenu({
		toggle: false // disable the auto collapse. Default: true.
	});
	
	/*=== Show left slide menu ====*/
	
	$('#show-menu').on('click', function() {
		
		$("#slide-menu").css('left', '0');
		$("#black-overlay").css('display', 'block');
		$("#black-overlay").css('opacity', '1');
		
		return false;
		
	});
	
	/*=== Close left slide menu ====*/
	
	$('#close-menu, #black-overlay').on('click', function() {
		
		$("#slide-menu").css('left', '-290px');
		$("#black-overlay").css('opacity', '0');
		setTimeout(function() { 	
			$("#black-overlay").css('display', 'none');
		}, 300)
		
		return false;
		
	});
	
})(jQuery);

/*=== initializate google map ====*/

function initMap() {

	var myLatLng = {lat: 34.0522342, lng: -118.2436849};

	// Create a map object and specify the DOM element for display.
	var map = new google.maps.Map(document.getElementById('contact-map'), {
		center: myLatLng,
		scrollwheel: false,
		zoom: 15
	});
	
	var image = 'media/images/marker.png';
	
	// Create a marker and set its position.
	var marker = new google.maps.Marker({
		map: map,
		icon: image,
		position: myLatLng,
		title: 'OUR LOCATON!'
	});
	
}

/*=== Send message get quote form ====*/
function sendmail_1() {
	var fields = $('#gq-form').serialize();
	$.ajax({
		type: 'POST',
		url: 'sendmail.php',
		data: fields+'&formname=get_quote',
		success: function(data) {
			$('.send-result').html(data);
		}
	});
}

/*=== Send message contact form ====*/
function sendmail_2() {
	var fields = $('#contact-form').serialize();
	$.ajax({
		type: 'POST',
		url: 'sendmail.php',
		data: fields+'&formname=contact',
		success: function(data) {
			$('.send-result').html(data);
		}
	});
}
	