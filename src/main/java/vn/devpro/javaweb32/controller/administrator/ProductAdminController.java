package vn.devpro.javaweb32.controller.administrator;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import vn.devpro.javaweb32.controller.BaseController;
import vn.devpro.javaweb32.dto.Jw32Contant;
import vn.devpro.javaweb32.model.Category;
import vn.devpro.javaweb32.model.Product;
import vn.devpro.javaweb32.model.ProductImage;
import vn.devpro.javaweb32.service.CategoryService;
import vn.devpro.javaweb32.service.ProductService;

@Controller
@RequestMapping("/admin/product/")
public class ProductAdminController extends BaseController implements Jw32Contant{
	
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
						@RequestParam("categoryId") int categoryId,
						@RequestParam("avatarFile") MultipartFile avatarFile,
						@RequestParam("imageFiles") MultipartFile[] imageFiles) 
						throws IOException {
		
		Category category = cs.getById(categoryId);
		product.setCategory(category);
		
		// Xử lý file avatar
		if (!avatarFile.isEmpty()) {
			String avatarFolder = FOLDER_UPLOAD + "Product/Avatar/";
			String fileName = avatarFile.getOriginalFilename();
			File dest = new File(avatarFolder + fileName);
			avatarFile.transferTo(dest);
			product.setAvatar("UploadFiles/Product/Avatar/" + fileName); // lưu path tương đối
		}
		
		// Lưu sản phẩm luôn: vì các ảnh phụ cần có product_id để liên kết
	    ps.saveOrUpdate(product);
	    
	    // Xử lý nhiều ảnh phụ
	    if (imageFiles != null && imageFiles.length > 0) {
	        String imageFolder = FOLDER_UPLOAD + "Product/Image/";

	        for (MultipartFile file : imageFiles) {
	            if (!file.isEmpty()) {
	                String fileName = file.getOriginalFilename();
	                File dest = new File(imageFolder + fileName);
	                file.transferTo(dest);

	                ProductImage productImage = new ProductImage();
	                productImage.setProduct(product);
	                productImage.setTitle(file.getOriginalFilename());
	                productImage.setPath("UploadFiles/Product/Image/" + fileName);
	                productImage.setStatus(true);

	                product.getProductImages().add(productImage);
	            }
	        }
	    }
	    // Lưu sản phẩm lần 2
	    ps.saveOrUpdate(product);
	    return "redirect:/admin/product/list";
	}
	
	@RequestMapping(value = "edit", method = RequestMethod.POST)
	public String edit(Product product,
	                   @RequestParam("categoryId") int categoryId,
	                   @RequestParam(value = "avatarFile", required = false) MultipartFile avatarFile,
	                   @RequestParam(value = "imageFiles", required = false) MultipartFile[] imageFiles)
	                   throws IOException {

	    Category category = cs.getById(categoryId);
	    product.setCategory(category);

	    // Lấy sản phẩm cũ từ DB để giữ ảnh cũ nếu không upload mới
	    Product oldProduct = ps.getById(product.getId());
	    product.setAvatar(oldProduct.getAvatar()); // giữ avatar cũ mặc định
	    product.setProductImages(oldProduct.getProductImages()); // giữ ảnh phụ cũ

	    // ==== Xử lý avatar mới ====
	    if (avatarFile != null && !avatarFile.isEmpty()) {
	        String avatarFolder = FOLDER_UPLOAD + "Product/Avatar/";
	        String fileName = avatarFile.getOriginalFilename();
	        File dest = new File(avatarFolder + fileName);
	        avatarFile.transferTo(dest);
	        product.setAvatar("UploadFiles/Product/Avatar/" + fileName);
	    }

	    // ==== Xử lý ảnh phụ mới (nếu có) ====
	    if (imageFiles != null && imageFiles.length > 0) {
	        String imageFolder = FOLDER_UPLOAD + "Product/Image/";
	        for (MultipartFile file : imageFiles) {
	            if (!file.isEmpty()) {
	                String fileName = file.getOriginalFilename();
	                File dest = new File(imageFolder + fileName);
	                file.transferTo(dest);

	                ProductImage newImg = new ProductImage();
	                newImg.setProduct(product);
	                newImg.setTitle(file.getOriginalFilename());
	                newImg.setPath("UploadFiles/Product/Image/" + fileName);
	                newImg.setStatus(true);
	                product.getProductImages().add(newImg);
	            }
	        }
	    }

	    ps.saveOrUpdate(product);
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
