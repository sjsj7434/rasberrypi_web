<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
	
	<title>온습도 관리 - Register</title>
	<link href="resources/img/undraw_posting_photo.svg" rel="shortcut icon">
	
	<!-- Custom fonts for this template-->
	<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
	
	<!-- Custom styles for this template-->
	<link href="css/sb-admin-2.min.css" rel="stylesheet">
	<!-- Bootstrap core JavaScript-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="js/sb-admin-2.min.js"></script>
</head>
<body class="bg-gradient-primary">
	<div class="container">
		<div class="card o-hidden border-0 shadow-lg my-5">
			<div class="card-body p-0">
				<!-- Nested Row within Card Body -->
				<div class="row">
					<div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
					<div class="col-lg-7">
						<div class="p-5">
							<div style="padding-top: 150px;"></div>
							
							<div class="text-center">
								<h1 class="h1 text-gray-900 mb-4">제품 등록</h1>
							</div>
							<form class="user" name="registerForm" action="registering" method="post">
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="text" class="form-control form-control-user" id="serialnumber" name="serialnumber" placeholder="serialnumber">
									</div>
									<div class="col-sm-6">
										<input type="password" class="form-control form-control-user" id="passwd" name="passwd" placeholder="password">
									</div>
								</div>
								
								<hr>
								
								<c:if test="${msg != null}">
									<p style="color: red;">${msg}</p>
									<hr>
								</c:if>
								
								<a href="#" onclick="registerSubmit()" class="btn btn-primary btn-user btn-block"> 제품 등록 </a>
								<script type="text/javascript">
									function registerSubmit() {
										if($('#serialnumber').val() == ''){
											alert('serialnumber를 입력해주세요');
											return;
										}
										if($('#passwd').val() == ''){
											alert('비밀번호를 입력해주세요');
											return;
										}
										
										var registerForm = document.registerForm;
										registerForm.submit();
									}
								</script>
							</form>
							
							<div style="padding-bottom: 150px;"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>