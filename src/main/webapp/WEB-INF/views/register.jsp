<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href=".${env }/customer/css/register.css">
</head>
<body>
    <div class="register-container">
        <div class="left-side">
            <img src="${env }/customer/img/register.svg" alt="Register">
        </div>
        <div class="right-side">
            <h3>Đăng Ký</h3>
            <form>
                <input type="text" class="form-control" placeholder="Username">
                <input type="email" class="form-control" placeholder="Email">
                <input type="password" class="form-control" placeholder="Password">
                <input type="password" class="form-control" placeholder="Confirm Password">
                <button type="submit" class="btn btn-register">Đăng Ký</button>
            </form>
            <div class="bottom-links">
                <a href="${env}/login">Đã có tài khoản? Đăng nhập</a>
            </div>
        </div>
    </div>


</body>
</html>