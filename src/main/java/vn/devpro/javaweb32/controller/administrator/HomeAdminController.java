package vn.devpro.javaweb32.controller.administrator;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import vn.devpro.javaweb32.controller.BaseController;
import vn.devpro.javaweb32.service.SaleOrderProductService;

@Controller
public class HomeAdminController extends BaseController{
	
	@Autowired SaleOrderProductService sops;
	
	@RequestMapping(value ="/admin/home")
	public String list(Model model) {
		
		List<Object[]> topProducts = sops.getTop5SellingProducts();

        List<String> productNames = new ArrayList<>();
        List<Integer> productSales = new ArrayList<>();

        for (Object[] row : topProducts) {
            productNames.add((String) row[0]);
            productSales.add(((Number) row[1]).intValue());
        }

        model.addAttribute("productNames", productNames);
        model.addAttribute("productSales", productSales);
        
		return "administrator/home";
	}
}
