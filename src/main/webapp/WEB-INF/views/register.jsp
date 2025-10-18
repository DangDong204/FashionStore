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
    <title>Đăng ký</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${env }/customer/css/register.css">
</head>
<body>
    <div class="register-container">
        <div class="left-side">
            <img src="${env }/customer/img/register.svg" alt="Register">
        </div>
        <div class="right-side">
            <h3>Đăng Ký</h3>
            <c:if test="${param.error == 'exists'}">
			    <div class="alert alert-danger mt-2">Tên đăng nhập đã tồn tại, vui lòng chọn tên khác.</div>
			</c:if>
			
			<c:if test="${param.success == 'register'}">
			    <div class="alert alert-success mt-2">Đăng ký thành công! Vui lòng đăng nhập.</div>
			</c:if>
            <form action="${env}/register" method="post">
			    <input type="text" name="name" class="form-control" placeholder="Họ và tên" required>
			    <input type="email" name="email" class="form-control" placeholder="Email" required>
                <input type="text" name="username" class="form-control" placeholder="Username" required>
			    <input type="password" name="password" class="form-control" placeholder="Password" required>
                <button type="submit" class="btn btn-register">Đăng Ký</button>
            </form>
            <div class="bottom-links">
                <a href="${env}/login">Đã có tài khoản? Đăng nhập</a>
            </div>
            
			            
        </div>
    </div>


</body>
<!-- 
<script>
    const params = new URLSearchParams(window.location.search);
    if (params.get("success") === "register") {
        alert("Đăng ký thành công! Mời bạn đăng nhập.");
    }
    if (params.get("error") === "exists") {
        alert("Tên đăng nhập đã tồn tại!");
    }
</script>
 -->
</html>