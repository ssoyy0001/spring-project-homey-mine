<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<style>
.form-group {
	margin: 10px;
}
</style>
<body>

	<main role="main">
		<!-- ======= Breadcrumbs ======= -->
		<div class="breadcrumbs d-flex align-items-center"
			style="background-image: url('https://images.pexels.com/photos/2227832/pexels-photo-2227832.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1');">
			<div
				class="container position-relative d-flex flex-column align-items-center"
				data-aos="fade">

				<h2>Register</h2>
				<ol>
					<li><a href="index.html">Home</a></li>
					<li>Register</li>
				</ol>

			</div>
		</div>
		<!-- End Breadcrumbs -->
		<section id="about" class="about">
			<div class="container">

				<form action="/gen/join" method="post" class="form-horizontal"
					enctype="multipart/form-data">
					<c:set var="idMsg" value="아이디는 필수입력 항목입니다." />
					<c:set var="pwMsg" value="비밀번호는 필수입력 항목입니다." />
					<c:set var="nmMsg" value="이름은 필수입력 항목입니다." />
					<c:set var="mailMsg" value="메일은 필수입력 항목입니다." />
					<c:set var="addrMsg" value="주소는 필수입력 항목입니다." />
					<c:set var="phoneMsg" value="번호는 필수입력 항목입니다." />

					<div class="form-group row">
						<label class="col-sm-2">아이디</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="mid" id="mid"
								required="required" oninput="setCustomValidity('')"
								oninvalid="this.setCustomValidity('${idMsg }')">
						</div>
						<div class="col-sm-3" id="mid-message"></div>
					</div>

					<div class="form-group row">
						<label class="col-sm-2">비밀번호</label>
						<div class="col-sm-3">
							<input type="password" class="form-control" name="pw" id="pw"
								required="required" oninput="setCustomValidity('')"
								oninvalid="this.setCustomValidity('${pwMsg }')">
						</div>
						<div class="col-sm-3" id="pw-message"></div>
					</div>

					<div class="form-group row">
						<label class="col-sm-2">비밀번호 확인</label>
						<div class="col-sm-3">
							<input type="password" class="form-control" name="pwcheck"
								id="pwcheck" required="required">
						</div>
						<div class="col-sm-3" id="pw-message2"></div>
					</div>

					<div class="form-group row">
						<label class="col-sm-2">이름</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="mname" id="mname"
								required="required" oninput="setCustomValidity('')"
								oninvalid="this.setCustomValidity('${nmMsg }')">
						</div>
					</div>

					<div class="form-group row">
						<label class="col-sm-2">이메일</label>
						<div class="col-sm-6">
							<div class="input-group">
								<input type="text" id="email1" class="form-control"
									required="required" oninput="setCustomValidity('')"
									oninvalid="this.setCustomValidity('${mailMsg }')">
								<div class="input-group-prepend">
									<span class="input-group-text">@</span>
								</div>
								<input type="text" id="email2" class="form-control"> <select
									id="email3" class="form-control">
									<option value="직접입력">직접입력</option>
									<option value="naver.com">naver.com</option>
									<option value="gmail.com">gmail.com</option>
								</select>
							</div>
						</div>
						<div class="col-sm-2">
							<input type="hidden" id="memail" name="memail" value="">
						</div>
					</div>

					<div class="form-group row">
						<label class="col-sm-2">주소</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="addr" id="addr"
								required="required" oninput="setCustomValidity('')"
								oninvalid="this.setCustomValidity('${addrMsg }')">
						</div>
						<div class="col-sm-3">
							<input type="button" value="검색" class="btn btn-secondary"
								onclick="goPopup();">
						</div>
					</div>

					<div class="form-group row align-items-center">
						<label class="col-sm-2">상세주소</label>
						<div class="col-sm-4">
							<div class="row">
								<div class="col">
									<input type="text" class="form-control" name="addrdetail"
										id="addrdetail">
								</div>
							</div>
						</div>
						<input type="hidden" name="maddr" id="maddr" value="">
					</div>

					<div class="form-group row">
						<label class="col-sm-2">연락처</label>
						<div class="col-sm-2 ">
							<div class="input-group">
								<select class="form-control" name="phone0" id="phone0">
									<option value="직접입력">직접입력</option>
									<option>010</option>
									<option>011</option>
									<option>019</option>
								</select> <input type="text" name="phone1" id="phone1" maxlength="3"
									class="form-control" value="" required="required"
									oninput="setCustomValidity('')"
									oninvalid="this.setCustomValidity('${phoneMsg }')">
							</div>
						</div>
						<div class="col-sm-2">
							<input type="text" name="phone2" id="phone2" maxlength="4"
								class="form-control" value="1234" required="required"
								oninput="setCustomValidity('')"
								oninvalid="this.setCustomValidity('${phoneMsg }')">
						</div>
						<div class="col-sm-2">
							<input type="text" name="phone3" id="phone3" maxlength="4"
								class="form-control" value="5678" required="required"
								oninput="setCustomValidity('')"
								oninvalid="this.setCustomValidity('${phoneMsg }')">
						</div>
						<input type="hidden" id="mphone" name="mphone" value="">
					</div>



					<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="button" class="btn btn-info" value="등록"
								id="register-button"> <input type="button"
								class="btn btn-secondary" onclick="history.back()" value="취소">
						</div>
					</div>
					<input type="hidden" name="${_csrf.parameterName }"
						value="${_csrf.token }">
				</form>
			</div>
		</section>
	</main>
