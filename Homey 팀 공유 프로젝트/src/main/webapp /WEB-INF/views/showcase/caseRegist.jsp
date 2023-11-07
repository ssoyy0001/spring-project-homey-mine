<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<style>
#notice {
	color: red;
}

.caseNm {
	width: 150px;
}

.caseItem {
	width: 200px;
}

.imgNotice {
	font-size: 10px;
	color: lightcoral;
}

.horizontal-list {
	display: flex;
	flex-wrap: nowrap; /* 가로 방향으로 넘치지 않도록 설정 */
}

.horizontal-list li {
	list-style: none;
	margin-right: 10px; /* 각 요소 사이의 간격을 조절할 수 있습니다. */
}
</style>

</head>
<body>
	<!-- ======= header ======= -->
	<%@ include file="../includes/header.jsp"%>

	<!--======= main ======= -->
	<main id="main">

		<!-- ======= Breadcrumbs ======= -->
		<div class="breadcrumbs d-flex align-items-center"
			style="background-image: url('../resources/assets/img/breadcrumbs-bg.jpg');">
			<div
				class="container position-relative d-flex flex-column align-items-center"
				data-aos="fade">
				<h2>Portfolio Registration</h2>
			</div>
		</div>
		<!-- End Breadcrumbs -->

		<!-- ======= 제품 나눔 게시글 등록 폼 ======= -->

		<section id="project-details" class="project-details">
			<div class="container" data-aos="fade-up" data-aos-delay="100">
				<div class="row justify-content-between gy-4 mt-4">
					<div class="col-lg-8 mx-auto">
						<div class="portfolio-description">
							<h2>시공사례 등록</h2>
							<hr>
							<!-----------------------start form----------------------->
							<form action="/showcase/caseRegist" method="post" role="form"
								enctype="multipart/form-data">

								<div class="form-group mt-3">
									<label class="caseNm"><strong>작업등록번호</strong></label> <input
										type="text" name="sicheNo" class="caseItem"
										value="${siche.sicheNo }" required readonly>
								</div>

								<div class="form-group mt-3">
									<label class="caseNm"><strong>시공비용</strong></label> <input
										type="text" name="totalRange" value="${siche.total }" readonly
										class="caseItem">
								</div>

								<div class="form-group mt-3">
									<label class="caseNm"><strong>평수</strong></label> <input
										type="text" name="sizeRange" class="caseItem"
										value="${siche.pyeongsu }" required readonly>
								</div>

								<div class="form-group mt-3">
									<label class="caseNm"><strong>주거유형</strong></label> <input
										type="text" name="buildingType" class="caseItem"
										required="required" value="${siche.buildingType }" readonly>
								</div>
								<div class="form-group mt-3">
									<label class="caseNm"><strong>썸네일 이미지</strong></label> <input
										type="file" name="thumbnailImg" />
									<div class="uploadThumbnail">
										<ul class="horizontal-list">
										</ul>
									</div>
								</div>

								<div class="form-group mt-3">
									<label class="caseNm"><strong> 제 목</strong></label> <input
										type="text" name="scTitle" class="form-control" required>
								</div>

								<div class="form-group mt-3">
									<label class="caseNm"><strong> 내 용</strong></label>
									<textarea class="form-control" name="scContent" id="" rows="10"
										required></textarea>
								</div>

								<br>

								<div class="form-group mt-3">
									<!-- 파일 선택 버튼  -->
									<div class="form-group uploadDiv">
										<input type="file" name="uploadFile" multiple="multiple" />
									</div>

									<div class="imgNotice">
										* 이미지 파일은 10mb 이내, 파일 확장자는 jpg 혹은 png만 가능<br> * 썸네일이미지 중복
										선택 X
									</div>
								</div>
								<div class="row">
									<div class="uploadResult">
										<ul class="horizontal-list">
										</ul>
									</div>
								</div>
								<!-- 스프링 시큐리티 ( 서버에서 들어오는 정보 ) -->
								<!-- 서버에서 _csrf의 토큰을 받아오면서 침입인 건지 아닌지를 판별함(토큰이 없으면 침입으로 간주) -->
								<input type="hidden" name="${_csrf.parameterName }"
									value="${_csrf.token }"> <br> <br>

								<div class="text-center" id="btn-group">
									<button type="button" class="btn btn-secondary"
										onclick="insertCancel(event);">취소</button>
									<button type="submit" class="btn btn-warning regBtn">등록</button>
								</div>

							</form>
							<!-----------------------end form----------------------->

						</div>
						<!-- End portfolio-description -->
					</div>
					<!-- End col-lg-8 mx-auto -->
					<%@ include file="../includes/sideMenuAdm.jsp"%>
				</div>
				<!-- End row justify-content-between -->
			</div>
			<!-- End container -->
		</section>
		<!-- End Project Details Section -->


	</main>
	<!-- End #main -->


	<%@ include file="../includes/footer.jsp"%>

	<a href="#"
		class="scroll-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>
	<div id="preloader"></div>


	<script>
	//비용(total),평수 데이터 변형
		window.onload = function() {
        var total ='${siche.total}'; // input 값 받아오기
        total = Math.floor(total / 10000000); // 백만으로 나누고 내림 처리 후 다시 백만을 곱하기
        if (total === 0) {
            total = "1000만원이하";
        } else if (total === 1) {
            total = "1000만원+";
        } else if (total === 2) {
            total = "2000만원+";
        } else if (total === 3) {
            total = "3000만원+";
        } else if (total >= 4) {
            total = "4000만원+";
        }
        $('input[name=totalRange]').val(total);
        
        var size='${siche.pyeongsu}'
        size=Math.floor(size/10);
        if(size ==0){
        	size="10평대";
        }else if(size >= 4){
        	size="40평대+"
        }else{
        	size=(size*10)+"평대";        	
        }
        $('input[name=sizeRange]').val(size);
    }
		//업로드 제한(사이즈, 확장자) 확인-------------------------------------------------

		var regEx = new RegExp("\\.(bmp|gif|jpg|jpeg|png)$"); //정규표현식 : 이미지 파일만 업로드 가능
		var maxSize = 10485760; //사이즈제한 : 10mb까지만 업로드 가능

		function checkExtension(fileName, fileSize) {
			//확장자 확인 및 알림 메시지 출력 및 중단
			if (!regEx.test(fileName)) { //파일이름의 확장자부분을 regEx로 테스트
				alert("이미지 형식의 파일이 아닌 경우 업로드할 수 없습니다.");
				return false;
			}
			//크기 확인 및 알림 메시지 출력 및 중단 (파일 사이즈가 5mb보다 크면, 업로드 불가)
			if (fileSize > maxSize) {
				alert("파일 크기(10MB) 초과 - 업로드 불가");
				return false;
			}
			//그 외의 경우 업로드 가능
			return true;
		}
		//END 업로드 제한 확인-----------------------------------------------------------

		//썸네일 선택 이벤트 처리 -----------------
		var csrfHeaderName = '${_csrf.headerName}';//csrf 토큰 관련 변수
		var csrfTokenValue = '${_csrf.token}';
		$('input[name="thumbnailImg"]').on('change', function() {
			var formData = new FormData();
			var files = $('input[name="thumbnailImg"]')[0].files;

			//formData 객체에 파일 추가

			if (!checkExtension(files[0].name, files[0].size)) {
				return false;
			} else {
				formData.append('uploadFile', files[0]);
			}

			$.ajax({
				type : 'post', //get | post
				url : '/scupload/ajaxAction', //전송할 곳 
				data : formData, //전송할 데이터 
				dataType : 'json', //수신할 데이터 타입
				contentType : false, //컨텐트 타입 및 인코딩
				processData : false,
				beforeSend : function(xhr) {//xhr; xml http request
					//전송 전 csrf 헤더 설정	
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(result, status, xhr) {
					$('input[type="file"]').val("");
					showUploadedThumb(result);
				}, //성공시
				error : function(xhr, status, er) {
					console.log("upload error");
				} //에러시
			}); //END ajax;
		});//END 첨부파일 선택 이벤트 처리 -------------

		//썸네일업로드 결과 출력 ----------------------------------------------
		var resultThm = $('.uploadThumbnail ul');
		function showUploadedThumb(result) {
			var liTag = '';
			var obj = $(result)[0];

			//서버로 전송할 정보를 li 태그의 속성으로 저장
			liTag += '<li data-upFolder="';
								liTag += obj.upFolder + '" data-uuid="';
								liTag += obj.uuid + '" data-fileName="';
								liTag += obj.fileName + '" data-isThumbnail=1>';

			var thumbImg = encodeURIComponent(obj.upFolder + "/s_" + obj.uuid
					+ "_" + obj.fileName);

			var originImg = obj.upFolder + "\\" + obj.uuid + "_" + obj.fileName;
			originImg = originImg.replace(new RegExp(/\\/g), "/");

			liTag += '<img src="/display?fileName='
					+ thumbImg
					+ '"></a><br>'
					+ obj.fileName
					+ '<button type="button" class="btn btn-warning btn-circle" ' +
						 	 		' data-file="' + thumbImg + '" ' +
						      		' data-type="image"> '
					+ '<i class="fa fa-times"></i></button></li>';

			resultThm.append(liTag);
		}//END 업로드 결과 출력 ------------------------------------------
		//첨부파일 선택 이벤트 처리 -----------------

		$('input[name="uploadFile"]').on('change', function() {
			var formData = new FormData();
			var files = $('input[name="uploadFile"]')[0].files;

			//formData 객체에 파일 추가
			for (var i = 0; i < files.length; i++) {
				if (!checkExtension(files[i].name, files[i].size)) {
					return false;
				} else {
					formData.append('uploadFile', files[i]);
				}
			}

			$.ajax({
				type : 'post', //get | post
				url : '/scupload/ajaxAction', //전송할 곳 
				data : formData, //전송할 데이터 
				dataType : 'json', //수신할 데이터 타입
				contentType : false, //컨텐트 타입 및 인코딩
				processData : false,
				beforeSend : function(xhr) {//xhr; xml http request
					//전송 전 csrf 헤더 설정	
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(result, status, xhr) {
					$('input[name="uploadFile"]').val("");
					showUploadedFile(result);
				}, //성공시
				error : function(xhr, status, er) {
					console.log("upload error");
				} //에러시
			}); //END ajax;
		});//END 첨부파일 선택 이벤트 처리 -------------

		//업로드 결과 출력 ----------------------------------------------
		var resultUL = $('.uploadResult ul');
		function showUploadedFile(result) {
			var liTag = '';

			$(result)
					.each(
							function(i, obj) {

								//서버로 전송할 정보를 li 태그의 속성으로 저장
								liTag += '<li data-upFolder="';
								liTag += obj.upFolder + '" data-uuid="';
								liTag += obj.uuid + '" data-fileName="';
								liTag += obj.fileName + '">';

								var thumbImg = encodeURIComponent(obj.upFolder
										+ "/s_" + obj.uuid + "_" + obj.fileName);

								var originImg = obj.upFolder + "\\" + obj.uuid
										+ "_" + obj.fileName;
								originImg = originImg.replace(
										new RegExp(/\\/g), "/");

								liTag += '<img src="/display?fileName='
										+ thumbImg
										+ '"></a><br>'
										+ obj.fileName
										+ '<button type="button" class="btn btn-warning btn-circle" ' +
						 	 		' data-file="' + thumbImg + '" ' +
						      		' data-type="image"> '
										+ '<i class="fa fa-times"></i></button></li>';

							});//END each()
			resultUL.append(liTag);
		}//END 업로드 결과 출력 ------------------------------------------
		//X 버튼 클릭 이벤트 처리 -----------------------------------------
		$('.uploadResult,.uploadThumbnail').on('click', 'button', function() {
			var x = $(this).closest('li');

			$.ajax({
				type : 'post',
				url : '/deleteFile',
				data : {
					fileName : $(this).data('file'),
					type : $(this).data('type')
				},
				dataType : 'text',
				beforeSend : function(xhr) {//xhr; xml http request
					//전송 전 csrf 헤더 설정	
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(result, status, xhr) {
					alert(result);
					x.remove();
				}, //성공시
				error : function(xhr, status, er) {
					console.log("delete error");
				} //에러시
			}); //END ajax;
		});
		//END X 버튼 클릭 이벤트 처리 -------------------------------------
		//submit
		$("button[type='submit']")
				.on(
						"click",
						function(e) {
							e.preventDefault();
							console.log("submit clicked");
							var hdTag = '';
							var obj = $('.uploadThumbnail ul li')[0];
							console.log("thumb:" + $(obj).data('uuid'));

							hdTag += '<input type="hidden" name="attachList[0].upFolder" value="'
									+ $(obj).data('upfolder') + '">';
							hdTag += '<input type="hidden" name="attachList[0].fileName" value="'
									+ $(obj).data('filename') + '">';
							hdTag += '<input type="hidden" name="attachList[0].uuid" value="'
									+ $(obj).data('uuid') + '">';
							hdTag += '<input type="hidden" name="attachList[0].isThumbnail" value=1>';

							$('.uploadResult ul li')
									.each(
											function(i, obj) {
												console
														.log($(obj)
																.data('uuid'));
												hdTag += '<input type=hidden name=attachList['
														+ (i + 1)
														+ '].upFolder value="'
														+ $(obj).data(
																'upfolder')
														+ '">';
												hdTag += '<input type=hidden name=attachList['
														+ (i + 1)
														+ '].fileName value="'
														+ $(obj).data(
																'filename')
														+ '">';
												hdTag += '<input type=hidden name=attachList['
														+ (i + 1)
														+ '].uuid value="'
														+ $(obj).data('uuid')
														+ '">';
											});

							$("form").append(hdTag);
							$("form").submit();
						});
	</script>
	<%@ include file="../includes/footer.jsp"%>
