package vn.devpro.javaweb32.controller.administrator;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.javaweb32.controller.BaseController;
import vn.devpro.javaweb32.model.Product;
import vn.devpro.javaweb32.service.ProductService;

@Controller
@RequestMapping("/admin/product/")
public class ProductAdminController extends BaseController{
	
	@Autowired ProductService ps;
	
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(Model model) {
		List<Product> products = ps.findAll();
		model.addAttribute("products", products);
		return "administrator/product/product-list";
	}
	
	
}
