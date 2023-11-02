<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<style>
@import
	url('https://fonts.googleapis.com/css?family=Poppins:400,500,600,700,800,900')
	;

body {
	font-family: 'Poppins', sans-serif;
	font-weight: 300;
	font-size: 15px;
	line-height: 1.7;
	color: #c4c3ca;
	background-color: gray;
	overflow-x: hidden;
}

a {
	cursor: pointer;
	transition: all 200ms linear;
}

a:hover {
	text-decoration: none;
}

.link {
	color: #c4c3ca;
}

.link:hover {
	color: #ffeba7;
}

p {
	font-weight: 500;
	font-size: 14px;
	line-height: 1.7;
}

h4 {
	font-weight: 600;
}

h6 span {
	padding: 0 20px;
	text-transform: uppercase;
	font-weight: 700;
}

.section {
	position: relative;
	width: 100%;
	display: block;
}

.full-height {
	min-height: 100vh;
}

.card-3d-wrap { //폼 사이즈 조절가능 position:relative;
	width: 1200px;
	max-width: 100%;
	height: 1000px;
	-webkit-transform-style: preserve-3d;
	transform-style: preserve-3d;
	perspective: 800px;
	margin-top: 60px;
}

.card-3d-wrapper {
	width: 100%;
	height: 100%;
	position: absolute;
	top: 0;
	left: 0;
	-webkit-transform-style: preserve-3d;
	transform-style: preserve-3d;
	transition: all 600ms ease-out;
}

.card-front, .card-back {
	width: 100%;
	height: 100%;
	background-color: #2a2b38;
	background-image:
		url('https://cdn.pixabay.com/photo/2016/12/09/08/56/roma-1893861_640.jpg');
	/* url ('https: //s3-us-west-2.amazonaws.com/s.cdpn.io/1462889/pat.svg'); */
	background-position: bottom center;
	background-repeat: no-repeat;
	background-size: 300%;
	position: absolute;
	border-radius: 6px;
	left: 0;
	top: 0;
	-webkit-transform-style: preserve-3d;
	transform-style: preserve-3d;
	-webkit-backface-visibility: hidden;
	-moz-backface-visibility: hidden;
	-o-backface-visibility: hidden;
	backface-visibility: hidden;
}

.center-wrap {
	position: absolute;
	width: 100%;
	padding: 0 35px;
	top: 50%;
	left: 0;
	transform: translate3d(0, -50%, 35px) perspective(100px);
	z-index: 20;
	display: block;
}

.form-group {
	position: relative;
	display: block;
	margin: 0;
	padding: 0;
}

.form-style {
	padding: 13px 20px;
	padding-left: 55px;
	height: 48px;
	width: 50%;
	font-weight: 500;
	border-radius: 4px;
	font-size: 14px;
	line-height: 22px;
	letter-spacing: 0.5px;
	outline: none;
	color: #c4c3ca;
	background-color: #1f2029;
	border: none;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
	box-shadow: 0 4px 8px 0 rgba(21, 21, 21, .2);
}

.form-style:focus, .form-style:active {
	border: none;
	outline: none;
	box-shadow: 0 4px 8px 0 rgba(21, 21, 21, .2);
}

.form-group input:-ms-input-placeholder {
	color: #c4c3ca;
	opacity: 0.7;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
}

.form-group input::-moz-placeholder {
	color: #c4c3ca;
	opacity: 0.7;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
}

.form-group input:-moz-placeholder {
	color: #c4c3ca;
	opacity: 0.7;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
}

.form-group input::-webkit-input-placeholder {
	color: #c4c3ca;
	opacity: 0.7;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
}

.form-group input:focus:-ms-input-placeholder {
	opacity: 0;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
}

.form-group input:focus::-moz-placeholder {
	opacity: 0;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
}

.form-group input:focus:-moz-placeholder {
	opacity: 0;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
}

.form-group input:focus::-webkit-input-placeholder {
	opacity: 0;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
}

.btn {
	border-radius: 4px;
	height: 44px;
	width: 50%;
	font-size: 13px;
	font-weight: 600;
	text-transform: uppercase;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
	padding: 0 30px;
	letter-spacing: 1px;
	display: -webkit-inline-flex;
	display: -ms-inline-flexbox;
	display: inline-flex;
	-webkit-align-items: center;
	-moz-align-items: center;
	-ms-align-items: center;
	align-items: center;
	-webkit-justify-content: center;
	-moz-justify-content: center;
	-ms-justify-content: center;
	justify-content: center;
	-ms-flex-pack: center;
	text-align: center;
	border: none;
	background-color: #ffeba7;
	color: #102770;
	box-shadow: 0 8px 24px 0 rgba(255, 235, 167, .2);
}

