<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Modal thêm user -->
<div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg rounded-3">
      <div class="modal-header bg-success text-white">
        <h5 class="modal-title fw-semibold" id="addUserModalLabel">
          <i class="ri-add-circle-line me-1"></i> Thêm người dùng
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>

      <form action="${env}/admin/user/add" method="post" enctype="multipart/form-data">
        <div class="modal-body">
          <div class="row g-3">

            <!-- Avatar -->
            <div class="col-md-4 text-center">
              <img id="add-avatar-preview" src="https://via.placeholder.com/150" 
                   class="img-fluid rounded-circle shadow-sm border mb-2" 
                   style="width: 150px; height: 150px; object-fit: cover;">
              <input type="file" class="form-control" name="avatarFile" accept="image/*">
            </div>

            <div class="col-md-8">
              <div class="row g-3">
                <div class="col-md-6">
                  <label class="form-label fw-semibold">Tên đăng nhập</label>
                  <input type="text" class="form-control" name="username" required>
                </div>

                <div class="col-md-6">
                  <label class="form-label fw-semibold">Mật khẩu</label>
                  <input type="password" class="form-control" name="password" required>
                </div>

                <div class="col-md-6">
                  <label class="form-label fw-semibold">Họ tên</label>
                  <input type="text" class="form-control" name="name" required>
                </div>

                <div class="col-md-6">
                  <label class="form-label fw-semibold">Email</label>
                  <input type="email" class="form-control" name="email">
                </div>

                <div class="col-md-6">
                  <label class="form-label fw-semibold">Số điện thoại</label>
                  <input type="text" class="form-control" name="mobile">
                </div>

                <div class="col-md-6">
                  <label class="form-label fw-semibold">Địa chỉ</label>
                  <input type="text" class="form-control" name="address">
                </div>

                <div class="col-md-6">
                  <label class="form-label fw-semibold">Trạng thái</label>
                  <select class="form-select" name="status">
                    <option value="true" selected>Hoạt động</option>
                    <option value="false">Ngừng hoạt động</option>
                  </select>
                </div>
              </div>
            </div>

            <div class="col-12">
              <label class="form-label fw-semibold">Mô tả</label>
              <textarea class="form-control" name="description" rows="3"></textarea>
            </div>
          </div>
        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
          <button type="submit" class="btn btn-success text-white">
            <i class="ri-save-3-line me-1"></i> Lưu người dùng
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- JS - Xem trước ảnh -->
<script>
document.addEventListener("DOMContentLoaded", () => {
  const avatarInput = document.querySelector("input[name='avatarFile']");
  const previewImg = document.getElementById("add-avatar-preview");

  avatarInput.addEventListener("change", e => {
    const file = e.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = evt => {
        previewImg.src = evt.target.result;
      };
      reader.readAsDataURL(file);
    }
  });

  // Xoá preview khi đóng modal
  const modal = document.getElementById("addUserModal");
  modal.addEventListener("hidden.bs.modal", () => {
    avatarInput.value = "";
    previewImg.src = "https://via.placeholder.com/150";
  });
});
</script>

<!-- JS - Xử lý mật khẩu mạnh -->
<script>
document.addEventListener("DOMContentLoaded", () => {

  const form = document.querySelector("#addUserModal form");
  const passwordInput = form.querySelector("input[name='password']");

  form.addEventListener("submit", function(event) {
    const password = passwordInput.value;
    let hasError = false;

    // Yêu cầu mật khẩu mạnh
    const regex = {
      length: /.{8,}/,
      upper: /[A-Z]/,
      lower: /[a-z]/,
      number: /[0-9]/,
      special: /[!@#$%^&*(),.?":{}|<>]/,
    };

    if (!regex.length.test(password)) {
      showError(passwordInput, "Mật khẩu phải có ít nhất 8 ký tự.");
      hasError = true;
    } else if (!regex.upper.test(password)) {
      showError(passwordInput, "Mật khẩu phải chứa ít nhất 1 chữ hoa.");
      hasError = true;
    } else if (!regex.lower.test(password)) {
      showError(passwordInput, "Mật khẩu phải chứa ít nhất 1 chữ thường.");
      hasError = true;
    } else if (!regex.number.test(password)) {
      showError(passwordInput, "Mật khẩu phải chứa ít nhất 1 chữ số.");
      hasError = true;
    } else if (!regex.special.test(password)) {
      showError(passwordInput, "Mật khẩu phải chứa ít nhất 1 ký tự đặc biệt.");
      hasError = true;
    } else {
      removeError(passwordInput);
    }

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

  function removeError(input) {
    input.classList.remove("is-invalid");
  }

});
</script>
