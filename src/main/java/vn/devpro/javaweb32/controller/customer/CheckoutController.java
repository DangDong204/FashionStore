package vn.devpro.javaweb32.controller.customer;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.javaweb32.controller.BaseController;
import vn.devpro.javaweb32.dto.Cart;
import vn.devpro.javaweb32.dto.CartProduct;
import vn.devpro.javaweb32.model.SaleOrder;
import vn.devpro.javaweb32.model.SaleOrderProduct;
import vn.devpro.javaweb32.model.User;
import vn.devpro.javaweb32.model.Voucher;
import vn.devpro.javaweb32.service.ProductService;
import vn.devpro.javaweb32.service.SaleOrderProductService;
import vn.devpro.javaweb32.service.SaleOrderService;

@Controller
public class CheckoutController extends BaseController{
	
	@Autowired ProductService ps;
	
	@Autowired SaleOrderService ss;
	
	@Autowired SaleOrderProductService sps;
	
	@RequestMapping(value = "/checkout", method = RequestMethod.GET)
	public String checkout(final HttpServletRequest request, final Model model) {
        HttpSession session = request.getSession();
        
        // Kiểm tra xem có giỏ hàng trong session không
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getCartProducts().isEmpty()) {
            // Nếu giỏ hàng trống thì quay lại trang giỏ hàng
            return "redirect:/cart";
        }
        
        // Tính tổng tiền
        BigDecimal total = BigDecimal.ZERO;
        for (CartProduct p : cart.getCartProducts()) {
            total = total.add(p.totalPrice());
        }
        
     // THÊM PHẦN NÀY: Áp dụng discount từ voucher nếu có
        Voucher appliedVoucher = (Voucher) session.getAttribute("appliedVoucher");
        BigDecimal discountValue = (BigDecimal) session.getAttribute("discountValue");
        
        BigDecimal finalTotal = total;
        if (appliedVoucher != null && discountValue != null) {
            finalTotal = total.subtract(discountValue);
            // Đảm bảo tổng tiền không âm
            if (finalTotal.compareTo(BigDecimal.ZERO) < 0) {
                finalTotal = BigDecimal.ZERO;
            }
            
            // Thêm thông tin voucher vào model để hiển thị
            model.addAttribute("appliedVoucher", appliedVoucher);
            model.addAttribute("discountValue", discountValue);
        }

        // Đưa dữ liệu sang JSP
        model.addAttribute("cart", cart);
        model.addAttribute("totalCartPrice", finalTotal); // Sử dụng finalTotal thay vì total - update T6 ngày 17/10
        //model.addAttribute("totalCartPrice", total);

        return "customer/checkout";
    }
	
	@RequestMapping(value = "checkout", method = RequestMethod.POST)
	public String placeOrder(final HttpServletRequest request) {
	    
		HttpSession session = request.getSession();
	    Cart cart = (Cart) session.getAttribute("cart");
	    if (cart == null || cart.getCartProducts().isEmpty()) {
	        return "redirect:/cart";
	    }

	    // Lấy thông tin từ form
	    String name = request.getParameter("customerName");
	    String address = request.getParameter("customerAddress");
	    String phone = request.getParameter("customerPhone");
	    String email = request.getParameter("customerEmail");
	    
	    // Tính tổng tiền cuối cùng (có thể đã được giảm giá)
	    BigDecimal finalTotal = cart.totalCartPrice();
	    Voucher appliedVoucher = (Voucher) session.getAttribute("appliedVoucher");
	    BigDecimal discountValue = (BigDecimal) session.getAttribute("discountValue");

	    if (appliedVoucher != null && discountValue != null) {
	        finalTotal = cart.totalCartPrice().subtract(discountValue);
	        // Đảm bảo tổng tiền không âm
	        if (finalTotal.compareTo(BigDecimal.ZERO) < 0) {
	            finalTotal = BigDecimal.ZERO;
	        }
	    }
	    
	    // 1️: Tạo đối tượng SaleOrder
	    SaleOrder saleorder = new SaleOrder();
	    saleorder.setCustomerName(name);
	    saleorder.setCustomerAddress(address);
	    saleorder.setCustomerMobile(phone);
	    saleorder.setCustomerEmail(email);
	    saleorder.setTotal(finalTotal);
	    saleorder.setCode(System.currentTimeMillis() + saleorder.getCustomerMobile()); // mã đơn hàng
	    User user = new User();
		user.setId(2);
		
		saleorder.setUser(user);
		saleorder.setStatus(true);
	    

		// Thêm voucher nếu có
	    if (appliedVoucher != null) {
	        saleorder.setVoucher(appliedVoucher);
	    }
		
	    // 2️: Lưu đơn hàng vào DB
	    ss.saveOrUpdate(saleorder);;

	    // 3️: Lưu các sản phẩm trong giỏ hàng vào bảng sale_order_product
	    for (CartProduct p : cart.getCartProducts()) {
	        SaleOrderProduct saleOrderProduct = new SaleOrderProduct();
	        saleOrderProduct.setSaleOrder(saleorder);
	        saleOrderProduct.setProduct(ps.getById(p.getId()));
	        saleOrderProduct.setQuantity(p.getQuantity().intValue());
	        saleOrderProduct.setPrice(p.getPrice());
			saleOrderProduct.setProductName(p.getName());

	        sps.saveOrUpdate(saleOrderProduct);;
	    }

	    // 4️: Xóa giỏ hàng sau khi đặt hàng thành công
	    session.removeAttribute("cart");
	    session.removeAttribute("appliedVoucher");
	    session.removeAttribute("discountValue");


	    // 5️: Chuyển hướng đến trang xác nhận
	    return "redirect:/success";
	}

}
