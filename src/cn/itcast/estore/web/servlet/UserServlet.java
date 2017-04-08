package cn.itcast.estore.web.servlet;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import cn.itcast.estore.domain.User;
import cn.itcast.estore.exception.LoginException;
import cn.itcast.estore.exception.RegistException;
import cn.itcast.estore.service.UserServiceImpl;

public class UserServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 得到请求参数method,判断当前是什么操作
		String method = request.getParameter("method");

		if ("login".equals(method)) { // 登录操作台
			login(request, response);
		} else if ("regist".equals(method)) { // 注册操作
			regist(request, response);
		} else if ("logout".equals(method)) {
			// 注销操作
			logout(request, response);
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	// 激活用户操作

	// 注销操作
	public void logout(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getSession().invalidate(); // 销毁session

		Cookie cookie = new Cookie("autologin", "");
		cookie.setMaxAge(0);
		cookie.setPath("/");

		response.addCookie(cookie);

		response.sendRedirect(request.getContextPath() + "/index.jsp");

	}

	// 登录操作
	public void login(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 1.得到用户名与密码
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		// 2.调用service中登录方法
		UserServiceImpl service = new UserServiceImpl();
		try {
			User user = service.login(username, password);

			if (user != null) {

				// 用户如果登录成功，判断是否勾选了记住用户名.
				String saveUsername = request.getParameter("remember");

				if ("on".equals(saveUsername)) {
					// 记住用户名
					Cookie cookie = new Cookie("saveusername",
							URLEncoder.encode(username, "utf-8")); // 存储utf-8码
					cookie.setMaxAge(7 * 24 * 60 * 60); // 可以记住7天
					cookie.setPath("/");
					response.addCookie(cookie);
				} else {
					Cookie cookie = new Cookie("saveusername",
							URLEncoder.encode(username, "utf-8")); // 存储utf-8码
					cookie.setMaxAge(0);
					cookie.setPath("/");
					response.addCookie(cookie);
				}

				// 自动登录
				String autologin = request.getParameter("autologin");

				if ("on".equals(autologin)) {
					// 勾选了自动登录，就将用户名与密码存储到cookie中.
					Cookie cookie = new Cookie("autologin", URLEncoder.encode(
							username, "utf-8") + password);
					cookie.setMaxAge(7 * 24 * 60 * 60);
					cookie.setPath("/");
					response.addCookie(cookie);
				} else {
					Cookie cookie = new Cookie("autologin", URLEncoder.encode(
							username, "utf-8") + password);
					cookie.setMaxAge(0);
					cookie.setPath("/");
					response.addCookie(cookie);
				}

				// 登录成功后，将用户存储到session中.
				request.getSession().invalidate();
				request.getSession().setAttribute("user", user);
				response.sendRedirect(request.getContextPath() + "/index.jsp");
				return;
			} else {
				request.setAttribute("login.message", "用户名或密码错误");
				request.getRequestDispatcher("/page.jsp").forward(request,
						response);
				return;
			}

		} catch (LoginException e) {
			e.printStackTrace();
			request.setAttribute("login.message", e.getMessage());
			request.getRequestDispatcher("/page.jsp")
					.forward(request, response);
			return;
		}
	}

	// 注册操作
	public void regist(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 验证码操作
		String checkcode = request.getParameter("checkcode");

		String _checkcode = (String) request.getSession().getAttribute(
				"checkcode_session");

		request.getSession().removeAttribute("checkcode_session");
		if (_checkcode == null || (!_checkcode.equals(checkcode))) {
			request.setAttribute("regist.message", "验证码不正确");
			request.getRequestDispatcher("/regist.jsp").forward(request,
					response);
			return;
		}

		// 1.得到请求参数，封装到javaBean中.
		User user = new User();
		try {
			BeanUtils.populate(user, request.getParameterMap());
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}

		// 进行服务器端数据校验
		Map<String, String> map = user.validateRegist();

		if (map.size() > 0) {
			// 说明有错误信息
			request.setAttribute("map", map);
			request.getRequestDispatcher("/regist.jsp").forward(request,
					response);
			return;
		}

		// 手动封装一个激活码

		// 2.调用service操作

		UserServiceImpl service = new UserServiceImpl();

		try {
			service.regist(user);
			response.sendRedirect("/bookEstore/page.jsp"); //重定向

		} catch (RegistException e) {
			request.setAttribute("regist.message", e.getMessage());
			request.getRequestDispatcher("/regist.jsp").forward(request,
					response);
			return;
		}

	}

}
