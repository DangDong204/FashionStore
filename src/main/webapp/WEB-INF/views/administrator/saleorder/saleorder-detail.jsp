<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    
    <title>Chi tiết đơn hàng #${saleOrder.code}</title>
    <meta content="" name="description">
    <meta content="" name="keywords">
    
    <jsp:include page="/WEB-INF/views/administrator/layout/css.jsp"></jsp:include>
</head>

<body>
    <jsp:include page="/WEB-INF/views/administrator/layout/header.jsp"></jsp:include>

    <jsp:include page="/WEB-INF/views/administrator/layout/left-sidebar.jsp"></jsp:include>
    
    <main id="main" class="main">

        <div class="pagetitle">
            <h1>Chi tiết đơn hàng</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${env }/admin/home">Home</a></li>
                    <li class="breadcrumb-item"><a href="${env }/admin/saleorder/list">Đơn hàng</a></li>
                    <li class="breadcrumb-item active">Chi tiết #${saleOrder.code}</li>
                </ol>
            </nav>
        </div>
        <!-- End Page Title -->
        
        <section class="section">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">
                                Đơn hàng #${saleOrder.code}
                                <span class="badge bg-${saleOrder.status ? 'success' : 'danger'} ms-2">
                                    ${saleOrder.status ? 'Active' : 'Inactive'}
                                </span>
                            </h5>
                            
                            <!-- Thông tin chung -->
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <div class="card border">
                                        <div class="card-header bg-light">
                                            <h6 class="card-title mb-0">Thông tin đơn hàng</h6>
                                        </div>
                                        <div class="card-body">
                                            <div class="row mb-2">
                                                <div class="col-sm-4 fw-semibold">Mã đơn hàng:</div>
                                                <div class="col-sm-8">${saleOrder.code}</div>
                                            </div>
                                            <div class="row mb-2">
                                                <div class="col-sm-4 fw-semibold">Ngày tạo:</div>
                                                <div class="col-sm-8">
                                                    <fmt:formatDate value="${saleOrder.createDate}" pattern="dd/MM/yyyy HH:mm:ss" />
                                                </div>
                                            </div>
                                            <div class="row mb-2">
                                                <div class="col-sm-4 fw-semibold">Ngày cập nhật:</div>
                                                <div class="col-sm-8">
                                                    <c:if test="${not empty saleOrder.updateDate}">
                                                        <fmt:formatDate value="${saleOrder.updateDate}" pattern="dd/MM/yyyy HH:mm:ss" />
                                                    </c:if>
                                                </div>
                                            </div>
                                            <div class="row mb-2">
                                                <div class="col-sm-4 fw-semibold">Trạng thái:</div>
                                                <div class="col-sm-8">
                                                    <c:choose>
                                                        <c:when test="${saleOrder.orderStatus == 0}">
                                                            <span class="badge bg-secondary">Chờ phê duyệt</span>
                                                        </c:when>
                                                        <c:when test="${saleOrder.orderStatus == 1}">
                                                            <span class="badge bg-primary">Xác nhận</span>
                                                        </c:when>
                                                        <c:when test="${saleOrder.orderStatus == 2}">
                                                            <span class="badge bg-warning text-dark">Chờ đơn vị vận chuyển</span>
                                                        </c:when>
                                                        <c:when test="${saleOrder.orderStatus == 3}">
                                                            <span class="badge bg-info">Đang giao hàng</span>
                                                        </c:when>
                                                        <c:when test="${saleOrder.orderStatus == 4}">
                                                            <span class="badge bg-success">Đã giao hàng</span>
                                                        </c:when>
                                                        <c:when test="${saleOrder.orderStatus == 5}">
                                                            <span class="badge bg-danger">Trả hàng</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-dark">Không xác định</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            <div class="row mb-2">
                                                <div class="col-sm-4 fw-semibold">Tổng tiền:</div>
                                                <div class="col-sm-8 text-danger fw-bold">
                                                    <fmt:formatNumber value="${saleOrder.total}" type="number" minFractionDigits="0" /> ₫
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="card border">
                                        <div class="card-header bg-light">
                                            <h6 class="card-title mb-0">Thông tin khách hàng</h6>
                                        </div>
                                        <div class="card-body">
                                            <div class="row mb-2">
                                                <div class="col-sm-4 fw-semibold">Họ tên:</div>
                                                <div class="col-sm-8">${saleOrder.customerName}</div>
                                            </div>
                                            <div class="row mb-2">
                                                <div class="col-sm-4 fw-semibold">Điện thoại:</div>
                                                <div class="col-sm-8">${saleOrder.customerMobile}</div>
                                            </div>
                                            <div class="row mb-2">
                                                <div class="col-sm-4 fw-semibold">Email:</div>
                                                <div class="col-sm-8">${saleOrder.customerEmail}</div>
                                            </div>
                                            <div class="row mb-2">
                                                <div class="col-sm-4 fw-semibold">Địa chỉ:</div>
                                                <div class="col-sm-8">${saleOrder.customerAddress}</div>
                                            </div>
                                            <div class="row mb-2">
                                                <div class="col-sm-4 fw-semibold">Thanh toán:</div>
                                                <div class="col-sm-8">
                                                    <c:choose>
                                                        <c:when test="${saleOrder.paymentMethod == 0}">COD</c:when>
                                                        <c:when test="${saleOrder.paymentMethod == 1}">VNPay</c:when>
                                                        <c:otherwise>Không xác định</c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Danh sách sản phẩm -->
                            <div class="card border mb-4">
                                <div class="card-header bg-light">
                                    <h6 class="card-title mb-0">Danh sách sản phẩm</h6>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-hover">
                                            <thead class="table-light">
                                                <tr>
                                                    <th width="5%" class="text-center">STT</th>
                                                    <th width="10%" class="text-center">Hình ảnh</th>
                                                    <th width="30%">Tên sản phẩm</th>
                                                    <th width="15%" class="text-center">Đơn giá</th>
                                                    <th width="10%" class="text-center">Số lượng</th>
                                                    <th width="15%" class="text-center">Thành tiền</th>
                                                    <th width="15%" class="text-center">Ghi chú</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="item" items="${saleOrderProducts}" varStatus="loop">
                                                    <tr>
                                                        <td class="text-center">${loop.index + 1}</td>
                                                        <td class="text-center">
                                                            <c:if test="${not empty item.product.avatar}">
                                                                <img src="${env}/${item.product.avatar}" 
                                                                     alt="${item.productName}" 
                                                                     class="img-thumbnail" 
                                                                     style="width: 60px; height: 60px; object-fit: cover;">
                                                            </c:if>
                                                            <c:if test="${empty item.product.avatar}">
                                                                <div class="text-muted">No image</div>
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            <div class="fw-semibold">${item.productName}</div>
                                                            
                                                        </td>
                                                        <td class="text-end">
                                                            <fmt:formatNumber value="${item.product.price}" type="number" minFractionDigits="0" /> ₫
                                                        </td>
                                                        <td class="text-center">${item.quantity}</td>
                                                        <td class="text-end text-danger fw-semibold">
                                                            <fmt:formatNumber value="${item.totalPrice}" type="number" minFractionDigits="0" /> ₫
                                                        </td>
                                                        <td class="text-center">
                                                            <c:if test="${not empty item.description}">
                                                                <span class="badge bg-info">${item.description}</span>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                            <tfoot class="table-light">
                                                <tr>
                                                    <td colspan="5" class="text-end fw-bold">Tổng cộng:</td>
                                                    <td colspan="2" class="text-end fw-bold text-danger">
                                                        <fmt:formatNumber value="${saleOrder.total}" type="number" minFractionDigits="0" /> ₫
                                                    </td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Thông tin bổ sung -->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="card border">
                                        <div class="card-header bg-light">
                                            <h6 class="card-title mb-0">Voucher & Giảm giá</h6>
                                        </div>
                                        <div class="card-body">
                                            <c:choose>
                                                <c:when test="${not empty saleOrder.voucher}">
                                                    <div class="row mb-2">
                                                        <div class="col-sm-4 fw-semibold">Mã giảm giá:</div>
                                                        <div class="col-sm-8">${saleOrder.voucher.code}</div>
                                                    </div>
                                                    <div class="row mb-2">
                                                        <div class="col-sm-4 fw-semibold">Giá trị:</div>
                                                        <div class="col-sm-8">${saleOrder.voucher.discountValue}%</div>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="text-muted">Không sử dụng voucher</div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="card border">
                                        <div class="card-header bg-light">
                                            <h6 class="card-title mb-0">Ghi chú & Thông tin khác</h6>
                                        </div>
                                        <div class="card-body">
                                            <div class="row mb-2">
                                                <div class="col-sm-4 fw-semibold">Ghi chú:</div>
                                                <div class="col-sm-8">${saleOrder.description}</div>
                                            </div>
                                            <div class="row mb-2">
                                                <div class="col-sm-4 fw-semibold">Ngày giao hàng:</div>
                                                <div class="col-sm-8">
                                                    <c:if test="${not empty saleOrder.deliveryDate}">
                                                        <fmt:formatDate value="${saleOrder.deliveryDate}" pattern="dd/MM/yyyy" />
                                                    </c:if>
                                                    <c:if test="${empty saleOrder.deliveryDate}">
                                                        <span class="text-muted">Chưa xác định</span>
                                                    </c:if>
                                                </div>
                                            </div>
                                            <div class="row mb-2">
                                                <div class="col-sm-4 fw-semibold">Người tạo đơn:</div>
                                                <div class="col-sm-8">
                                                    <c:if test="${not empty saleOrder.user}">
                                                        ${saleOrder.user.username} (${saleOrder.user.email})
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Nút điều hướng -->
                            <div class="row mt-4">
                                <div class="col-12 text-center">
                                    <a href="${env}/admin/saleorder/list" class="btn btn-secondary me-2">
                                        <i class="ri-arrow-left-line me-1"></i> Quay lại danh sách
                                    </a>
                                    <a href="${env}/admin/saleorder/edit/${saleOrder.id}" class="btn btn-warning me-2">
                                        <i class="ri-edit-line me-1"></i> Chỉnh sửa trạng thái
                                    </a>
                                    <button type="button" class="btn btn-primary" onclick="window.print()">
                                        <i class="ri-printer-line me-1"></i> In đơn hàng
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
    <!-- End #main -->
    
    <jsp:include page="/WEB-INF/views/administrator/layout/footer.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/views/administrator/layout/js.jsp"></jsp:include>
    
    <!-- CSS in riêng cho trang chi tiết -->
    <style>
        .card-header {
            background-color: #f8f9fa !important;
        }
        .table th {
            background-color: #f8f9fa !important;
            font-weight: 600;
        }
        .product-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 4px;
        }
        .badge {
            font-size: 0.85em;
            padding: 0.4em 0.8em;
        }
        @media print {
            .no-print {
                display: none !important;
            }
            .card {
                border: 1px solid #ddd !important;
            }
            .badge {
                border: 1px solid #333 !important;
                color: #333 !important;
                background: none !important;
            }
        }
    </style>
</body>
</html>