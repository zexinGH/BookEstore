package cn.itcast.estore.web.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.itcast.estore.domain.User;
import cn.itcast.estore.exception.PrivilegeException;
import cn.itcast.estore.factory.ProductServiceFactory;
import cn.itcast.estore.service.ProductService;

public class AddCategoryServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String categroy =request.getParameter("category");
		// 调用ProductService中的添加商品方法.

		ProductService service = ProductServiceFactory.getInstance();

		try {
			User user = (User) request.getSession().getAttribute("user");
			service.addCategroy(user, categroy);
			response.sendRedirect(request.getContextPath() + "/index.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (PrivilegeException e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath()
					+ "/error/error.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
