<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>SWE - Admin</title>
	<meta content="" name="description">
	<meta content="" name="keywords">
	
	<jsp:include page="/WEB-INF/views/administrator/layout/css.jsp"></jsp:include>
</head>

<body>
	<jsp:include page="/WEB-INF/views/administrator/layout/header.jsp"></jsp:include>

  	<jsp:include page="/WEB-INF/views/administrator/layout/left-sidebar.jsp"></jsp:include>
  	
  	<main id="main" class="main">

		<div class="pagetitle">
			<h1>Product</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="${env }/admin/home">Home</a></li>
					<li class="breadcrumb-item active">Product</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->

		<section class="section">
			<div class="row">
				<div class="col-lg-12">

					<div class="card">
						<div class="card-body">
							<h5 class="card-title">Danh sách sản phẩm</h5>

							<div class="text-end mb-3">
								<button type="button" class="btn btn-success"
									data-bs-toggle="modal" data-bs-target="#addProductModal">
									<i class="ri-add-circle-fill"></i> Thêm mới
								</button>
							</div>
							
							<!-- Bảng hiển thị sản phẩm -->
							<table class="table table-striped table-hover table-bordered 
											align-middle datatable text-center">
							  <thead class="table-light text-center">
							    <tr>
							      <th scope="col">Id</th>
							      <th scope="col">Tên sản phẩm</th>
							      <th scope="col">Hình ảnh</th>
							      <th scope="col">Giá</th>
							      <th scope="col">Giá khuyến mãi</th>
							      <th scope="col">Hot</th>
							      <th scope="col">Tồn kho</th>
							      <th scope="col">Chức năng</th>
							    </tr>
							  </thead>
							
							  <tbody class="text-center">
							    <c:forEach var="product" items="${products}">
							      <tr>
							        <td>${product.id}</td>
							        <td>${product.name}</td>
							        <td>
									  <c:choose>
									    <c:when test="${not empty product.avatar}">
									      <img src="${env }/${product.avatar}"
									           alt="${product.name}"
									           class="img-thumbnail"
									           style="width: 70px; height: 70px; object-fit: cover;">
									    </c:when>
									    <c:otherwise>
									      <img src="${env }/images/no-image.png"
									           alt="No Image"
									           class="img-thumbnail"
									           style="width: 70px; height: 70px; object-fit: cover;">
									    </c:otherwise>
									  </c:choose>
									</td>

							        <td><fmt:formatNumber value="${product.price}" type="number" minFractionDigits="0"/> ₫</td>
							        <td><fmt:formatNumber value="${product.salePrice}" type="number" minFractionDigits="0"/> ₫</td>
							        
							        <td>
							          <c:choose>
							            <c:when test="${product.isHot}">
							              <i class="bi bi-fire text-danger fs-5" title="Hot product"></i>
							            </c:when>
							            <c:otherwise>
							              <i class="bi bi-fire text-muted fs-5" title="Normal product"></i>
							            </c:otherwise>
							          </c:choose>
							        </td>
							
							        <td>${product.stockQuantity}</td>
									
							        <td>
							          <!-- Xem chi tiết --> 
							          	<c:set var="imagePaths" value="" />
										<c:forEach var="img" items="${product.productImages}" varStatus="s">
										  <c:set var="imagePaths"
										         value="${imagePaths}${env }/${img.path}${!s.last ? ';' : ''}" />
										</c:forEach>
									<button type="button"
									        class="btn btn-primary btn-sm text-white"
									        title="Xem chi tiết"
									        data-bs-toggle="modal"
									        data-bs-target="#detailProductModal"
									        data-id="${product.id}"
									        data-name="${product.name}"
									        data-category="${product.category.name}"
									        data-avatar="${env }/${product.avatar}"
									        data-images="${imagePaths}"
									        

									        data-price="${product.price}"
									        data-saleprice="${product.salePrice}"
									        data-ishot="${product.isHot}"
									        data-stock="${product.stockQuantity}"
									        data-createby="${product.createBy}"
									        data-updateby="${product.updateBy}"
									        data-createdate="<fmt:formatDate value='${product.createDate}' pattern='dd-MM-yyyy'/>"
									        data-updatedate="<fmt:formatDate value='${product.updateDate}' pattern='dd-MM-yyyy'/>"
									        data-status="${product.status}"
									        data-shortdesc="${product.shortDescription}"
									        data-detaildesc="${product.detailDescription}">
									  <i class="ri-eye-fill"></i>
									</button> 
									
									<!-- Chỉnh sửa -->
									<button type="button" class="btn btn-warning btn-sm"
										title="Chỉnh sửa" data-bs-toggle="modal"
										data-bs-target="#editProductModal" 
										data-id="${product.id}"
										data-name="${product.name}"
										data-categoryid="${product.category.id}"
										data-price="${product.price}"
										data-saleprice="${product.salePrice}"
										data-avatar="${product.avatar}"
										data-ishot="${product.isHot}"
										data-stock="${product.stockQuantity}"
										data-createby="${product.createBy}"
										data-updateby="${product.updateBy}"
										data-createdate="<fmt:formatDate value='${product.createDate}' pattern='yyyy-MM-dd'/>"
										data-updatedate="<fmt:formatDate value='${product.updateDate}' pattern='yyyy-MM-dd'/>"
										data-status="${product.status}"
										data-shortdesc="${product.shortDescription}"
										data-detaildesc="${product.detailDescription}">
										<i class="ri-pencil-fill"></i>
									</button> 
									
									<!-- Xóa -->
							          <a href="${env}/admin/product/delete/${product.id}"
							             class="btn btn-danger btn-sm"
							             title="Xóa"
							             onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này không?');">
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
	
	<jsp:include page="/WEB-INF/views/administrator/product/product-read.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/administrator/product/product-add.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/administrator/product/product-edit.jsp"></jsp:include>
	
	<!-- Footer - File -->
	<jsp:include page="/WEB-INF/views/administrator/layout/footer.jsp"></jsp:include>

	<!-- Nút quay trở lại phía trên -->
	<a href="#" class="back-to-top d-flex align-items-center justify-content-center">
		<i class="bi bi-arrow-up-short"></i></a>

	<!-- JS - File -->
	<jsp:include page="/WEB-INF/views/administrator/layout/js.jsp"></jsp:include>
</body>
</html>