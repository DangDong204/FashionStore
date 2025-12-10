package vn.devpro.javaweb32.controller.customer;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.javaweb32.controller.BaseController;
import vn.devpro.javaweb32.dto.Cart;
import vn.devpro.javaweb32.dto.CartProduct;
import vn.devpro.javaweb32.model.Product;
import vn.devpro.javaweb32.service.ProductService;

@Controller
public class CustomerCartController extends BaseController{
	
	@Autowired ProductService ps;
	
	@RequestMapping(value = "/cart", method = RequestMethod.GET)
	public String cart(
			final HttpServletRequest request,
			final Model model) {
		
		HttpSession session = request.getSession();
		BigDecimal total = BigDecimal.ZERO;
		if(session.getAttribute("cart") != null) {
			Cart cart = (Cart)session.getAttribute("cart");
			for(CartProduct cartProduct : cart.getCartProducts()) {
				total = total.add(cartProduct.totalPrice());
			}
		}
		model.addAttribute("totalCartPrice", total);
		return "customer/shop-cart";
	}
	
	@RequestMapping(value = "/add-to-cart", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addToCart(
			HttpServletRequest request,
			@RequestBody CartProduct cartProduct){
		
		Map<String, Object> jsonResult = new HashMap<String, Object>();
		
		if(cartProduct.getQuantity().intValue() < 1) {
			jsonResult.put("code", 500);
			jsonResult.put("message", "So luong khong hop le");
		} else { 		// ------------- Them san pham vao gio hang:-------------
			
			// B1: Lay session:
			HttpSession session = request.getSession();
			
			if(session.getAttribute("cart") == null) { 
				// Nếu chưa có giỏ hàng -> Khởi tạo
				Cart cart = new Cart();
				session.setAttribute("cart", cart);
			}
			
			// B2: Lay gio hang:
			Cart cart = (Cart)session.getAttribute("cart");
			int index = cart.findById(cartProduct.getId());
			
			if(index == -1) { // Gio hang chua co san pham nao
				cart.getCartProducts().add(cartProduct);
			}else {
				cart.getCartProducts().get(index).updateQuantity(cartProduct.getQuantity());
			}
			jsonResult.put("code", 200);
			jsonResult.put("message", "Them san pham thanh cong");
			
			BigInteger totalCartProducts = BigInteger.ZERO;
			for(CartProduct product:cart.getCartProducts()) {
				totalCartProducts = totalCartProducts.add(product.getQuantity());
			}
			jsonResult.put("totalCartProducts", totalCartProducts);
		}
		return ResponseEntity.ok(jsonResult);
	}
	
	@RequestMapping(value = "/update-product-quantity", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> editProductCart(
			final HttpServletRequest request,
			@RequestBody CartProduct cartProduct){
		
		Map<String, Object> jsonResults = new HashMap<String, Object>();
		
		Cart cart = null;
		HttpSession session = request.getSession();
		if(session.getAttribute("cart") != null) { // co gio hang
			cart = (Cart)session.getAttribute("cart");
			// Tim hang trong gio can sua
			int index = cart.findById(cartProduct.getId());
			if(index != -1) {
				
				// Lấy thông tin sản phẩm từ database
	            Product product = ps.getById(cartProduct.getId());
	            
	            if (product == null) {
	                jsonResults.put("code", 404);
	                jsonResults.put("message", "Sản phẩm không tồn tại");
	                return ResponseEntity.ok(jsonResults);
	            }
	            
	            int stockQuantity = product.getStockQuantity();
	            int currentQuantityInCart = cart.getCartProducts().get(index).getQuantity().intValue();
	            
	            // TH1: Bấm dấu -
	            if(cartProduct.getQuantity().intValue() == -1) {
	                if(currentQuantityInCart > 1) {
	                    cart.getCartProducts().get(index).updateQuantity(new BigInteger("-1"));
	                }
	            } 
	            // TH2: Bấm dấu +
	            else if(cartProduct.getQuantity().intValue() == 1) {
	                // Kiểm tra xem có vượt quá tồn kho không
	                if (currentQuantityInCart + 1 > stockQuantity) {
	                    jsonResults.put("code", 400);
	                    jsonResults.put("message", "Số lượng vượt quá tồn kho. Chỉ còn " + stockQuantity + " sản phẩm");
	                    jsonResults.put("stockQuantity", stockQuantity);
	                    jsonResults.put("currentQuantity", currentQuantityInCart);
	                    return ResponseEntity.ok(jsonResults);
	                }
	                cart.getCartProducts().get(index).updateQuantity(new BigInteger("1"));
	            }
				// Cap nhat lai session
				session.setAttribute("cart", cart);
				
				int newQuantity = cart.getCartProducts().get(index).getQuantity().intValue();
	            int remainingStock = stockQuantity - newQuantity;
				
				jsonResults.put("code", 200);
				jsonResults.put("productId", cartProduct.getId());
				jsonResults.put("newQuantity", cart.getCartProducts().get(index).getQuantity());
				jsonResults.put("remainingStock", remainingStock);
				jsonResults.put("totalPrice", toCurrency(cart.getCartProducts().get(index).totalPrice()) + " ₫");
				jsonResults.put("totalCartPrice", toCurrency(cart.totalCartPrice()) + " ₫");
				jsonResults.put("totalCartProducts", super.totalCartProducts(request));
				
				
	
			}
		}
		return ResponseEntity.ok(jsonResults);
	}
	
	//Chuyen so sang chuoi dinh dang tien te
	public StringBuilder toCurrency (BigDecimal money) {
		StringBuilder str = new StringBuilder(""+ money.longValue());
		int i = str.length() - 3;
		int j = 0;
		while (i > 0) {
			if (j % 3 == 0) {
				str.insert (i, ".");
			}
			i--;
			j++;
		}
		return str;
	}
	
	@RequestMapping(value = "/cart-product-delete", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> deleteCartProduct(
	        final HttpServletRequest request,
	        @RequestBody CartProduct cartProduct) {

	    Map<String, Object> jsonResult = new HashMap<>();
	    HttpSession session = request.getSession();
	    if (session.getAttribute("cart") != null) {
	        Cart cart = (Cart) session.getAttribute("cart");
	        int index = cart.findById(cartProduct.getId());
	        if (index != -1) {
	            cart.getCartProducts().remove(index);
	        }
	        session.setAttribute("cart", cart);

	        jsonResult.put("code", 200);
	        jsonResult.put("totalCartPrice", toCurrency(cart.totalCartPrice()) + " ₫");
	        jsonResult.put("totalCartProducts", super.totalCartProducts(request));
	    } else {
	        jsonResult.put("code", 404);
	        jsonResult.put("message", "Không tìm thấy giỏ hàng");
	    }

	    return ResponseEntity.ok(jsonResult);
	}


}
