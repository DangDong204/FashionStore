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
			<h1>Category</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="${env }/admin/home">Home</a></li>
					<li class="breadcrumb-item active">Category</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->
		
		<section class="section">
    <div class="row">
      <div class="col-lg-12">

        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Danh sách danh mục</h5>

            <div class="text-end mb-3">
              <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                <i class="ri-add-circle-fill"></i> Thêm mới
              </button>
            </div>

            <!-- Bảng hiển thị danh mục -->
            <table class="table table-striped table-hover table-bordered align-middle datatable">
              <thead class="table-light text-center">
                <tr>
                  <!-- <th scope="col">No</th> -->
                  <th scope="col">Id</th>
                  <th scope="col">Name</th>
                  <th scope="col">Create By</th>
                  <th scope="col">Update By</th>
                  <th scope="col">Create Date</th>
                  <th scope="col">Update Date</th>
                  <th scope="col">Status</th>
                  <th scope="col">Action</th>
                </tr>
              </thead>
              <tbody class="text-center">
         		<c:forEach var="category" items="${categories }" varStatus="loop">
			        <tr>
			          <%-- <td>${loop.index + 1}</td> --%>
			          <td>${category.id }</td>
			          <td>${category.name }</td>
			          <td>${category.createBy }</td>
			          <td>${category.updateBy }</td>
			          <td class="text-center">
			            <fmt:formatDate value="${category.createDate }" pattern="dd-MM-yyyy"/>
			          </td>
			          <td class="text-center">
			            <fmt:formatDate value="${category.updateDate }" pattern="dd-MM-yyyy"/>
			          </td>
			          <td class="text-center">
                   		<c:choose>
                   			<c:when test="${category.status }">
          						<i class="bi bi-check-circle-fill text-success" title="Active"></i>
                   			</c:when>
                   			<c:otherwise>
          						<i class="bi bi-x-circle-fill text-danger" title="Inactive"></i>
                   			</c:otherwise>
                   		</c:choose>
                      </td>
                      
			          <td>
			          	<button type="button"
						        class="btn btn-primary btn-sm text-white"
						        title="Xem chi tiết"
						        data-bs-toggle="modal"
						        data-bs-target="#detailCategoryModal"
						        data-id="${category.id}"
						        data-name="${category.name}"
						        data-createby="${category.createBy}"
						        data-updateby="${category.updateBy}"
						        data-createdate="<fmt:formatDate value='${category.createDate}' pattern='dd-MM-yyyy'/>"
						        data-updatedate="<fmt:formatDate value='${category.updateDate}' pattern='dd-MM-yyyy'/>"
						        data-status="${category.status}"
						        data-desc="${category.description}">
						  <i class="ri-eye-fill"></i>
						</button>
			          	
			            <button type="button" 
						        class="btn btn-warning btn-sm" 
						        title="Chỉnh sửa"
						        data-bs-toggle="modal" 
						        data-bs-target="#editCategoryModal"
						        data-id="${category.id}"
						        data-name="${category.name}"
						        data-createby="${category.createBy}"
						        data-updateby="${category.updateBy}"
						        data-createdate="<fmt:formatDate value='${category.createDate}' pattern='yyyy-MM-dd'/>"
						        data-updatedate="<fmt:formatDate value='${category.updateDate}' pattern='yyyy-MM-dd'/>"
						        data-status="${category.status}"
						        data-desc="${category.description}">
						  <i class="ri-pencil-fill"></i>
						</button>


			            <a href="${env }/admin/category/delete/${category.id}"
						   class="btn btn-danger btn-sm"
						   title="Xóa"
						   onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này không?');">
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
	
	<jsp:include page="/WEB-INF/views/administrator/category/category-read.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/administrator/category/category-add.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/administrator/category/category-edit.jsp"></jsp:include>
	
	
	
	<!-- Footer - File -->
	<jsp:include page="/WEB-INF/views/administrator/layout/footer.jsp"></jsp:include>

	<!-- Nút quay trở lại phía trên -->
	<a href="#" class="back-to-top d-flex align-items-center justify-content-center">
		<i class="bi bi-arrow-up-short"></i></a>

	<!-- JS - File -->
	<jsp:include page="/WEB-INF/views/administrator/layout/js.jsp"></jsp:include>
</body>
</html>