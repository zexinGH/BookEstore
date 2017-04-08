<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>图书商城</title>
<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css"/>
<link rel="stylesheet" href="css/style.css" type="text/css"/>
<script type="text/javascript">
	window.onload = function() {

		//从cookie中获取saveusername值,得到的是utf-8码
		var usernamevalue = "${cookie.saveusername.value}";

		//通过decodeURIComponent这个函数完成utf-8解码操作
		document.getElementById("username").value = window.decodeURIComponent(
				usernamevalue, "utf-8");
	}
	
	function change() {
		document.getElementById("im").src = "${pageContext.request.contextPath}/checkcode?time"
				+ new Date().getTime();
	};

	function checkForm() {
		
		//先得到所有的span,将其内容清空。
		var spans=document.getElementsByName("t1");
		
		for(var i=0;i<spans.length;i++){
			spans[i].innerHTML="";
		}

		//验证用户名
		var flag1=checkNull("username");
		//验证密码
		var flag2=checkNull("password");
		
		//验证确认密码
		var flag3=checkNull("repassword");
		
		var flag4=checkNull("nickname");
		var flag6=checkNull("checkcode");
		
		
		//对确认密码进行操作
		var flag7=repasswordValidate();

		return flag1&&flag2&&flag3&&flag4&&flag5&&flag6&&flag7;
	};
	
	function repasswordValidate(){
		
		var value1=document.getElementById("password").value;
		var value2=document.getElementById("repassword").value;
		
		if(value1==value2){
			return true;
		}else{
			document.getElementById("repassword_span").innerHTML="两次密码不一致";
			return false;
		}
	}
	
	//非空操作
	function checkNull(field){
		var reg = /^\s*$/; //代表0个或多个空白符
		
		var value = document.getElementById(field).value;
		
		if (reg.test(value)) {
			document.getElementById(field+"_span").innerHTML=(field+"不能为空");
			return false;
		}
		
		return true;
	}
</script>
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

	<div class="wrap">
		<div id="carousel-example-generic" class="carousel slide"
			data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#carousel-example-generic" data-slide-to="0"
					class="active"></li>
				<li data-target="#carousel-example-generic" data-slide-to="1"></li>
				<li data-target="#carousel-example-generic" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner" role="listbox">
				<div class="item active">
					<img src="images/g1.jpg">
				</div>
				<div class="item">
					<img src="images/g2.jpg">
				</div>
				<div class="item">
					<img src="images/g3.jpg">
				</div>
			</div>

			<a class="left carousel-control" href="#carousel-example-generic"
				role="button" data-slide="prev">prev</a> <a
				class="right carousel-control" href="#carousel-example-generic"
				role="button" data-slide="next">next</a>
		</div>
		<div class="site-category">
			<ul class="site-category-list">
				<c:forEach items="${ca}" var="ca">
					<li><a href='product?method=findByCate&category=${ca.name}'>${ca.name}<span
							class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></a></li>
				</c:forEach>
			</ul>
		</div>
	</div>

	<div class="wrap">
		<div class="row">
			<div class="col-md-4"><a href="#"><img src="images/t1.jpg" /></a></div>
			<div class="col-md-4"><a href="#"><img src="images/t2.jpg" /></a></div>
			<div class="col-md-4"><a href="#"><img src="images/t3.jpg" /></a></div>
		</div>
	</div>

	<div class="page-main">
		<div class="smart wrap">
			<div class="box-hd">
				<h2 class="title">专用软件</h2>
				<div class="more">
					<a class="more-link" href='product?method=findByCate&category=专用软件'
						target="_blank">查看全部 <span
						class="glyphicon glyphicon-circle-arrow-right"></span>
					</a>
				</div>
			</div>
			<div class="box-bd">
				<div class="dleft">
					<a href="#"><img src="images/s1.jpg" /></a>
				</div>
				<div class="dright">
					<ul class="clearfix">
						<c:forEach items="${ps}" var="p" varStatus="vs">
							<c:if test="${p.category == '专用软件'}">
								<li class="item">
									<div class="img">
										<a href='product?method=findById&id=${p.id}'><img
											src=".${p.imgurl}" width="160px" height="160px" /></a>
									</div>
									<h3 class="title">
										<a href='product?method=findById&id=${p.id}'>${p.name }</a>
									</h3>
									<p class="price">${p.price }元</p>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>

		<div class="smart wrap">
			<div class="box-hd">
				<h2 class="title">图形图像</h2>
				<div class="more">
					<a class="more-link" href='product?method=findByCate&category=图形图像'
						target="_blank">查看全部 <span
						class="glyphicon glyphicon-circle-arrow-right"></span>
					</a>
				</div>
			</div>
			<div class="box-bd">
				<div class="dleft">
					<a href="#"><img src="images/s2.jpg" /></a>
					<a href="#" class="last"><img src="images/s3.jpg" /></a>
				</div>
				<div class="dright">
					<ul class="clearfix">
						<c:forEach items="${ps}" var="p" varStatus="vs">
							<c:if test="${p.category == 'javaEE'}">
								<li class="item">
									<div class="img">
										<a href='product?method=findById&id=${p.id}'><img
											src=".${p.imgurl}" width="140px" height="160px" /></a>
									</div>
									<h3 class="title">
										<a href='product?method=findById&id=${p.id}'>${p.name }</a>
									</h3>
									<p class="price">${p.price }元</p>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
		
		<div class="smart wrap">
			<div class="box-hd">
				<h2 class="title">云计算</h2>
				<div class="more">
					<a class="more-link" href='product?method=findByCate&category=云计算'
						target="_blank">查看全部 <span
						class="glyphicon glyphicon-circle-arrow-right"></span>
					</a>
				</div>
			</div>
			<div class="box-bd">
				<div class="dleft">
					<a href="#"><img src="images/s4.jpg" /></a>
					<a href="#" class="last"><img src="images/s5.jpg" /></a>
				</div>
				<div class="dright">
					<ul class="clearfix">
						<c:forEach items="${ps}" var="p" varStatus="vs">
							<c:if test="${p.category == 'javaEE'}">
								<li class="item">
									<div class="img">
										<a href='product?method=findById&id=${p.id}'><img
											src=".${p.imgurl}" width="140px" height="160px" /></a>
									</div>
									<h3 class="title">
										<a href='product?method=findById&id=${p.id}'>${p.name }</a>
									</h3>
									<p class="price">${p.price }元</p>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
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

<script>
    $(document).ready(function(){
        $(".smart .box-bd ul li").mouseenter(function(){
            $(this).addClass("item-active");
        }).mouseleave(function(){
            $(this).removeClass("item-active");
        });
    });
</script>
</body>
</html>
