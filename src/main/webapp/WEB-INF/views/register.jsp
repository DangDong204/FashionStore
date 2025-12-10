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

	<script>
		document.addEventListener("DOMContentLoaded", () => {
		
		  const form = document.querySelector("form[action$='/register']");
		  const passwordInput = form.querySelector("input[name='password']");
		
		  form.addEventListener("submit", function(event) {
		    const password = passwordInput.value;
		    let hasError = false;
		
		    const rules = {
		      length: /.{8,}/,
		      upper: /[A-Z]/,
		      lower: /[a-z]/,
		      number: /[0-9]/,
		      special: /[!@#$%^&*(),.?":{}|<>]/,
		    };
		
		    if (!rules.length.test(password)) {
		      showError("Mật khẩu phải có ít nhất 8 ký tự.");
		      hasError = true;
		    } else if (!rules.upper.test(password)) {
		      showError("Mật khẩu phải có ít nhất 1 chữ hoa.");
		      hasError = true;
		    } else if (!rules.lower.test(password)) {
		      showError("Mật khẩu phải có ít nhất 1 chữ thường.");
		      hasError = true;
		    } else if (!rules.number.test(password)) {
		      showError("Mật khẩu phải có ít nhất 1 số.");
		      hasError = true;
		    } else if (!rules.special.test(password)) {
		      showError("Mật khẩu phải có ít nhất 1 ký tự đặc biệt.");
		      hasError = true;
		    }
		
		    if (hasError) {
		      event.preventDefault();
		    }
		  });
		
		  // Hiển thị lỗi kiểu Bootstrap-like
		  function showError(message) {
		    passwordInput.classList.add("is-invalid");
		
		    let error = passwordInput.nextElementSibling;
		    if (!error || !error.classList.contains("invalid-feedback")) {
		      error = document.createElement("div");
		      error.className = "invalid-feedback d-block";
		      passwordInput.insertAdjacentElement("afterend", error);
		    }
		    error.innerText = message;
		  }
		
		});
		</script>


</body>

</html>