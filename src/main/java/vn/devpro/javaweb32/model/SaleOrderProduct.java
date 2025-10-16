package vn.devpro.javaweb32.model;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_sale_order_product")
public class SaleOrderProduct extends BaseModel{
	
	// ------------ Mapping many-to-one: SaleOrderProduct - SaleOrder ------------
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "sale_order_id", nullable = false)
	private SaleOrder saleOrder;

	// ------------ Mapping many-to-one: SaleOrderProduct - Product ------------
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "product_id", nullable = false)
	private Product product;

	@Column(name = "quantity", nullable = false)
	private Integer quantity = 1;

	@Column(name = "price", nullable = false, precision = 15, scale = 2)
	private BigDecimal price = BigDecimal.ZERO;

	// total_price là cột sinh tự động trong DB, nên không cần set
	// insertable/updatable
	@Column(name = "total_price", precision = 15, scale = 2, insertable = false, updatable = false)
	private BigDecimal totalPrice;

	@Column(name = "product_name", length = 300)
	private String productName;

	@Column(name = "description", length = 500)
	private String description;

	public SaleOrderProduct() {
		super();
	}

	public SaleOrderProduct(Integer id, Integer createBy, Integer updateBy, Date createDate, Date updateDate,
			Boolean status, SaleOrder saleOrder, Product product, Integer quantity, BigDecimal price,
			BigDecimal totalPrice, String productName, String description) {
		super(id, createBy, updateBy, createDate, updateDate, status);
		this.saleOrder = saleOrder;
		this.product = product;
		this.quantity = quantity;
		this.price = price;
		this.totalPrice = totalPrice;
		this.productName = productName;
		this.description = description;
	}

	public SaleOrder getSaleOrder() {
		return saleOrder;
	}

	public void setSaleOrder(SaleOrder saleOrder) {
		this.saleOrder = saleOrder;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public BigDecimal getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(BigDecimal totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
