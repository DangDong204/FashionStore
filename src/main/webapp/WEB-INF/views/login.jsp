<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%-- JSTL directive --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đăng nhập</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="${env}/customer/css/login.css">
</head>
<body>
	<div class="login-container">
		<div class="left-side">
			<img src="${env}/customer/img/login.svg" alt="Welcome">
		</div>
		<div class="right-side">
			<h3>Đăng Nhập</h3>

			<!-- Hiển thị lỗi nếu có -->
			<c:if test="${param.login_error != null}">
				<div class="alert alert-danger" role="alert">Tên đăng nhập
					hoặc mật khẩu không đúng!</div>
			</c:if>

			<!-- Hiển thị thông báo logout nếu có -->
			<c:if test="${param.logout != null}">
				<div class="alert alert-success" role="alert">Bạn đã đăng xuất
					thành công!</div>
			</c:if>

			<!-- Form login với Spring Security -->
			<form method="post" action="${env}/login_processing_url">
				<input type="text" class="form-control" id="username"
					name="username" placeholder="Tên đăng nhập" required> 
				<input type="password" class="form-control" id="password" 
					name="password" placeholder="Mật khẩu" required>
				<div class="form-check mb-3">
					<input type="checkbox" class="form-check-input" id="remember-me"
						name="remember-me"> 
					<label class="form-check-label" for="remember-me">Ghi nhớ đăng nhập</label>
				</div>
				<button type="submit" class="btn btn-login">Đăng Nhập</button>

				<!-- CSRF Token (bắt buộc với Spring Security) -->
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
			<div class="bottom-links">
				<a href="${env }/register">Tạo tài khoản</a> | <a
					href="${env }/forgot-password">Quên mật khẩu</a>
			</div>
		</div>
	</div>

</body>
</html>