package cn.itcast.estore.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import cn.itcast.estore.domain.Category;
import cn.itcast.estore.domain.Product;
import cn.itcast.estore.utils.DataSourceUtils;

public class ProductDao {

	public void addProduct(Product p) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "insert into products values(?,?,?,?,?,?,?)";
		runner.update(sql, p.getId(), p.getName(), p.getPrice(),
				p.getCategory(), p.getPnum(), p.getImgurl(), p.getDescription());
	}
	
	public void addCategroy(String c) throws SQLException{
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "insert into category value(?)";
		runner.update(sql,c);
	}
	
	public List<Category> findCate() throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from category";
		return runner.query(sql, new BeanListHandler<Category>(Category.class));
	}

	public List<Product> findAll() throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from products";
		return runner.query(sql, new BeanListHandler<Product>(Product.class));
	}

	public Product findById(String id) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from products where id=? ";
		return runner.query(sql, new BeanHandler<Product>(Product.class),id);
	}

	public List<Product> findByName(String name) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from products where name like ?";
		return runner.query(sql, new BeanListHandler<Product>(Product.class),"%"+name+"%");
	}
	
	public List<Product> findByCate(String cate) throws SQLException {
		QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
		String sql = "select * from products where category=?";
		return runner.query(sql, new BeanListHandler<Product>(Product.class),cate);
	}
}
