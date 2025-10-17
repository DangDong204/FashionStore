<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- directive của JSTL -->
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
    <title>SWE - Checkout</title>

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

    <!-- Breadcrumb Begin -->
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__links">
                        <a href="./index.html"><i class="fa fa-home"></i> Home</a>
                        <span>Shopping cart</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Checkout Section Begin -->
	<section class="checkout spad">
		<div class="container">
			<form action="${classpath}/checkout" method="post" class="checkout__form">
				<div class="row">
					<div class="col-lg-8">
						<h5>Thông tin giao hàng</h5>
						<div class="row">
							<div class="col-lg-12">
								<div class="checkout__form__input">
									<p>
										Họ và tên <span>*</span>
									</p>
									<input type="text" name="customerName" placeholder="Nguyễn Văn A" required>
								</div>
								<div class="checkout__form__input">
									<p>
										Address <span>*</span>
									</p>
									<input type="text" name="customerAddress" placeholder="Số 26 đường Kim Ngọc" required>
								</div>
							</div>
							<div class="col-lg-6 col-md-6 col-sm-6">
								<div class="checkout__form__input">
									<p>
										Phone <span>*</span>
									</p>
									<input type="text" name="customerPhone" placeholder="+084" required>
								</div>
							</div>
							<div class="col-lg-6 col-md-6 col-sm-6">
								<div class="checkout__form__input">
									<p>
										Email <span>*</span>
									</p>
									<input type="text" name="customerEmail" placeholder="demo@gmail.com">
								</div>
							</div>

						</div>
					</div>
					<div class="col-lg-4">
						<div class="checkout__order">
							<h5>Đơn hàng của bạn</h5>
							<div class="checkout__order__product">
								<ul>
									<li><span class="top__text">Sản phẩm</span> <span
										class="top__text__right">Thành tiền</span></li>
									<c:forEach var="cartProduct" items="${cart.cartProducts}"
										varStatus="loop">
										<li>
											<div style="display: flex; align-items: center;">
												<img src="${classpath}/${cartProduct.avatar}"
													alt="${cartProduct.name}"
													style="width: 50px; height: 50px; object-fit: cover; border-radius: 6px; margin-right: 10px;">
												<span
													style="max-width: 160px; font-size: 14px; color: #333;">
													${cartProduct.name} (x${cartProduct.quantity}) </span>
											</div> <span style="font-weight: 600; color: #000;"> <fmt:formatNumber
													value="${cartProduct.totalPrice()}" minFractionDigits="0" />
												₫
										</span>
										</li>
									</c:forEach>
								</ul>
							</div>
							<div class="checkout__order__total">
								<ul>
									<li>Tổng giá trị <span>
							            <fmt:formatNumber value="${cart.totalCartPrice()}" minFractionDigits="0"/> ₫
							        </span></li>
							        
							        <%-- Hiển thị dòng giảm giá nếu có voucher --%>
							        <c:if test="${not empty appliedVoucher}">
							            <li>Giảm giá 
							                <span style="color: #ff0000;">
							                    -<fmt:formatNumber value="${discountValue}" minFractionDigits="0"/> ₫
							                </span>
							            </li>
							        </c:if>
							        
							        <li>Tổng thanh toán <span style="font-weight: bold; font-size: 18px;">
							            <fmt:formatNumber value="${totalCartPrice}" minFractionDigits="0"/> ₫
							        </span></li>
								</ul>
							</div>

							<button type="submit" class="site-btn">Xác nhận đặt hàng</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</section>
	<!-- Checkout Section End -->

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