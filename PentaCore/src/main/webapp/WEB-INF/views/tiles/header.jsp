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
				 
				<div class="logo" id="main-logo" style="cursor: pointer;`">
					<div class="logo-image" >
						<img src="resources/img/logo.png" alt="" 
							onclick="location.href='${pageContext.request.contextPath }/home'" />
					</div>
					<div class="logo-text" onclick="location.href='${pageContext.request.contextPath }/home'">
						<!-- MY <span class="color-primary">STORAGE</span> -->
						<span id="logo">MY</span>&nbsp;<span id="logo2">STORAGE</span>
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
						<c:if test="${loginId != 'admin' || loginId eq null }">					
						<!-- === top menu item === -->
						<li>
							<a onclick="LoginCheckToSelfOffer('${loginId }')" style="cursor: pointer;">????????????</a>
						</li> 
						<li class="main-menu-separator"></li>
						<!-- === top menu item === -->
						<li class="dropdown">
							<a data-toggle="dropdown" href="myPageInfo">?????????????????? ??????</a>
							<ul class="dropdown-menu" role="menu">
								<li>
									<a href="companyIntro">????????????</a>
								</li>
								<li>
									<a href="useForm">????????????</a>
								</li>
								<li>
									<a onclick="storeTour('${loginId }')">????????????????????????</a>
								</li>
								<li>
									<a href="keep">??????????????????</a>
								</li>
							</ul>
						</li> 
						<li class="main-menu-separator"></li>
						<!-- === top menu item === -->
						<li class="dropdown">
							<a data-toggle="dropdown" href="#">????????????</a>
							<ul class="dropdown-menu" role="menu">
								<li>
									<a href="reviewList">????????????</a>
								</li>
								<li>
									<a href="iqPaging">???????????????</a>
								</li>
								<li>
									<a href="faqList">FAQ</a>
								</li>
							</ul>
						</li> 
						<li class="main-menu-separator"></li>
						</c:if>
						
						<!-- LOGIN ???????????? -->
						<sec:authorize access="isAnonymous()"> 
							<li >
								<a class="latest" href="memberLoginForm">LOGIN</a>
							</li>
						</sec:authorize>
						
						<!-- LOGIN ????????? -->
						<sec:authorize access="isAuthenticated()">
						<c:if test="${loginId != 'admin' }">
						<li>
							<a href="myPageInfo">MYPAGE</a>
						</li>
						</c:if>
						
						<!-- ADMIN LOGIN -->
						<sec:authorize access="hasRole('ROLE_ADMIN')">
						<li class="dropdown">
							<a data-toggle="dropdown" href="myPageInfo">ADMIN</a>
							<ul class="dropdown-menu" role="menu">
									<li>
										<a href="iqAdmin">???????????????</a>
									</li>
									<li>
										<a href="goStoreSelect">????????????</a>
									</li>
									<li>
										<a href="goTrans">????????????</a>
									</li>
							</ul>
						</li>
							
						</sec:authorize>
							<li class="main-menu-separator"></li>
							
							
						<li >
								<sec:authorize access="isAuthenticated()">
								
									<form id="logout" action="logout" method="post">
										<button style="margin:17px 30px;"><a style="color: #478FEB"><b>LOGOUT</b></a></button>
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
				alert("????????? ??? ??????????????????.");
				location.href = "memberLoginForm";
			}else {
				location.href = "selfOffer";
			}
		}
		
		function storeTour(member_id){
			if(member_id == ""){
				alert("????????? ??? ??????????????????.");
				location.href = "memberLoginForm";
			}else {
				location.href = "storeTour";
			}
		}
		
	</script>