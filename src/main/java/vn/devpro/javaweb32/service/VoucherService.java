package vn.devpro.javaweb32.service;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import vn.devpro.javaweb32.model.Voucher;

@Service
public class VoucherService extends BaseService<Voucher>{

	@Override
	public Class<Voucher> clazz() {
		
		return Voucher.class;
	}
	
	public List<Voucher> findAllActive() {
		String sql = "SELECT * FROM tbl_voucher WHERE status = 1";
		return executeNativeSql(sql);
	}
	
	// Tìm voucher theo mã code
	@SuppressWarnings("unchecked")
	public Voucher findByCode(String code) {
		String sql = "SELECT * FROM tbl_voucher WHERE code = '" + code + "'";
		var result = executeNativeSql(sql);
		return result.isEmpty() ? null : result.get(0);
	}
	
	@Transactional
	@Override
	public void saveOrUpdate(Voucher voucher) {
	    if (voucher.getId() == null || voucher.getId() == 0) {
	        // Thêm mới
	        voucher.setCreateDate(new Date()); 
	        entityManager.persist(voucher);
	    } else {
	        // Cập nhật
	        Voucher existing = entityManager.find(Voucher.class, voucher.getId());
	        if (existing != null) {
	            voucher.setCreateDate(existing.getCreateDate());
	            voucher.setCreateBy(existing.getCreateBy());
	            entityManager.merge(voucher);
	        }
	    }
	}


}
