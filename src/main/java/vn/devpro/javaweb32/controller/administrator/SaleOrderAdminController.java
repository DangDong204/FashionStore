package vn.devpro.javaweb32.controller.administrator;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.javaweb32.model.SaleOrder;
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
}
