<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- JSTL directive --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
    
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ashion Template">
    <meta name="keywords" content="Ashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>SWE</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap"
    rel="stylesheet">
    <!-- icon - cho slider -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    

    <!-- Css Styles -->
    <jsp:include page="/WEB-INF/views/customer/layout/css.jsp"></jsp:include>
    <style type="text/css">
    	.price-input input {
	  min-width: 100px;
	  max-width: 130px;
	  text-align: center;
	  border: none;
	  background: transparent;
	  font-weight: 600;
	}
	
	@media (max-width: 768px) {
	  .price-input input {
	    min-width: 80px;
	    font-size: 14px;
	  }
	}
	    	
    </style>
</head>

<body>
	<!-- Header -->
	<jsp:include page="/WEB-INF/views/customer/layout/header.jsp"></jsp:include>

	<!-- Slider -->
	<jsp:include page="/WEB-INF/views/customer/layout/slider.jsp"></jsp:include>    

    <!-- Breadcrumb Begin -->
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__links">
                        <a href="${env }/index"><i class="fa fa-home"></i> Home</a>
                        <span>Shop</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Shop Section Begin -->
    <section class="shop spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-3">
                    <div class="shop__sidebar">
                        <div class="sidebar__categories">
						    <div class="section-title">
						        <h4>Danh mục</h4>
						    </div>
						    <div class="categories__accordion">
						        <div class="accordion" id="accordionExample">
						            <div class="card">
						                <div class="card-heading active">
						                    <a data-toggle="collapse" data-target="#collapseAll">Tất cả danh mục</a>
						                </div>
						                <div id="collapseAll" class="collapse show" data-parent="#accordionExample">
						                    <div class="card-body">
						                        <ul class="list-unstyled">
						                            <c:forEach var="cate" items="${categories}">
						                                <li>
						                                    <a href="${env}/shop?categoryId=${cate.id}"
						                                       class="${cate.id == categoryId ? 'font-weight-bold text-danger' : ''}">
						                                        ${cate.name}
						                                    </a>
						                                </li>
						                            </c:forEach>
						                        </ul>
						                    </div>
						                </div>
						            </div>
						        </div>
						    </div>
						</div>
                        
                        <div class="sidebar__filter">
						    <div class="section-title">
						        <h4>Lọc theo giá</h4>
						    </div>
						
						    <form action="${env}/shop" method="get" id="priceFilterForm">
						        <div class="filter-range-wrap">
						            <div id="slider-range"
						                 class="price-range ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content"></div>
						            <div class="range-slider mt-3">
						                <div class="price-input d-flex align-items-center" style="gap: 8px; flex-wrap: nowrap;">
										    <p class="mb-0">Giá:</p>
										    <input type="text" id="minamount" name="minPrice" readonly
										           style="width:120px;text-align:center;border:none;background:transparent;font-weight:600;">
										    <span>-</span>
										    <input type="text" id="maxamount" name="maxPrice" readonly
										           style="width:120px;text-align:center;border:none;background:transparent;font-weight:600;">
										</div>         
						            </div>
						        </div>
						        <button type="submit" class="site-btn">Lọc sản phẩm</button>
						    </form>
						</div>
                        
                    </div>
                </div>
                
                <div class="col-lg-9 col-md-9">
                	<!-- Thêm thông báo tìm kiếm -->
				    <c:if test="${not empty searchMessage}">
				        <div class="alert alert-info mb-4">
				            <strong>${searchMessage}</strong>
				            <a href="${env}/shop" class="float-right">Hiển thị tất cả sản phẩm</a>
				        </div>
				    </c:if>
                    <div class="row">
                    	<c:forEach var="product" items="${products}">
	                        <div class="col-lg-4 col-md-6">
	                            <div class="product__item">
	                                <div class="product__item__pic set-bg" data-setbg="${env}/${product.avatar}">
					                    <ul class="product__hover">
					                        <li><a href="${env}/${product.avatar}" class="image-popup"><span class="arrow_expand"></span></a></li>
					                        <li><a href="#"><span class="icon_heart_alt"></span></a></li>
					                        <li>
					                            <a href="javascript:void(0);" onclick="addToCart(${product.id}, 1, ${product.price}, '${product.name}', '${product.avatar}')">
					                                <span class="icon_bag_alt"></span>
					                            </a>
					                        </li>
					                    </ul>
					                </div>
					                <div class="product__item__text">
					                    <h6><a href="${env}/product/${product.id}">${product.name}</a></h6>
					                    <div class="product__price">
					                        <fmt:formatNumber value="${product.price}" type="number" minFractionDigits="0"/>đ
					                    </div>
					                </div>
	                            </div>
	                            
	                        </div>
	                    </c:forEach>
	                    
	                    <c:if test="${empty products}">
				            <div class="col-lg-12 text-center">
				                <c:choose>
				                    <c:when test="${not empty keyword}">
				                        <p>Không tìm thấy sản phẩm nào phù hợp với từ khóa "<strong>${keyword}</strong>"!</p>
				                        <img src="${env}/customer/img/empty-search.png" alt="Empty search" 
		                                 style="width:300px; opacity:0.8; margin-bottom:20px;">
				                    </c:when>
				                    <c:otherwise>
				                        <p>Không có sản phẩm nào phù hợp!</p>
				                    </c:otherwise>
				                </c:choose>
				            </div>
				        </c:if>
	                    
	                    <div class="col-lg-12 text-center">
	                            <div class="pagination__option">
	                                <a href="#">1</a>
	                                <a href="#">2</a>
	                                <a href="#">3</a>
	                                <a href="#"><i class="fa fa-angle-right"></i></a>
	                            </div>
	                     </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shop Section End -->

    <jsp:include page="/WEB-INF/views/customer/layout/services.jsp"></jsp:include>
	
	<!-- Footer -->
	<jsp:include page="/WEB-INF/views/customer/layout/footer.jsp"></jsp:include>
	<!-- End - Footer -->
	
	<jsp:include page="/WEB-INF/views/customer/layout/search.jsp"></jsp:include>

	<!-- JS Plugins -->
	<jsp:include page="/WEB-INF/views/customer/layout/js.jsp"></jsp:include>
	
	<jsp:include page="/WEB-INF/views/customer/layout/js-addtocart.jsp"></jsp:include>
	
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>
	$(function() {
	    // Giới hạn giá (tuỳ chỉnh theo dữ liệu thật)
	    var minPrice = 0;
	    var maxPrice = 2000000; // 5 triệu chẳng hạn
	
	    // Lấy giá trị hiện tại (từ model trả về)
	    var currentMin = ${minPrice != null ? minPrice : 0};
	    var currentMax = ${maxPrice != null ? maxPrice : 2000000};
	
	    // Hàm định dạng tiền Việt
	    function formatVND(number) {
	        return new Intl.NumberFormat('vi-VN').format(number) + ' đ';
	    }
	
	    $("#slider-range").slider({
	        range: true,
	        min: minPrice,
	        max: maxPrice,
	        step: 100000, // mỗi bước 10.000đ cho dễ kéo
	        values: [currentMin, currentMax],
	        slide: function(event, ui) {
	            $("#minamount").val(formatVND(ui.values[0]));
	            $("#maxamount").val(formatVND(ui.values[1]));
	        },
	        change: function(event, ui) {
	            // Cập nhật giá trị thực tế (ẩn để gửi lên controller)
	            $("input[name='minPrice']").val(ui.values[0]);
	            $("input[name='maxPrice']").val(ui.values[1]);
	        }
	    });
	
	    // Gán giá trị mặc định khi load trang
	    $("#minamount").val(formatVND($("#slider-range").slider("values", 0)));
	    $("#maxamount").val(formatVND($("#slider-range").slider("values", 1)));
	
	    // Đảm bảo khi submit form gửi giá trị số (không có ký tự "đ")
	    $("#priceFilterForm").submit(function() {
	        var min = $("#slider-range").slider("values", 0);
	        var max = $("#slider-range").slider("values", 1);
	        $("<input>").attr({
	            type: "hidden",
	            name: "minPrice",
	            value: min
	        }).appendTo(this);
	        $("<input>").attr({
	            type: "hidden",
	            name: "maxPrice",
	            value: max
	        }).appendTo(this);
	    });
	});
	</script>
	
	
	
</body>
</html>