package vn.devpro.javaweb32.dto;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class Cart {
	private List<CartProduct> cartProducts = new ArrayList<CartProduct>();
	
	// Phuong thuc tim san pham da co trong gio hang chua
	public int findById(int id) {
		for(int index = 0; index < cartProducts.size(); index++) {
			if(cartProducts.get(index).getId() == id) {
				return index;	// co vi tri co chi so [index]
			}
		}
		return -1;		// TH: khong co
	}
	
	public BigDecimal totalCartPrice() {
		
		BigDecimal total = BigDecimal.ZERO;
		
		for (CartProduct cartProduct : this.cartProducts) {
			total = total.add(cartProduct.totalPrice());
		}
		return total;
	}

	public Cart() {
		super();
	}

	public Cart(List<CartProduct> cartProducts) {
		super();
		this.cartProducts = cartProducts;
	}

	public List<CartProduct> getCartProducts() {
		return cartProducts;
	}

	public void setCartProducts(List<CartProduct> cartProducts) {
		this.cartProducts = cartProducts;
	}
	
	
}
