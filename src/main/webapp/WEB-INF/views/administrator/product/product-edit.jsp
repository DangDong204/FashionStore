<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Modal sửa sản phẩm -->
<div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="editProductModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg rounded-3">
      <div class="modal-header bg-warning text-black">
        <h5 class="modal-title fw-semibold" id="editProductModalLabel">
          <i class="ri-edit-2-line me-1"></i> Chỉnh sửa sản phẩm
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>

      <form action="${env}/admin/product/edit" method="post" class="row g-3 m-3" enctype="multipart/form-data">
        <!-- ID ẩn -->
        <input type="hidden" name="id" id="edit-id">

        <!-- Tên sản phẩm -->
        <div class="col-md-6">
          <label class="form-label fw-semibold">Tên sản phẩm</label>
          <input type="text" class="form-control" id="edit-name" name="name" required>
        </div>

        <!-- Danh mục -->
        <div class="col-md-6">
          <label class="form-label fw-semibold">Danh mục</label>
          <select class="form-select" id="edit-categoryid" name="categoryId" required>
            <c:forEach var="category" items="${categories }">
              <option value="${category.id }">${category.name }</option>
            </c:forEach>
          </select>
        </div>

        <!-- Giá và giá khuyến mãi -->
        <div class="col-md-6">
          <label class="form-label fw-semibold">Giá gốc</label>
          <input type="number" class="form-control" id="edit-price" name="price" step="0.01" required>
        </div>

        <div class="col-md-6">
          <label class="form-label fw-semibold">Giá khuyến mãi</label>
          <input type="number" class="form-control" id="edit-saleprice" name="salePrice" step="0.01">
        </div>

        <!-- Ảnh đại diện -->
		<div class="col-md-6">
		  <label class="form-label fw-semibold">Ảnh đại diện (avatar)</label>
		  <input type="file" class="form-control" id="edit-avatarfile" name="avatarFile" accept="image/*">
		  <div id="edit-avatar-preview" class="mt-2"></div>
		</div>
		
		<!-- Ảnh phụ -->
		<div class="col-md-6">
		  <label class="form-label fw-semibold">Ảnh phụ (có thể chọn nhiều)</label>
		  <input type="file" class="form-control" id="edit-imagefiles" name="imageFiles" multiple accept="image/*">
		  <small class="text-muted fst-italic">Giữ Ctrl hoặc Shift để chọn nhiều ảnh</small>
		  <div id="edit-preview-images" class="d-flex flex-wrap gap-2 mt-2"></div>
		</div>
		        

        <!-- Số lượng tồn -->
        <div class="col-md-6">
          <label class="form-label fw-semibold">Số lượng tồn</label>
          <input type="number" class="form-control" id="edit-stock" name="stockQuantity" min="0">
        </div>

        <!-- Hot & Trạng thái -->
        <div class="col-md-6">
          <label class="form-label fw-semibold">Sản phẩm nổi bật</label>
          <select class="form-select" id="edit-ishot" name="isHot">
            <option value="true">Hot</option>
            <option value="false">Bình thường</option>
          </select>
        </div>

        <div class="col-md-6">
          <label class="form-label fw-semibold">Trạng thái</label>
          <select class="form-select" id="edit-status" name="status">
            <option value="true">Hoạt động</option>
            <option value="false">Ngừng hoạt động</option>
          </select>
        </div>

        <!-- Người tạo / cập nhật -->
        <div class="col-md-6">
          <label class="form-label fw-semibold">Người tạo</label>
          <input type="text" class="form-control" id="edit-createby" name="createBy" readonly>
        </div>

        <div class="col-md-6">
          <label class="form-label fw-semibold">Ngày tạo</label>
          <input type="text" class="form-control" id="edit-createdate" name="createDate" readonly>
        </div>

        <div class="col-md-6">
          <label class="form-label fw-semibold">Người cập nhật</label>
          <input type="text" class="form-control" id="edit-updateby" name="updateBy">
        </div>

        <div class="col-md-6">
          <label class="form-label fw-semibold">Ngày cập nhật</label>
          <input type="date" class="form-control" id="edit-updatedate" name="updateDate">
        </div>

        <!-- Mô tả -->
        <div class="col-12">
          <label class="form-label fw-semibold">Mô tả ngắn</label>
          <textarea class="form-control" id="edit-shortdesc" name="shortDescription" rows="2"></textarea>
        </div>

        <div class="col-12">
          <label class="form-label fw-semibold">Mô tả chi tiết</label>
          <textarea class="form-control" id="edit-detaildesc" name="detailDescription" rows="3"></textarea>
        </div>

        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">
            <i class="ri-check-line me-1"></i> Lưu thay đổi
          </button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
