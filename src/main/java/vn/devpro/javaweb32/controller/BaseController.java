package vn.devpro.javaweb32.controller;

import java.math.BigInteger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;

import vn.devpro.javaweb32.dto.Cart;
import vn.devpro.javaweb32.dto.CartProduct;

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
}
