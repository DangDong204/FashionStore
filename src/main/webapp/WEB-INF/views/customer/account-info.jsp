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
                        <span>Account</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Checkout Section Begin -->
	<section class="checkout spad">
		<div class="container">
			<form action="${env}/account/update" method="post" class="checkout__form" enctype="multipart/form-data">
				<div class="row">
					<div class="col-lg-8">
						<c:if test="${param.success == 'update'}">
							<div class="alert alert-success mt-2">Cập nhật thông tin thành công!</div>
						</c:if>
												
						<h5>Thông tin tài khoản</h5>
						<div class="row">
							<div class="col-lg-12">
								<div class="checkout__form__input">
									<p>
										Họ và tên <span>*</span>
									</p>
									<input type="text" name="customerName" placeholder="Nhập họ và tên" 
											value="${loginedUser.name}" required>
								</div>
								<div class="checkout__form__input">
									<p>
										Address <span>*</span>
									</p>
									<input type="text" name="customerAddress" placeholder="Nhập địa chỉ" 
											value="${loginedUser.address}">
								</div>
							</div>
							<div class="col-lg-6 col-md-6 col-sm-6">
								<div class="checkout__form__input">
									<p>
										Phone <span>*</span>
									</p>
									<input type="text" name="customerPhone" placeholder="Nhập số điện thoại" 
											value="${loginedUser.mobile}">
								</div>
							</div>
							<div class="col-lg-6 col-md-6 col-sm-6">
								<div class="checkout__form__input">
									<p>
										Email <span>*</span>
									</p>
									<input type="text" name="customerEmail" placeholder="Nhập email"
										value="${loginedUser.email}">
								</div>
							</div>

						</div>
					</div>
					<div class="col-lg-4">
						<div class="checkout__order text-center p-4 shadow-sm rounded position-relative">
    <div class="position-relative d-inline-block">
        <img id="avatarPreview" 
             src="${env}/${loginedUser.avatar}" 
             alt="Avatar" 
             class="rounded-circle mb-3"
             style="width:150px; height:150px; object-fit:cover; border:3px solid #f1f1f1;">
             
        <!-- Nút bút nhỏ gọn, cân đối -->
        <label for="avatarFile"
               class="position-absolute bg-primary text-white d-flex align-items-center justify-content-center"
               style="width:32px; height:32px; border-radius:50%; 
                      bottom:10px; right:10px; cursor:pointer; 
                      border:2px solid #fff; transition:all 0.2s ease;">
            <i class="fa fa-pen" style="font-size:14px;"></i>
        </label>

        <!-- Input file ẩn -->
        <input type="file" name="avatarFile" id="avatarFile" accept="image/*" class="d-none">
    </div>

    <button type="submit" class="site-btn mt-3">Lưu thay đổi</button>
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
	
	<jsp:include page="/WEB-INF/views/customer/layout/search.jsp"></jsp:include>
	

	<!-- JS Plugins -->
	<jsp:include page="/WEB-INF/views/customer/layout/js.jsp"></jsp:include>
	
	<script>
	// Hiển thị ảnh xem trước khi chọn file mới
	document.getElementById('avatarFile').addEventListener('change', function (e) {
		const file = e.target.files[0];
		if (file) {
			const reader = new FileReader();
			reader.onload = function (evt) {
				document.getElementById('avatarPreview').src = evt.target.result;
			};
			reader.readAsDataURL(file);
		}
	});
</script>
</body>
</html>