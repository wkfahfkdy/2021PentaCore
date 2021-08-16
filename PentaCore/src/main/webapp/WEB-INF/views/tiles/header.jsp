<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
@font-face {
    font-family: 'ONE-Mobile-POP';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2105_2@1.0/ONE-Mobile-POP.woff') format('woff');
    font-weight: normal;
    font-style: normal;
    
}
#logo {font-family:'ONE-Mobile-POP';
  		color: grey;
  		font-size: 18px;}
  		
#logo2 {font-family:'ONE-Mobile-POP';
  		color: #478FEB;
  		font-size: 18px;}
</style>

<form id="logout" action="/logout" method="POST">
	<!-- <input name="${_csrf.parameterName }" type="hidden" value="${_csrf.token}" /> -->
</form>

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
						<img src="resources/img/logo.png" alt="" 
							onclick="location.href='home'" />
					</div>
					<div class="logo-text" onclick="location.href='home'">
						<!-- MY <span class="color-primary">STORAGE</span> -->
						<span id="logo">MY</span><span id="logo2">STORAGE</span>
					</div>
				</div>
				 
				<!-- === TOP SEARCH === -->
				 
				
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
							<a onclick="LoginCheckToSelfOffer('${loginId }')">셀프견적</a>
						</li> 
						<li class="main-menu-separator"></li>
						<!-- === top menu item === -->
						<li class="dropdown">
							<a data-toggle="dropdown" href="myPageInfo">마이스토리지 안내</a>
							<ul class="dropdown-menu" role="menu">
								<li>
									<a href="companyIntro">회사소개</a>
								</li>
								<li>
									<a href="useForm">이용안내</a>
								</li>
								<li>
									<a onclick="storeTour('${loginId }')">스토리지투어예약</a>
								</li>
								<li>
									<a href="keep">안심보관이사</a>
								</li>
							</ul>
						</li> 
						<li class="main-menu-separator"></li>
						<!-- === top menu item === -->
						<li class="dropdown">
							<a data-toggle="dropdown" href="#">고객센터</a>
							<ul class="dropdown-menu" role="menu">
								<li>
									<a href="reviewList">이용후기</a>
								</li>
								<li>
									<a href="iqPaging">문의게시판</a>
								</li>
								<sec:authorize access="hasRole('ROLE_ADMIN')">
									<li>
										<a href="iqAdmin">문의게시판(관리자용)</a>
									</li>
								</sec:authorize>
								<li>
									<a href="faqList">FAQ</a>
								</li>
								<li>
									<!-- API 테스트 용 -->
									<a href="calendarTest">CalendarTest</a>
								</li>
								<li>
									<!-- API 테스트 용 -->
									<a href="kakaoMapTest">KakaoMapTest</a>
								</li>
								<li>
									<!-- 투어 예제 -->
									<a href="tourTest">tourTest</a>
								</li>
								<li>
									<!-- 어드민-지점관리 이동 테스트 용 -->
									<a href="goStoreSelect">goStoreAdmin</a>
								</li>
							</ul>
						</li> 
						<li class="main-menu-separator"></li>
						
						
						<!-- LOGIN 안됐을때 -->
						<sec:authorize access="isAnonymous()"> 
							<li >
								<a class="latest" href="memberLoginForm">LOGIN</a>
							</li>
						</sec:authorize>
						
						<!-- LOGIN 했을때 -->
						<sec:authorize access="isAuthenticated()">
							<li>
								<a href="myPageInfo">MYPAGE</a>
							</li>
							
							<li class="main-menu-separator"></li>
							
							<li >
								<sec:authorize access="isAuthenticated()">
									<form id="logout" action="logout" method="post">
										<button style="margin:17px 30px;"><a>LOGOUT</a></button>
									</form>	
								</sec:authorize>
							</li>
						</sec:authorize>
						
					</ul>
				</div>

			</div>
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
	<script>
		function LoginCheckToSelfOffer(member_id){
			if(member_id == ""){
				alert("로그인 후 이용해주세요.");
				location.href = "memberLoginForm";
			}else {
				location.href = "selfOffer";
			}
		}
		
		function storeTour(member_id){
			if(member_id == ""){
				alert("로그인 후 이용해주세요.");
				location.href = "memberLoginForm";
			}else {
				location.href = "storeTour";
			}
		}
		
	</script>