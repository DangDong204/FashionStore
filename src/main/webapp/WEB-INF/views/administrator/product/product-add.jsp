<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Modal thêm sản phẩm -->
<div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModal" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg rounded-3">
      <div class="modal-header bg-success text-white">
        <h5 class="modal-title fw-semibold" id="addProductModalLabel">
          <i class="ri-add-circle-line me-1"></i> Thêm sản phẩm
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>

      <form action="${env}/admin/product/add" method="post">
        <div class="modal-body">
          <div class="row g-3">

            <!-- Tên sản phẩm -->
            <div class="col-md-6">
              <label class="form-label fw-semibold">Tên sản phẩm</label>
              <input type="text" class="form-control" name="name" required placeholder="Nhập tên sản phẩm">
            </div>

            <!-- Danh mục -->
            <div class="col-md-6">
              <label class="form-label fw-semibold">Danh mục</label>
              <select class="form-select" name="categoryId" required>
                <option value="">-- Chọn danh mục --</option>
                <c:forEach var="cate" items="${categories}">
                  <option value="${cate.id}">${cate.name}</option>
                </c:forEach>
              </select>
            </div>

            <!-- Link ảnh (URL) -->
            <div class="col-md-6">
              <label class="form-label fw-semibold">Ảnh sản phẩm (URL)</label>
              <input type="text" class="form-control" name="avatar" placeholder="Dán link ảnh vào đây">
            </div>

            <!-- Giá -->
            <div class="col-md-3">
              <label class="form-label fw-semibold">Giá gốc</label>
              <input type="number" class="form-control" name="price" step="0.01" min="0" required>
            </div>

            <!-- Giá khuyến mãi -->
            <div class="col-md-3">
              <label class="form-label fw-semibold">Giá bán</label>
              <input type="number" class="form-control" name="salePrice" step="0.01" min="0">
            </div>

            <!-- Số lượng tồn -->
            <div class="col-md-3">
              <label class="form-label fw-semibold">Số lượng</label>
              <input type="number" class="form-control" name="stockQuantity" min="0" required>
            </div>

            <!-- Sản phẩm nổi bật -->
            <div class="col-md-3">
              <label class="form-label fw-semibold">Nổi bật</label>
              <select class="form-select" name="isHot">
                <option value="false" selected>Không</option>
                <option value="true">Có</option>
              </select>
            </div>

            <!-- Mô tả ngắn -->
            <div class="col-12">
              <label class="form-label fw-semibold">Mô tả ngắn</label>
              <textarea class="form-control" name="shortDescription" rows="2" placeholder="Nhập mô tả ngắn"></textarea>
            </div>

            <!-- Mô tả chi tiết -->
            <div class="col-12">
              <label class="form-label fw-semibold">Mô tả chi tiết</label>
              <textarea class="form-control" name="detailDescription" rows="3" placeholder="Nhập mô tả chi tiết"></textarea>
            </div>

            <!-- Trạng thái -->
            <div class="col-md-6">
              <label class="form-label fw-semibold">Trạng thái</label>
              <select class="form-select" name="status">
                <option value="true" selected>Hoạt động</option>
                <option value="false">Ngừng hoạt động</option>
              </select>
            </div>

          </div>
        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
          <button type="submit" class="btn btn-success text-white">
            <i class="ri-save-3-line me-1"></i> Lưu sản phẩm
          </button>
        </div>
      </form>
    </div>
  </div>
</div>