const editProductModal = document.getElementById('editProductModal');
const avatarInput = document.getElementById('edit-avatarfile');
const avatarPreview = document.getElementById('edit-avatar-preview');
const imageInput = document.getElementById('edit-imagefiles');
const previewContainer = document.getElementById('edit-preview-images');

// =========================
// 🔸 Khi mở modal sửa (gán dữ liệu cũ)
// =========================
editProductModal.addEventListener('show.bs.modal', function (event) {
  const button = event.relatedTarget;

  // --- Gán dữ liệu cơ bản ---
  document.getElementById('edit-id').value = button.getAttribute('data-id');
  document.getElementById('edit-name').value = button.getAttribute('data-name');
  document.getElementById('edit-categoryid').value = button.getAttribute('data-categoryid');
  document.getElementById('edit-price').value = button.getAttribute('data-price');
  document.getElementById('edit-saleprice').value = button.getAttribute('data-saleprice');
  document.getElementById('edit-stock').value = button.getAttribute('data-stock');
  document.getElementById('edit-createby').value = button.getAttribute('data-createby');
  document.getElementById('edit-updateby').value = button.getAttribute('data-updateby');
  document.getElementById('edit-createdate').value = button.getAttribute('data-createdate');
  document.getElementById('edit-updatedate').value = button.getAttribute('data-updatedate');
  document.getElementById('edit-shortdesc').value = button.getAttribute('data-shortdesc') || "";
  document.getElementById('edit-detaildesc').value = button.getAttribute('data-detaildesc') || "";

  // --- Hot / Status ---
  document.getElementById('edit-ishot').value =
    (button.getAttribute('data-ishot') === '1' || button.getAttribute('data-ishot') === 'true') ? 'true' : 'false';
  document.getElementById('edit-status').value =
    (button.getAttribute('data-status') === '1' || button.getAttribute('data-status') === 'true') ? 'true' : 'false';

  // ❌ Không hiển thị ảnh cũ nữa
  avatarPreview.innerHTML = "";
  previewContainer.innerHTML = "";

  // Reset lại input file khi mở modal mới
  avatarInput.value = "";
  imageInput.value = "";
});

// =========================
// 🔸 Khi chọn ảnh mới (xem trước)
// =========================

// Khi chọn avatar mới
avatarInput.addEventListener('change', e => {
  avatarPreview.innerHTML = "";
  const file = e.target.files[0];
  if (file) {
    const reader = new FileReader();
    reader.onload = evt => {
      avatarPreview.innerHTML = `
        <div class="position-relative d-inline-block">
          <img src="${evt.target.result}" class="img-thumbnail" style="max-width:150px;">
        </div>
      `;
    };
    reader.readAsDataURL(file);
  }
});

// Khi chọn nhiều ảnh phụ mới
imageInput.addEventListener('change', e => {
  previewContainer.innerHTML = "";
  Array.from(e.target.files).forEach(file => {
    const reader = new FileReader();
    reader.onload = evt => {
      const img = document.createElement("img");
      img.src = evt.target.result;
      img.className = "img-thumbnail";
      img.style.maxWidth = "100px";
      img.style.margin = "3px";
      previewContainer.appendChild(img);
    };
    reader.readAsDataURL(file);
  });
});
</script>


