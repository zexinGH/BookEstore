package cn.itcast.estore.service;

import java.sql.SQLException;

import cn.itcast.estore.dao.UserDao;
import cn.itcast.estore.domain.User;
import cn.itcast.estore.exception.ActiveUserException;
import cn.itcast.estore.exception.LoginException;
import cn.itcast.estore.exception.RegistException;

public class UserServiceImpl implements UserService{

	// 注册功能
	public void regist(User user) throws RegistException {

		// 调用dao中添加用户操作的方法
	 try {
		new UserDao().addUser(user);
	} catch (SQLException e) {
		e.printStackTrace();
	}

	}

	public void activeUser(String activecode) throws RegistException,
			ActiveUserException {
	}

	public User login(String username, String password) throws LoginException {
		UserDao dao = new UserDao();
		User user = null;
		try {
			user = dao.findUserByUserNameAndPassword(username, password);

			if (user == null) {
				throw new LoginException("用户名或密码不正确");
			}
			// 判断用户的状态。
			if (user.getState() == 0) {
				// 用户状态未激活，不能进行登录操作
				throw new LoginException("用户未激活");
			}

		} catch (SQLException e) {
			throw new LoginException("登录失败");
		}

		return user;
	}
}
