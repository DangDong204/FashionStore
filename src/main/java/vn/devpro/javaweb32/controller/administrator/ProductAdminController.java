package vn.devpro.javaweb32.controller.administrator;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import vn.devpro.javaweb32.controller.BaseController;
import vn.devpro.javaweb32.model.Category;
import vn.devpro.javaweb32.model.Product;
import vn.devpro.javaweb32.service.CategoryService;
import vn.devpro.javaweb32.service.ProductService;

@Controller
@RequestMapping("/admin/product/")
public class ProductAdminController extends BaseController{
	
	@Autowired ProductService ps;
	
	@Autowired CategoryService cs;
	
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(Model model) {
		List<Product> products = ps.findAll();
//		List<Product> products = ps.findAllActive();
		model.addAttribute("products", products);
		
		List<Category> categories = cs.findAll();
		model.addAttribute("categories", categories);
		
		return "administrator/product/product-list";
	}
	
	@RequestMapping(value = "add", method = RequestMethod.POST)
	public String addPost(Product product,
						@RequestParam("categoryId") int categoryId) {
		Category category = cs.getById(categoryId);
		product.setCategory(category);
	    ps.saveOrUpdate(product);
	    return "redirect:/admin/product/list";
	}
	
	@RequestMapping(value = "edit", method = RequestMethod.POST)
	public String edit(Product product,
					@RequestParam("categoryId") int categoryId) {
		
		Category category = cs.getById(categoryId);
		product.setCategory(category);
		
	    ps.saveOrUpdate(product); 				// Dùng chung hàm giống add
	    return "redirect:/admin/product/list";
	}
	
	// Xóa hẳn khỏi database
//	@RequestMapping(value = "delete/{productId}", method = RequestMethod.GET)
//	public String viewDelete(@PathVariable("productId") int productId) {
//		ps.deleteById(productId);
//		return "redirect:/admin/product/list";
//	}
	
	// Xóa - chuyển từ active -> inactive
	@RequestMapping(value = "delete/{productId}", method = RequestMethod.GET)
	public String viewDelete(@PathVariable("productId") int productId) {
		Product product = ps.getById(productId);
		product.setStatus(false);
		ps.saveOrUpdate(product);
		return "redirect:/admin/product/list";
	}
	
}
