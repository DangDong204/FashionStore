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
                    	<c:choose>
                    		<c:when test="${not empty cart and not empty cart.cartProducts}">
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
			                                <tr id="row_${cartProduct.id}">
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
			                                    	<button type="button" class="btn btn-danger btn-sm"
										                    onclick="deleteCartProduct(${cartProduct.id})">
										                <i class="fa fa-trash"></i>
										            </button>
			                                    </td>
			                                </tr>
			                                
		                                </c:forEach>
		                                
		                            </tbody>
		                        </table>
		                     </c:when>
		                     
		                     <c:otherwise>
		                     	<div class="text-center my-5">
		                            <img src="${env}/customer/img/empty-cart.png" alt="Empty cart" 
		                                 style="width:150px; opacity:0.8; margin-bottom:20px;">
		                            <h4 class="mb-3">Giỏ hàng của bạn đang trống</h4>
		                            <p class="text-muted mb-4">Hãy tiếp tục mua sắm để thêm sản phẩm yêu thích nhé!</p>
		                        </div>
		                     </c:otherwise>
		                </c:choose>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="cart__btn">
                        <a href="${env }/index">Tiếp tục mua sắm</a>
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
                        <h6>Mã giảm giá</h6>
                        <form id="voucherForm">
						    <input type="text" id="voucherCode" placeholder="Nhập mã giảm giá">
						    <button type="button" class="site-btn" onclick="applyVoucher()">Áp dụng</button>
						</form>
						
						<p id="voucherMessage" style="margin-top:10px;"></p>
						                        
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
                        <a href="${env }/checkout" class="primary-btn">Đặt hàng</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shop Cart Section End -->

    <!-- Footer -->
	<jsp:include page="/WEB-INF/views/customer/layout/footer.jsp"></jsp:include>
	<!-- End - Footer -->

	<jsp:include page="/WEB-INF/views/customer/layout/search.jsp"></jsp:include>

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
	<script type="text/javascript">
		function deleteCartProduct(productId) {
		    if (!confirm("Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?")) return;
		
		    $.ajax({
		        url: "/cart-product-delete", // Gọi controller xóa
		        type: "POST",
		        contentType: "application/json",
		        data: JSON.stringify({ id: productId }),
		        dataType: "json",
		        success: function(jsonResult) {
		            if (jsonResult.code === 200) {
		                // Xóa dòng sản phẩm trong bảng giỏ hàng
		                $("#row_" + productId).remove();
		                // Cập nhật tổng tiền, tổng số sản phẩm
		                $("#totalCartPriceId").html(jsonResult.totalCartPrice);
		                $("#totalCartProducts").html(jsonResult.totalCartProducts);
		
		                // Nếu giỏ hàng trống thì hiển thị thông báo
		                if (jsonResult.totalCartProducts == 0) {
		                	const emptyCartHtml = `
		                        <div class="text-center my-5">
		                            <img src="${env}/customer/img/empty-cart.png" alt="Empty cart" 
		                                 style="width:150px; opacity:0.8; margin-bottom:20px;">
		                            <h4 class="mb-3">Giỏ hàng của bạn đang trống</h4>
		                            <p class="text-muted mb-4">Hãy tiếp tục mua sắm để thêm sản phẩm yêu thích nhé!</p>
		                            
		                        </div>
		                    `;
		                    $("table").replaceWith(emptyCartHtml);
		                }
		            }
		        },
		        error: function() {
		            alert("Xóa sản phẩm thất bại!");
		        }
		    });
		}
	</script>
	
	<script>
		function applyVoucher() {
		    let code = $("#voucherCode").val().trim();
		    if (code === "") {
		        $("#voucherMessage").text("Vui lòng nhập mã giảm giá!");
		        return;
		    }
	
		    $.ajax({
		        url: "/apply-voucher",
		        type: "POST",
		        data: { code: code },
		        success: function(response) {
		            if (response.valid) {
		                $("#voucherMessage").text("Áp dụng thành công! Giảm " + response.discountText);
		                $("#totalCartPriceId").html(response.newTotalFormatted);
		            } else {
		                $("#voucherMessage").text(response.message);
		            }
		        },
		        error: function() {
		            $("#voucherMessage").text("Lỗi khi áp dụng mã giảm giá!");
		        }
		    });
		}
	</script>
			
	
</body>

</html>