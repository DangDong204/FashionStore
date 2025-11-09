<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- Modal chỉnh sửa Voucher -->
<div class="modal fade" id="editVoucherModal" tabindex="-1" aria-labelledby="editVoucherModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg rounded-3">
      
      <div class="modal-header bg-warning text-dark">
        <h5 class="modal-title fw-semibold" id="editVoucherModalLabel">
          <i class="ri-pencil-fill me-1"></i> Chỉnh sửa Voucher
        </h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>

      <form action="${env}/admin/voucher/edit" method="post" class="modal-body row g-3">

        <!-- CODE -->
        <div class="col-md-6">
          <label class="form-label fw-semibold">Mã voucher</label>
          <input type="text" class="form-control" id="edit-code" name="code" readonly>
        </div>

        <!-- DISCOUNT TYPE -->
        <div class="col-md-6">
          <label class="form-label fw-semibold">Loại giảm giá</label>
          <select class="form-select" id="edit-type" name="discountType">
            <option value="PERCENT">Giảm theo %</option>
            <option value="AMOUNT">Giảm theo số tiền</option>
          </select>
        </div>

        <!-- VALUE -->
        <div class="col-md-6">
          <label class="form-label fw-semibold">Giá trị giảm</label>
          <input type="number" class="form-control" id="edit-value" name="discountValue" required>
        </div>

        <!-- QUANTITY -->
        <div class="col-md-6">
          <label class="form-label fw-semibold">Số lượng</label>
          <input type="number" class="form-control" id="edit-quantity" name="quantity" required>
        </div>

        <!-- MIN ORDER -->
        <div class="col-md-6">
          <label class="form-label fw-semibold">Giá trị đơn hàng tối thiểu</label>
          <input type="number" class="form-control" id="edit-minorder" name="minOrderValue">
        </div>

        <!-- DATE START -->
        <div class="col-md-6">
          <label class="form-label fw-semibold">Ngày bắt đầu</label>
          <input type="date" class="form-control" id="edit-startdate" name="startDate">
        </div>

        <!-- DATE END -->
        <div class="col-md-6">
          <label class="form-label fw-semibold">Ngày kết thúc</label>
          <input type="date" class="form-control" id="edit-enddate" name="endDate">
        </div>

        <!-- STATUS -->
        <div class="col-md-6">
          <label class="form-label fw-semibold">Trạng thái</label>
          <select class="form-select" id="edit-status" name="status">
            <option value="true">Hoạt động</option>
            <option value="false">Ngừng hoạt động</option>
          </select>
        </div>

        <input type="hidden" id="edit-id" name="id">

        <div class="modal-footer mt-4">
          <button type="submit" class="btn btn-warning text-dark">
            Lưu thay đổi
          </button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
            Hủy
          </button>
        </div>

      </form>

    </div>
  </div>
</div>

<script>
  const editVoucherModal = document.getElementById('editVoucherModal');

  editVoucherModal.addEventListener('show.bs.modal', function (event) {
    const button = event.relatedTarget;

    document.getElementById('edit-id').value = button.getAttribute('data-id');
    document.getElementById('edit-code').value = button.getAttribute('data-code');
    document.getElementById('edit-type').value = button.getAttribute('data-type');
    document.getElementById('edit-value').value = button.getAttribute('data-value');
    document.getElementById('edit-quantity').value = button.getAttribute('data-quantity');
    document.getElementById('edit-minorder').value = button.getAttribute('data-minorder');
    document.getElementById('edit-startdate').value = button.getAttribute('data-startdate');
    document.getElementById('edit-enddate').value = button.getAttribute('data-enddate');


    document.getElementById('edit-status').value = button.getAttribute('data-status');
  });
</script>
