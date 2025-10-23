<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <style type="text/css">
    	.payment-result {
		    padding: 40px;
		    background: #f8f9fa;
		    border-radius: 10px;
		}
		
		.success-icon, .error-icon {
		    margin-bottom: 20px;
		}
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/customer/layout/header.jsp"></jsp:include>

    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__links">
                        <a href="${env }/index"><i class="fa fa-home"></i> Home</a>
                        <span>Kết quả thanh toán</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <section class="checkout spad">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="payment-result text-center">
                        <c:choose>
                            <c:when test="${success}">
                                <div class="success-icon">
                                    <i class="fa fa-check-circle" style="color: #28a745; font-size: 48px;"></i>
                                </div>
                                <h3 class="text-success">Thanh toán thành công!</h3>
                                <div class="payment-details">
                                    <p><strong>Mã đơn hàng:</strong> ${orderCode}</p>
                                    <p><strong>Mã giao dịch:</strong> ${transactionNo}</p>
                                    <p><strong>Số tiền:</strong> <fmt:formatNumber value="${amount}" minFractionDigits="0"/> ₫</p>
                                </div>
                                <p>Cảm ơn bạn đã mua hàng. Đơn hàng của bạn đang được xử lý.</p>
                                <a href="${env }/index" class="site-btn">Tiếp tục mua sắm</a>
                            </c:when>
                            <c:otherwise>
                                <div class="error-icon">
                                    <i class="fa fa-times-circle" style="color: #dc3545; font-size: 48px;"></i>
                                </div>
                                <h3 class="text-danger">Thanh toán thất bại!</h3>
                                <p>${message}</p>
                                <a href="${env }/checkout" class="site-btn">Quay lại thanh toán</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="/WEB-INF/views/customer/layout/services.jsp"></jsp:include>
	
	<!-- Footer -->
	<jsp:include page="/WEB-INF/views/customer/layout/footer.jsp"></jsp:include>
	<!-- End - Footer -->
	
	<jsp:include page="/WEB-INF/views/customer/layout/search.jsp"></jsp:include>

	<!-- JS Plugins -->
	<jsp:include page="/WEB-INF/views/customer/layout/js.jsp"></jsp:include>
	
	<jsp:include page="/WEB-INF/views/customer/layout/js-addtocart.jsp"></jsp:include>
</body>
</html>
