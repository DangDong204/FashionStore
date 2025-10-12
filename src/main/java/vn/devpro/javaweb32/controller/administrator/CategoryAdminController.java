package vn.devpro.javaweb32.controller.administrator;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.javaweb32.controller.BaseController;
import vn.devpro.javaweb32.model.Category;
import vn.devpro.javaweb32.service.CategoryService;

@Controller
@RequestMapping("/admin/category/")
public class CategoryAdminController extends BaseController{
	
	@Autowired CategoryService cs;
	
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(Model model) {
		List<Category> categories = cs.findAll();
//		List<Category> categories = cs.findAllActive();
		
		model.addAttribute("categories", categories);
		return "administrator/category/category-list";
	}
	
	@RequestMapping(value = "add", method = RequestMethod.POST)
	public String addPost(Category category) {
	    cs.saveOrUpdate(category);
	    return "redirect:/admin/category/list";
	}
	
	@RequestMapping(value = "edit", method = RequestMethod.POST)
	public String edit(Category category) {
	    cs.saveOrUpdate(category); 				// Dùng chung hàm giống add
	    return "redirect:/admin/category/list";
	}

	
	// Xóa hẳn khỏi database
//	@RequestMapping(value = "delete/{categoryId}", method = RequestMethod.GET)
//	public String viewDelete(@PathVariable("categoryId") int categoryId) {
//		cs.deleteById(categoryId);
//	    return "redirect:/admin/category/list";
//	}
	
	// Xóa - chuyển từ active -> inactive
	@RequestMapping(value = "delete/{categoryId}", method = RequestMethod.GET)
	public String viewDelete(@PathVariable("categoryId") int categoryId) {
		Category category = cs.getById(categoryId);
		category.setStatus(false);
		cs.saveOrUpdate(category);
		return "redirect:/admin/category/list";
	}
	
	
}
