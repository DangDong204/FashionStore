package vn.devpro.javaweb32.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_sale_order")
public class SaleOrder extends BaseModel{

	// ---------- Mapping many-to-one: SaleOrder - User ----------
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id", nullable = false)
	private User user;

	@Column(name = "code", nullable = false, length = 60)
	private String code;

	@Column(name = "total", precision = 15, scale = 2)
	private BigDecimal total = BigDecimal.ZERO;

	@Column(name = "customer_name", nullable = false, length = 300)
	private String customerName;

	@Column(name = "customer_mobile", length = 120)
	private String customerMobile;

	@Column(name = "customer_email", length = 120)
	private String customerEmail;

	@Column(name = "customer_address", length = 300)
	private String customerAddress;

	@Column(name = "order_status")
	private Integer orderStatus = 0;

	@Column(name = "delivery_date")
	private Date deliveryDate;

	@Column(name = "description", length = 500)
	private String description;

	public SaleOrder() {
		super();
	}

	public SaleOrder(Integer id, Integer createBy, Integer updateBy, Date createDate, Date updateDate, Boolean status,
			User user, String code, BigDecimal total, String customerName, String customerMobile, String customerEmail,
			String customerAddress, Integer orderStatus, Date deliveryDate, String description) {
		super(id, createBy, updateBy, createDate, updateDate, status);
		this.user = user;
		this.code = code;
		this.total = total;
		this.customerName = customerName;
		this.customerMobile = customerMobile;
		this.customerEmail = customerEmail;
		this.customerAddress = customerAddress;
		this.orderStatus = orderStatus;
		this.deliveryDate = deliveryDate;
		this.description = description;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public BigDecimal getTotal() {
		return total;
	}

	public void setTotal(BigDecimal total) {
		this.total = total;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getCustomerMobile() {
		return customerMobile;
	}

	public void setCustomerMobile(String customerMobile) {
		this.customerMobile = customerMobile;
	}

	public String getCustomerEmail() {
		return customerEmail;
	}

	public void setCustomerEmail(String customerEmail) {
		this.customerEmail = customerEmail;
	}

	public String getCustomerAddress() {
		return customerAddress;
	}

	public void setCustomerAddress(String customerAddress) {
		this.customerAddress = customerAddress;
	}

	public Integer getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(Integer orderStatus) {
		this.orderStatus = orderStatus;
	}

	public Date getDeliveryDate() {
		return deliveryDate;
	}

	public void setDeliveryDate(Date deliveryDate) {
		this.deliveryDate = deliveryDate;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@OneToMany(mappedBy = "saleOrder", fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
	private List<SaleOrderProduct> saleOrderProducts = new ArrayList<>();

	
	
}
