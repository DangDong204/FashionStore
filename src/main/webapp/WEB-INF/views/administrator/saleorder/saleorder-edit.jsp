<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- Modal chỉnh sửa trạng thái đơn hàng -->
<div class="modal fade" id="editSaleOrderModal" tabindex="-1" aria-labelledby="editSaleOrderModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg rounded-3">
      <div class="modal-header bg-warning text-black">
        <h5 class="modal-title fw-semibold" id="editSaleOrderModalLabel">
          <i class="ri-edit-2-line me-1"></i> Cập nhật trạng thái đơn hàng
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>

      <form action="${env }/admin/saleorder/edit" method="post" class="row g-3 m-3">
        <!-- Ẩn id để gửi khi submit -->
        <input type="hidden" name="id" id="edit-id">

        <div class="col-md-6">
          <label class="form-label fw-semibold">Mã đơn hàng</label>
          <input type="text" class="form-control" id="edit-code" readonly>
        </div>

        <div class="col-md-6">
          <label class="form-label fw-semibold">Tên khách hàng</label>
          <input type="text" class="form-control" id="edit-customername" readonly>
        </div>

        <div class="col-md-6">
          <label class="form-label fw-semibold">Tổng giá trị</label>
          <input type="text" class="form-control" id="edit-total" readonly>
        </div>

        <div class="col-md-6">
          <label class="form-label fw-semibold">Trạng thái hiện tại</label>
          <input type="text" class="form-control" id="edit-current-status" readonly>
        </div>

        <div class="col-12">
          <label class="form-label fw-semibold">Trạng thái đơn hàng <span class="text-danger">*</span></label>
          <select class="form-select" id="edit-orderstatus" name="orderStatus" required>
            <option value="0">Chờ phê duyệt</option>
            <option value="1">Xác nhận</option>
            <option value="2">Chờ đơn vị vận chuyển</option>
            <option value="3">Đang giao hàng</option>
            <option value="4">Đã giao hàng</option>
            <option value="5">Trả hàng</option>
          </select>
        </div>

        <div class="col-12">
          <label class="form-label fw-semibold">Ghi chú</label>
          <textarea class="form-control" id="edit-description" name="description" rows="3" placeholder="Nhập ghi chú (nếu có)"></textarea>
        </div>

        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">
            <i class="ri-check-line me-1"></i> Cập nhật trạng thái
          </button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  const editSaleOrderModal = document.getElementById('editSaleOrderModal');
  editSaleOrderModal.addEventListener('show.bs.modal', function (event) {
    const button = event.relatedTarget;

    // Lấy dữ liệu từ button
    const id = button.getAttribute('data-id');
    const code = button.getAttribute('data-code');
    const customerName = button.getAttribute('data-customername');
    const total = button.getAttribute('data-total');
    const orderStatus = button.getAttribute('data-orderstatus');
    const description = button.getAttribute('data-description') || "";

    // Định dạng số tiền
    const formattedTotal = new Intl.NumberFormat('vi-VN').format(total) + ' ₫';

    // Lấy tên trạng thái hiện tại
    const statusText = getStatusText(orderStatus);

    // Điền dữ liệu vào form
    document.getElementById('edit-id').value = id;
    document.getElementById('edit-code').value = code;
    document.getElementById('edit-customername').value = customerName;
    document.getElementById('edit-total').value = formattedTotal;
    document.getElementById('edit-current-status').value = statusText;
    document.getElementById('edit-orderstatus').value = orderStatus;
    document.getElementById('edit-description').value = description;
  });

  // Hàm lấy tên trạng thái từ số
  function getStatusText(status) {
    switch(status) {
      case '0': return 'Chờ phê duyệt';
      case '1': return 'Xác nhận';
      case '2': return 'Chờ đơn vị vận chuyển';
      case '3': return 'Đang giao hàng';
      case '4': return 'Đã giao hàng';
      case '5': return 'Trả hàng';
      default: return 'Không xác định';
    }
  }
</script>