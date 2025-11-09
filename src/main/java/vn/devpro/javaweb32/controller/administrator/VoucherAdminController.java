package vn.devpro.javaweb32.controller.administrator;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.javaweb32.controller.BaseController;
import vn.devpro.javaweb32.model.Voucher;
import vn.devpro.javaweb32.service.VoucherService;

@Controller
@RequestMapping("/admin/voucher/")
public class VoucherAdminController extends BaseController{

	@Autowired VoucherService vs;
	
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(Model model) {
		List<Voucher> vouchers = vs.findAll();
//		List<Voucher> vouchers = vs.findAllActive();
		model.addAttribute("vouchers", vouchers);
	
		return "administrator/voucher/voucher-list";
	}
	
	@RequestMapping(value = "add", method = RequestMethod.POST)
	public String add(Voucher voucher) {
	    vs.saveOrUpdate(voucher);
	    return "redirect:/admin/voucher/list";
	}
	
	@RequestMapping(value = "edit", method = RequestMethod.POST)
	public String edit(Voucher voucher) {
	    vs.saveOrUpdate(voucher);
	    return "redirect:/admin/voucher/list";
	}
	
	@RequestMapping(value = "delete/{voucherId}", method = RequestMethod.GET)
	public String delete(@PathVariable("voucherId") int voucherId) {
		Voucher voucher = vs.getById(voucherId);
		voucher.setStatus(false);
		vs.saveOrUpdate(voucher);
		return "redirect:/admin/voucher/list";
	}

}
