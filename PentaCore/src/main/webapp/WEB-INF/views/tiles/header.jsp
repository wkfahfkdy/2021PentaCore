<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
						<li>
							<a href="#">셀프견적</a>
						</li> 
						<li class="main-menu-separator"></li>
						<!-- === top menu item === -->
						<li class="dropdown">
							<a data-toggle="dropdown" href="#">마이스토리지 안내</a>
						</li> 
						<li class="main-menu-separator"></li>
						<!-- === top menu item === -->
						<li class="dropdown">
							<a data-toggle="dropdown" href="#">고객센터</a>
							<ul class="dropdown-menu" role="menu">
								<li>
									<a href="#">이용후기</a>
								</li>
								<li>
									<a href="#">1:1문의</a>
								</li>
								<li>
									<a href="#">FAQ</a>
								</li>
								<li>
									<!-- API 테스트 용 -->
									<a href="calendarTest.do">CalendarTest</a>
								</li>
							</ul>
						</li> 
						<li class="main-menu-separator"></li>
						<!-- === top menu item === -->
						<li >
							<a class="latest" href="#">LOGIN</a>
						</li>
					</ul>
				</div>

			</div>`
		</div>
	</div>
	 
	 <!-- =========================
		END TOP MAIN NAVBAR
	============================== -->
	
		
	<!-- =========================
	   SLIDE MENU
	============================== -->
	<aside id="slide-menu" class="slide-menu">
		
		<!-- === CLOSE MENU BUTON === -->	
		<div class="close-menu" id="close-menu">
			<i class="fa fa-close"></i>
		</div>
		
		<!-- === SLIDE MENU === -->	
		<ul id="left-menu" class="left-menu">
			
			<!-- === SLIDE MENU ITEM === -->	
			<li> 
				<a href="#">Home <i class="fa fa-plus arrow"></i></a>
				
				<!-- === slide menu child === -->	
				<ul class="slide-menu-child">
					<li><a href="index.html">Home 1</a></li>
					<li><a href="02_home.html">Home 2</a></li>
				</ul>
			</li>
			
			<!-- === SLIDE MENU ITEM === -->	
			<li> 
				<a href="#">Service <i class="fa fa-plus arrow"></i></a>
				
				<!-- === slide menu child === -->	
				<ul class="slide-menu-child">
					<li><a href="03_services.html">Service 1</a></li>
					<li><a href="04_services.html">Service 2</a></li>
					<li><a href="05_service_detail.html">Service Details</a></li>
				</ul>
			</li>
			
			<!-- === SLIDE MENU ITEM === -->	
			<li> 
				<a href="06_about.html">About us</a>
			</li>
			
			<!-- === SLIDE MENU ITEM === -->	
			<li> 
				<a href="#">Elements <i class="fa fa-plus arrow"></i></a>
				
				<!-- === slide menu child === -->	
				<ul class="slide-menu-child">
					<li><a href="07_typography.html">Typography</a></li>
					<li><a href="08_buttons.html">Buttons</a></li>
					<li><a href="09_progress.html">Progress Bars</a></li>
					<li><a href="10_alerts.html">Alerts</a></li>
				</ul>
			</li>
			
			<!-- === SLIDE MENU ITEM === -->	
			<li>
				<a href="#">Blog <i class="fa fa-plus arrow"></i></a>
				
				<!-- === slide menu child === -->	
				<ul class="slide-menu-child">
					<li><a href="11_blog.html">Blog items</a></li>
					<li><a href="12_blog_detail.html">Single Post</a></li>
				</ul>
			</li>
			
			<!-- === SLIDE MENU ITEM === -->	
			<li>
				<a href="13_contacts.html">Contacts</a>
			</li>
			
		</ul>
		
	</aside>
	<!-- =========================
	   END SLIDE MENU
	============================== -->

	
	<!-- =========================
	   BLACK OVERLAY
	============================== -->
	<div class="black-overlay" id="black-overlay"></div>
	<!-- =========================
	   END BLACK OVERLAY
	============================== -->
