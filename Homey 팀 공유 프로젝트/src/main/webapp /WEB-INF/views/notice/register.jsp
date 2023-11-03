<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 등록</title>
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
/* 첨부파일 경고문구 */
.imgNotice {	font-size: 10px; color: lightcoral;   }
/* 필수입령항목 경고 문구 */
#notice {  color: red;		}
.regiItemNm {	width: 150px;	}
/* 고정항목 */
.staticItem {		width: 200px;	
						border: none; /* 테두리 없음 */
       					outline: none; /* 포커스 표시 없음 */	}

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
		<h2>공지사항 등록</h2>
	</div>
</div>
<!-- End Breadcrumbs -->

<!-- ======= 게시물 등록 ======= -->
<section id="project-details" class="project-details">
    <div class="container" data-aos="fade-up" data-aos-delay="100">
    <div class="row justify-content-between gy-4 mt-4">
    <div class="col-lg-8 mx-auto">
	    <div class="portfolio-description">
	        <h2>📝공지사항 등록</h2>
	        <span id="notice">* 항목은 필수 입력 항목입니다.</span>
	        <hr>

	<!----------게시물 등록 폼 -->
	<form action="/notice/register" method="post" role="form">
		
		<div class="col-md-6 form-group">
			<label>* 분류</label> <select name="notCategory" id="notCategory">
				<option value="일반">일반</option>
				<option value="서비스안내">서비스안내</option>
			</select>
		</div>
		
		<div class="form-group mt-3">
           <label class="regiItemNm"><strong>* 작성자</strong></label>
           <input type="text" name="mid" class="staticItem" value="<sec:authentication property="principal.Username"/>" readonly>
	    </div>
	    
        <div class="form-group mt-3">
            <label class="regiItemNm"><strong>* 제   목</strong></label>
            <input type="text" name="notTitle" class="form-control" required>
        </div>	    

        <div class="form-group mt-3">
         	<label class="regiItemNm"><strong>* 내   용</strong></label>
         	<textarea class="form-control" name="notCont" rows="10" required></textarea>
    	</div>     
    	
    	<br>   
    	<br>   
		
		<div class="float-end">
		<button type="reset" class="btn btn-secondary">초기화</button>
		<button type="button" class="btn btn-warning"
			onclick="insertCancel(event);">목록으로</button>
		<button type="submit" class="btn btn-primary regBtn">등록</button>
		</div>
		<input type="hidden" name="${_csrf.parameterName }"
			value="${_csrf.token }">

	</form>
	<!-- END 게시물 등록 폼 -->

	<!-- 첨부 파일 ------------------------------->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading"><strong>파일 첨부</strong></div>
				<br>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<div class="form-group uploadDiv">
						<input type="file" name="uploadFile" multiple>
					</div>
					<div class="imgNotice">* 이미지 파일은 10mb 이내, 파일 확장자는 jpg 혹은 png만 가능</div>
					<!-- 업로드 결과 출력 -->
					<div class="uploadResult">
						<ul>
						</ul>
					</div>
					<!-- END 업로드 결과 출력 -->
				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
	<!-- END 첨부 파일 --------------------------->

	    </div><!-- End portfolio-description -->
    </div><!-- End col-lg-8 mx-auto -->
    </div><!-- End row justify-content-between -->
    </div><!-- End container -->
</section><!-- End Project Details Section -->

</main>


<!-- ======= script ======= -->
<script>
	
//취소 버튼 누를 시 ----------------------------
	function insertCancel(event){
	if(confirm('작성하던 글이 모두 사라집니다. \n게시글 등록을 취소하시겠습니까?')){
		 history.back(); 
    }else if(!cancel){
        	  event.preventDefault();
    };
}
// END 취소 버튼 누를 시 ----------------------------


//등록 버튼 누를 시 ----------------------------
//submit 버튼을 누르면 먼저 폼 전송부터 하게 하지 말고,
//hidden태그를 만들고 //그 이후에 폼을 전송해
var frm = $('form[role="form"]');
//submit 버튼 이벤트 처리 -----------------
$('button[type="submit"]')
		.on(
				'click',
				function(e) {
					e.preventDefault();

					var hiddenTag = ''; //서버 전송을 위한 추가부분	

					$('.uploadResult ul li')
							.each(
									function(i, obj) {//개발자 도구에 소문자로 넣어짐
										hiddenTag += '<input type="hidden" name="attachList['
												+ i
												+ '].uuid" '
												+ ' value="'
												+ $(obj).data('uuid')
												+ '">';

										hiddenTag += '<input type="hidden" name="attachList['
												+ i
												+ '].upFolder" '
												+ ' value="'
												+ $(obj).data('folder')
												+ '">';

										hiddenTag += '<input type="hidden" name="attachList['
												+ i
												+ '].fileName" '
												+ ' value="'
												+ $(obj).data('filenm')
												+ '">';

										hiddenTag += '<input type="hidden" name="attachList['
												+ i
												+ '].image" '
												+ ' value="'
												+ $(obj).data('image')
												+ '">';
									});
					//앞은 DTO랑 똑같이, 뒤는 li와 똑같이
					frm.append(hiddenTag);
					frm.submit();
				});//END submit 버튼 이벤트 처리 -------------
