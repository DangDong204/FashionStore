<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Modal thêm danh mục -->
<div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg rounded-3">
      <div class="modal-header bg-info text-white">
        <h5 class="modal-title fw-semibold" id="addCategoryModalLabel">
          <i class="ri-add-circle-line me-1"></i> Thêm danh mục
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>

      <form action="${env }/admin/category/add" method="post">
        <div class="modal-body">
          <div class="row g-3">
            <div class="col-md-6">
              <label class="form-label fw-semibold">Tên danh mục</label>
              <input type="text" class="form-control" name="name" required placeholder="Nhập tên danh mục">
            </div>

            <div class="col-md-6">
              <label class="form-label fw-semibold">Trạng thái</label>
              <select class="form-select" name="status">
                <option value="true" selected>Hoạt động</option>
                <option value="false">Ngừng hoạt động</option>
              </select>
            </div>

            <div class="col-12">
              <label class="form-label fw-semibold">Mô tả</label>
              <textarea class="form-control" name="description" rows="3" placeholder="Nhập mô tả (nếu có)"></textarea>
            </div>
          </div>
        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
          <button type="submit" class="btn btn-info text-white">
            <i class="ri-save-3-line me-1"></i> Lưu
          </button>
        </div>
      </form>
    </div>
  </div>
</div>
    