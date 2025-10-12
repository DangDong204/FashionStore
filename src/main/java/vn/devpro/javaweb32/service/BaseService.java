package vn.devpro.javaweb32.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Table;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import vn.devpro.javaweb32.model.BaseModel;

@Service
public abstract class BaseService <Model extends BaseModel>{
	
	@PersistenceContext
	EntityManager entityManager;
	
	public abstract Class<Model> clazz();
	
	//	----------------------------------------	
	// Thực hiện 1 lệnh sql ----- QUAN TRỌNG----
	//	----------------------------------------		
	@SuppressWarnings("unchecked")
	protected List<Model> executeNativeSql(String sql) {
		return (List<Model>) entityManager.createNativeQuery(sql, clazz()).getResultList();
	}
	
	//Lay mot ban ghi theo id
	public Model getById(int id) {
		return entityManager.find(clazz(), id);
	}
	
	//Lay tat ca cac ban ghi trong mot table
	@SuppressWarnings("unchecked")
	public List<Model> findAll() {
		Table table = clazz().getAnnotation(Table.class);
		return (List<Model>) entityManager.createNativeQuery(
				"SELECT * FROM " + table.name(), 
				clazz()).getResultList();
	}
	
	@Transactional
	public void saveOrUpdate(Model model) {
	    if (model.getId() == null || model.getId() == 0) {
	        entityManager.persist(model);		// Thêm mới
	    } else {
	        entityManager.merge(model);			// Cập nhật
	    }
	}
	
	@Transactional
	public void deleteById(int id) {
	    Model entity = getById(id);
	    if (entity != null) {
	        entityManager.remove(entity);
	    }
	}

	
}
