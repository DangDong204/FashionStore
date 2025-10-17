package vn.devpro.javaweb32.model;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_voucher")
public class Voucher extends BaseModel{
	
	@Column(name = "code", nullable = false, length = 100)
    private String code;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "ENUM('PERCENT', 'AMOUNT')")
    private DiscountType discountType;

    @Column(name = "discount_value", precision = 15, scale = 2)
    private BigDecimal discountValue;

    @Column(name = "start_date")
    private Date startDate;

    @Column(name = "end_date")
    private Date endDate;

    @Column(name = "quantity")
    private Integer quantity;

    @Column(name = "min_order_value", precision = 15, scale = 2)
    private BigDecimal minOrderValue;

    // Liên kết ngược: một voucher có thể dùng cho nhiều đơn hàng
    @OneToMany(mappedBy = "voucher", fetch = FetchType.LAZY)
    private List<SaleOrder> saleOrders;

    public enum DiscountType {
        PERCENT, AMOUNT
    }

	public Voucher() {
		super();
	}

	public Voucher(Integer id, Integer createBy, Integer updateBy, Date createDate, Date updateDate, Boolean status,
			String code, DiscountType discountType, BigDecimal discountValue, Date startDate, Date endDate,
			Integer quantity, BigDecimal minOrderValue, List<SaleOrder> saleOrders) {
		super(id, createBy, updateBy, createDate, updateDate, status);
		this.code = code;
		this.discountType = discountType;
		this.discountValue = discountValue;
		this.startDate = startDate;
		this.endDate = endDate;
		this.quantity = quantity;
		this.minOrderValue = minOrderValue;
		this.saleOrders = saleOrders;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public DiscountType getDiscountType() {
		return discountType;
	}

	public void setDiscountType(DiscountType discountType) {
		this.discountType = discountType;
	}

	public BigDecimal getDiscountValue() {
		return discountValue;
	}

	public void setDiscountValue(BigDecimal discountValue) {
		this.discountValue = discountValue;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public BigDecimal getMinOrderValue() {
		return minOrderValue;
	}

	public void setMinOrderValue(BigDecimal minOrderValue) {
		this.minOrderValue = minOrderValue;
	}

	public List<SaleOrder> getSaleOrders() {
		return saleOrders;
	}

	public void setSaleOrders(List<SaleOrder> saleOrders) {
		this.saleOrders = saleOrders;
	}
    
}
