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
			</div>
		</div>
		<!-- End Breadcrumbs -->
		<section id="about" class="about">
			<div class="container ">
				<div class="row justify-content-between gy-4 mt-4">
					<div class="col-lg-8 mx-auto">
						<form action="/gen/join" method="post" class="form-horizontal">

							<div class="form-group row">
								<label class="col-sm-2">아이디</label>
								<div class="col-sm-3">
									<input type="text" class="form-control" name="mid" id="mid"
										required="required">
								</div>
								<div class="col-sm-3" id="mid-message"></div>
							</div>

							<div class="form-group row">
								<label class="col-sm-2">비밀번호</label>
								<div class="col-sm-3">
									<input type="password" class="form-control" name="pw" id="pw"
										required="required">
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
										required="required">
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
		
								<div class="form-group row" style="margin-bottom: 10px">
									<label class="col-sm-2">도로명 주소</label>
									<div class="col-sm-6">
										<input type="text" name="address" id="address"
											class="form-control" required placeholder="주소">
									</div>
									<div class="col-sm-2">
										<input type="button" class="btn btn-outline-secondary"
											value="검색" onclick="execDaumPostcode()">
									</div>
								</div>
								<div class="form-group row" style="margin-bottom: 10px">
									<label class="col-sm-2">상세 주소</label>
									<div class="col-sm-6">
										<input type="text" name="detailAddress" id="detailAddress"
											class="form-control" placeholder="상세주소">
									</div>
								</div>
								<div id="wrap"
									style="display: none; border: 1px solid; width: 500px; height: 300px; margin: 5px 0; position: relative">
									<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
										id="btnFoldWrap"
										style="cursor: pointer; position: absolute; right: 0px; top: -1px; z-index: 1"
										onclick="foldDaumPostcode()" alt="접기 버튼">
								</div>
								<!-- end 카카오 주소 api  -->

								<input type="hidden" name="maddr" id="maddr" value="">

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
											class="form-control" value="" required="required">
									</div>
								</div>
								<div class="col-sm-2">
									<input type="text" name="phone2" id="phone2" maxlength="4"
										class="form-control" value="1234" required="required">
								</div>
								<div class="col-sm-2">
									<input type="text" name="phone3" id="phone3" maxlength="4"
										class="form-control" value="5678" required="required">
								</div>
								<input type="hidden" id="mphone" name="mphone" value="">
							</div>

							<br>
							<hr>
							<div class="form-group row text-center">
								<div class="col-sm-offset-2 col-sm-10">
									<input type="submit" class="btn btn-info" value="등록"
										id="register-button"> <input type="button"
										class="btn btn-secondary" onclick="history.back()" value="취소">
								</div>
							</div>
							<input type="hidden" name="${_csrf.parameterName }"
								value="${_csrf.token }">
						</form>
					</div>
				</div>
			</div>
		</section>
	</main>
</body>
<!-- End #main -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"
	crossorigin="anonymous"></script>
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
		if (isIdValid == true && isPwValid == true && isPwCheckValid == true) {
			$('#register-button').prop('disabled', false);
		} else {
			$('#register-button').prop('disabled', true);
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
																	.html(
																			'<span style="color: red;">중복된 아이디 입니다.</span>');
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
						$('input[id="pwcheck"]')
								.on(
										'change',
										function(e) {
											var pwcheck = $(this).val();
											if (pwcheck != $('input[id="pw"]')
													.val()) {
												$('#pw-message2')
														.html(
																'<span style="color: red;">일치하지 않습니다.</span>');
												isPwCheckValid = false;
												updateRegisterButton();
												return;
											} else {
												$('#pw-message2')
														.html(
																'<span style="color: green;"><i class="fas fa-check"></span>');
												isPwCheckValid = true;
												updateRegisterButton();
											}

										});
						//비밀번호 유효성과 비밀번호 체크 END
						//이메일
						// 이메일 도메인 선택 시 처리
						$("#email2")
								.on(
										"input",
										function() {
											var selectedDomain = $("#email2")
													.val();
											var customOption = $("#email3 option[value='직접입력']");
											if (selectedDomain !== "") {
												customOption.prop("selected",
														true);
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
						$("#phone1")
								.on(
										"input",
										function() {
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
						$("#register-button").on(
								"click",
								function(e) {

									e.preventDefault();
									var email1 = $('#email1').val();
									var email2 = $('#email2').val();
									var memailVal = email1 + "@" + email2;
									var phone1 = $('#phone1').val();
									var phone2 = $('#phone2').val();
									var phone3 = $('#phone3').val();
									var mphoneVal = phone1 + phone2 + phone3;
									var addr = $('#address').val();
									var addrdetail = $('#detailAddress').val();
									var maddrVal = addr + " " + addrdetail;

									if (email1 == "" || email2 == ""
											|| phone1 == "" || phone2 == ""
											|| phone3 == "" || addr == ""
											|| addrdetail == "") {
										alert("빈칸을 모두 기입해 주세요");
										return;
									}
									$("#memail").val(memailVal);
									$("#mphone").val(mphoneVal);
									$("#maddr").val(maddrVal);

									$("form").submit();
								});
					});

	//카카오 주소 API -----------------------------------------
	 // 우편번호 찾기 찾기 화면을 넣을 element
	    var element_wrap = document.getElementById('wrap');

	    function foldDaumPostcode() {
	        // iframe을 넣은 element를 안보이게
	        element_wrap.style.display = 'none';
	    }

	    function execDaumPostcode() {
	        // 현재 scroll 위치를 저장
	        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 각 주소의 노출 규칙에 따라 주소를 조합
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져옴
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣음

	                document.getElementById("address").value = addr;
	                // 커서를 상세주소 필드로 이동
	                document.getElementById("detailAddress").focus();

	                // iframe을 넣은 element를 안보이게 함
	                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않음
	                element_wrap.style.display = 'none';

	                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌림
	                document.body.scrollTop = currentScroll;
	            },
	            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성. iframe을 넣은 element의 높이값을 조정
	            onresize : function(size) {
	                element_wrap.style.height = size.height+'px';
	            },
	            width : '100%',
	            height : '100%'
	        }).embed(element_wrap);

	        // iframe을 넣은 element를 보이게 함.
	        element_wrap.style.display = 'block';
	    }
	//END 카카오 주소 API -----------------------------------------

</script>

<%@ include file="../includes/footer.jsp"%>
