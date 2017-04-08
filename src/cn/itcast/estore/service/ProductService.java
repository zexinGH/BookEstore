package cn.itcast.estore.service;

import java.util.List;

import cn.itcast.estore.annotation.PrivilegeInfo;
import cn.itcast.estore.domain.Category;
import cn.itcast.estore.domain.Product;
import cn.itcast.estore.domain.User;
import cn.itcast.estore.exception.PrivilegeException;

public interface ProductService {

	// 添加商品
	@PrivilegeInfo("添加商品")
	public void add(User user, Product product) throws PrivilegeException,
			Exception;
	
	//添加分类
	@PrivilegeInfo("添加分类")
	public void addCategroy(User user,String categroy) throws PrivilegeException,
			Exception;

	// 查找所有商品
	public List<Product> findAll() throws Exception;

	// 查找分类
	public List<Category> findCate() throws Exception;
		
	// 根据id查找商品
	public Product findById(String id) throws Exception;
	
	// 根据name查找商品
	public List<Product> findByName(String name) throws Exception;
	
	// 根据分类查找商品
	public List<Product> findByCate(String cate) throws Exception;
}
