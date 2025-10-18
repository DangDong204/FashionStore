<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- Add to cart -->
<script type="text/javascript">
	addToCart = function(_productId, _quantity, _price, _productName, _avatar) {
	    console.log("ID:", _productId, "Q:", _quantity, "Price:", _price, "Name:", _productName, "Avatar:", _avatar);
		alert("Thêm "  + _quantity + " sản phẩm '" + _productName + "' vào giỏ hàng ");
		let data = {
			id: _productId, //lay theo id
			quantity: _quantity,
			price: _price,
			name: _productName,
			avatar: _avatar,
		};
			
		//$ === jQuery
		jQuery.ajax({
			url : "/add-to-cart",
			type : "POST",
			contentType: "application/json",
			data : JSON.stringify(data),
			dataType : "json", //Kieu du lieu tra ve tu controller la json
			
			success : function(jsonResult) {
				alert(jsonResult.code + ": " + jsonResult.message);
				let totalProducts = jsonResult.totalCartProducts;
				$("#totalCartProducts").html(totalProducts);
			},
			
			error : function(jqXhr, textStatus, errorMessage) {
				alert(jsonResult.code + ': Đã có lỗi xay ra...!')
			},
		});
	}
</script>