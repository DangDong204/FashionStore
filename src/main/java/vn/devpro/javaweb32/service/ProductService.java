package vn.devpro.javaweb32.service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.stereotype.Service;

import vn.devpro.javaweb32.model.Product;

@Service
public class ProductService extends BaseService<Product>{

	@Override
	public Class<Product> clazz() {
		
		return Product.class;
	}

	public List<Product> findAllActive() {
		String sql = "SELECT * FROM tbl_product WHERE status = 1";
		return executeNativeSql(sql);
	}

	public List<Product> filterProducts(Integer categoryId, BigDecimal minPrice, 
										BigDecimal maxPrice, String keyword) {
		
		String sql = "SELECT * FROM tbl_product WHERE status = 1"; // chỉ lấy sản phẩm active

	    if (categoryId != null) {
	        sql += " AND category_id = " + categoryId;
	    }
	    if (minPrice != null) {
	        sql += " AND price >= " + minPrice;
	    }
	    if (maxPrice != null) {
	        sql += " AND price <= " + maxPrice;
	    }
	    if (keyword != null && !keyword.trim().isEmpty()) {
	        String searchTerm = keyword.trim().toLowerCase();
	        // Tìm kiếm trong name, short_description và detail_description
	        sql += " AND (LOWER(name) LIKE '%" + searchTerm + "%' " +
	               "OR LOWER(short_description) LIKE '%" + searchTerm + "%' " +
	               "OR LOWER(detail_description) LIKE '%" + searchTerm + "%')";
	    }
		return executeNativeSql(sql);
	}

}
