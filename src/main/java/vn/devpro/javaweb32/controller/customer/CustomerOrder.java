package vn.devpro.javaweb32.controller.customer;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import vn.devpro.javaweb32.controller.BaseController;
import vn.devpro.javaweb32.model.SaleOrder;
import vn.devpro.javaweb32.model.SaleOrderProduct;
import vn.devpro.javaweb32.model.User;
import vn.devpro.javaweb32.service.SaleOrderProductService;
import vn.devpro.javaweb32.service.SaleOrderService;

@Controller
public class CustomerOrder extends BaseController{
	
	@Autowired SaleOrderService sos;
	
	@Autowired SaleOrderProductService sops;
	
	@GetMapping(value = "/my-order")
	public String myOrder(Model model) {
		
		User loginedUser = getUserLogined();
        if (loginedUser == null) {
            return "redirect:/login";
        }
        
        List<SaleOrder> allOrders = sos.findAllSaleOrderByUser(loginedUser);
        
        // Lọc đơn hàng theo trạng thái
        List<SaleOrder> pendingOrders = sos.findSaleOrderByUserAndOrderStatus(loginedUser, 0);
        List<SaleOrder> confirmedOrders = sos.findSaleOrderByUserAndOrderStatus(loginedUser, 1);
        List<SaleOrder> waitingShipOrders = sos.findSaleOrderByUserAndOrderStatus(loginedUser, 2);
        List<SaleOrder> shippingOrders = sos.findSaleOrderByUserAndOrderStatus(loginedUser, 3);
        List<SaleOrder> deliveredOrders = sos.findSaleOrderByUserAndOrderStatus(loginedUser, 4);
        List<SaleOrder> returnedOrders = sos.findSaleOrderByUserAndOrderStatus(loginedUser, 5);
        
        model.addAttribute("allOrders", allOrders);
        model.addAttribute("pendingOrders", pendingOrders);
        model.addAttribute("confirmedOrders", confirmedOrders);
        model.addAttribute("waitingShipOrders", waitingShipOrders);
        model.addAttribute("shippingOrders", shippingOrders);
        model.addAttribute("deliveredOrders", deliveredOrders);
        model.addAttribute("returnedOrders", returnedOrders);
        
        
        return "customer/order-history";
	}
	
	@GetMapping(value = "/my-order/{orderId}")
    public String orderDetail(@PathVariable("orderId") int orderId, Model model) {
        
        User loginedUser = getUserLogined();
        if (loginedUser == null) {
            return "redirect:/login";
        }
        
        // Lấy đơn hàng theo ID
        SaleOrder order = sos.getById(orderId);
                
        // Lấy danh sách sản phẩm trong đơn hàng
        List<SaleOrderProduct> orderProducts = sops.findBySaleOrder(order);
        
        model.addAttribute("order", order);
        model.addAttribute("orderProducts", orderProducts);
        model.addAttribute("pageTitle", "Chi tiết đơn hàng #" + order.getCode());
        
        return "customer/order-detail";
    }
}
