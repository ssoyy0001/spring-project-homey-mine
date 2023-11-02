<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정</title>
<style type="text/css">
/* 라벨 강조 */
.form-group label {
	font-weight: bold;
}
/* 조절  */
.row {
	display: flex;
	justify-content: center;
}

/* 간격 조절 */
.form-group label, .form-group div {
	display: table-cell;
	padding: 5px 15px;
}
</style>
</head>
<body>

	<!-- ======= header ======= -->
	<%@ include file="../includes/header.jsp"%>

	<!-- ======= main ======= -->
	<main id="main">
		<!-- ======= Breadcrumbs ======= -->
		<div class="breadcrumbs d-flex align-items-center"
			style="background-image: url('../resources/assets/img/breadcrumbs-bg.jpg');">
			<div
				class="container position-relative d-flex flex-column align-items-center"
				data-aos="fade">
				<h2>공지사항 수정</h2>
				<h4 style="color: white;">일반 / 서비스 안내</h4>
			</div>
		</div>
		<!-- End Breadcrumbs -->

		<section id="services" class="services section-bg blog">
			<!-- blog를 추가해야 사이드바 스타일 활성화  -->
			<div class="container" data-aos="fade-up">
				<div class="row">
					<div class="col-lg-6">

						<!-- 게시물 수정/삭제 폼 -->
						<form action="/notice/modify" method="post" role="form">

							<div class="form-group">
								<label>No.</label> <input type="text" name="bno"
									class="form-control" value="${nvo.notNo }" readonly>
							</div>

							<div class="form-group">
								<label>분류</label> <select name="notCategory" id="notCategory">
									<option value="일반"
										${nvo.notCategory == '일반' ? 'selected' : '' }>일반</option>
									<option value="서비스안내"
										${nvo.notCategory == '서비스안내' ? 'selected' : '' }>서비스안내</option>
								</select>
							</div>

							<div class="form-group">
								<label>작성일</label>
								<fmt:formatDate value="${nvo.notDate}" pattern="yyyy-MM-dd (E)" />
							</div>

							<div class="form-group">
								<label>제목</label> <input type="text" name="notTitle"
									class="form-control" value="${nvo.notTitle }">
							</div>

							<div class="form-group">
								<label>내용</label>
								<textarea name="notCont" class="form-control" rows="3">${nvo.notCont }</textarea>
							</div>

							<div class="form-group">
								<label>작성자</label> <input type="text" name="mid"
									class="form-control" value="${nvo.mid }" readonly>
							</div>

							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<!-- 관리자만 수정 -->
								<button data-oper="remove" class="btn btn-danger"
									formaction="/notice/remove">삭제</button>
								<button data-oper="modify" class="btn btn-warning">수정</button>
							</sec:authorize>

							<button data-oper="list" class="btn btn-primary"
								formaction="/notice/list" formmethod="get">목록으로</button>
							<input type="hidden" name="pageNum" value="${cri.pageNum}">
							<input type="hidden" name="amount" value="${cri.amount}">
							<input type="hidden" name="type" value="${cri.type}"> <input
								type="hidden" name="keyword" value="${cri.keyword}"> <input
								type="hidden" name="notNo" value="${nvo.notNo }">
							<!-- 로그인 정보 보내기 -->
							<input type="hidden" name="${_csrf.parameterName }"
								value="${_csrf.token }">
						</form>
						<!-- END 게시물 수정/삭제 폼 -->

						<!-- 첨부파일 -->
						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-heading">Attach File</div>
									<!-- /.panel-heading -->
									<div class="panel-body">

										<!-- 업로드 -->
										<div class="form-group uploadDiv">
											<input type="file" name="uploadFile" multiple>
										</div>
										<!-- 업로드 -->

										<!-- 업로드 결과 출력 -->
										<div class="uploadResult">
											<ul>
											</ul>
										</div>
										<!-- 업로드 결과 출력 -->
									</div>
									<!-- /.panel-body -->
								</div>
								<!-- /.panel -->
							</div>
							<!-- /.col-lg-12 -->
						</div>
						<!-- /.row -->

					</div>
				</div>
			</div>
		</section>
	</main>

	<script>
		// 첨부파일 목록 가져오기
		var notNoVal = '${nvo.notNo}';
		//(function()
		$.getJSON("/notice/attachList", {
			notNo : notNoVal
		}, function(result) {
			console.log(result);
			showUploadedFile(result);
			//});
		});
		// 첨부파일 목록 가져오기

		//첨부파일 화면에 표시하기 -----------------------------
		function showUploadedFile(result) {
			var resultUL = $('.uploadResult ul');
			var liTag = '';
			$(result)
					.each(
							function(i, obj) {
								liTag += "<li data-folder= '" + obj.upFolder + "'";
 		liTag += "data-uuid= '" + obj.uuid + "' data-filenm='" + obj.fileName + "' data-image= '" + obj.image + "'>";

								if (obj.image) {
									var fileCallPath = encodeURIComponent(obj.upFolder
											+ "/s_"
											+ obj.uuid
											+ "_"
											+ obj.fileName); // thumbImg
									var orginImg = obj.upFolder + "\\"
											+ obj.uuid + "_" + obj.fileName;
									orginImg = orginImg.replace(new RegExp(
											/\\/g), "/");
									liTag += "<img src='/display?fileName="
											+ orginImg
											+ "'></a><br>"
											+ obj.fileName
											+ "<button type='button' class='btn btn-warning btn-danger'" +
		          "data-file='" + fileCallPath + "' " +
		          "data-type='image'>"
											+ " <i class='fa fa-times'></i></button></li>";
								} else {
									var fileCallPath = encodeURIComponent(obj.upFolder
											+ "/"
											+ obj.uuid
											+ "_"
											+ obj.fileName);
									liTag += "<img src='/resources/img/attach.png'></a><br>"
											+ obj.fileName
											+ "<button type='button' class='btn btn-warning btn-danger'" +
		          "data-file='" + fileCallPath + "' " +
		          "data-type='file'>"
											+ " <i class='fa fa-times'></i></button></li>";
								}
							});
			resultUL.append(liTag);
		};
		//첨부파일 등록하고 표시하기 -----------------------------

		var frm = $("form[role='form']");
		//submit 클릭 이벤트 처리
		$("button[data-oper='modify']")
				.on(
						"click",
						function(e) {
							//e.preventDefault();
							var liTag = "";
							$(".uploadResult ul li")
									.each(
											function(i, obj) {
												var hiddenobj = $(obj);
												//개발자 도구에 소문자로 넣어짐
												liTag += "<input type = 'hidden' name = 'attachList["
														+ i
														+ "].fileName' value = '"
														+ hiddenobj
																.data("filenm")
														+ "'>";
												liTag += "<input type = 'hidden' name = 'attachList["
														+ i
														+ "].uuid' value = '"
														+ hiddenobj
																.data("uuid")
														+ "'>";
												liTag += "<input type = 'hidden' name = 'attachList["
														+ i
														+ "].upFolder' value = '"
														+ hiddenobj
																.data("folder")
														+ "'>";
												liTag += "<input type = 'hidden' name = 'attachList["
														+ i
														+ "].image' value = '"
														+ hiddenobj
																.data("image")
														+ "'>";
												//앞은 DTO랑 똑같이, 뒤는 li와 똑같이
											});
							frm.append(liTag);
							frm.submit;

						});//END submit 클릭 이벤트 처리

		//업로드 제한 확인 --------------------------
		var regEx = new RegExp("(.*?)\.(exe|sh|zip)$"); //일부 확장자 파일은 못올리게 함
		var maxSize = 5242880; //파일 업로드 크기 제한
		function checkExtension(fileName, fileSize) {
			if (regEx.test(fileName)) { //이곳에 해당하면 25번 라인에 해당하는 확장자명
				alert("해당 확장자는 업로드가 제한된 파일입니다.");
				return false;
			}

			//크기 확인 및 알림 메시지 출력 -- 순서대로
			if (fileSize > maxSize) {
				alert("파일 크기(5MB)초과 - 업로드 불가");
				return false;
			}
			//그 외의 경우 업로드
			return true;
		}//END 업로드 제한 확인 ----------------------

		//첨부파일 선택 이벤트 처리
		var csrfHeaderName = '${_csrf.headerName}'; //CSRF 토큰 관련 변수
		var csrfTokenValue = '${_csrf.token}'; //
		$("input[type = 'file']").change(function(e) {
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;

			//formData 객체에 파일 추가
			for (var i = 0; i < files.length; i++) {
				//업로드 제한 사항이 있으면 폼에 추가 X 중단
				if (!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
				formData.append("uploadFile", files[i]);
			}

			$.ajax({
				type : 'post', //get   |   post
				url : '/upload/ajaxAction', //전송할 곳
				data : formData, //전송할 데이터
				dataType : 'json',
				contentType : false, //컨텐트 타입 및 인코딩
				processData : false,
				beforeSend : function(xhr) { //xhr ; XML Http Request
					//전송 전 CSRF 헤더 설정
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(result, status, xhr) { //성공 시 (result에 success 담겨있음)
					console.log("upload");
					console.log(result);
					showUploadedFile(result); //함수 호출
					$('input[name="uploadFile"]').val('');
				}, //결과 result로 받아 콘솔에 찍기
				error : function(xhr, status, er) { //에러 시
					console.log('upload error!')
				}
			});//END ajax()    
		});//END 첨부파일 선택 이벤트 처리

		//X 표시 클릭 이벤트 처리 ------------------ 파일 삭제
		//화면에서만 지우게 해야함, 실제 지우는건 modify버튼 누를 때
		$(".uploadResult").on("click", "button", function() {
			if (confirm('첨부파일을 삭제하시겠습니까?')) {
				var button = $(this).closest("li"); //버튼이 뭔지 알려주고
				button.remove();
			}
		});
		//END X 표시 클릭 이벤트 처리 ------------------
	</script>
	<!-- ======= END script ======= -->


	<!-- ======= Footer ======= -->
	<%@ include file="../includes/footer.jsp"%>
	<a href="#"
		class="scroll-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>
	<div id="preloader"></div>
	<!-- Vendor JS Files -->
	<script
		src="../resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="../resources/assets/vendor/aos/aos.js"></script>
	<script src="../resources/assets/vendor/glightbox/js/glightbox.min.js"></script>
	<script
		src="../resources/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
	<script src="../resources/assets/vendor/swiper/swiper-bundle.min.js"></script>
	<script
		src="../resources/assets/vendor/purecounter/purecounter_vanilla.js"></script>
	<script src="../resources/assets/vendor/php-email-form/validate.js"></script>
	<!-- Template Main JS File -->
	<script src="../resources/assets/js/main.js"></script>
	<!-- ======= END Footer ======= -->
</body>
</html>

















