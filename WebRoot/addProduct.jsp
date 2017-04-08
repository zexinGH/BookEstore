<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>添加图书，分类</title>
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/style.css" type="text/css" />
</head>
<body>
	<c:choose>
		<c:when test="${empty sessionScope.user or sessionScope.user.role != 'admin'}">
			<c:redirect url="./error/error.jsp" />
		</c:when>
		<c:otherwise>
			<div class="container" style="margin-top: 30px;">
				<a href="./" class="btn btn-info">返回首页</a>
			</div>
			<div class="container" style="margin-top: 30px;">
				<form action="addCategory" method="post">
					<table class="table table-bordered">
						<caption>
							<b>添加分类</b>
						</caption>
						<tr>
							<td>分类名称</td>
							<td><input class="form-control" type="text" name="category"></td>
							<td><button type="submit" class="btn btn-success"
									role="button">添加分类</button></td>
						</tr>
					</table>
				</form>
				<br /> <br />
				<form action="addProduct" method="post"
					enctype="multipart/form-data">
					<table class="table table-bordered">
						<caption>
							<b>添加图书</b>
						</caption>

						<tr>
							<td>商品名称</td>
							<td><input class="form-control" type="text" name="name"></td>
						</tr>

						<tr>
							<td>商品价格</td>
							<td><input class="form-control" type="text" name="price"></td>
						</tr>

						<tr>
							<td>商品类别</td>
							<td><select name="category">
									<option>--请选择类别--</option>
									<c:forEach items="${ca}" var="ca">
										<option value="${ca.name}">${ca.name}</option>
									</c:forEach>
							</select></td>
						</tr>

						<tr>
							<td>商品数量</td>
							<td><input class="form-control" type="text" name="pnum"></td>
						</tr>

						<tr>
							<td>商品图片</td>
							<td><input type="file" name="f"></td>
						</tr>

						<tr>
							<td>商品描述</td>
							<td><textarea class="form-control" name="description"
									rows="10" cols="40"></textarea></td>
						</tr>

						<tr>
							<td colspan="2" align="center"><button type="submit"
									class="btn btn-success">添加商品</button>
								<button type="reset" class="btn btn-warning">取消</button></td>
						</tr>
					</table>
				</form>
			</div>
		</c:otherwise>
	</c:choose>
</body>
</html>
