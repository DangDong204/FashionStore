<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- directive của JSTL -->
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
</head>

<body>
    <!-- Header -->
	<jsp:include page="/WEB-INF/views/customer/layout/header.jsp"></jsp:include>

    <!-- Breadcrumb Begin -->
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__links">
                        <a href="${env }/index"><i class="fa fa-home"></i> Home</a>
                        <span>Shopping cart</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Shop Cart Section Begin -->
    <section class="shop-cart spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="shop__cart__table">
                        <table>
                            <thead>
                                <tr>
                                    <th>Sản Phẩm</th>
                                    <th>Đơn giá</th>
                                    <th>Số lượng</th>
                                    <th>Thành tiền</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach var="cartProduct" items="${cart.cartProducts }">
	                                <tr>
	                                    <td class="cart__product__item">
	                                        <img src="${classpath}/${cartProduct.avatar }" alt=""
	                                        	style="width: 60px; height: 60px; object-fit: cover; border-radius: 8px; margin-right: 10px;">
	                                        <div class="cart__product__item__title">
	                                            <h6>${cartProduct.name }</h6>
	                                        </div>
	                                    </td>
	                                    <td class="cart__price">
	                                    	 <fmt:formatNumber value="${cartProduct.price}" 
	                                    	 type="currency" currencySymbol="₫" maxFractionDigits="0" />
										</td>
	                                    <td>
	                                        <div class="d-flex justify-content-center align-items-center">
						                        <button type="button" class="btn btn-sm btn-light"
						                                onclick="updateProductQuantity(${cartProduct.id}, -1)">-</button>
						                        <input type="text" id="productQuantity_${cartProduct.id}"
						                               value="${cartProduct.quantity}"
						                               class="form-control text-center mx-2" style="width: 60px;">
						                        <button type="button" class="btn btn-sm btn-light"
						                                onclick="updateProductQuantity(${cartProduct.id}, 1)">+</button>
						                    </div>
	                                    </td>
	                                    <td class="cart__total">
	                                    	<span id="totalPrice_${cartProduct.id}">
						                        <fmt:formatNumber value="${cartProduct.price * cartProduct.quantity}" 
						                                          type="currency" currencySymbol="₫" maxFractionDigits="0" />
						                    </span>
	                                    </td>
	                                    <td class="cart__close">
	                                    	<a href="${classpath}/cart/delete/${cartProduct.id}" 
						                       class="btn btn-danger btn-sm">
						                        <i class="fa fa-trash"></i>
						                    </a>
	                                    </td>
	                                </tr>
	                                
                                </c:forEach>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="cart__btn">
                        <a href="#">Continue Shopping</a>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="cart__btn update__btn">
                        <a href="#"><span class="icon_loading"></span> Update cart</a>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6">
                    <div class="discount__content">
                        <h6>Discount codes</h6>
                        <form action="#">
                            <input type="text" placeholder="Enter your coupon code">
                            <button type="submit" class="site-btn">Apply</button>
                        </form>
                    </div>
                </div>
                <div class="col-lg-4 offset-lg-2">
                    <div class="cart__total__procced">
                        <h6>Cart total</h6>
                        <ul>
                            <li>Subtotal <span>$ 750.0</span></li>
                            <li>Total <span id="totalCartPriceId">
                            	<fmt:formatNumber value="${totalCartPrice }"
                            	minFractionDigits="0"></fmt:formatNumber></span>
                            </li>
                        </ul>
                        <a href="#" class="primary-btn">Proceed to checkout</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shop Cart Section End -->

    <!-- Footer -->
	<jsp:include page="/WEB-INF/views/customer/layout/footer.jsp"></jsp:include>
	<!-- End - Footer -->

    <!-- Search Begin -->
    <div class="search-model">
        <div class="h-100 d-flex align-items-center justify-content-center">
            <div class="search-close-switch">+</div>
            <form class="search-model-form">
                <input type="text" id="search-input" placeholder="Search here.....">
            </form>
        </div>
    </div>
    <!-- Search End -->

    <!-- JS Plugins -->
	<jsp:include page="/WEB-INF/views/customer/layout/js.jsp"></jsp:include>
	
	<script type="text/javascript">
		updateProductQuantity = function(_productId, _quantity) {
			let data = {
				id : _productId, //lay theo id
				quantity : _quantity
			};

			//$ === jQuery
			jQuery.ajax({
				url : "/update-product-quantity",
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify(data),
				dataType : "json", //Kieu du lieu tra ve tu controller la json

				success : function(jsonResult) {
					let totalProducts = jsonResult.totalCartProducts; 
					//Viet lai so luong sau khi bam nut -, +
					$("#productQuantity_" + jsonResult.productId).val(jsonResult.newQuantity);
					$("#totalCartPriceId").html(jsonResult.totalCartPrice); 
					$("#totalPrice_" + jsonResult.productId).html(jsonResult.totalPrice);
					$("#totalCartProducts").html(jsonResult.totalCartProducts);
				},

				error : function(jqXhr, textStatus, errorMessage) {
					alert("An error occur");
				}
			});
		}
	</script>
	
</body>

</html>