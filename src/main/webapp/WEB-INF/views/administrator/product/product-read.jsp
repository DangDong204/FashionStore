<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Modal xem chi tiết danh mục -->
<div class="modal fade" id="detailProductModal" tabindex="-1" aria-labelledby="detailProductModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg rounded-3">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title fw-semibold" id="detailProductModalLabel">
          <i class="ri-information-line me-1"></i> Chi tiết sản phẩm
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>

      <div class="modal-body">
        <form class="row g-3">
          <div class="col-md-6">
            <label class="form-label fw-semibold">Mã danh mục</label>
            <input type="text" class="form-control" id="detail-id" readonly>
          </div>
          <div class="col-md-6">
            <label class="form-label fw-semibold">Tên danh mục</label>
            <input type="text" class="form-control" id="detail-name" readonly>
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
  const detailModal = document.getElementById('detailProductModal');
  detailModal.addEventListener('show.bs.modal', function (event) {
    const button = event.relatedTarget;

    document.getElementById('detail-id').value = button.getAttribute('data-id');
    document.getElementById('detail-name').value = button.getAttribute('data-name');
    document.getElementById('detail-createby').value = button.getAttribute('data-createby');
    document.getElementById('detail-updateby').value = button.getAttribute('data-updateby');
    document.getElementById('detail-createdate').value = button.getAttribute('data-createdate');
    document.getElementById('detail-updatedate').value = button.getAttribute('data-updatedate');
    document.getElementById('detail-desc').value = button.getAttribute('data-desc') || "(Không có mô tả)";

    const status = button.getAttribute('data-status') === 'true'
      ? '<span class="badge bg-success"><i class="ri-checkbox-circle-line me-1"></i>Hoạt động</span>'
      : '<span class="badge bg-secondary"><i class="ri-close-circle-line me-1"></i>Ngừng hoạt động</span>';
    document.getElementById('detail-status').innerHTML = status;
  });
</script>
    