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
}
