<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Search Begin -->
<div class="search-model">
    <div class="h-100 d-flex align-items-center justify-content-center">
        <div class="search-close-switch">+</div>
        <form class="search-model-form" action="${env}/shop" method="get" id="searchForm">
            <input type="text" id="search-input" name="keyword" placeholder="Nhập từ khóa tìm kiếm....." 
                   value="${keyword}">
            <button type="submit" style="display: none;">Tìm kiếm</button>
        </form>
    </div>
</div>
<!-- Search End -->