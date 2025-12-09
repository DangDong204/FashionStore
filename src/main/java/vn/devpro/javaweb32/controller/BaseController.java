package vn.devpro.javaweb32.controller;

import java.math.BigInteger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;

import vn.devpro.javaweb32.dto.Cart;
import vn.devpro.javaweb32.dto.CartProduct;
import vn.devpro.javaweb32.model.User;

@Controller
public class BaseController {
	
	@ModelAttribute("totalCartProducts")
	public BigInteger totalCartProducts(
			final HttpServletRequest request) {
		// Lay gio hang -> session
		BigInteger total = BigInteger.ZERO;
		
		HttpSession session = request.getSession();
		if(session.getAttribute("cart") != null) {
			Cart cart = (Cart)session.getAttribute("cart");
			for (CartProduct cartProduct : cart.getCartProducts()) {
				total = total.add(cartProduct.getQuantity());
			}
		}
		return total;
	}
	
	// Bổ sung T3 - 09/12: active Page trên header
	@ModelAttribute("activePage")
	public String getActivePage(HttpServletRequest request) {
	    String requestURI = request.getRequestURI();
	    String contextPath = request.getContextPath();
	    
	    // Loại bỏ context path
	    if (contextPath != null && !contextPath.isEmpty() && requestURI.startsWith(contextPath)) {
	        requestURI = requestURI.substring(contextPath.length());
	    }
	    
	    // Xác định active page
	    if (requestURI == null || requestURI.isEmpty() || requestURI.equals("/") || requestURI.contains("/index")) {
	        return "home";
	    } else if (requestURI.contains("/shop")) {
	        return "shop";
	    } else if (requestURI.contains("/cart")) {
	        return "cart";
	    } else if (requestURI.contains("/checkout")) {
	        return "checkout";
	    } else if (requestURI.contains("/contact")) {
	        return "contact";
	    } else if (requestURI.contains("/my-order")) {
	        return "my-order";
	    } else if (requestURI.contains("/quan")) {
	        return "quan";
	    } else if (requestURI.contains("/ao")) {
	        return "ao";
	    } else if (requestURI.contains("/blog")) {
	        return "blog";
	    }
	    
	    return "";
	}
	
	// Bố sung T7 - 18/10: tự động điền thông tin khi đăng nhập trong checkout
	// Lay thong tin cua user dang nhap
	@ModelAttribute("loginedUser")
	public User getLoginedUser() {

		Object loginedUser = 
				SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (loginedUser != null && loginedUser instanceof UserDetails) {
			User user = (User) loginedUser;
			return user;
		}
		return new User();
	}

	// Kiem tra da login hay chua?
	@ModelAttribute("isLogined")
	public boolean isLogined() {
		Object loginedUser = 
				SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (loginedUser != null && loginedUser instanceof UserDetails) {
			return true;
		}
		return false;
	}
	
	// Thêm phương thức mới để lấy user đã đăng nhập (dùng trong controller)
	public User getUserLogined() {
		Object loginedUser = 
				SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (loginedUser != null && loginedUser instanceof UserDetails) {
			User user = (User) loginedUser;
			return user;
		}
		return null; // Trả về null nếu không có user đăng nhập
	}
}
