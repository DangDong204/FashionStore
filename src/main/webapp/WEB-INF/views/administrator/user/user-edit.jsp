<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- Modal sửa user -->
<div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg rounded-3">
      <div class="modal-header bg-warning text-white">
        <h5 class="modal-title fw-semibold" id="editUserModalLabel">
          <i class="ri-edit-2-line me-1"></i> Sửa người dùng
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>

      <form action="${env}/admin/user/edit" method="post" id="editUserForm" enctype="multipart/form-data" >
        <div class="modal-body row g-3">

          <div class="col-md-4 text-center">
            <img id="edit-avatar-preview" src="" alt="Avatar người dùng"
                 class="img-fluid rounded-circle shadow-sm border mb-2"
                 style="width: 150px; height: 150px; object-fit: cover;">
            <input type="file" class="form-control form-control-sm" name="avatarFile" accept="image/*">
          </div>

          <div class="col-md-8">
            <input type="hidden" name="id" id="edit-id">
            <div class="row g-3">
              <div class="col-md-6">
                <label class="form-label fw-semibold">Tên đăng nhập</label>
                <input type="text" class="form-control" name="username" id="edit-username" required>
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Họ tên</label>
                <input type="text" class="form-control" name="name" id="edit-name">
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Email</label>
                <input type="email" class="form-control" name="email" id="edit-email">
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Số điện thoại</label>
                <input type="text" class="form-control" name="mobile" id="edit-mobile">
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Địa chỉ</label>
                <input type="text" class="form-control" name="address" id="edit-address">
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Trạng thái</label>
                <select class="form-select" name="status" id="edit-status">
                  <option value="1">Hoạt động</option>
                  <option value="0">Ngừng hoạt động</option>
                </select>
              </div>
              
              <!-- Thêm phần phân quyền -->
			<div class="col-12 mt-3">
			    <label class="form-label fw-semibold">Phân quyền</label>
			    <div id="edit-roles" class="d-flex flex-wrap gap-2">
			        <c:forEach var="role" items="${roles}">
			            <div class="form-check">
			                <input class="form-check-input role-checkbox" type="checkbox"
			                       name="roleIds" value="${role.id}" id="role-${role.id}">
			                <label class="form-check-label" for="role-${role.id}">${role.name}</label>
			            </div>
			        </c:forEach>
			    </div>
			</div>
			              
            </div>
          </div>

          <div class="col-12">
            <label class="form-label fw-semibold">Mô tả</label>
            <textarea class="form-control" name="description" id="edit-desc" rows="3"></textarea>
          </div>
        </div>

        <div class="modal-footer">
          <button type="submit" class="btn btn-warning">Lưu thay đổi</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>

	const editUserModal = document.getElementById('editUserModal');
	editUserModal.addEventListener('show.bs.modal', function(event) {
		const button = event.relatedTarget;

		document.getElementById('edit-id').value = button
				.getAttribute('data-id');
		document.getElementById('edit-username').value = button
				.getAttribute('data-username');
		document.getElementById('edit-name').value = button
				.getAttribute('data-name');
		document.getElementById('edit-email').value = button
				.getAttribute('data-email');
		document.getElementById('edit-mobile').value = button
				.getAttribute('data-mobile');
		document.getElementById('edit-address').value = button
				.getAttribute('data-address');
		document.getElementById('edit-desc').value = button
				.getAttribute('data-desc')
				|| '';
		document.getElementById('edit-status').value = button
				.getAttribute('data-status');

		const avatar = button.getAttribute('data-avatar');
		const avatarPreview = document.getElementById('edit-avatar-preview');
		avatarPreview.src = avatar && avatar.trim() !== '' ? avatar
				: '${env}/administrator/img/product-1.jpgg';
		
		const roleIds = (button.getAttribute('data-roleIds') || '').split(','); // ví dụ: "1,3"
	    document.querySelectorAll('.role-checkbox').forEach(cb => {
	        cb.checked = roleIds.includes(cb.value);
	    });
	});
</script>