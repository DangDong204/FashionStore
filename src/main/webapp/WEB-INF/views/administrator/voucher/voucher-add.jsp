<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- Modal thêm mới Voucher -->
<div class="modal fade" id="addVoucherModal" tabindex="-1" aria-labelledby="addVoucherModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg rounded-3">

      <div class="modal-header bg-success text-white">
        <h5 class="modal-title fw-semibold" id="addVoucherModalLabel">
          <i class="ri-add-circle-line me-1"></i> Thêm mới Voucher
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>

      <form action="${env}/admin/voucher/add" method="post" class="modal-body">
        <div class="row g-3">

          <div class="col-md-6">
            <label class="form-label fw-semibold">Mã voucher</label>
            <input type="text" name="code" class="form-control" required>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Loại giảm giá</label>
            <select name="discountType" class="form-select" required>
              <option value="PERCENT">Giảm theo %</option>
              <option value="AMOUNT">Giảm theo số tiền</option>
            </select>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Giá trị giảm</label>
            <input type="number" name="discountValue" class="form-control" required>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Số lượng</label>
            <input type="number" name="quantity" class="form-control" min="1" required>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Giá trị đơn hàng tối thiểu</label>
            <input type="number" name="minOrderValue" class="form-control" min="0" required>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Ngày bắt đầu</label>
            <input type="date" name="startDate" class="form-control" required>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Ngày kết thúc</label>
            <input type="date" name="endDate" class="form-control" required>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Trạng thái</label>
            <select name="status" class="form-select">
              <option value="true">Hoạt động</option>
              <option value="false">Không hoạt động</option>
            </select>
          </div>

        </div>

        <div class="modal-footer mt-3">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
          <button type="submit" class="btn btn-success">Thêm mới</button>
        </div>
      </form>

    </div>
  </div>
</div>
