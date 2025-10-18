package vn.devpro.javaweb32.controller.customer;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import vn.devpro.javaweb32.controller.BaseController;
import vn.devpro.javaweb32.model.Category;
import vn.devpro.javaweb32.model.Product;
import vn.devpro.javaweb32.service.CategoryService;
import vn.devpro.javaweb32.service.ProductService;

@Controller
public class ShopController extends BaseController{
	
	@Autowired ProductService ps;
	
	@Autowired CategoryService cs;
	
	@RequestMapping(value = "/shop", method = RequestMethod.GET) 
	public String productDetail(
				@RequestParam(value = "categoryId", required = false) Integer categoryId,
				@RequestParam(value = "minPrice", required = false) BigDecimal minPrice,
	            @RequestParam(value = "maxPrice", required = false) BigDecimal maxPrice,
	            @RequestParam(value = "keyword", required = false) String keyword,
	            Model model) { 
		
		List<Product> products = ps.filterProducts(categoryId, minPrice, maxPrice, keyword);
        model.addAttribute("products", products);
        
        List<Category> categories = cs.findAllActive();
        model.addAttribute("categories", categories);

        // Truyền lại tham số để giữ giá trị lọc khi reload trang
        model.addAttribute("categoryId", categoryId);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("keyword", keyword);
		
        // Thêm thông báo tìm kiếm (tuỳ chọn)
        if (keyword != null && !keyword.trim().isEmpty()) {
            model.addAttribute("searchMessage", "Kết quả tìm kiếm cho: " + keyword);
        }
		
		return "customer/shop"; 
	}
	
	
	
}
