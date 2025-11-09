<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- Modal xem chi tiết Voucher -->
<div class="modal fade" id="detailVoucherModal" tabindex="-1" aria-labelledby="detailVoucherModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg rounded-3">
      
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title fw-semibold" id="detailVoucherModalLabel">
          <i class="ri-information-line me-1"></i> Chi tiết Voucher
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>

      <div class="modal-body">
        <form class="row g-3">

          <div class="col-md-6">
            <label class="form-label fw-semibold">Mã voucher</label>
            <input type="text" class="form-control" id="detail-code" readonly>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Loại giảm giá</label>
            <input type="text" class="form-control" id="detail-type" readonly>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Giá trị giảm</label>
            <input type="text" class="form-control" id="detail-value" readonly>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Số lượng</label>
            <input type="text" class="form-control" id="detail-quantity" readonly>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Giá trị đơn hàng tối thiểu</label>
            <input type="text" class="form-control" id="detail-minorder" readonly>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Ngày bắt đầu</label>
            <input type="text" class="form-control" id="detail-startdate" readonly>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Ngày kết thúc</label>
            <input type="text" class="form-control" id="detail-enddate" readonly>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Trạng thái</label>
            <div id="detail-status" class="form-control-plaintext"></div>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Ngày tạo</label>
            <input type="text" class="form-control" id="detail-createdate" readonly>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Ngày cập nhật</label>
            <input type="text" class="form-control" id="detail-updatedate" readonly>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Người tạo</label>
            <input type="text" class="form-control" id="detail-createby" readonly>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Người cập nhật</label>
            <input type="text" class="form-control" id="detail-updateby" readonly>
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
  const detailVoucherModal = document.getElementById('detailVoucherModal');

  detailVoucherModal.addEventListener('show.bs.modal', function (event) {
    const button = event.relatedTarget;

    document.getElementById('detail-code').value = button.getAttribute('data-code');
    document.getElementById('detail-type').value = button.getAttribute('data-type');
    document.getElementById('detail-value').value = button.getAttribute('data-value');
    document.getElementById('detail-quantity').value = button.getAttribute('data-quantity');
    document.getElementById('detail-minorder').value = button.getAttribute('data-minorder');
    document.getElementById('detail-startdate').value = button.getAttribute('data-startdate');
    document.getElementById('detail-enddate').value = button.getAttribute('data-enddate');

    document.getElementById('detail-createby').value = button.getAttribute('data-createby');
    document.getElementById('detail-updateby').value = button.getAttribute('data-updateby');
    document.getElementById('detail-createdate').value = button.getAttribute('data-createdate');
    document.getElementById('detail-updatedate').value = button.getAttribute('data-updatedate');

    const status = button.getAttribute('data-status') === 'true'
      ? '<span class="badge bg-success"><i class="ri-checkbox-circle-line me-1"></i>Hoạt động</span>'
      : '<span class="badge bg-secondary"><i class="ri-close-circle-line me-1"></i>Ngừng hoạt động</span>';

    document.getElementById('detail-status').innerHTML = status;
  });
</script>
