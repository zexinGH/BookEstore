<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>商品列表页</title>
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/style.css" />
</head>
<body>
	<div class="site-topbar">
		<div class="wrap">
			<div class="topbar-nav">
				<a href="./">首页</a> <span class="sep">|</span> <a href="#">论坛</a> <span
					class="sep">|</span> <a href="#">关于我们</a> <span class="sep">|</span>
				<a href="#">在线客服</a> <span class="sep">|</span> <a href="#">图书社区</a>
				<span class="sep">|</span> <a href="#">收藏网站</a>
			</div>
			<div class="topbar-info">
				<span>欢迎光临网上书城！&nbsp;&nbsp;&nbsp;</span>

				<c:if test="${empty user }">
					<a href="javascript:void(null)" data-toggle="modal"
						data-target="#Login">登录</a>
					<span class="sep">|</span>
					<a href="javascript:void(null)" data-toggle="modal"
						data-target="#Regist">注册</a>&nbsp;&nbsp;&nbsp;
					<font color='red'>${requestScope["login.message"]}${requestScope["regist.message"] }</font>
				</c:if>

				<c:if test="${not empty user }">
					<a href="javascript:void(null)">您好，${user.username}！</a>
					<a href='user?method=logout'>注销</a>
				</c:if>
			</div>
		</div>
	</div>

	<div class="modal fade in" id="Login">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">登录</h4>
				</div>
				<form method="post" id="loginForm" action=" user">
					<input type="hidden" name="method" value="login">
					<div class="modal-body">
						<div class="input-group">
							<span class="input-group-addon" id="sizing-addon1">用户名</span> <input
								type="text" value="" name="username" class="form-control"
								placeholder="username" aria-describedby="sizing-addon1">
						</div>
						<div class="input-group">
							<span class="input-group-addon" id="sizing-addon1">密&nbsp;&nbsp;&nbsp;码</span>
							<input type="password" value="" name="password"
								class="form-control" placeholder="password"
								aria-describedby="sizing-addon1">
						</div>
						<div class="xz">
							<input type="checkbox" name="remember" value="on" />记住用户 <input
								type="checkbox" name="autologin" value="on" />自动登陆
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="submit" name="loginbtn" class="btn btn-primary">确认登录</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="modal fade in" id="Regist">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">注册</h4>
				</div>
				<form action="user" method="post" onsubmit="return checkForm();">
					<input type="hidden" name="method" value="regist">
					<div class="modal-body">
						<span class="t1" id="username_span"></span>
						<div class="input-group">
							<span class="input-group-addon" id="sizing-addon1">&nbsp;用户名&nbsp;</span>
							<input type="text" value="" name="username" id="username"
								placeholder="username" class="form-control"
								aria-describedby="sizing-addon1">
						</div>
						<span class="t1" id="password_span"></span>
						<div class="input-group">
							<span class="input-group-addon" id="sizing-addon1">密码</span> <input
								type="password" value="" name="password" id="password"
								placeholder="password" class="form-control"
								aria-describedby="sizing-addon1">
						</div>
						<span class="t1" id="repassword_span"></span>
						<div class="input-group">
							<span class="input-group-addon" id="sizing-addon1">确认密码</span> <input
								type="password" value="" name="repassword" id="repassword"
								placeholder="repassword" class="form-control"
								aria-describedby="sizing-addon1">
						</div>
						<span class="t1" id="nickname_span"></span>
						<div class="input-group">
							<span class="input-group-addon" id="sizing-addon1">昵称</span> <input
								type="text" value="" name="nickname" id="nickname"
								placeholder="nickname" class="form-control"
								aria-describedby="sizing-addon1">
						</div>
						<span class="t1" id="checkcode_span"></span>
						<div class="input-group">
							<span class="input-group-addon" id="sizing-addon1">验证码</span> <input
								type="text" value="" name="checkcode" id="checkcode"
								placeholder="checkcode" class="form-control"
								aria-describedby="sizing-addon1">
						</div>
						<img src='checkcode' id="im" onclick="change();"> <a
							href="javascript:void(0)" onclick="change();"><font
							color='black'>看不清，换一张</font></a>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="submit" class="btn btn-primary">确认注册</button>
					</div>
				</form>

			</div>
		</div>
	</div>

	<div class="site-header">
		<div class="wrap">
			<div class="header-logo">
				<img alt="图书商城" src="images/logo.png">
			</div>
			<div class="header-nav">
				<ul class="clearfix">
					<li><a href="./">首页</a></li>
					<li><a href="product?method=findALLcate">添加商品</a></li>
					<li><a href="showCart.jsp">查看购物车</a></li>
					<li><a href="#">关于我们</a></li>
					<li><a href="#">联系方式</a></li>
				</ul>
			</div>

			<div class="header-search">
				<form method="post" id="newsletterform" action="product">
					<input type="hidden" name="method" value="findByName">
					<div class="input-group">
						<input type="text" value="" name="name" id="name"
							class="form-control" placeholder="请输入图书名"> <span
							class="input-group-btn">
							<button class="btn btn-default" name="search" type="submit">搜索</button>
						</span>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="lby">
		<div class="wrap">
			<c:if test="${p == null}">
				<div class="warring">抱歉！没有找到相关商品</div>
			</c:if>
			<c:if test="${p != null}">
				<c:set var="sum" value="0" />
				<ul class="clearfix">
					<c:forEach items="${p }" var="p">
						<li class="item">
							<div class="img">
								<a href='product?method=findById&id=${p.id}'><img
									src="./${p.imgurl}" width="200" height="200" /></a>
							</div>
							<div class="info">
								<h3>
									<a href='product?method=findById&id=${p.id}'>${p.name}</a>
								</h3>
								<div class="intro">${p.description}</div>
								<div class="price">
									价格：<em>${p.price}</em>
								</div>
								<div class="price">
									数量：<em>${p.pnum}</em>
								</div>
								<div class="buy">
									<a href="product?method=findById&id=${p.id}">立即购买</a>
								</div>
							</div>
						</li>
						<c:set var="sum" value="${sum + 1}" />
					</c:forEach>
				</ul>
			</c:if>
			<div class="find">
				总共找到<em><c:out value="${sum }" /></em>件商品
			</div>
		</div>
	</div>
	<div class="site-footer">
		<div class="wrap">
			<div class="footer-service"><img src="images/foot.png" /></div>
			<div class="fc text-center">本网站由嘉应大学计算机学院提供，仅供参考，不得用于商业用途，违者后果自负。</div>
			<ul class="list-inline text-center">
            <li><a href="javascript:void(null)">京ICP备11008151号</a></li>
            <li>京公网安备11010802014853</li>
          </ul>
		</div>
	</div>
	
	<script type="text/javascript"
		src="css/jquery-2.1.4.min.js"></script>
	<script type="text/javascript"
		src="css/bootstrap.min.js"></script>
</body>
</html>