package cn.itcast.estore.service;

import java.sql.SQLException;
import java.util.List;

import cn.itcast.estore.dao.ProductDao;
import cn.itcast.estore.domain.Category;
import cn.itcast.estore.domain.Product;
import cn.itcast.estore.domain.User;
import cn.itcast.estore.exception.PrivilegeException;

public class ProductServiceImpl implements ProductService {

	// 添加商品
	public void add(User user, Product product) throws PrivilegeException,
	SQLException {

		ProductDao dao = new ProductDao();

		dao.addProduct(product);

	}

	//添加分类
	public void addCategroy(User user,String categroy) throws PrivilegeException,
	SQLException{
		ProductDao dao = new ProductDao();
		dao.addCategroy(categroy);
	}

	// 查找所有分类
	public List<Category> findCate() throws SQLException {
		ProductDao dao = new ProductDao();
		return dao.findCate();
	}

	// 查找所有商品
	public List<Product> findAll() throws SQLException {
		ProductDao dao = new ProductDao();
		return dao.findAll();
	}

	// 根据id查找商品
	public Product findById(String id) throws SQLException {
		ProductDao dao = new ProductDao();
		return dao.findById(id);
	}

	// 根据name查找商品
	public List<Product> findByName(String name) throws SQLException {
		ProductDao dao = new ProductDao();
		return dao.findByName(name);
	}

	// 根据分类查找商品
	public List<Product> findByCate(String cate) throws SQLException {
		ProductDao dao = new ProductDao();
		return dao.findByCate(cate);
	}
}
