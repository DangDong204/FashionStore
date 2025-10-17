<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Modal xem chi tiết user -->
<div class="modal fade" id="detailUserModal" tabindex="-1" aria-labelledby="detailUserModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg rounded-3">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title fw-semibold" id="detailUserModalLabel">
          <i class="ri-information-line me-1"></i> Chi tiết người dùng
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>

      <div class="modal-body">
        <form class="row g-3">

          <div class="col-md-4 text-center">
            <img id="detail-avatar" src="" alt="Avatar người dùng"
                 class="img-fluid rounded-circle shadow-sm border" style="width: 150px; height: 150px; object-fit: cover;">
          </div>

          <div class="col-md-8">
            <div class="row g-3">
              <div class="col-md-6">
                <label class="form-label fw-semibold">ID</label>
                <input type="text" class="form-control" id="detail-id" readonly>
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Tên đăng nhập</label>
                <input type="text" class="form-control" id="detail-username" readonly>
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Họ tên</label>
                <input type="text" class="form-control" id="detail-name" readonly>
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Email</label>
                <input type="text" class="form-control" id="detail-email" readonly>
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Số điện thoại</label>
                <input type="text" class="form-control" id="detail-mobile" readonly>
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Địa chỉ</label>
                <input type="text" class="form-control" id="detail-address" readonly>
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Người tạo</label>
                <input type="text" class="form-control" id="detail-createby" readonly>
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Ngày tạo</label>
                <input type="text" class="form-control" id="detail-createdate" readonly>
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Người cập nhật</label>
                <input type="text" class="form-control" id="detail-updateby" readonly>
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Ngày cập nhật</label>
                <input type="text" class="form-control" id="detail-updatedate" readonly>
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Trạng thái</label>
                <div id="detail-status" class="form-control-plaintext"></div>
              </div>
              <div class="col-md-6">
				    <label class="form-label fw-semibold">Phân quyền</label>
				    <input type="text" class="form-control" id="detail-roles" readonly>
				</div>
				              
            </div>
          </div>

          <div class="col-12">
            <label class="form-label fw-semibold">Mô tả</label>
            <textarea class="form-control" id="detail-desc" rows="3" readonly></textarea>
          </div>
        </form>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
      </div>
    </div>
  </div>
</div>

<script>
  const userDetailModal = document.getElementById('detailUserModal');
  userDetailModal.addEventListener('show.bs.modal', function (event) {
    const button = event.relatedTarget;

    // Lấy dữ liệu từ data-attribute
    document.getElementById('detail-id').value = button.getAttribute('data-id');
    document.getElementById('detail-username').value = button.getAttribute('data-username');
    document.getElementById('detail-name').value = button.getAttribute('data-name');
    document.getElementById('detail-email').value = button.getAttribute('data-email');
    document.getElementById('detail-mobile').value = button.getAttribute('data-mobile');
    document.getElementById('detail-address').value = button.getAttribute('data-address');
    document.getElementById('detail-createby').value = button.getAttribute('data-createby') || '(Chưa xác định)';
    document.getElementById('detail-updateby').value = button.getAttribute('data-updateby') || '(Chưa cập nhật)';
    document.getElementById('detail-createdate').value = button.getAttribute('data-createdate') || '';
    document.getElementById('detail-updatedate').value = button.getAttribute('data-updatedate') || '';
    document.getElementById('detail-desc').value = button.getAttribute('data-desc') || '(Không có mô tả)';
	
 	// Ảnh đại diện
    const avatar = button.getAttribute('data-avatar');
    const avatarElement = document.getElementById('detail-avatar');
    avatarElement.src = avatar && avatar.trim() !== '' 
      ? avatar 
      : '${env}/administrator/img/product-1.jpg';


    // Trạng thái
    const statusValue = button.getAttribute('data-status');
    const statusHtml = (statusValue === '1' || statusValue === 'true')
      ? '<span class="badge bg-success"><i class="ri-checkbox-circle-line me-1"></i>Hoạt động</span>'
      : '<span class="badge bg-secondary"><i class="ri-close-circle-line me-1"></i>Ngừng hoạt động</span>';
    document.getElementById('detail-status').innerHTML = statusHtml;
    
    const roles = button.getAttribute('data-roles') || '(Chưa có)';
    document.getElementById('detail-roles').value = roles;

  });
</script>

    