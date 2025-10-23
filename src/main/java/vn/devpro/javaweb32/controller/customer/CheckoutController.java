package vn.devpro.javaweb32.controller.customer;

import java.math.BigDecimal;
import java.util.List;

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
import vn.devpro.javaweb32.model.Product;
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
	
	// Thêm phương thức POST mới cho checkout
	@RequestMapping(value = "/checkout", method = RequestMethod.POST)
	public String placeOrder(final HttpServletRequest request, final Model model) {
	    
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
	    String paymentMethod = request.getParameter("paymentMethod");
	    
	    // Tính tổng tiền cuối cùng (có thể đã được giảm giá)
	    BigDecimal finalTotal = cart.totalCartPrice();
	    Voucher appliedVoucher = (Voucher) session.getAttribute("appliedVoucher");
	    BigDecimal discountValue = (BigDecimal) session.getAttribute("discountValue");

	    if (appliedVoucher != null && discountValue != null) {
	        finalTotal = cart.totalCartPrice().subtract(discountValue);
	        if (finalTotal.compareTo(BigDecimal.ZERO) < 0) {
	            finalTotal = BigDecimal.ZERO;
	        }
	    }
	    
	    // KIỂM TRA: Nếu đã có đơn hàng chờ thanh toán trong session, sử dụng lại
	    SaleOrder saleorder = (SaleOrder) session.getAttribute("pendingOrder");
	    boolean isExistingOrder = (saleorder != null);
	    
	    if (saleorder == null) {
	        // Tạo đối tượng SaleOrder mới
	        saleorder = new SaleOrder();
	        saleorder.setCode(System.currentTimeMillis() + phone); // mã đơn hàng
	    }
	    
	    // Cập nhật thông tin đơn hàng (cả mới và cũ)
	    saleorder.setCustomerName(name);
	    saleorder.setCustomerAddress(address);
	    saleorder.setCustomerMobile(phone);
	    saleorder.setCustomerEmail(email);
	    saleorder.setTotal(finalTotal);
	    
	    User user = new User();
	    user.setId(2); // Hoặc lấy từ user đã đăng nhập
	    saleorder.setUser(user);
	    saleorder.setStatus(true);
	    
	    // Thêm voucher nếu có
	    if (appliedVoucher != null) {
	        saleorder.setVoucher(appliedVoucher);
	    }
	    
	    // Xác định phương thức thanh toán
	    if ("VNPAY".equals(paymentMethod)) {
	        // Lưu đơn hàng với trạng thái chờ thanh toán
	        saleorder.setOrderStatus(0); // Chờ thanh toán
	        saleorder.setPaymentMethod(1); // VNPay
	        ss.saveOrUpdate(saleorder);
	        
	        // CHỈ lưu sản phẩm nếu là đơn hàng mới
	        if (!isExistingOrder) {
	            // Lưu các sản phẩm trong đơn hàng
	            for (CartProduct p : cart.getCartProducts()) {
	                Product product = ps.getById(p.getId());
	             // Kiểm tra số lượng tồn kho trước khi trừ
	                if (product.getStockQuantity() >= p.getQuantity().intValue()) {
	                    product.setStockQuantity(product.getStockQuantity() - p.getQuantity().intValue());
	                    ps.saveOrUpdate(product);
	                }
	                
	                SaleOrderProduct saleOrderProduct = new SaleOrderProduct();
	                saleOrderProduct.setSaleOrder(saleorder);
	                saleOrderProduct.setProduct(ps.getById(p.getId()));
	                saleOrderProduct.setQuantity(p.getQuantity().intValue());
	                saleOrderProduct.setPrice(p.getPrice());
	                saleOrderProduct.setProductName(p.getName());
	                
	                sps.saveOrUpdate(saleOrderProduct);
	            }
	        }
	        
	        // Lưu đơn hàng vào session để sử dụng khi thanh toán
	        session.setAttribute("pendingOrder", saleorder);
	        session.setAttribute("totalCartPrice", finalTotal);
	        
	        // Chuyển hướng đến trang chọn VNPay
	        return "redirect:/create-payment";
	        
	    } else {
	        // Thanh toán COD (giữ nguyên logic cũ)
	        saleorder.setOrderStatus(2); // Đã đặt hàng (chờ xác nhận)
	        saleorder.setPaymentMethod(0); // COD
	        ss.saveOrUpdate(saleorder);

	        // Lưu các sản phẩm (chỉ nếu là đơn hàng mới)
	        if (!isExistingOrder) {
	            for (CartProduct p : cart.getCartProducts()) {
	                Product product = ps.getById(p.getId());
	                product.setStockQuantity(product.getStockQuantity() - p.getQuantity().intValue());
	                ps.saveOrUpdate(product);
	                
	                SaleOrderProduct saleOrderProduct = new SaleOrderProduct();
	                saleOrderProduct.setSaleOrder(saleorder);
	                saleOrderProduct.setProduct(ps.getById(p.getId()));
	                saleOrderProduct.setQuantity(p.getQuantity().intValue());
	                saleOrderProduct.setPrice(p.getPrice());
	                saleOrderProduct.setProductName(p.getName());

	                sps.saveOrUpdate(saleOrderProduct);
	            }
	        }

	        // Xóa session
	        session.removeAttribute("cart");
	        session.removeAttribute("appliedVoucher");
	        session.removeAttribute("discountValue");
	        session.removeAttribute("pendingOrder"); // Xóa đơn hàng chờ thanh toán

	        return "redirect:/success";
	    }
	}
	
	@RequestMapping(value = "/cancel-pending-order", method = RequestMethod.GET)
	public String cancelPendingOrder(HttpSession session) {
	    SaleOrder pendingOrder = (SaleOrder) session.getAttribute("pendingOrder");
	    
	    if (pendingOrder != null) {
	    	
	    	// Lấy danh sách sản phẩm trong đơn hàng
            List<SaleOrderProduct> orderProducts = sps.findBySaleOrder(pendingOrder);
            
            // Khôi phục số lượng tồn kho cho từng sản phẩm
            for (SaleOrderProduct orderProduct : orderProducts) {
                Product product = orderProduct.getProduct();
                if (product != null) {
                    // Cộng lại số lượng đã trừ
                    product.setStockQuantity(product.getStockQuantity() + orderProduct.getQuantity());
                    ps.saveOrUpdate(product);
                    System.out.println("Khôi phục " + orderProduct.getQuantity() + " sản phẩm: " + product.getName());
                }
            }
	    	
	        // Xóa đơn hàng khỏi database
	        ss.deleteById(pendingOrder.getId());
	        // Xóa khỏi session
	        session.removeAttribute("pendingOrder");
	    }
	    
	    return "redirect:/checkout";
	}

}
