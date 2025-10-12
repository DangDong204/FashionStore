package vn.devpro.javaweb32.service;

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

}
