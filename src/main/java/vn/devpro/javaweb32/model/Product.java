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
@Table(name = "tbl_product")
public class Product extends BaseModel{
	
	// ----------- Mapping many-to-one: product-to-category ------------
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id", nullable = false)
    private Category category;

    @Column(name = "name", nullable = false, length = 300)
    private String name;

    @Column(name = "avatar", length = 300)
    private String avatar;

    @Column(name = "price", nullable = false, precision = 15, scale = 2)
    private BigDecimal price;

    @Column(name = "sale_price", precision = 15, scale = 2)
    private BigDecimal salePrice = BigDecimal.ZERO;

    @Column(name = "is_hot", nullable = true)
    private Boolean isHot = Boolean.FALSE;

    @Column(name = "stock_quantity", nullable = false)
    private Integer stockQuantity;

    @Column(name = "short_description", length = 500)
    private String shortDescription;

    @Column(name = "detail_description", length = 500)
    private String detailDescription;

	public Product() {
		super();
	}
	
	public Product(Integer id, Integer createBy, Integer updateBy, Date createDate, Date updateDate, Boolean status,
			Category category, String name, String avatar, BigDecimal price, BigDecimal salePrice, Boolean isHot,
			Integer stockQuantity, String shortDescription, String detailDescription) {
		super(id, createBy, updateBy, createDate, updateDate, status);
		this.category = category;
		this.name = name;
		this.avatar = avatar;
		this.price = price;
		this.salePrice = salePrice;
		this.isHot = isHot;
		this.stockQuantity = stockQuantity;
		this.shortDescription = shortDescription;
		this.detailDescription = detailDescription;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
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

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public BigDecimal getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(BigDecimal salePrice) {
		this.salePrice = salePrice;
	}

	public Boolean getIsHot() {
		return isHot;
	}

	public void setIsHot(Boolean isHot) {
		this.isHot = isHot;
	}

	public Integer getStockQuantity() {
		return stockQuantity;
	}

	public void setStockQuantity(Integer stockQuantity) {
		this.stockQuantity = stockQuantity;
	}

	public String getShortDescription() {
		return shortDescription;
	}

	public void setShortDescription(String shortDescription) {
		this.shortDescription = shortDescription;
	}

	public String getDetailDescription() {
		return detailDescription;
	}

	public void setDetailDescription(String detailDescription) {
		this.detailDescription = detailDescription;
	}

	public List<ProductImage> getProductImages() {
		return productImages;
	}

	public void setProductImages(List<ProductImage> productImages) {
		this.productImages = productImages;
	}

	// ----------- Mapping one-to-many: productImage-to-product ------------
	// ----------- Cách này khác các thầy (Thầy dùng Set) ------------------
	@OneToMany(mappedBy = "product", fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
	private List<ProductImage> productImages = new ArrayList<>();
	
	@OneToMany(mappedBy = "product", fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
	private List<SaleOrderProduct> saleOrderProducts = new ArrayList<>();

    
}
