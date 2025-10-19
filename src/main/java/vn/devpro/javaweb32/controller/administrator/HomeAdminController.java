package vn.devpro.javaweb32.controller.administrator;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import vn.devpro.javaweb32.controller.BaseController;
import vn.devpro.javaweb32.service.SaleOrderProductService;
import vn.devpro.javaweb32.service.UserService;

@Controller
public class HomeAdminController extends BaseController{
	
	@Autowired SaleOrderProductService sops;
	
	@Autowired UserService us;
	
	@RequestMapping(value ="/admin/home")
	public String list(Model model) throws JsonProcessingException {
		
		List<Object[]> topProducts = sops.getTop5SellingProducts();

        List<String> productNames = new ArrayList<>();
        List<Integer> productSales = new ArrayList<>();

        for (Object[] row : topProducts) {
            productNames.add((String) row[0]);
            productSales.add(((Number) row[1]).intValue());
        }

        model.addAttribute("productNames", productNames);
        model.addAttribute("productSales", productSales);
        
        // --------------
        List<Object[]> revenueData = sops.getRevenueLast7Days();
		List<String> orderDates = new ArrayList<>();
		List<Double> totalRevenue = new ArrayList<>();

		for (Object[] row : revenueData) {
			orderDates.add(row[0].toString()); // yyyy-MM-dd
			totalRevenue.add(((Number) row[1]).doubleValue());
		}

		ObjectMapper mapper = new ObjectMapper();
		model.addAttribute("orderDates", mapper.writeValueAsString(orderDates));
		model.addAttribute("totalRevenue", mapper.writeValueAsString(totalRevenue));
        
		 // --- Đếm số ĐH trong tháng ---
	    Long ordersThisMonth = sops.countOrdersInCurrentMonth();
	    model.addAttribute("ordersThisMonth", ordersThisMonth);
		
	    // Tính tổng doanh thu tháng này
	    Double totalRevenueThisMonth = sops.getTotalRevenueThisMonth();
	    model.addAttribute("totalRevenueThisMonth", totalRevenueThisMonth);
	    
	    // Số lượng khách hàng
	    Long totalCustomers = us.countAllUsers();
	    model.addAttribute("totalCustomers", totalCustomers);
	    
		return "administrator/home";
	}
}
