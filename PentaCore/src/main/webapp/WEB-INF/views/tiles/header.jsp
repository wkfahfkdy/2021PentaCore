<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- =========================
     PRE LOADER       
	============================== -->
	
    <div class="preloader" id="preloader">
        <div class="cssload-container">
        	<div class="cssload-whirlpool"></div>
        </div>
    </div>
	
	<!-- =========================
     END PRE LOADER       
	============================== -->
	
	
	<!-- =========================
		TOP BAR
	============================== -->
	<div class="top-bar">
		<div class="container">
				
				<!-- === TOP BAR SOCIAL ICONS === -->
				
				<div class="top-bar-social">
					<a href="#"><div class="my-btn my-btn-primary">
						<div class="my-btn-bg-top"></div>
						<div class="my-btn-bg-bottom"></div>
						<div class="my-btn-text">
							<i class="fa fa-twitter"></i>
						</div>
					</div></a>
					<a href="#"><div class="my-btn my-btn-primary">
						<div class="my-btn-bg-top"></div>
						<div class="my-btn-bg-bottom"></div>
						<div class="my-btn-text">
							<i class="fa fa-facebook"></i>
						</div>
					</div></a>
					<a href="#"><div class="my-btn my-btn-primary">
						<div class="my-btn-bg-top"></div>
						<div class="my-btn-bg-bottom"></div>
						<div class="my-btn-text">
							<i class="fa fa-google-plus"></i>
						</div>
					</div></a>
					<a href="#"><div class="my-btn my-btn-primary">
						<div class="my-btn-bg-top"></div>
						<div class="my-btn-bg-bottom"></div>
						<div class="my-btn-text">
							<i class="fa fa-pinterest-p"></i>
						</div>
					</div></a>
					<a href="#"><div class="my-btn my-btn-primary">
						<div class="my-btn-bg-top"></div>
						<div class="my-btn-bg-bottom"></div>
						<div class="my-btn-text">
							<i class="fa fa-instagram"></i>
						</div>
					</div></a>
				</div>
				
				<!-- === TOP BAR PHONE === -->
				
				<div class="top-bar-phone">
					<div class="top-bar-phone-icon">
						<i class="fa fa-phone"></i>
					</div>
					+900 123 45 67
				</div>
				
				<!-- === TOP BAR E-MAIL === -->
				
				<div class="top-bar-mail">
					<div class="top-bar-mail-icon">
						<i class="fa fa-envelope"></i>
					</div>
					info@domain.com
				</div>
			
		</div>
	</div>	
	<!-- =========================
		END TOP BAR
	============================== -->
	
	<!-- =========================
		TOP MAIN NAVBAR
	============================== -->
	<div class="main-navbar main-navbar-2">
		<div class="container">
			<div class="row">
                 
				<!-- === TOP LOGO === -->
				 
				<div class="logo" id="main-logo">
					<div class="logo-image">
						<img src="resources/img/logo_dark.png" alt="" />
					</div>
					<div class="logo-text">
						Trans <span class="color-primary">Aero</span>
					</div>
				</div>
				 
				<!-- === TOP SEARCH === -->
				 
				<div class="main-search-input" id="main-search-input">
					<form>
						<input type="text" id="main-search" name="main-search" placeholder="Try and type enter..." />
					</form>
				</div>
				 
				<div class="search-control">
					<!-- === top search button show === -->
					<a id="show-search" class="show-search latest" href="#">
						<div class="my-btn my-btn-grey">
                            <div class="my-btn-bg-top"></div>
                            <div class="my-btn-bg-bottom"></div>
                            <div class="my-btn-text">
                                <i class="fa fa-search"></i>
                            </div>
						</div>
					</a>
					<!-- === top search button close === -->
					<a id="close-search" class="close-search latest" href="#">
						<div class="my-btn my-btn-grey">
							<div class="my-btn-bg-top"></div>
							<div class="my-btn-bg-bottom"></div>
							<div class="my-btn-text">
								<i class="fa fa-close"></i>
							</div>
						</div>
					</a>
				</div>
				
				<div class="show-menu-control">
					<!-- === top search button show === -->
					<a id="show-menu" class="show-menu" href="#">
						<div class="my-btn my-btn-primary">
                            <div class="my-btn-bg-top"></div>
                            <div class="my-btn-bg-bottom"></div>
                            <div class="my-btn-text">
                                <i class="fa fa-bars"></i>
                            </div>
						</div>
					</a>
				</div>
				  
				<!-- === TOP MENU === -->
								 
				<div class="collapse navbar-collapse main-menu main-menu-2" id="main-menu">
					<ul class="nav navbar-nav">
											
						<!-- === top menu item === -->
						<li class="active dropdown">
							<a data-toggle="dropdown" href="#">Home</a>
							<ul class="dropdown-menu" role="menu">
								<li>
									<a href=#>Home 1</a>
								</li>
								<li class="active">
									<a href="#">Home 2</a>
								</li>
							</ul>
						</li>
						<li class="main-menu-separator"></li>
						<!-- === top menu item === -->
						<li class="dropdown">
							<a data-toggle="dropdown" href="#">Service</a>
							<ul class="dropdown-menu" role="menu">
								<li>
									<a href="#">Service 1</a>
								</li>
								<li>
									<a href="#">Service 2</a>
								</li>
								<li>
									<a href="#">Service Details</a>
								</li>
							</ul>
						</li>
						<li class="main-menu-separator"></li>
						<!-- === top menu item === -->
						<li>
							<a href="#">About us</a>
						</li> 
						<li class="main-menu-separator"></li>
						<!-- === top menu item === -->
						<li class="dropdown">
							<a data-toggle="dropdown" href="#">Elements</a>
							<ul class="dropdown-menu" role="menu">
								<li>
									<a href="#">Typography</a>
								</li>
								<li>
									<a href="#">Buttons</a>
								</li>
								<li>
									<a href="#">Progress Bars</a>
								</li>
								<li>
									<a href="#">Alerts</a>
								</li>
							</ul>
						</li> 
						<li class="main-menu-separator"></li>
						<!-- === top menu item === -->
						<li class="dropdown">
							<a data-toggle="dropdown" href="#">Blog</a>
							<ul class="dropdown-menu" role="menu">
								<li>
									<a href="#">Blog items</a>
								</li>
								<li>
									<a href="#">Single Post</a>
								</li>
							</ul>
						</li> 
						<li class="main-menu-separator"></li>
						<!-- === top menu item === -->
						<li >
							<a class="latest" href="#">Contacts</a>
						</li>
					</ul>
				</div>

			</div>
		</div>
	</div>
	 
	 <!-- =========================
		END TOP MAIN NAVBAR
	============================== -->
     
	 
	 <!-- =========================
		MAIN SLIDER
	============================== -->
	<div id="main-slider-2" class="main-slider main-slider-2">
		
		<!-- === SLIDER BUTTONS === -->
		
		<a class="main-slider-2-button-prev" href="#">
			<div class="my-btn my-btn-grey">
				<div class="my-btn-bg-top"></div>
				<div class="my-btn-bg-bottom"></div>
				<div class="my-btn-text">
					<i class="fa fa-angle-left"></i>
				</div>
			</div>
		</a>
		
		<a class="main-slider-2-button-next" href="#">
			<div class="my-btn my-btn-grey">
				<div class="my-btn-bg-top"></div>
				<div class="my-btn-bg-bottom"></div>
				<div class="my-btn-text">
					<i class="fa fa-angle-right"></i>
				</div>
			</div>
		</a>
		
		<div class="sp-slides">
			
			<!-- === SLIDER ITEM === -->	
			
			<div class="sp-slide">
				
				<!-- === slide overlay === -->	
				<div class="main-slider-overlay"></div>
				
				<!-- === slide image === -->	
                <img class="sp-image" src="resources/assets/slider-pro/css/images/blank.gif"
				data-src="resources/media/main-slider/1.jpg"
				data-retina="resources/media/main-slider/1.jpg" alt="" />
				
				<!-- === slide container === -->	
				<div class="container">
                    <div class="main-slider-content">
        				<h2 class="sp-layer"
                            data-position="centerCenter" data-vertical="-55"
        					data-show-transition="left" data-hide-transition="left" data-show-delay="200" data-hide-delay="200">
        					We are your reliable partner
        				</h2>
        
        				<h2 class="sp-layer color-primary"
                            data-position="centerCenter" data-vertical="10"
        					data-show-transition="left" data-hide-transition="left" data-show-delay="400" data-hide-delay="400">
        					Quality services of cargo
        				</h2>
            
                        <a class="sp-layer main-button-2" href="#"
                            data-position="centerCenter" data-vertical="280"
            				data-show-transition="left" data-hide-transition="left" data-show-delay="600" data-hide-delay="600">
							<div class="my-btn my-btn-primary">
								<div class="my-btn-bg-top"></div>
								<div class="my-btn-bg-bottom"></div>
								<div class="my-btn-text">
									GET A FREE QUOTE
								</div>
							</div>
						</a>
                         
                    </div>
                </div>
			</div>

            <!-- === SLIDER ITEM === -->	
			
			<div class="sp-slide">
				
				<!-- === slide overlay === -->	
				<div class="main-slider-overlay"></div>
				
				<!-- === slide image === -->	
                <img class="sp-image" src="resources/assets/slider-pro/css/images/blank.gif"
				data-src="resources/media/main-slider/2.jpg"
				data-retina="resources/media/main-slider/2.jpg" alt="" />
				
				<!-- === slide container === -->	
				<div class="container">
                    <div class="main-slider-content">
        				<h2 class="sp-layer"
                            data-position="centerCenter" data-vertical="-55"
        					data-show-transition="down" data-hide-transition="down" data-show-delay="600" data-hide-delay="600">
        					We are your reliable partner
        				</h2>
        
        				<h2 class="sp-layer color-primary"
                            data-position="centerCenter" data-vertical="10"
        					data-show-transition="down" data-hide-transition="down" data-show-delay="400" data-hide-delay="400">
        					Quality services of cargo
        				</h2>
            
                        <a class="sp-layer main-button-2" href="#"
                            data-position="centerCenter" data-vertical="280"
            				data-show-transition="down" data-hide-transition="down" data-show-delay="200" data-hide-delay="200">
							<div class="my-btn my-btn-primary">
								<div class="my-btn-bg-top"></div>
								<div class="my-btn-bg-bottom"></div>
								<div class="my-btn-text">
									GET A FREE QUOTE
								</div>
							</div>
						</a>
                         
                    </div>
                </div>
			</div>
   
            <!-- === SLIDER ITEM === -->	
			
			<div class="sp-slide">
				
				<!-- === slide overlay === -->	
				<div class="main-slider-overlay"></div>
				
				<!-- === slide image === -->	
                <img class="sp-image" src="resources/assets/slider-pro/css/images/blank.gif"
				data-src="resources/media/main-slider/3.jpg"
				data-retina="resources/media/main-slider/3.jpg" alt="" />
				
				<!-- === slide container === -->	
				<div class="container">
                    <div class="main-slider-content">
        				<h2 class="sp-layer"
                            data-position="centerCenter" data-vertical="-55"
        					data-show-transition="up" data-hide-transition="up" data-show-delay="200" data-hide-delay="200">
        					We are your reliable partner
        				</h2>
        
        				<h2 class="sp-layer color-primary"
                            data-position="centerCenter" data-vertical="10"
        					data-show-transition="up" data-hide-transition="up" data-show-delay="400" data-hide-delay="400">
        					Quality services of cargo
        				</h2>
            
                        <a class="sp-layer main-button-2" href="#"
                            data-position="centerCenter" data-vertical="280"
            				data-show-transition="up" data-hide-transition="up" data-show-delay="600" data-hide-delay="600">
							<div class="my-btn my-btn-primary">
								<div class="my-btn-bg-top"></div>
								<div class="my-btn-bg-bottom"></div>
								<div class="my-btn-text">
									GET A FREE QUOTE
								</div>
							</div>
						</a>
                       
                    </div>
                </div>
			</div>

		</div>
    </div>
	<!-- =========================
		END MAIN SLIDER
	============================== -->
</body>
</html>