<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%-- JSTL directive --%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<link
	href="https://fonts.googleapis.com/css2?family=Cookie&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap"
	rel="stylesheet">
<!-- icon - cho slider -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">


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
						<a href="${env }/index"><i class="fa fa-home"></i> Home</a> <span>Contact</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Breadcrumb End -->

	<!-- Contact Section Begin -->
	<section class="contact spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-6 col-md-6">
					<div class="contact__form">
						<h5>Gửi tin nhắn</h5>
						
						<!-- Hiển thị thông báo thành công -->
						<c:if test="${not empty successMessage}">
						    <div class="alert alert-success alert-dismissible fade show" role="alert">
						        ${successMessage}
						        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
						            <span aria-hidden="true">&times;</span>
						        </button>
						    </div>
						</c:if>
						
						<!-- Hiển thị thông báo lỗi -->
						<c:if test="${not empty errorMessage}">
						    <div class="alert alert-danger alert-dismissible fade show" role="alert">
						        ${errorMessage}
						        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
						            <span aria-hidden="true">&times;</span>
						        </button>
						    </div>
						</c:if>
						
						<!-- Form liên hệ -->
						<form:form action="${env }/contact" 
						           method="POST" 
						           modelAttribute="contact">
						    
						    <div class="form-group">
						        <form:input path="name" 
						                    class="form-control" 
						                    placeholder="Họ và tên *"
						                    required="required" />
						        <form:errors path="name" cssClass="text-danger small" />
						    </div>
						    
						    <div class="form-group">
						        <form:input path="email" 
						                    type="email" 
						                    class="form-control" 
						                    placeholder="Email *"
						                    required="required" />
						        <form:errors path="email" cssClass="text-danger small" />
						    </div>
						    
						    <div class="form-group">
						        <form:input path="phone" 
						                    class="form-control" 
						                    placeholder="Số điện thoại" />
						    </div>
						    
						    <div class="form-group">
						        <form:input path="subject" 
						                    class="form-control" 
						                    placeholder="Chủ đề" />
						    </div>
						    
						    <div class="form-group">
						        <form:textarea path="message" 
						                      class="form-control" 
						                      placeholder="Tin nhắn *"
						                      rows="5"
						                      required="required" />
						        <form:errors path="message" cssClass="text-danger small" />
						    </div>
						    
						    <button type="submit" class="site-btn">Gửi tin nhắn</button>
						</form:form>
					</div>
				</div>
				<div class="col-lg-6 col-md-6">
					<div class="contact__address">
						<h5>Thông tin liên hệ</h5>
						<ul>
							<li>
								<h6>
									<i class="fa fa-map-marker"></i> Địa chỉ
								</h6>
								<p>số 688 Đường Quang Trung,P. Hà Đông, TP. Hà Nội.</p>
							</li>
							<li>
								<h6>
									<i class="fa fa-phone"></i> Số điện thoại
								</h6>
								<p>
									<span> 024 - 7303.0222</span>
								</p>
							</li>
							<li>
								<h6>
									<i class="fa fa-headphones"></i> Hỗ trợ
								</h6>
								<p>dangdong2802@gmail.com</p>
							</li>
						</ul>
					</div>
					<div class="contact__map">
						<iframe
							src="https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d3541.4348110137494!2d105.7607180250295!3d20.96120888067127!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1zc-G7kSA2ODggxJDGsOG7nW5nIFF1YW5nIFRydW5nLCBQLiBIw6AgxJDDtG5nLCBUUC4gSMOgIE7hu5lpLg!5e1!3m2!1svi!2s!4v1760688527250!5m2!1svi!2s"
							width="600" height="450" style="border: 0;" allowfullscreen=""
							loading="lazy" referrerpolicy="no-referrer-when-downgrade">
						</iframe>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Contact Section End -->

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
	
	<!-- Script hiển thị thông báo -->
	<script>
	    // Tự động ẩn thông báo sau 5 giây
	    setTimeout(function() {
	        $('.alert').alert('close');
	    }, 5000);
	</script>
</body>
</html>