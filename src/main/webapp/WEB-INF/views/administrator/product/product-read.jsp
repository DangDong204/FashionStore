<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Modal xem chi tiết sản phẩm -->
<div class="modal fade" id="detailProductModal" tabindex="-1" aria-labelledby="detailProductModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-centered">
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
            <label class="form-label fw-semibold">Mã sản phẩm</label>
            <input type="text" class="form-control" id="detail-id" readonly>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Tên sản phẩm</label>
            <input type="text" class="form-control" id="detail-name" readonly>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Danh mục</label>
            <input type="text" class="form-control" id="detail-category" readonly>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Số lượng tồn</label>
            <input type="text" class="form-control" id="detail-stock" readonly>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Giá gốc</label>
            <input type="text" class="form-control" id="detail-price" readonly>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Giá bán</label>
            <input type="text" class="form-control" id="detail-saleprice" readonly>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Trạng thái hot</label>
            <div id="detail-ishot" class="form-control-plaintext"></div>
          </div>

          <div class="col-md-6">
            <label class="form-label fw-semibold">Trạng thái hoạt động</label>
            <div id="detail-status" class="form-control-plaintext"></div>
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

          <div class="col-md-12 text-center">
            <label class="form-label fw-semibold d-block">Ảnh sản phẩm</label>
            <img id="detail-avatar" src="" alt="Ảnh sản phẩm" class="img-thumbnail" style="max-height: 200px;">
          </div>

          <div class="col-12">
            <label class="form-label fw-semibold">Mô tả ngắn</label>
            <textarea class="form-control" id="detail-shortdesc" rows="2" readonly></textarea>
          </div>

          <div class="col-12">
            <label class="form-label fw-semibold">Mô tả chi tiết</label>
            <textarea class="form-control" id="detail-detaildesc" rows="4" readonly></textarea>
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
  const productModal = document.getElementById('detailProductModal');
  productModal.addEventListener('show.bs.modal', function (event) {
    const button = event.relatedTarget;

    document.getElementById('detail-id').value = button.getAttribute('data-id');
    document.getElementById('detail-name').value = button.getAttribute('data-name');
    document.getElementById('detail-category').value = button.getAttribute('data-category');
    document.getElementById('detail-price').value = button.getAttribute('data-price');
    document.getElementById('detail-saleprice').value = button.getAttribute('data-saleprice');
    document.getElementById('detail-stock').value = button.getAttribute('data-stock');
    document.getElementById('detail-createby').value = button.getAttribute('data-createby');
    document.getElementById('detail-updateby').value = button.getAttribute('data-updateby');
    document.getElementById('detail-createdate').value = button.getAttribute('data-createdate');
    document.getElementById('detail-updatedate').value = button.getAttribute('data-updatedate');
    document.getElementById('detail-shortdesc').value = button.getAttribute('data-shortdesc') || "(Không có mô tả)";
    document.getElementById('detail-detaildesc').value = button.getAttribute('data-detaildesc') || "(Không có mô tả chi tiết)";

    // Hiển thị ảnh
    const avatar = button.getAttribute('data-avatar');
    document.getElementById('detail-avatar').src = avatar ? avatar : '${env}/administrator/img/product-1.jpg';

 	// Hiển thị trạng thái hot
    const isHotAttr = button.getAttribute('data-ishot');
    const isHot = (isHotAttr === 'true');
    document.getElementById('detail-ishot').innerHTML = isHot
      ? '<span class="badge bg-danger"><i class="ri-fire-fill me-1"></i>Sản phẩm hot</span>'
      : '<span class="badge bg-secondary"><i class="ri-temp-cold-line me-1"></i>Bình thường</span>';

    // Hiển thị trạng thái hoạt động
    const statusAttr = button.getAttribute('data-status');
    const status = (statusAttr === 'true')
      ? '<span class="badge bg-success"><i class="ri-checkbox-circle-line me-1"></i>Hoạt động</span>'
      : '<span class="badge bg-dark"><i class="ri-close-circle-line me-1"></i>Ngừng hoạt động</span>';
    document.getElementById('detail-status').innerHTML = status;

  });
</script>
