package vn.devpro.javaweb32.controller.administrator;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.javaweb32.model.SaleOrder;
import vn.devpro.javaweb32.model.SaleOrderProduct;
import vn.devpro.javaweb32.service.SaleOrderService;

@Controller
@RequestMapping("/admin/saleorder/")
public class SaleOrderAdminController {
	
	@Autowired SaleOrderService ss;
	
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(Model model) {
		List<SaleOrder> saleorders = ss.findAll();
		model.addAttribute("saleorders", saleorders);
		
		return "administrator/saleorder/saleorder-list";
	}
	
	// Xem chi tiết đơn hàng
	@RequestMapping(value = "detail/{saleOrderId}", method = RequestMethod.GET)
	public String detail(@PathVariable("saleOrderId") int saleOrderId, Model model) {
	    // Lấy thông tin đơn hàng
	    SaleOrder saleOrder = ss.getById(saleOrderId);
	    if (saleOrder == null) {
	        return "redirect:/admin/saleorder/list";
	    }
	    
	    // Lấy danh sách sản phẩm trong đơn hàng
	    List<SaleOrderProduct> saleOrderProducts = saleOrder.getSaleOrderProducts();
	    
	    model.addAttribute("saleOrder", saleOrder);
	    model.addAttribute("saleOrderProducts", saleOrderProducts);
	    
	    return "administrator/saleorder/saleorder-detail";
	}
	
	// Phương thức cập nhật trạng thái đơn hàng
	@PostMapping(value = "edit")
	public String edit(@ModelAttribute SaleOrder saleOrder) {
	    // Lấy đơn hàng hiện tại từ database
	    SaleOrder existingOrder = ss.getById(saleOrder.getId());
	    
	    if (existingOrder != null) {
	        // Chỉ cập nhật các trường cần thiết
	        existingOrder.setOrderStatus(saleOrder.getOrderStatus());
	        existingOrder.setDescription(saleOrder.getDescription());
	        existingOrder.setUpdateDate(new Date());
	        
	        // Lưu thay đổi
	        ss.saveOrUpdate(existingOrder);
	    }
	    
	    return "redirect:/admin/saleorder/list";
	}
	
	// Phương thức xóa (chuyển status thành false)
	@RequestMapping(value = "delete/{saleOrderId}", method = RequestMethod.GET)
	public String delete(@PathVariable("saleOrderId") int saleOrderId) {
		SaleOrder saleOrder = ss.getById(saleOrderId);
		if (saleOrder != null) {
			saleOrder.setStatus(false);
			saleOrder.setUpdateDate(new Date());
			
			
			
			ss.saveOrUpdate(saleOrder);
		}
		return "redirect:/admin/saleorder/list";
	}
}
