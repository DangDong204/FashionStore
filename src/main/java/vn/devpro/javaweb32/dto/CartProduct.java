package vn.devpro.javaweb32.dto;

import java.math.BigDecimal;
import java.math.BigInteger;

public class CartProduct {
	private int id;
	private BigInteger quantity;
	private BigDecimal price;
	private String name;
	private String avatar;

	public BigDecimal totalPrice() {
		return this.price.multiply(new BigDecimal(this.quantity));
	}
	
	public void updateQuantity(BigInteger aq) { //ag = additionalQuatity
		this.quantity = this.quantity.add(aq);
	}
	
	public CartProduct() {
		super();
	}

	public CartProduct(int id, BigInteger quantity, BigDecimal price, String name, String avatar) {
		super();
		this.id = id;
		this.quantity = quantity;
		this.price = price;
		this.name = name;
		this.avatar = avatar;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public BigInteger getQuantity() {
		return quantity;
	}

	public void setQuantity(BigInteger quantity) {
		this.quantity = quantity;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
	
	
}
