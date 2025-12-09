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
    <title>SWE - Đơn hàng của tôi</title>

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
        .order-tabs {
            margin-bottom: 30px;
        }
        
        .order-tabs .nav-tabs {
            border-bottom: 2px solid #f0f0f0;
            margin-bottom: 20px;
            display: flex;
            flex-wrap: nowrap;
            overflow-x: auto;
            padding-bottom: 5px;
        }
        
        .order-tabs .nav-tabs::-webkit-scrollbar {
            height: 4px;
        }
        
        .order-tabs .nav-tabs::-webkit-scrollbar-track {
            background: #f1f1f1;
        }
        
        .order-tabs .nav-tabs::-webkit-scrollbar-thumb {
            background: #888;
            border-radius: 2px;
        }
        
        .order-tabs .nav-tabs::-webkit-scrollbar-thumb:hover {
            background: #555;
        }
        
        .order-tabs .nav-tabs .nav-item {
            margin-right: 5px;
            flex-shrink: 0;
        }
        
        .order-tabs .nav-tabs .nav-link {
            border: 1px solid #f0f0f0;
            border-bottom: none;
            border-radius: 4px 4px 0 0;
            padding: 8px 12px;
            color: #333;
            font-weight: 500;
            background-color: #f8f9fa;
            transition: all 0.3s ease;
            font-size: 14px;
            white-space: nowrap;
        }
        
        .order-tabs .nav-tabs .nav-link:hover {
            background-color: #e9ecef;
        }
        
        .order-tabs .nav-tabs .nav-link.active {
            background-color: #ff6b6b;
            color: white;
            border-color: #ff6b6b;
        }
        
        .order-tabs .tab-content {
            padding: 20px 0;
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
        
        .order-code {
            font-weight: 600;
            color: #ff6b6b;
            font-size: 15px;
        }
                
        .site-btn:hover {
            background-color: #ff5252;
            color: white;
        }
        
        .table thead th {
            background-color: #f8f9fa;
            border-top: none;
            font-weight: 600;
            font-size: 14px;
            padding: 12px 15px;
        }
        
        .table tbody td {
            padding: 12px 15px;
            vertical-align: middle;
            font-size: 14px;
        }
        
        .empty-orders-icon {
            font-size: 48px;
            color: #dee2e6;
            margin-bottom: 15px;
        }
        
        @media (max-width: 768px) {
            .order-tabs .nav-tabs .nav-link {
                padding: 6px 8px;
                font-size: 13px;
            }
            
            .table {
                display: block;
                overflow-x: auto;
            }
            
            .table thead th,
            .table tbody td {
                white-space: nowrap;
                min-width: 120px;
            }
            
            .order-code {
                font-size: 13px;
            }
            
            .site-btn {
                padding: 5px 10px;
                font-size: 12px;
            }
        }
    </style>
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
                        <a href="${env}/index"><i class="fa fa-home"></i> Home</a>
                        <span>Đơn hàng của tôi</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

	<!-- Order History Section Begin -->
	<section class="shop-cart spad">
		<div class="container">
			<!-- Tab Navigation -->
			<div class="row order-tabs">
				<div class="col-lg-12">
					<ul class="nav nav-tabs" role="tablist">
						<li class="nav-item">
							<a class="nav-link active" data-toggle="tab" href="#tabs-0" role="tab">
								<i class="bi bi-list-check"></i> Tất cả
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" data-toggle="tab" href="#tabs-1" role="tab">
								<i class="bi bi-clock-history"></i> Chờ duyệt
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" data-toggle="tab" href="#tabs-2" role="tab">
								<i class="bi bi-check-circle"></i> Xác nhận
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" data-toggle="tab" href="#tabs-3" role="tab">
								<i class="bi bi-truck"></i> Chờ vận chuyển
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" data-toggle="tab" href="#tabs-4" role="tab">
								<i class="bi bi-box-seam"></i> Đang giao
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" data-toggle="tab" href="#tabs-5" role="tab">
								<i class="bi bi-check-lg"></i> Đã giao
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" data-toggle="tab" href="#tabs-6" role="tab">
								<i class="bi bi-arrow-return-left"></i> Trả hàng
							</a>
						</li>
					</ul>
					
					<div class="tab-content">
						<!-- Tab 0: Tất cả đơn hàng -->
						<div class="tab-pane active" id="tabs-0" role="tabpanel">
							<div class="shop__cart__table">
								<c:choose>
									<c:when test="${not empty allOrders}">
										<table class="table">
											<thead>
												<tr>
													<th>MÃ ĐƠN HÀNG</th>
													<th>NGÀY ĐẶT</th>
													<th>TỔNG TIỀN</th>
													<th>TRẠNG THÁI</th>
													<th></th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="saleorder" items="${allOrders}">
													<tr>
														<td><span class="order-code">#${saleorder.code}</span></td>
														<td><fmt:formatDate value="${saleorder.createDate}"
																pattern="dd/MM/yyyy HH:mm" /></td>
														<td><fmt:formatNumber value="${saleorder.total}"
																type="currency" currencySymbol="₫" maxFractionDigits="0" />
														</td>
														<td>
															<c:choose>
																<c:when test="${saleorder.orderStatus == 0}">
																	<span class="badge bg-secondary">Chờ phê duyệt</span>
																</c:when>
																<c:when test="${saleorder.orderStatus == 1}">
																	<span class="badge bg-primary">Xác nhận</span>
																</c:when>
																<c:when test="${saleorder.orderStatus == 2}">
																	<span class="badge bg-warning text-dark">Chờ vận chuyển</span>
																</c:when>
																<c:when test="${saleorder.orderStatus == 3}">
																	<span class="badge bg-info">Đang giao hàng</span>
																</c:when>
																<c:when test="${saleorder.orderStatus == 4}">
																	<span class="badge bg-success">Đã giao hàng</span>
																</c:when>
																<c:when test="${saleorder.orderStatus == 5}">
																	<span class="badge bg-danger">Trả hàng</span>
																</c:when>
																<c:otherwise>
																	<span class="badge bg-dark">Không xác định</span>
																</c:otherwise>
															</c:choose>
														</td>
														<td>
															<button type="button" class="site-btn" onclick="location.href='${env}/my-order/${saleorder.id}'">CHI TIẾT</button>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</c:when>
									<c:otherwise>
										<div class="text-center my-5 py-5">
											<div class="empty-orders-icon">
												<i class="bi bi-cart-x"></i>
											</div>
											<h5 class="mb-3">Bạn chưa có đơn hàng nào</h5>
											<p class="text-muted mb-4">Hãy tiếp tục mua sắm để có trải
												nghiệm tốt nhất nhé!</p>
											<a href="${env}/shop" class="site-btn">Tiếp tục mua sắm</a>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						
						<!-- Tab 1: Chờ phê duyệt -->
						<div class="tab-pane" id="tabs-1" role="tabpanel">
							<div class="shop__cart__table">
								<c:choose>
									<c:when test="${not empty pendingOrders}">
										<table class="table">
											<thead>
												<tr>
													<th>MÃ ĐƠN HÀNG</th>
													<th>NGÀY ĐẶT</th>
													<th>TỔNG TIỀN</th>
													<th>TRẠNG THÁI</th>
													<th></th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="saleorder" items="${pendingOrders}">
													<tr>
														<td><span class="order-code">#${saleorder.code}</span></td>
														<td><fmt:formatDate value="${saleorder.createDate}"
																pattern="dd/MM/yyyy HH:mm" /></td>
														<td><fmt:formatNumber value="${saleorder.total}"
																type="currency" currencySymbol="₫" maxFractionDigits="0" />
														</td>
														<td>
															<span class="badge bg-secondary">Chờ phê duyệt</span>
														</td>
														<td>
															<button type="button" class="site-btn" onclick="location.href='${env}/my-order/${saleorder.id}'">CHI TIẾT</button>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</c:when>
									<c:otherwise>
										<div class="text-center my-5 py-5">
											<div class="empty-orders-icon">
												<i class="bi bi-clock-history"></i>
											</div>
											<h5 class="mb-3">Không có đơn hàng nào đang chờ phê duyệt</h5>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						
						<!-- Tab 2: Xác nhận -->
						<div class="tab-pane" id="tabs-2" role="tabpanel">
							<div class="shop__cart__table">
								<c:choose>
									<c:when test="${not empty confirmedOrders}">
										<table class="table">
											<thead>
												<tr>
													<th>MÃ ĐƠN HÀNG</th>
													<th>NGÀY ĐẶT</th>
													<th>TỔNG TIỀN</th>
													<th>TRẠNG THÁI</th>
													<th></th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="saleorder" items="${confirmedOrders}">
													<tr>
														<td><span class="order-code">#${saleorder.code}</span></td>
														<td><fmt:formatDate value="${saleorder.createDate}"
																pattern="dd/MM/yyyy HH:mm" /></td>
														<td><fmt:formatNumber value="${saleorder.total}"
																type="currency" currencySymbol="₫" maxFractionDigits="0" />
														</td>
														<td>
															<span class="badge bg-primary">Xác nhận</span>
														</td>
														<td>
															<button type="button" class="site-btn" onclick="location.href='${env}/my-order/${saleorder.id}'">CHI TIẾT</button>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</c:when>
									<c:otherwise>
										<div class="text-center my-5 py-5">
											<div class="empty-orders-icon">
												<i class="bi bi-check-circle"></i>
											</div>
											<h5 class="mb-3">Không có đơn hàng nào đã xác nhận</h5>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						
						<!-- Tab 3: Chờ vận chuyển -->
						<div class="tab-pane" id="tabs-3" role="tabpanel">
							<div class="shop__cart__table">
								<c:choose>
									<c:when test="${not empty waitingShipOrders}">
										<table class="table">
											<thead>
												<tr>
													<th>MÃ ĐƠN HÀNG</th>
													<th>NGÀY ĐẶT</th>
													<th>TỔNG TIỀN</th>
													<th>TRẠNG THÁI</th>
													<th></th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="saleorder" items="${waitingShipOrders}">
													<tr>
														<td><span class="order-code">#${saleorder.code}</span></td>
														<td><fmt:formatDate value="${saleorder.createDate}"
																pattern="dd/MM/yyyy HH:mm" /></td>
														<td><fmt:formatNumber value="${saleorder.total}"
																type="currency" currencySymbol="₫" maxFractionDigits="0" />
														</td>
														<td>
															<span class="badge bg-warning text-dark">Chờ vận chuyển</span>
														</td>
														<td>
															<button type="button" class="site-btn" onclick="location.href='${env}/my-order/${saleorder.id}'">CHI TIẾT</button>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</c:when>
									<c:otherwise>
										<div class="text-center my-5 py-5">
											<div class="empty-orders-icon">
												<i class="bi bi-truck"></i>
											</div>
											<h5 class="mb-3">Không có đơn hàng nào chờ vận chuyển</h5>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						
						<!-- Tab 4: Đang giao hàng -->
						<div class="tab-pane" id="tabs-4" role="tabpanel">
							<div class="shop__cart__table">
								<c:choose>
									<c:when test="${not empty shippingOrders}">
										<table class="table">
											<thead>
												<tr>
													<th>MÃ ĐƠN HÀNG</th>
													<th>NGÀY ĐẶT</th>
													<th>TỔNG TIỀN</th>
													<th>TRẠNG THÁI</th>
													<th></th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="saleorder" items="${shippingOrders}">
													<tr>
														<td><span class="order-code">#${saleorder.code}</span></td>
														<td><fmt:formatDate value="${saleorder.createDate}"
																pattern="dd/MM/yyyy HH:mm" /></td>
														<td><fmt:formatNumber value="${saleorder.total}"
																type="currency" currencySymbol="₫" maxFractionDigits="0" />
														</td>
														<td>
															<span class="badge bg-info">Đang giao hàng</span>
														</td>
														<td>
															<button type="button" class="site-btn" onclick="location.href='${env}/my-order/${saleorder.id}'">CHI TIẾT</button>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</c:when>
									<c:otherwise>
										<div class="text-center my-5 py-5">
											<div class="empty-orders-icon">
												<i class="bi bi-box-seam"></i>
											</div>
											<h5 class="mb-3">Không có đơn hàng nào đang giao</h5>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						
						<!-- Tab 5: Đã giao hàng -->
						<div class="tab-pane" id="tabs-5" role="tabpanel">
							<div class="shop__cart__table">
								<c:choose>
									<c:when test="${not empty deliveredOrders}">
										<table class="table">
											<thead>
												<tr>
													<th>MÃ ĐƠN HÀNG</th>
													<th>NGÀY ĐẶT</th>
													<th>TỔNG TIỀN</th>
													<th>TRẠNG THÁI</th>
													<th></th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="saleorder" items="${deliveredOrders}">
													<tr>
														<td><span class="order-code">#${saleorder.code}</span></td>
														<td><fmt:formatDate value="${saleorder.createDate}"
																pattern="dd/MM/yyyy HH:mm" /></td>
														<td><fmt:formatNumber value="${saleorder.total}"
																type="currency" currencySymbol="₫" maxFractionDigits="0" />
														</td>
														<td>
															<span class="badge bg-success">Đã giao hàng</span>
														</td>
														<td>
															<button type="button" class="site-btn" onclick="location.href='${env}/my-order/${saleorder.id}'">CHI TIẾT</button>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</c:when>
									<c:otherwise>
										<div class="text-center my-5 py-5">
											<div class="empty-orders-icon">
												<i class="bi bi-check-lg"></i>
											</div>
											<h5 class="mb-3">Không có đơn hàng nào đã giao</h5>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						
						<!-- Tab 6: Trả hàng -->
						<div class="tab-pane" id="tabs-6" role="tabpanel">
							<div class="shop__cart__table">
								<c:choose>
									<c:when test="${not empty returnedOrders}">
										<table class="table">
											<thead>
												<tr>
													<th>MÃ ĐƠN HÀNG</th>
													<th>NGÀY ĐẶT</th>
													<th>TỔNG TIỀN</th>
													<th>TRẠNG THÁI</th>
													<th></th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="saleorder" items="${returnedOrders}">
													<tr>
														<td><span class="order-code">#${saleorder.code}</span></td>
														<td><fmt:formatDate value="${saleorder.createDate}"
																pattern="dd/MM/yyyy HH:mm" /></td>
														<td><fmt:formatNumber value="${saleorder.total}"
																type="currency" currencySymbol="₫" maxFractionDigits="0" />
														</td>
														<td>
															<span class="badge bg-danger">Trả hàng</span>
														</td>
														<td>
															<button type="button" class="site-btn" onclick="location.href='${env}/my-order/${saleorder.id}'">CHI TIẾT</button>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</c:when>
									<c:otherwise>
										<div class="text-center my-5 py-5">
											<div class="empty-orders-icon">
												<i class="bi bi-arrow-return-left"></i>
											</div>
											<h5 class="mb-3">Không có đơn hàng nào trả lại</h5>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Order History Section End -->

	<jsp:include page="/WEB-INF/views/customer/layout/services.jsp"></jsp:include>

	<!-- Footer -->
	<jsp:include page="/WEB-INF/views/customer/layout/footer.jsp"></jsp:include>
	<!-- End - Footer -->
	
	<jsp:include page="/WEB-INF/views/customer/layout/search.jsp"></jsp:include>

	<!-- JS Plugins -->
	<jsp:include page="/WEB-INF/views/customer/layout/js.jsp"></jsp:include>
	
	<script type="text/javascript">
		// Khi trang được load, active tab đầu tiên
		$(document).ready(function() {
			$('.nav-tabs a:first').tab('show');
			
			// Thêm hiệu ứng cho tab khi click
			$('.nav-tabs a').click(function() {
				$(this).tab('show');
			});
		});
	</script>
	
</body>
</html>