</body>
<!-- End #main -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<!-- Font Awesome JS -->
<script>
	var csrfHeaderName = '${_csrf.headerName}';//csrf 토큰 관련 변수
	var csrfTokenValue = '${_csrf.token}';
	//아이디, 비밀번호, 비밀번호 확인 유효성 및 중복 체크 결과 저장
	var isIdValid = false;
	var isPwValid = false;
	var isPwCheckValid = false;
	// 모든 검사가 통과된 경우에만 등록 버튼 활성화
	function updateRegisterButton() {
		if (isIdValid==true && isPwValid==true && isPwCheckValid==true) {
			$('#register-button').prop('disabled',false );
		} else {
			$('#register-button').prop('disabled',true );
		}
	}
	$(document)
			.ready(
					function() {
						//아이디 중복체크 및 유효성검사
						$('input[id="mid"]')
								.on(
										'change',
										function(e) {
											var id = $(this).val();
											var re = /^(?=.*[a-z])(?=.*\d)[a-z\d]{5,20}$/i; // 정규식: 영문자와 숫자로 구성되며 길이가 5~20인 문자열

											if (!re.test(id)) {
												$('#mid-message')
														.html(
																'<span style="color: red;">ID는 5~20글자 사이여야 하고, 숫자와 영문 모두 포함해 주셔야 합니다.</span>');
												isIdValid = false;
												updateRegisterButton();
												return;
											}

											$
													.ajax({
														type : 'POST',
														url : '/gen/checkId',
														data : {
															mid : id
														},
														dataType : 'text',
														beforeSend : function(
																xhr) {//xhr; xml http request
															//전송 전 csrf 헤더 설정    
															xhr
																	.setRequestHeader(
																			csrfHeaderName,
																			csrfTokenValue);
														},
														success : function(
																result, status,
																xhr) {
															$('#mid-message')
																	.html(
																			'<span style="color: green;"><i class="fas fa-check"></span>');
															isIdValid = true;
															updateRegisterButton();
														}, //성공시
														error : function(xhr,
																status, er) {
															$('#mid-message')
																	.html('<span style="color: red;">중복된 아이디 입니다.</span>');
															isIdValid = false;
															updateRegisterButton();
														} //에러시
													}); //END ajax;
										});
						//아이디 중복체크 END
						//비밀번호 유효성과 비밀번호 체크
						$('input[id="pw"]')
								.on(
										'change',
										function(e) {
											var pw = $(this).val();
											var re = /^(?=.*[a-z])(?=.*\d)[a-z\d]{10,20}$/i; // 정규식: 영문자와 숫자로 구성되며 길이가 5~20인 문자열

											if (!re.test(pw)) {
												$('#pw-message')
														.html(
																'<span style="color: red;">PW는 10~20글자 사이여야 하고, 숫자와 영문 모두 포함해 주셔야 합니다.</span>');
												isPwValid = false;
												updateRegisterButton();
												return;
											} else {
												$('#pw-message')
														.html(
																'<span style="color: green;"><i class="fas fa-check"></span>');
												isPwValid = true;
												updateRegisterButton();
											}

										});
						$('input[id="pwcheck"]').on('change',function(e) {
											var pwcheck = $(this).val();
											var re = /^(?=.*[a-z])(?=.*\d)[a-z\d]{10,20}$/i; // 정규식: 영문자와 숫자로 구성되며 길이가 5~20인 문자열

											if (pwcheck != $('input[id="pw"]').val()) {
												$('#pw-message2').html(
																'<span style="color: red;">일치하지 않습니다.</span>');
												isPwCheckValid = false;
												updateRegisterButton();
												return;
											} else {
												$('#pw-message2').html(
																'<span style="color: green;"><i class="fas fa-check"></span>');
												isPwCheckValid = true;
												updateRegisterButton();
											}

										});
						//비밀번호 유효성과 비밀번호 체크 END
						//이메일
						// 이메일 도메인 선택 시 처리
						$("#email2").on("input",function() {
											var selectedDomain = $("#email2").val();
											var customOption = $("#email3 option[value='직접입력']");
											if (selectedDomain !== "") {
												customOption.prop("selected",true);
											}
										});

						// 이메일 도메인 직접입력 선택 시 처리
						$("#email3").on("change", function() {
							var selectedOption = $(this).val();

							if (selectedOption !== "직접입력") {
								// email2 값 비우기
								$("#email2").val(selectedOption);
							}
						});
						//이메일 end
						//폰 번호
						$("#phone1").on("input",function() {
											var selectedPhone = $("#phone1")
													.val();
											var customPhone = $("#phone0 option[value='직접입력']");

											if (selectedPhone !== "") {
												customPhone.prop("selected",
														true);
											}
										});
						$("#phone0").on("change", function() {
							var selectedPhone = $(this).val();
							if (selectedPhone !== "직접입력") {
								$("#phone1").val(selectedPhone);
							}
						});
						//폰 번호 end
						$("#register-button").on("click", function() {
							var email1 = $('#email1').val();
							var email2 = $('#email2').val();
							var memailVal=email1+"@"+email2;
							var phone1= $('#phone1').val();
							var phone2= $('#phone2').val();
							var phone3= $('#phone3').val();
							var mphoneVal=phone1+phone2+phone3;
							var addr=$('#addr').val();
							var addrdetail=	$('#addrdetail').val();		
							var maddrVal=addr+" "+addrdetail;
							$("#memail").val(memailVal);
							$("#mphone").val(mphoneVal);
							$("#maddr").val(maddrVal);
							
							$("form").submit();
						});
					});
	

	//주소API사용-->csrf때문에 보류
	/* function goPopup() {
		var pop = window.open("/gen/jusoPopup", "pop",
				"width=570,height=420, scrollbars=yes, resizable=yes");
	}

	function jusoCallBack(jibunAddr, addrDetail) {
		$('#addr').val(jibunAddr);
		$('#addrdetail').val(addrDetail);
	} */
	//주소API사용-END
</script>

<%@ include file="../includes/footer.jsp"%>
