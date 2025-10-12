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