<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Modal sửa danh mục -->
<div class="modal fade" id="editCategoryModal" tabindex="-1" aria-labelledby="editCategoryModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg rounded-3">
      <div class="modal-header bg-warning text-black">
        <h5 class="modal-title fw-semibold" id="editCategoryModalLabel">
          <i class="ri-edit-2-line me-1"></i> Chỉnh sửa danh mục
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>

      <form action="${env }/admin/category/edit" method="post" class="row g-3 m-3">
        <!-- Ẩn id để gửi khi submit -->
        <input type="hidden" name="id" id="edit-id">

        <div class="col-md-6">
          <label class="form-label fw-semibold">Tên danh mục</label>
          <input type="text" class="form-control" id="edit-name" name="name" required>
        </div>

        <div class="col-md-6">
          <label class="form-label fw-semibold">Trạng thái</label>
          <select class="form-select" id="edit-status" name="status">
            <option value="true">Hoạt động</option>
            <option value="false">Ngừng hoạt động</option>
          </select>
        </div>

        <div class="col-md-6">
          <label class="form-label fw-semibold">Người tạo</label>
          <input type="text" class="form-control" id="edit-createby" name="createBy" readonly>
        </div>

        <div class="col-md-6">
          <label class="form-label fw-semibold">Ngày tạo</label>
          <input type="text" class="form-control" id="edit-createdate" name="createDate" readonly>
        </div>

        <div class="col-md-6">
          <label class="form-label fw-semibold">Người cập nhật</label>
          <input type="text" class="form-control" id="edit-updateby" name="updateBy">
        </div>

        <div class="col-md-6">
          <label class="form-label fw-semibold">Ngày cập nhật</label>
          <input type="date" class="form-control" id="edit-updatedate" name="updateDate">
        </div>

        <div class="col-12">
          <label class="form-label fw-semibold">Mô tả</label>
          <textarea class="form-control" id="edit-desc" name="description" rows="3"></textarea>
        </div>

        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">
            <i class="ri-check-line me-1"></i> Lưu thay đổi
          </button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  const editModal = document.getElementById('editCategoryModal');
  editModal.addEventListener('show.bs.modal', function (event) {
    const button = event.relatedTarget;

    document.getElementById('edit-id').value = button.getAttribute('data-id');
    document.getElementById('edit-name').value = button.getAttribute('data-name');
    document.getElementById('edit-createby').value = button.getAttribute('data-createby');
    document.getElementById('edit-updateby').value = button.getAttribute('data-updateby');
    document.getElementById('edit-createdate').value = button.getAttribute('data-createdate');
    document.getElementById('edit-updatedate').value = button.getAttribute('data-updatedate');
    document.getElementById('edit-desc').value = button.getAttribute('data-desc') || "";

    const status = button.getAttribute('data-status');
    document.getElementById('edit-status').value = (status === 'true') ? 'true' : 'false';
  });
</script>

    