package vn.devpro.javaweb32.controller.customer;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.javaweb32.controller.BaseController;
import vn.devpro.javaweb32.model.Product;
import vn.devpro.javaweb32.service.ProductService;

@Controller
public class CustomerHomeController extends BaseController {

	@Autowired
	ProductService ps = new ProductService();
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String home(final Model model) {
		List<Product> products = ps.findAllActive();
		model.addAttribute("products", products);
		return "customer/index";
	}
	
	@RequestMapping(value = "/product/{productId}", method = RequestMethod.GET)
	public String home(final Model model,
						@PathVariable("productId") int productId) {
		// Lấy từ bảng tbl_product
		Product product = ps.getById(productId);
		model.addAttribute("product", product);

		return "customer/product";
	}
	
}