// END 등록 버튼 누를 시 ----------------------------
		



		//업로드 제한 확인 ------------------------
		var regEx = new RegExp("(.*?)\.(exe|sh|zip)$"); //일부 확장자 파일은 못올리게 함
		var maxSize = 5242880;//파일 업로드 크기 제한

		function checkExtension(fileName, fileSize) {
			//크기 확인 및 알림 메시지 출력 -- 순서대로
			if (fileSize > maxSize) {
				alert("파일 크기(5MB)가 초과하여 업로드 할 수 없습니다.");
				return false;
			}

			if (regEx.test(fileName)) { //이곳에 해당하면 25번 라인에 해당하는 확장자명
				alert("해당 형식의 파일은 업로드 할 수 없습니다.");
				return false;
			}
			//그 외의 경우 업로드
			return true;
		}//END 업로드 제한 확인 --------------------

		//첨부파일 선택 이벤트 처리 -----------------
		var csrfHeaderName = '${_csrf.headerName}'; //CSRF 토큰 관련 변수
		var csrfTokenValue = '${_csrf.token}'; //
		$('input[type="file"]').on('change', function() {
			var formData = new FormData();
			var files = $('input[name="uploadFile"]')[0].files;

			//formData 객체에 파일 추가
			for (var i = 0; i < files.length; i++) {
				//업로드 제한 사항이 있으면 폼에 추가 X 중단
				if (!checkExtension(files[i].name, files[i].size)) {
					return false;
				} else {
					formData.append('uploadFile', files[i]);
				}
			}

			$.ajax({
				type : 'post', //get | post
				url : '/upload/ajaxAction', //전송할 곳 - replyContoller로 넘어감
				data : formData, //전송할 데이터 
				dataType : 'json', //수신할 데이터 타입
				contentType : false, //컨텐트 타입 및 인코딩
				processData : false,
				beforeSend : function(xhr) { //xhr ; XML Http Request
					//전송 전 CSRF 헤더 설정
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(result, status, xhr) {//성공 시 (result에 success 담겨있음)
					$('input[type="file"]').val(""); //<input type='file'> 의 초기화
					showUploadedFile(result); //함수호출
				}, //성공시
				error : function(xhr, status, er) {
					console.log("upload error");
				} //에러시
			}); //END ajax;
		});//END 첨부파일 선택 이벤트 처리 -------------

		//업로드 결과 출력 ----------------------------------------------
		var resultUL = $('.uploadResult ul');
		function showUploadedFile(result) {
			var liTag = '';//liTag 초기화

			$(result)
					.each(
							function(i, obj) {

								//이미지든, 아니든 li태그가 다 그냥 만들어지게
								//근데 그게 attatchFileDTO안에 uuid, upfoleder, filename, image, bno
								//li태그에 첨부파일 VO 4개 추가

								//서버로 전송할 정보를 li 태그의 속성으로 저장
								liTag += '<li data-uuid="' + obj.uuid + '" ' + 
						' data-folder="' + obj.upFolder + '" ' + 
						' data-filenm="' + obj.fileName + '" ' + 
						' data-image="' + obj.image + '">';

								if (obj.image) { //이미지는 썸네일과 파일명 표시
									var thumbImg = encodeURIComponent(obj.upFolder
											+ "/s_"
											+ obj.uuid
											+ "_"
											+ obj.fileName);
									//1. 원본 이미지 경로 및 파일명
									var originImg = obj.upFolder + "\\"
											+ obj.uuid + "_" + obj.fileName;
									//2. \ 를 /로 변경
									originImg = originImg.replace(new RegExp(
											/\\/g), "/");

									liTag += '<img src="/display?fileName='
											+ thumbImg
											+ '"></a><br>'
											+ obj.fileName
											+ '<button type="button" class="btn btn-warning btn-circle" ' +
						 	 		' data-file="' + thumbImg + '" ' +
						      		' data-type="image"> '
											+ '<i class="fa fa-times"></i></button></li>';
								} else { //일반 파일은 attach.png 이미지와 파일명 표시, 클릭시 다운로드
									var filePath = encodeURIComponent(obj.upFolder
											+ "/"
											+ obj.uuid
											+ "_"
											+ obj.fileName);
									liTag += '<img src="/resources/img/attach.png"></a><br>'
											+ obj.fileName
											+ '<button type="button" class="btn btn-warning btn-circle btn-xs" ' +
					 	 		' data-file="' + filePath + '" ' +
					      		' data-type="file"> '
											+ '<i class="fa fa-times"></i></button></li>';
								}
							});//END each()
			resultUL.append(liTag);
		}//END 업로드 결과 출력 ------------------------------------------

		//X 버튼 클릭 이벤트 처리 ----------------------------------------- 삭제
		$('.uploadResult').on('click', 'button', function() {
			var x = $(this).closest('li');//버튼이 뭔지 알려주고

			$.ajax({
				type : 'post', //컨트롤러 
				url : '/deleteFile', //컨트롤러
				data : {
					fileName : $(this).data('file'),
					type : $(this).data('type')
				}, //컨트롤러에서 매개변수로 받는 파라미터 이름 : 스팬 태그에 붙인 data-file, data-type	 
				dataType : 'text',
				beforeSend : function(xhr) { //xhr ; XML Http Request
					//전송 전 CSRF 헤더 설정
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

