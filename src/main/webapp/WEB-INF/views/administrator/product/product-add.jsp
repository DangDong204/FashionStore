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

      <form id="addProductForm" action="${env}/admin/product/add" method="post" enctype="multipart/form-data">
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
            
         	<!-- Ảnh sản phẩm (Server - Trong Folder UploadFiles -->
			<div class="col-md-6">
				<label class="form-label fw-semibold">Ảnh đại diện(avatar)</label> 
				<input type="file" class="form-control"
					name="avatarFile" accept="image/*" required>
			</div>
			
			<div class="col-md-6">
			  <label class="form-label fw-semibold">Ảnh phụ (có thể chọn nhiều)</label>
			  <input type="file" class="form-control" name="imageFiles" multiple accept="image/*">
			  <small class="text-muted fst-italic">Giữ Ctrl hoặc Shift để chọn nhiều ảnh</small>
			  <!-- Nơi hiển thị preview -->
			  <div id="preview-images" class="d-flex flex-wrap gap-2 mt-2"></div>
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

<script>
document.addEventListener("DOMContentLoaded", () => {
  // ==== XEM TRƯỚC ẢNH ĐẠI DIỆN ====
  const avatarInput = document.querySelector("input[name='avatarFile']");
  avatarInput.addEventListener("change", e => {
    const file = e.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = evt => {
        const oldPreview = avatarInput.parentNode.querySelector(".img-preview-wrapper");
        if (oldPreview) oldPreview.remove();

        // Tạo vùng preview
        const wrapper = document.createElement("div");
        wrapper.className = "img-preview-wrapper position-relative d-inline-block mt-2";

        const preview = document.createElement("img");
        preview.src = evt.target.result;
        preview.className = "img-thumbnail";
        preview.style.maxWidth = "150px";

        // Nút xóa ảnh đại diện
        const removeBtn = document.createElement("button");
        removeBtn.type = "button";
        removeBtn.innerHTML = "&times;";
        removeBtn.className = "btn btn-sm btn-danger position-absolute top-0 end-0 m-1 rounded-circle";
        removeBtn.style.lineHeight = "1";
        removeBtn.addEventListener("click", () => {
          wrapper.remove();
          avatarInput.value = "";
        });

        wrapper.appendChild(preview);
        wrapper.appendChild(removeBtn);
        avatarInput.parentNode.appendChild(wrapper);
      };
      reader.readAsDataURL(file);
    }
  });

  // ==== XEM TRƯỚC ẢNH PHỤ ====
  const imageFilesInput = document.querySelector("input[name='imageFiles']");
  const previewContainer = document.getElementById("preview-images");

  imageFilesInput.addEventListener("change", e => {
    previewContainer.innerHTML = ""; // xoá cũ
    const files = Array.from(e.target.files);

    files.forEach((file, index) => {
      const reader = new FileReader();
      reader.onload = evt => {
        const wrapper = document.createElement("div");
        wrapper.className = "position-relative d-inline-block";
        wrapper.style.margin = "5px";

        const img = document.createElement("img");
        img.src = evt.target.result;
        img.className = "img-thumbnail";
        img.style.maxWidth = "100px";
        img.style.height = "auto";
        img.style.objectFit = "cover";

        // Nút xóa ảnh phụ
        const removeBtn = document.createElement("button");
        removeBtn.type = "button";
        removeBtn.innerHTML = "&times;";
        removeBtn.className = "btn btn-sm btn-danger position-absolute top-0 end-0 m-1 rounded-circle";
        removeBtn.style.lineHeight = "1";
        removeBtn.addEventListener("click", () => {
          wrapper.remove();
        });

        wrapper.appendChild(img);
        wrapper.appendChild(removeBtn);
        previewContainer.appendChild(wrapper);
      };
      reader.readAsDataURL(file);
    });
  });

  // ==== XOÁ ẢNH KHI ĐÓNG MODAL ====
  const modal = document.getElementById("addProductModal");
  modal.addEventListener("hidden.bs.modal", () => {
    previewContainer.innerHTML = "";
    const oldAvatar = avatarInput.parentNode.querySelector(".img-preview-wrapper");
    if (oldAvatar) oldAvatar.remove();
    avatarInput.value = "";
    imageFilesInput.value = "";
  });
});
</script>


<!-- <script>
document.addEventListener("DOMContentLoaded", () => {

  // ... các đoạn code preview ảnh của bạn ...

  // === VALIDATION SỐ LƯỢNG > 0 ===
  const formAdd = document.getElementById("addProductForm");
  const stockInput = formAdd.querySelector("input[name='stockQuantity']");

  formAdd.addEventListener("submit", function(event) {
    const value = Number(stockInput.value);

    if (isNaN(value) || value <= 0) {
      event.preventDefault();   // chặn submit
      stockInput.classList.add("is-invalid");

      // Nếu chưa có thông báo lỗi thì tạo
      let error = stockInput.parentNode.querySelector(".invalid-feedback");
      if (!error) {
        error = document.createElement("div");
        error.className = "invalid-feedback";
        error.innerText = "Số lượng phải lớn hơn 0.";
        stockInput.parentNode.appendChild(error);
      }

      // Focus lại vào ô nhập
      stockInput.focus();
    } else {
      // Nếu hợp lệ thì xoá trạng thái lỗi (nếu có)
      stockInput.classList.remove("is-invalid");
    }
  });

});
</script> -->
<script>
document.addEventListener("DOMContentLoaded", () => {

  const formAdd = document.getElementById("addProductForm");
  const stockInput = formAdd.querySelector("input[name='stockQuantity']");
  const priceInput = formAdd.querySelector("input[name='price']");
  const salePriceInput = formAdd.querySelector("input[name='salePrice']");

  formAdd.addEventListener("submit", function(event) {
    let hasError = false;

    // === KIỂM TRA SỐ LƯỢNG > 0 ===
    const stock = Number(stockInput.value);
    if (isNaN(stock) || stock <= 0) {
      showError(stockInput, "Số lượng phải lớn hơn 0.");
      hasError = true;
    } else removeError(stockInput);

    // === KIỂM TRA GIÁ BÁN < GIÁ GỐC ===
    const price = Number(priceInput.value);
    const salePrice = Number(salePriceInput.value);

    if (salePrice > 0 && salePrice >= price) {
      showError(salePriceInput, "Giá bán phải nhỏ hơn giá gốc.");
      hasError = true;
    } else removeError(salePriceInput);

    // Nếu có lỗi thì chặn submit
    if (hasError) event.preventDefault();
  });

  // Hàm hiển thị lỗi Bootstrap
  function showError(input, message) {
    input.classList.add("is-invalid");
    let error = input.parentNode.querySelector(".invalid-feedback");
    if (!error) {
      error = document.createElement("div");
      error.className = "invalid-feedback";
      input.parentNode.appendChild(error);
    }
    error.innerText = message;
  }

  // Hàm xoá lỗi
  function removeError(input) {
    input.classList.remove("is-invalid");
  }

});
</script>

