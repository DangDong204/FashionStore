<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	<title>SWE - Admin</title>
	<meta content="" name="description">
	<meta content="" name="keywords">
	
	<jsp:include page="/WEB-INF/views/administrator/layout/css.jsp"></jsp:include>
</head>

<body>

  <main>
    <div class="container">

      <section class="section error-404 min-vh-100 d-flex flex-column align-items-center justify-content-center">
        <h1>404</h1>
        <h2>The page you are looking for doesn't exist.</h2>
        <a class="btn" href="${env }/admin/home">Back to home</a>
        <img src="${env }/administrator/img/not-found.svg" class="img-fluid py-5" alt="Page Not Found">
      </section>

    </div>
  </main><!-- End #main -->

	<!-- Footer - File -->
	<jsp:include page="/WEB-INF/views/administrator/layout/footer.jsp"></jsp:include>

	<!-- Nút quay trở lại phía trên -->
	<a href="#"
		class="back-to-top d-flex align-items-center justify-content-center">
		<i class="bi bi-arrow-up-short"></i>
	</a>

	<!-- JS - File -->
	<jsp:include page="/WEB-INF/views/administrator/layout/js.jsp"></jsp:include>

</body>

</html>