package vn.devpro.javaweb32.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_product_image")
public class ProductImage extends BaseModel{
	
	// ----------- Mapping many-to-one: productImage-to-product ------------
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;

    @Column(name = "title", length = 500)
    private String title;

    @Column(name = "path", length = 300)
    private String path;

	public ProductImage() {
		super();
	}

	public ProductImage(Integer id, Integer createBy, Integer updateBy, Date createDate, Date updateDate,
			Boolean status, Product product, String title, String path) {
		super(id, createBy, updateBy, createDate, updateDate, status);
		this.product = product;
		this.title = title;
		this.path = path;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}
    

}
