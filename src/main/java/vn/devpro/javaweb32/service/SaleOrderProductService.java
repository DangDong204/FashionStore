package vn.devpro.javaweb32.service;

import java.time.LocalDate;
import java.time.YearMonth;
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
    
    // Doanh thu theo ngày (7 ngày gần nhất)
    @SuppressWarnings("unchecked")
    public List<Object[]> getRevenueLast7Days() {
    	String sql = "SELECT DATE(create_date) AS order_date, SUM(total) AS total_revenue "
                + "FROM tbl_sale_order "
                + "WHERE create_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) "
                + "GROUP BY DATE(create_date) "
                + "ORDER BY order_date ASC";

        Query query = entityManager.createNativeQuery(sql);
        return query.getResultList();
    }
    
    // Số lượng đơn trong tháng
    @SuppressWarnings("unchecked")
    public Long countOrdersInCurrentMonth() {
        String sql = "SELECT COUNT(*) FROM tbl_sale_order "
                   + "WHERE MONTH(create_date) = MONTH(CURDATE()) "
                   + "AND YEAR(create_date) = YEAR(CURDATE())";

        Query query = entityManager.createNativeQuery(sql);
        Object result = query.getSingleResult();

        // Tránh lỗi khi chưa có đơn nào
        if (result == null) return 0L;
        return ((Number) result).longValue();
    }
    
    // Tính tổng doanh thu trong tháng hiện tại
    public Double getTotalRevenueThisMonth() {
        YearMonth currentMonth = YearMonth.now();
        LocalDate startOfMonth = currentMonth.atDay(1);
        LocalDate endOfMonth = currentMonth.atEndOfMonth();

        String sql = "SELECT SUM(total) FROM tbl_sale_order "
                   + "WHERE create_date BETWEEN :start AND :end";

        Object result = entityManager.createNativeQuery(sql)
                .setParameter("start", java.sql.Timestamp.valueOf(startOfMonth.atStartOfDay()))
                .setParameter("end", java.sql.Timestamp.valueOf(endOfMonth.atTime(23, 59, 59)))
                .getSingleResult();

        return result != null ? ((Number) result).doubleValue() : 0.0;
    }
    
    

}
