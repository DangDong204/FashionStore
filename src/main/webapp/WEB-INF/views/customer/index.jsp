<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- JSTL directive --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ashion Template">
    <meta name="keywords" content="Ashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>SWE</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap"
    rel="stylesheet">
    <!-- icon - cho slider -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    

    <!-- Css Styles -->
    <jsp:include page="/WEB-INF/views/customer/layout/css.jsp"></jsp:include>
</head>

<body>
    <!-- Page Preloder -->
    <!-- <div id="preloder">
        <div class="loader"></div>
    </div> -->

	<!-- Header -->
	<jsp:include page="/WEB-INF/views/customer/layout/header.jsp"></jsp:include>

	<!-- Slider -->
	<jsp:include page="/WEB-INF/views/customer/layout/slider.jsp"></jsp:include>


	<!-- Product Section Begin -->
	<section class="product spad">
	    <div class="container">
	        <div class="row">
	            <div class="col-lg-4 col-md-4">
	                <div class="section-title">
	                    <h4>Sản phẩm</h4>
	                </div>
	            </div>
	            <div class="col-lg-8 col-md-8">
	                <ul class="filter__controls">
	                    <li class="active" data-filter="*">All</li>
	                    <li data-filter=".women">Women’s</li>
	                    <li data-filter=".men">Men’s</li>
	                    <li data-filter=".kid">Kid’s</li>
	                    <li data-filter=".accessories">Accessories</li>
	                    <li data-filter=".cosmetic">Cosmetics</li>
	                </ul>
	            </div>
	        </div>
	        <div class="row property__gallery">
	            <c:forEach items="${products}" var="product">
			        <div class="col-lg-3 col-md-4 col-sm-6 mix">
			            <div class="product__item">
			                <div class="product__item__pic set-bg" data-setbg="${env}/${product.avatar}">
			                    <ul class="product__hover">
			                        <li>
			                            <a href="${env}/${product.avatar}" class="image-popup">
			                                <span class="arrow_expand"></span>
			                            </a>
			                        </li>
			                        <li><a href="#"><span class="icon_heart_alt"></span></a></li>
			                        <li><a href="#"><span class="icon_bag_alt"></span></a></li>
			                    </ul>
			                </div>
			                <div class="product__item__text">
			                    <h6><a href="${env}/product/${product.id}">${product.name}</a></h6>
			                    <div class="product__price">
			                        <fmt:formatNumber value="${product.price}" type="number" minFractionDigits="0" />đ
			                    </div>
			                </div>
			            </div>
			        </div>
			    </c:forEach>
	            
	            
	            
	            
	            
	            
	        </div>
	    </div>
	</section>
	<!-- Product Section End -->


	<!-- Trend Section Begin -->
	<section class="trend spad">
	    <div class="container">
	        <div class="row">
	            <div class="col-lg-4 col-md-4 col-sm-6">
	                <div class="trend__content">
	                    <div class="section-title">
	                        <h4>Hot Trend</h4>
	                    </div>
	                    <div class="trend__item">
	                        <div class="trend__item__pic">
	                            <img src="${env }/customer/img/trend/ht-1.jpg" alt="">
	                        </div>
	                        <div class="trend__item__text">
	                            <h6>Chain bucket bag</h6>
	                            <div class="rating">
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                            </div>
	                            <div class="product__price">$ 59.0</div>
	                        </div>
	                    </div>
	                    <div class="trend__item">
	                        <div class="trend__item__pic">
	                            <img src="${env }/customer/img/trend/ht-2.jpg" alt="">
	                        </div>
	                        <div class="trend__item__text">
	                            <h6>Pendant earrings</h6>
	                            <div class="rating">
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                            </div>
	                            <div class="product__price">$ 59.0</div>
	                        </div>
	                    </div>
	                    <div class="trend__item">
	                        <div class="trend__item__pic">
	                            <img src="${env }/customer/img/trend/ht-3.jpg" alt="">
	                        </div>
	                        <div class="trend__item__text">
	                            <h6>Cotton T-Shirt</h6>
	                            <div class="rating">
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                            </div>
	                            <div class="product__price">$ 59.0</div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	            <div class="col-lg-4 col-md-4 col-sm-6">
	                <div class="trend__content">
	                    <div class="section-title">
	                        <h4>Best seller</h4>
	                    </div>
	                    <div class="trend__item">
	                        <div class="trend__item__pic">
	                            <img src="${env }/customer/img/trend/bs-1.jpg" alt="">
	                        </div>
	                        <div class="trend__item__text">
	                            <h6>Cotton T-Shirt</h6>
	                            <div class="rating">
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                            </div>
	                            <div class="product__price">$ 59.0</div>
	                        </div>
	                    </div>
	                    <div class="trend__item">
	                        <div class="trend__item__pic">
	                            <img src="${env }/customer/img/trend/bs-2.jpg" alt="">
	                        </div>
	                        <div class="trend__item__text">
	                            <h6>Zip-pockets pebbled tote <br />briefcase</h6>
	                            <div class="rating">
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                            </div>
	                            <div class="product__price">$ 59.0</div>
	                        </div>
	                    </div>
	                    <div class="trend__item">
	                        <div class="trend__item__pic">
	                            <img src="${env }/customer/img/trend/bs-3.jpg" alt="">
	                        </div>
	                        <div class="trend__item__text">
	                            <h6>Round leather bag</h6>
	                            <div class="rating">
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                            </div>
	                            <div class="product__price">$ 59.0</div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	            <div class="col-lg-4 col-md-4 col-sm-6">
	                <div class="trend__content">
	                    <div class="section-title">
	                        <h4>Feature</h4>
	                    </div>
	                    <div class="trend__item">
	                        <div class="trend__item__pic">
	                            <img src="${env }/customer/img/trend/f-1.jpg" alt="">
	                        </div>
	                        <div class="trend__item__text">
	                            <h6>Bow wrap skirt</h6>
	                            <div class="rating">
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                            </div>
	                            <div class="product__price">$ 59.0</div>
	                        </div>
	                    </div>
	                    <div class="trend__item">
	                        <div class="trend__item__pic">
	                            <img src="${env }/customer/img/trend/f-2.jpg" alt="">
	                        </div>
	                        <div class="trend__item__text">
	                            <h6>Metallic earrings</h6>
	                            <div class="rating">
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                            </div>
	                            <div class="product__price">$ 59.0</div>
	                        </div>
	                    </div>
	                    <div class="trend__item">
	                        <div class="trend__item__pic">
	                            <img src="${env }/customer/img/trend/f-3.jpg" alt="">
	                        </div>
	                        <div class="trend__item__text">
	                            <h6>Flap cross-body bag</h6>
	                            <div class="rating">
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                            </div>
	                            <div class="product__price">$ 59.0</div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</section>
	<!-- Trend Section End -->


	<jsp:include page="/WEB-INF/views/customer/layout/services.jsp"></jsp:include>
	
	<!-- Footer -->
	<jsp:include page="/WEB-INF/views/customer/layout/footer.jsp"></jsp:include>
	<!-- End - Footer -->
	
	<!-- Search Begin -->
	<div class="search-model">
	    <div class="h-100 d-flex align-items-center justify-content-center">
	        <div class="search-close-switch">+</div>
	        <form class="search-model-form">
	            <input type="text" id="search-input" placeholder="Search here.....">
	        </form>
	    </div>
	</div>
	<!-- Search End -->

	<!-- JS Plugins -->
	<jsp:include page="/WEB-INF/views/customer/layout/js.jsp"></jsp:include>
	
</body>
</html>