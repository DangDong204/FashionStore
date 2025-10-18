package vn.devpro.javaweb32.service;

import java.util.List;

import javax.persistence.Query;

import org.springframework.stereotype.Service;

import vn.devpro.javaweb32.model.SaleOrderProduct;

@Service
public class SaleOrderProductService extends BaseService<SaleOrderProduct>{

	@Override
	public Class<SaleOrderProduct> clazz() {
		
		return SaleOrderProduct.class;
	}
	
	// Lấy top 5 sản phẩm bán chạy nhất
    @SuppressWarnings("unchecked")
    public List<Object[]> getTop5SellingProducts() {
        String sql = "SELECT p.name AS product_name, SUM(sop.quantity) AS total_sold "
                   + "FROM tbl_sale_order_product sop "
                   + "JOIN tbl_product p ON sop.product_id = p.id "
                   + "GROUP BY p.name "
                   + "ORDER BY total_sold DESC "
                   + "LIMIT 5";

        Query query = entityManager.createNativeQuery(sql);
        return query.getResultList();
    }
}
