<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>SWE - SaleOrder</title>
	<meta content="" name="description">
	<meta content="" name="keywords">
	
	<jsp:include page="/WEB-INF/views/administrator/layout/css.jsp"></jsp:include>
</head>

<body>
	<jsp:include page="/WEB-INF/views/administrator/layout/header.jsp"></jsp:include>

  	<jsp:include page="/WEB-INF/views/administrator/layout/left-sidebar.jsp"></jsp:include>
  	
  	<main id="main" class="main">

		<div class="pagetitle">
			<h1>Order</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="${env }/admin/home">Home</a></li>
					<li class="breadcrumb-item active">Order</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->
		
		<section class="section">
    <div class="row">
      <div class="col-lg-12">

        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Danh sách đơn hàng</h5>

            <div class="text-end mb-3">
              <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addSaleOrderModal">
                <i class="ri-add-circle-fill"></i> Thêm mới
              </button>
            </div>

            <!-- Bảng hiển thị đơn hàng -->
            <table class="table table-striped table-hover table-bordered align-middle datatable">
              <thead class="table-light text-center">
                <tr>
                  <th scope="col">No</th>
                  <th scope="col">Tên khách hàng</th>
                  <th scope="col">Mã đơn hàng</th>
                  <th scope="col">Tổng giá trị</th>
                  <th scope="col">Trạng thái đơn hàng</th>
                  <th scope="col">Status</th>
                  <th scope="col">Action</th>
                </tr>
              </thead>
              <tbody class="text-center">
         		<c:forEach var="saleorder" items="${saleorders }" varStatus="loop">
			        <tr>
						<td>${loop.index + 1}</td>
						<%-- <td>${saleorder.user.name }</td> --%>
						<td>${saleorder.customerName }</td>
						<td>${saleorder.code }</td>
						<td><fmt:formatNumber value="${saleorder.total }"
								type="number" minFractionDigits="0" /> ₫</td>
						<td>
							<c:choose>
								<c:when test="${saleorder.orderStatus == 0}">
									<span class="badge bg-secondary"> <i
										class="bi bi-clock-history me-1"></i>Chờ phê duyệt
									</span>
								</c:when>
								<c:when test="${saleorder.orderStatus == 1}">
									<span class="badge bg-primary"> <i
										class="bi bi-check-circle me-1"></i>Xác nhận
									</span>
								</c:when>
								<c:when test="${saleorder.orderStatus == 2}">
									<span class="badge bg-warning text-dark"> <i
										class="bi bi-truck me-1"></i>Chờ đơn vị vận chuyển
									</span>
								</c:when>
								<c:when test="${saleorder.orderStatus == 3}">
									<span class="badge bg-info"> <i
										class="bi bi-box-seam me-1"></i>Đang giao hàng
									</span>
								</c:when>
								<c:when test="${saleorder.orderStatus == 4}">
									<span class="badge bg-success"> <i
										class="bi bi-check-lg me-1"></i>Đã giao hàng
									</span>
								</c:when>
								<c:when test="${saleorder.orderStatus == 5}">
									<span class="badge bg-danger"> <i
										class="bi bi-arrow-return-left me-1"></i>Trả hàng
									</span>
								</c:when>
								<c:otherwise>
									<span class="badge bg-dark"> <i
										class="bi bi-question-circle me-1"></i>Không xác định
									</span>
								</c:otherwise>
							</c:choose>
						</td>

						<td class="text-center">
							<c:choose>
								<c:when test="${saleorder.status }">
									<i class="bi bi-check-circle-fill text-success"
										title="Active"></i>
								</c:when>
								<c:otherwise>
									<i class="bi bi-x-circle-fill text-danger"
										title="Inactive"></i>
								</c:otherwise>
							</c:choose>
						</td>

						<td>
							<!-- Nút Xem chi tiết -->
							<%-- <button type="button"
								class="btn btn-primary btn-sm text-white"
								title="Xem chi tiết" data-bs-toggle="modal"
								data-bs-target="#detailSaleOrderModal"
								data-id="${saleorder.id}" data-code="${saleorder.code}"
								data-customername="${saleorder.customerName}"
								data-total="${saleorder.total}"
								data-orderstatus="${saleorder.orderStatus}"
								data-description="${saleorder.description}">
								<i class="ri-eye-fill"></i>
							</button>  --%>
							<a href="${env}/admin/saleorder/detail/${saleorder.id}" 
   class="btn btn-primary btn-sm text-white" 
   title="Xem chi tiết">
    <i class="ri-eye-fill"></i>
</a>
							<!-- Nút Chỉnh sửa trạng thái -->
							<!-- Trong phần action buttons -->
							<button type="button" class="btn btn-warning btn-sm"
							    title="Chỉnh sửa trạng thái" data-bs-toggle="modal"
							    data-bs-target="#editSaleOrderModal"
							    data-id="${saleorder.id}" 
							    data-code="${saleorder.code}"
							    data-customername="${saleorder.customerName}"
							    data-total="${saleorder.total}"
							    data-orderstatus="${saleorder.orderStatus}"
							    data-description="${saleorder.description}">
							    <i class="ri-pencil-fill"></i>
							</button>
							
							<!-- Nút Xóa (nếu cần) --> 
							<a href="${env }/admin/saleorder/delete/${saleorder.id}"
								class="btn btn-danger btn-sm" title="Xóa"
								onclick="return confirm('Bạn có chắc chắn muốn xóa đơn hàng này không?');">
							<i class="ri-delete-bin-5-fill"></i>
							</a>
						</td>
					</tr>
			      </c:forEach>
              </tbody>
            </table>
            <!-- End Table -->
          </div>
        </div>
      </div>
    </div>
  </section>
		

	</main>
	<!-- End #main -->
	
	
	<%-- <jsp:include page="/WEB-INF/views/administrator/saleorder/saleorder-add.jsp"></jsp:include> --%>
	<%-- <jsp:include page="/WEB-INF/views/administrator/saleorder/saleorder-read.jsp"></jsp:include> --%>
	<jsp:include page="/WEB-INF/views/administrator/saleorder/saleorder-edit.jsp"></jsp:include>
	
	
	<!-- Footer - File -->
	<jsp:include page="/WEB-INF/views/administrator/layout/footer.jsp"></jsp:include>

	<!-- Nút quay trở lại phía trên -->
	<a href="#" class="back-to-top d-flex align-items-center justify-content-center">
		<i class="bi bi-arrow-up-short"></i></a>

	<!-- JS - File -->
	<jsp:include page="/WEB-INF/views/administrator/layout/js.jsp"></jsp:include>
</body>
</html>