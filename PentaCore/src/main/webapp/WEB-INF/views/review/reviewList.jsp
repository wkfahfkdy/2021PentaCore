<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review list</title>
</head>


<body>

<div class="home-clients"  align="center">
						
						<!-- === TITLE GROUP === -->
						<div class="title-group">
							<h2>CLIENTS</h2>
							<div class="subtitle with-square">ALIQUAM MALESUADA</div>
						</div>
						<p>
						Praesent vestibulum dapibus nibh. Etiam iaculis nunc ac metus. Ut nisl quis enim dignissim sagittis. 
						Etiam sollicitudin, ipsum eu pulvinar rutrum, tellus ipsum laoreet sapien, quis venenatis ante odio. 
						</p>
						
						<!-- === OWL CAROUSEL === -->
						<div class="home-clients-carousel owl-carousel owl-theme" id="owl-clients">
						
							
							<!-- === OWL CAROUSEL ITEM === -->
							<div class="home-clients-carousel-block">
							
								
								<!-- === client item === -->
								
								<c:forEach items="${homepageProductList }" var="vo">
								
								<div class="home-clients-carousel-item">
									<a href="#"><img src="media/clients/client1.png" alt="" /></a>
								</div>
								
								<div class="home-clients-carousel-hline"></div>
								<div class="home-clients-carousel-vline1"></div>
								<div class="home-clients-carousel-vline2"></div>
								
								</c:forEach>
								
								</div>
								
								<c:forEach items="${homepageProductList }" var="vo">
								
								<div class="home-clients-carousel-item">
									<a href="#"><img src="media/clients/client1.png" alt="" /></a>
								</div>
								
								<div class="home-clients-carousel-hline"></div>
								<div class="home-clients-carousel-vline1"></div>
								<div class="home-clients-carousel-vline2"></div>
								
								</c:forEach>
								
								</div>
								
								<c:forEach items="${homepageProductList }" var="vo">
								
								<div class="home-clients-carousel-item">
									<a href="#"><img src="media/clients/client1.png" alt="" /></a>
								</div>
								
								<div class="home-clients-carousel-hline"></div>
								<div class="home-clients-carousel-vline1"></div>
								<div class="home-clients-carousel-vline2"></div>
								
								</c:forEach>
								
								</div>
								
								<!-- 
								=== client item ===
								<div class="home-clients-carousel-item ">
									<a href="#"><img src="media/clients/client2.png" alt="" /></a>
								</div>
								=== client item ===
								<div class="home-clients-carousel-item">
									<a href="#"><img src="media/clients/client3.png" alt="" /></a>
								</div>
								=== client item ===
								<div class="home-clients-carousel-item">
									<a href="#"><img src="media/clients/client4.png" alt="" /></a>
								</div>
								=== client item ===
								<div class="home-clients-carousel-item">
									<a href="#"><img src="media/clients/client5.png" alt="" /></a>
								</div>
								=== client item ===
								<div class="home-clients-carousel-item">
									<a href="#"><img src="media/clients/client6.png" alt="" /></a>
								</div>
								
							
							=== OWL CAROUSEL ITEM ===
							<div class="home-clients-carousel-block">
								
								=== client item ===
								<div class="home-clients-carousel-item">
									<a href="#"><img src="media/clients/client1.png" alt="" /></a>
								</div>
								=== client item ===
								<div class="home-clients-carousel-item ">
									<a href="#"><img src="media/clients/client2.png" alt="" /></a>
								</div>
								=== client item ===
								<div class="home-clients-carousel-item">
									<a href="#"><img src="media/clients/client3.png" alt="" /></a>
								</div>
								=== client item ===
								<div class="home-clients-carousel-item">
									<a href="#"><img src="media/clients/client4.png" alt="" /></a>
								</div>
								=== client item ===
								<div class="home-clients-carousel-item">
									<a href="#"><img src="media/clients/client5.png" alt="" /></a>
								</div>
								=== client item ===
								<div class="home-clients-carousel-item">
									<a href="#"><img src="media/clients/client6.png" alt="" /></a>
								</div>
								<div class="home-clients-carousel-hline"></div>
								<div class="home-clients-carousel-vline1"></div>
								<div class="home-clients-carousel-vline2"></div>
							</div>
							
							=== OWL CAROUSEL ITEM ===
							<div class="home-clients-carousel-block">
								
								=== client item ===
								<div class="home-clients-carousel-item">
									<a href="#"><img src="media/clients/client1.png" alt="" /></a>
								</div>
								=== client item ===
								<div class="home-clients-carousel-item ">
									<a href="#"><img src="media/clients/client2.png" alt="" /></a>
								</div>
								=== client item ===
								<div class="home-clients-carousel-item">
									<a href="#"><img src="media/clients/client3.png" alt="" /></a>
								</div>
								=== client item ===
								<div class="home-clients-carousel-item">
									<a href="#"><img src="media/clients/client4.png" alt="" /></a>
								</div>
								=== client item ===
								<div class="home-clients-carousel-item">
									<a href="#"><img src="media/clients/client5.png" alt="" /></a>
								</div>
								=== client item ===
								<div class="home-clients-carousel-item">
									<a href="#"><img src="media/clients/client6.png" alt="" /></a>
								</div>
								<div class="home-clients-carousel-hline"></div>
								<div class="home-clients-carousel-vline1"></div>
								<div class="home-clients-carousel-vline2"></div>
							</div> -->
							
						</div>
						
						<!-- === OWL CAROUSEL BUTTONS === -->
						<div class="home-clients-buttons">
							<a id="prev-clients" href="#"><div class="my-btn my-btn-primary">
								<div class="my-btn-bg-top"></div>
								<div class="my-btn-bg-bottom"></div>
								<div class="my-btn-text">
									<i class="fa fa-angle-left"></i>
								</div>
							</div></a>
							<a id="next-clients" href="#"><div class="my-btn my-btn-grey">
								<div class="my-btn-bg-top"></div>
								<div class="my-btn-bg-bottom"></div>
								<div class="my-btn-text">
									<i class="fa fa-angle-right"></i>
								</div>
							</div></a>
						</div>
						
					</div>

</body>
</html>