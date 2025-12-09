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
    <title>SWE - ${pageTitle}</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap"
    rel="stylesheet">
    <!-- icon - cho slider -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- Css Styles -->
    <jsp:include page="/WEB-INF/views/customer/layout/css.jsp"></jsp:include>
    
    <style>
        .order-detail-header {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 30px;
        }
        
        .order-code-large {
            font-size: 24px;
            font-weight: 700;
            color: #ff6b6b;
            margin-bottom: 10px;
        }
        
        .order-info-row {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }
        
        .order-info-item {
            flex: 1;
            min-width: 200px;
            margin-bottom: 15px;
        }
        
        .order-info-label {
            font-weight: 600;
            color: #6c757d;
            font-size: 14px;
            margin-bottom: 5px;
        }
        
        .order-info-value {
            font-size: 16px;
            color: #333;
        }
        
        .badge {
            padding: 5px 10px;
            font-size: 12px;
            font-weight: 500;
            border-radius: 4px;
        }
        
        .badge.bg-secondary {
            background-color: #6c757d !important;
            color: white;
        }
        
        .badge.bg-primary {
            background-color: #007bff !important;
            color: white;
        }
        
        .badge.bg-warning {
            background-color: #ffc107 !important;
            color: #212529;
        }
        
        .badge.bg-info {
            background-color: #17a2b8 !important;
            color: white;
        }
        
        .badge.bg-success {
            background-color: #28a745 !important;
            color: white;
        }
        
        .badge.bg-danger {
            background-color: #dc3545 !important;
            color: white;
        }
        
        .badge.bg-dark {
            background-color: #343a40 !important;
            color: white;
        }
        
        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
        }
        
        .order-summary {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-top: 30px;
        }
        
        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .summary-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }
        
        .summary-label {
            font-weight: 500;
            color: #6c757d;
        }
        
        .summary-value {
            font-weight: 600;
            color: #333;
        }
        
        .summary-total {
            font-size: 18px;
            color: #ff6b6b;
        }
        
        .back-btn {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .back-btn:hover {
            background-color: #5a6268;
            color: white;
        }
        
        .print-btn {
            background-color: #ff6b6b;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .print-btn:hover {
            background-color: #ff5252;
            color: white;
        }
        
        @media (max-width: 768px) {
            .order-info-item {
                min-width: 100%;
            }
            
            .order-code-large {
                font-size: 20px;
            }
        }
    </style>
</head>

<body>
    <!-- Header -->
    <jsp:include page="/WEB-INF/views/customer/layout/header.jsp"></jsp:include>

    <!-- Breadcrumb Begin -->
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__links">
                        <a href="${env}/index"><i class="fa fa-home"></i> Home</a>
                        <a href="${env}/my-order">Đơn hàng của tôi</a>
                        <span>Chi tiết đơn hàng</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Order Detail Section Begin -->
    <section class="shop-cart spad">
        <div class="container">
            <!-- Header thông tin đơn hàng -->
            <div class="order-detail-header">
                <div class="order-code-large">#${order.code}</div>
                
                <div class="order-info-row">
                    <div class="order-info-item">
                        <div class="order-info-label">Trạng thái đơn hàng</div>
                        <div class="order-info-value">
                            <c:choose>
                                <c:when test="${order.orderStatus == 0}">
                                    <span class="badge bg-secondary">Chờ phê duyệt</span>
                                </c:when>
                                <c:when test="${order.orderStatus == 1}">
                                    <span class="badge bg-primary">Xác nhận</span>
                                </c:when>
                                <c:when test="${order.orderStatus == 2}">
                                    <span class="badge bg-warning text-dark">Chờ đơn vị vận chuyển</span>
                                </c:when>
                                <c:when test="${order.orderStatus == 3}">
                                    <span class="badge bg-info">Đang giao hàng</span>
                                </c:when>
                                <c:when test="${order.orderStatus == 4}">
                                    <span class="badge bg-success">Đã giao hàng</span>
                                </c:when>
                                <c:when test="${order.orderStatus == 5}">
                                    <span class="badge bg-danger">Trả hàng</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-dark">Không xác định</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <div class="order-info-item">
                        <div class="order-info-label">Ngày đặt hàng</div>
                        <div class="order-info-value">
                            <fmt:formatDate value="${order.createDate}" pattern="dd/MM/yyyy HH:mm" />
                        </div>
                    </div>
                    
                    <div class="order-info-item">
                        <div class="order-info-label">Người nhận</div>
                        <div class="order-info-value">${order.customerName}</div>
                    </div>
                </div>
                
                <div class="order-info-row">
                    <div class="order-info-item">
                        <div class="order-info-label">Số điện thoại</div>
                        <div class="order-info-value">${order.customerMobile}</div>
                    </div>
                    
                    <div class="order-info-item">
                        <div class="order-info-label">Email</div>
                        <div class="order-info-value">${order.customerEmail}</div>
                    </div>
                </div>
                
                <div class="order-info-item">
                    <div class="order-info-label">Địa chỉ nhận hàng</div>
                    <div class="order-info-value">${order.customerAddress}</div>
                </div>
            </div>
            
            <!-- Danh sách sản phẩm -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="shop__cart__table">
                        <h4 class="mb-4">Danh sách sản phẩm</h4>
                        
                        <c:choose>
                            <c:when test="${not empty orderProducts}">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>SẢN PHẨM</th>
                                            <th>ĐƠN GIÁ</th>
                                            <th>SỐ LƯỢNG</th>
                                            <th>THÀNH TIỀN</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:set var="subTotal" value="0"></c:set>
                                        <c:forEach var="item" items="${orderProducts}">
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <c:if test="${not empty item.product.avatar}">
                                                                <img src="${env}/${item.product.avatar}" 
                                                                     alt="${item.productName}" 
                                                                     class="img-thumbnail" 
                                                                     style="width: 60px; height: 60px; object-fit: cover;">
                                                         </c:if>
                                                            <c:if test="${empty item.product.avatar}">
                                                                <div class="text-muted">No image</div>
                                                            </c:if>
                                                        <div>
                                                            <div class="fw-semibold">${item.productName}</div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <fmt:formatNumber value="${item.price}" 
                                                                      type="currency" 
                                                                      currencySymbol="₫" 
                                                                      maxFractionDigits="0" />
                                                </td>
                                                <td>${item.quantity}</td>
                                                <td>
                                                    <fmt:formatNumber value="${item.price * item.quantity}" 
                                                                      type="currency" 
                                                                      currencySymbol="₫" 
                                                                      maxFractionDigits="0" />
                                                    <c:set var="subTotal" value="${subTotal + (item.price * item.quantity)}" />
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center my-5 py-5">
                                    <i class="bi bi-exclamation-circle empty-orders-icon"></i>
                                    <h5 class="mb-3">Không có sản phẩm nào trong đơn hàng này</h5>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            
            <!-- Tổng kết đơn hàng -->
            <div class="row">
                <div class="col-lg-4 offset-lg-8">
                    <div class="order-summary">
                        <h5 class="mb-4">Tổng kết đơn hàng</h5>
                        
                        <div class="summary-item">
                            <div class="summary-label">Tạm tính:</div>
                            <div class="summary-value">
                                <fmt:formatNumber value="${subTotal }" 
                                                  type="currency" 
                                                  currencySymbol="₫" 
                                                  maxFractionDigits="0" />
                            </div>
                        </div>
                        
                        <div class="summary-item">
                            <div class="summary-label">Phí vận chuyển:</div>
                            <div class="summary-value">
                                <fmt:formatNumber value="0" 
                                                  type="currency" 
                                                  currencySymbol="₫" 
                                                  maxFractionDigits="0" />
                            </div>
                        </div>
                        
                        <div class="summary-item">
                            <div class="summary-label">Giảm giá:</div>
                            <div class="summary-value">
                                <fmt:formatNumber value="${subTotal - order.total }" 
                                                  type="currency" 
                                                  currencySymbol="₫" 
                                                  maxFractionDigits="0" />
                            </div>
                        </div>
                        
                        <div class="summary-item summary-total">
                            <div class="summary-label">Tổng cộng:</div>
                            <div class="summary-value">
                                <fmt:formatNumber value="${order.total }" 
                                                  type="currency" 
                                                  currencySymbol="₫" 
                                                  maxFractionDigits="0" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Nút quay lại trang danh sách đơn hàng -->
            <div class="cart__btn">
                <a href="${env }/my-order">Quay lại</a>
            </div>
            
        </div>
    </section>
    <!-- Order Detail Section End -->

    <jsp:include page="/WEB-INF/views/customer/layout/services.jsp"></jsp:include>

    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/customer/layout/footer.jsp"></jsp:include>
    <!-- End - Footer -->
    
    <jsp:include page="/WEB-INF/views/customer/layout/search.jsp"></jsp:include>

    <!-- JS Plugins -->
    <jsp:include page="/WEB-INF/views/customer/layout/js.jsp"></jsp:include>
    
    <script type="text/javascript">
        // Hàm định dạng số tiền
        function formatCurrency(amount) {
            return new Intl.NumberFormat('vi-VN', {
                style: 'currency',
                currency: 'VND'
            }).format(amount);
        }
        
        // Nếu cần tính toán động, có thể thêm ở đây
        $(document).ready(function() {
            console.log("Chi tiết đơn hàng #${order.code} đã được tải");
        });
    </script>
    
</body>
</html>