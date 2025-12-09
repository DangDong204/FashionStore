package vn.devpro.javaweb32.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.devpro.javaweb32.model.SaleOrder;
import vn.devpro.javaweb32.model.User;

@Service
public class SaleOrderService extends BaseService<SaleOrder>{

	@Override
	public Class<SaleOrder> clazz() {

		return SaleOrder.class;
	}
	
	// Lấy đơn hàng từ phiên đăng nhập
	public List<SaleOrder> findAllSaleOrderByUser(User user) {
        String sql = "SELECT * FROM tbl_sale_order WHERE user_id = " + user.getId() 
                   + " ORDER BY create_date DESC";
        return super.executeNativeSql(sql);
    }
	
	public List<SaleOrder> findSaleOrderByUserAndOrderStatus(User user, int status) {
	    String sql = "SELECT * FROM tbl_sale_order WHERE user_id = " + user.getId() 
	               + " AND order_status = " + status 
	               + " ORDER BY create_date DESC";
	    return super.executeNativeSql(sql);
	}
	
}
