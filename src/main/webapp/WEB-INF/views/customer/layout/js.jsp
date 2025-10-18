<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<script src="${env }/customer/js/jquery-3.3.1.min.js"></script>
<script src="${env }/customer/js/bootstrap.min.js"></script>
<script src="${env }/customer/js/jquery.magnific-popup.min.js"></script>
<script src="${env }/customer/js/jquery-ui.min.js"></script>
<script src="${env }/customer/js/mixitup.min.js"></script>
<script src="${env }/customer/js/jquery.countdown.min.js"></script>
<script src="${env }/customer/js/jquery.slicknav.js"></script>
<script src="${env }/customer/js/owl.carousel.min.js"></script>
<script src="${env }/customer/js/jquery.nicescroll.min.js"></script>
<script src="${env }/customer/js/main.js"></script>


<!-- Thêm JS - Filter -->
<script src="${env }/customer/js/jquery-ui.js"></script>

<!-- Them JS  - Slider-->
<script src="${env }/customer/js/slick/jquery-3.7.1.js"></script>
<script src="${env }/customer/js/slick/slick.min.js"></script>

<script>
    $(document).ready(function(){
        $('.slider').slick({
            // Tự động chuyển slide
            autoplay: true,
            // Tốc độ chạy bao nhiêu ms / lần
            autoplaySpeed: 1000,

            // hiện thị bao nhiêu slide 1 lần
            slidesToShow: 1,
            // Next/Back lại bao nhiêu slide / lần
            slidesToScroll: 1,
            // Hiện thị hoặc ẩn số lượng slide 1-2-3 
            // dots: true,
            // Ẩn hoặc hiện nút Next/Back   
            arrows: true,

            prevArrow: '<button type="button" class="slick-prev custom-prev"><i class="fa-solid fa-chevron-left"></i></button>',
            nextArrow: '<button type="button" class="slick-next custom-next"><i class="fa-solid fa-chevron-right"></i></button>',
        });
    });
</script>

<script>
$(document).ready(function() {
    // Xử lý sự kiện khi nhấn Enter trong ô tìm kiếm
    $('#search-input').on('keypress', function(e) {
        if (e.which === 13) { // Enter key
            e.preventDefault();
            performSearch();
        }
    });
    
    // Xử lý sự kiện khi click icon search (nếu cần)
    $('#searchIcon').on('click', function() {
        // Mở popup search (nếu template đã có sẵn chức năng này)
        $('.search-model').addClass('active');
        $('#search-input').focus();
    });
    
    // Hàm thực hiện tìm kiếm
    function performSearch() {
        var keyword = $('#search-input').val().trim();
        if (keyword !== '') {
            // Chuyển hướng đến trang shop với từ khóa tìm kiếm
            window.location.href = '${env}/shop?keyword=' + encodeURIComponent(keyword);
        } else {
            // Nếu từ khóa rỗng, chuyển đến trang shop không lọc
            window.location.href = '${env}/shop';
        }
    }
    
    // Đóng popup search khi click nút close
    $('.search-close-switch').on('click', function() {
        $('.search-model').removeClass('active');
    });
    
    // Hiển thị từ khóa tìm kiếm hiện tại (nếu có)
    var currentKeyword = '${keyword}';
    if (currentKeyword) {
        $('#search-input').val(currentKeyword);
    }
});
</script>