.btn:active, .btn:focus {
	background-color: #102770;
	color: #ffeba7;
	box-shadow: 0 8px 24px 0 rgba(16, 39, 112, .2);
}

.btn:hover {
	background-color: #102770;
	color: #ffeba7;
	box-shadow: 0 8px 24px 0 rgba(16, 39, 112, .2);
}
</style>
<main id="main">

	<!-- ======= Breadcrumbs ======= -->
	<div class="breadcrumbs d-flex align-items-center"
		style="background-image: url('https://images.pexels.com/photos/2227832/pexels-photo-2227832.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1');">
	</div>
	<!-- End Breadcrumbs -->
	<div class="section">
		<div class="container">
			<div class="row full-height justify-content-center">
				<div class="col-12 text-center align-self-center py-5">
					<div class="section pb-5 pt-5 pt-sm-2 text-center">
						<div class="card-3d-wrap mx-auto">
							<div class="card-3d-wrapper">
								<div class="card-front">
									<div class="center-wrap">
										<div class="section text-center">
											<!-- 에러메세지 표시 -->

											<!-- END에러메세지 표시 -->
											<h4 class="mb-4 pb-3">Change PW</h4>
											<form role="form" action="/gen/pwModify" method="post">
												<div style="float: left;margin-left: 25%" id="findID-msg"></div><br>
												<div class="form-group row">
													<input type="password" name="newPW" class="form-style"
														placeholder="New PassWord" id="pw" autocomplete="off">
													
												</div>
												<span style="color:red;font-weight: bold;" id="spanpw"></span>
												<div class="form-group mt-2">
													<input type="password" name="pwcheck" class="form-style"
														placeholder="Check PassWord" id="pwcheck"
														autocomplete="off">	
												</div>
												<span style="color:red;font-weight: bold;" id="spanpw2"></span>
												<div class="form-group mt-2">
												<input type="hidden" name="${_csrf.parameterName }"
													value="${_csrf.token }"> <input type="submit"
													value="change Password!" class="btn mt-4" id="modifyPw">
													</div>
												<sec:authorize access="isAnonymous()">
												<input type="hidden" value="${mid }" name="mid">
												</sec:authorize>
												<sec:authorize access="isAuthenticated()">
												<input type="hidden" value="<sec:authentication property="principal.Username"/>" name="mid">
												</sec:authorize>
												
											</form>
											<p class="mb-0 mt-4 text-center"><a href="/gen/login" class="link">Go to login?</a></p>
											<p class="mb-0 mt-4 text-center">
										
											</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>
<script>
var isPwValid = false;
var isPwCheckValid = false;
function updateRegisterButton() {
	if (isPwValid==true && isPwCheckValid==true) {
		$('#modifyPw').prop('disabled',false );
	} else {
		$('#modifyPw').prop('disabled',true );
	}
}
updateRegisterButton();
$('input[id="pw"]')
.on(
		'change',
		function(e) {
			var pw = $(this).val();
			var re = /^(?=.*[a-z])(?=.*\d)[a-z\d]{10,20}$/i; // 정규식: 영문자와 숫자로 구성되며 길이가 10~20인 문자열

			if (!re.test(pw)) {
				$('#spanpw')
						.html('PW는 10~20글자 사이여야 하고, 숫자와 영문 모두 포함해 주셔야 합니다.');
				isPwValid = false;
				updateRegisterButton();
				return;
			} else {
				$('#spanpw')
				.html('');
				isPwValid = true;
				updateRegisterButton();
			}

		});
$('input[id="pwcheck"]').on('change',function(e) {
			var pwcheck = $(this).val();

			if (pwcheck != $('input[id="pw"]').val()) {
				$('#spanpw2').html(
								'<span style="color: red;">일치하지 않습니다.</span>');
				isPwCheckValid = false;
				updateRegisterButton();
				return;
			} else {
				$('#spanpw2').html(
								'<span style="color: green;"><i class="fas fa-check">일치합니다.</span>');
				isPwCheckValid = true;
				updateRegisterButton();
			}

		});
//비밀번호 유효성과 비밀번호 체크 END
</script>
<%@ include file="../includes/footer.jsp"%>
