<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 나눔 후기 수정</title>

<style>
	#notice {  color: red;		}
	.regiItemNm {	width: 150px;	}
	.regiItem {		width: 200px;	}
	.imgNotice {	font-size: 10px; color: lightcoral;   }
	.staticItem {		width: 200px;	
							border: none; /* 테두리 없음 */
        					outline: none; /* 포커스 표시 없음 */	}
</style>

</head>
<body>
<!-- ======= header ======= -->
<%@ include file="../includes/header.jsp" %>

<!--======= main ======= -->
<main id="main">

<!-- ======= Breadcrumbs ======= -->
<div class="breadcrumbs d-flex align-items-center" style="background-image: url('../resources/assets/img/breadcrumbs-bg.jpg');">
  <div class="container position-relative d-flex flex-column align-items-center" data-aos="fade">
    <h2>Product Trial Review</h2>
  </div>
</div><!-- End Breadcrumbs -->

 <!-- ======= 제품 나눔 후기 수정 폼 ======= -->
 
<section id="project-details" class="project-details">
    <div class="container" data-aos="fade-up" data-aos-delay="100">
    <div class="row justify-content-between gy-4 mt-4">
    <div class="col-lg-8 mx-auto">
	    <div class="portfolio-description">
	        <h2>📝제품 나눔 당첨후기 수정</h2>
	        <span id="notice">* 항목은 필수 입력 항목입니다.</span>
	        <hr>
<!-----------------------start form----------------------->
	        <form action="/fpReview/modify" method="post" id="modiForm" role="form" enctype="multipart/form-data">
	            
	            <input type="hidden" name="prNo" value="${prvo.prNo }">
	            
	            <div class="form-group mt-3">
	                <label class="regiItemNm"><strong>* 작성자</strong></label>
	                <input type="text" name="mid" class="staticItem" value="${prvo.mid }" readonly>
	            </div>
	            
	            <div class="form-group mt-3">
	                <label class="regiItemNm"><strong>* 나눔 물품</strong></label>
	                <input type="text" class="staticItem" value="${freePdt }" readonly>
	            </div>

	            <div class="form-group mt-3">
	                <label class="regiItemNm"><strong>* 제   목</strong></label>
	                <input type="text" name="prTitle" class="form-control" value="${prvo.prTitle }">
	            </div>
	            
	            <div class="form-group mt-3">
		            <label class="regiItemNm"><strong>* 내   용</strong></label>
		            <textarea class="form-control" name="prContent" id="" rows="10">${prvo.prContent }</textarea>
	        	</div>
	            
	            <br>
	            
	            <!-- 스프링 시큐리티 ( 서버에서 들어오는 정보 ) -->
	            <!-- 서버에서 _csrf의 토큰을 받아오면서 침입인 건지 아닌지를 판별함(토큰이 없으면 침입으로 간주) -->
	            <input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
                
                <!---- 수정 이후에 Criteria 내용을 유지하기 위함 ------------------------>
	            <input type="hidden" name="pageNum" value="${socri.pageNum}">
		        <input type="hidden" name="amount"  value="${socri.amount}">
	            <input type="hidden" name="type" value="${socri.type}">
		        <input type="hidden" name="keyword"  value="${socri.keyword}">
		        
	            <br>
	            <br>
	            
	            <div class="text-center" id="btn-group">
					<button type="button" class="btn btn-secondary" onclick="insertCancel(event);">취소</button>
					<button type="submit" class="btn btn-warning modiBtn">수정</button>
	            </div>
	            
	        </form>
<!-----------------------end form----------------------->

<!----------------------------- 첨부파일 ------------------------------>
<div class = "row">
   <div class = "col-lg-12">
      <div class = "panel panel-default">
         <div class = "panel-heading">
         	이미지 첨부
         </div>
         <!-- /.panel-heading -->
         <div class = "panel-body">
         		<!-- 첨부파일 선택 -->
               <div class = "form-group uploadDiv">
                  <input type = "file" name = 'uploadFile' multiple>
               </div>
               <!-- 업로드 결과 출력 -->
               <div class = 'uploadResult'>
                  <ul>
                  </ul>
               </div>
         </div><!-- /.panel-body -->
      </div><!-- /.panel -->
   </div><!-- /.col-lg-12 -->
</div><!-- /.row -->
<!----------------------------- END 첨부파일 ------------------------------>

	        
	    </div><!-- End portfolio-description -->
    </div><!-- End col-lg-8 mx-auto -->
    </div><!-- End row justify-content-between -->
    </div><!-- End container -->
</section><!-- End Project Details Section -->


</main><!-- End #main -->


<%@ include file="../includes/footer.jsp"%>

  <a href="#" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
  <div id="preloader"></div>
  
  <!-- 자바스크립트 파일 -->
  <script src="../resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="../resources/assets/vendor/aos/aos.js"></script>
  <script src="../resources/assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="../resources/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="../resources/assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="../resources/assets/vendor/purecounter/purecounter_vanilla.js"></script>
  <script src="../resources/assets/vendor/php-email-form/validate.js"></script>
  <!-- Template Main JS File -->
  <script src="../resources/assets/js/main.js"></script>


<script>



//원데이클래스 등록 폼에서 [취소] 버튼 클릭 시 
function insertCancel(event){
	if(confirm('수정하던 글이 모두 사라집니다. \n게시글 등록을 취소하시겠습니까?')){
		 history.back(); 
  }else if(!cancel){
      	  event.preventDefault();
  };
}



//게시물번호를 넘겨서 첨부파일 목록 가져오기 (ajax) --------------------------------------------------------

var fpNoVal = '${prvo.fpNo }';

(function(){ 
$.getJSON('/fpReview/attachList/',      
        		{ prNo : fpNoVal },
				  function(result){                     // 잘 받아와서 성공 시
				        console.log(result);            // 첨부파일 리스트 콘솔에 찍어보기
				        showUploadedFile(result);
				  }
				);   
// ajax END   

})();

//END 첨부파일 목록 가져오기 ---------------------------------------------------



//업로드 결과 출력 ------------------------------------------------------------------------------------
var resultUL = $('.uploadResult ul');		//업로드결과를 ul내의 li에 추가하여 표시할 예정
	
function showUploadedFile(result){
		
	resultUL.empty(); // 기존 결과를 비움 -> 안비우면 두 쌍씩 뜨던데 왜 그러는지 모르겠음
				
	if(result == null || result.length == 0){		//result에 값이 없다면 showUploadedFile 함수 탈출. 보여줄 게 없으니까
		return;
	}
	var liTag = '';		
				
	$(result).each(function(i, obj){		//i는 result(attachList)배열의 크기, obj는 result 속 개별파일
	
		//서버로 전송할 정보(첨부파일VO의 4가지 변수)를 li태그의 속성으로 저장
		//data- 뒷이름은 소문자로 해야 인식됨(이유모를에러), obj가 이미지파일이든 아니든 첨부파일테이블에 넣어야 하므로 if문 밖에 작성
		liTag += '<li data-uuid="' + obj.uuid + '" data-filenm="' +obj.fileName + 
		'" data-folder="' + obj.upFolder + '" data-image="' + obj.image + '">';
			
		
		if (obj.image) {		//이미지인 경우 true, 아닐 경우 false 반환. -> 이미지인 경우 썸네일과 파일명 표시되도록 구현
			//썸네일 이미지 URL
			var thumbImg = encodeURIComponent(obj.upFolder + '/s_' + obj.uuid + '_' + obj.fileName);
					            
			//1.원본 이미지 경로 및 파일명 (URL)
			var originImg = obj.upFolder + "\\" + obj.uuid + "_" + obj.fileName;			
								
			//2. \\ >>> /로 변경  : 원본 이미지의 경로를 URL 형태로 표현하기 위해 역슬래시(\)를 슬래시(/)로 변경
			originImg = originImg.replace(new RegExp(/\\/g), "/");		

			//3.썸네일 이미지 및 파일이름과 X버튼 표시   , X버튼 : <i class="fa fa-times"></i>
			liTag += '<img src="/display?fileName=' + thumbImg + '"><br>'
	           + obj.fileName +
	           '<button type="button" class="btn btn-warning btn-circle" '
	           +'data-file="' + thumbImg + '" ' + ' data-type="image"> '
	           +' <i class="fa fa-times"></i></button></li>';
					
		}
		
	});//END each()
				
	resultUL.append(liTag);	//출력하게 함
		
}//END showUploadedFile() 업로드 결과 출력 ---------------------------------




//[수정] 버튼 클릭 시
$('.modiBtn').click(function(event) {
	event.preventDefault(); 						//form 제출 막기

	
	// 필수 입력 필드의 값들을 가져와서 검사
	var prTitle = $('input[name="prTitle"]').val();
	var prContent = $('input[name="prContent"]').val();

	if ( prTitle === "" || prContent === "" ) {		//입력 필수항목 중 빈 값이 있을 경우
	 	
		alert("미입력 항목을 확인해주세요.");	
	 	
	}else{		//입력 필수항목이 다 채워져있다면
		
		//서버로 전송할 첨부파일vo의 정보를 form에 붙여야 함
		 var hiddenTag = '';
		
		//앞쪽은 첨부파일DTO 변수와 일치시키고, 뒷쪽은 data-에 붙인 것과 일치시킬 것
		$('.uploadResult ul li').each(function(i, obj){
	        hiddenTag += '<input type="hidden" name="prAttachList[' + i + '].uuid" value="' + $(obj).data('uuid') + '">' +
					            '<input type="hidden" name="prAttachList[' + i + '].fileName" value="' + $(obj).data('filenm') + '">' +
					            '<input type="hidden" name="prAttachList[' + i + '].upFolder" value="' + $(obj).data('folder') + '">' +
					            '<input type="hidden" name="prAttachList[' + i + '].image" value="' + $(obj).data('image') + '">';
		});
			 
		$('#modiForm').append(hiddenTag);		//form안에 hidden 태그 붙이기
		
		
		if (confirm('수정하시겠습니까?')) {
			$('#modiForm').submit();
		}
		
		
	}//END else
	
});





//업로드 제한(사이즈, 확장자) 확인-------------------------------------------------

var regEx = new RegExp("\\.(bmp|gif|jpg|jpeg|png)$");		//정규표현식 : 이미지 파일만 업로드 가능
var maxSize = 10485760;													//사이즈제한 : 10mb까지만 업로드 가능

function checkExtension(fileName, fileSize){
			//확장자 확인 및 알림 메시지 출력 및 중단
			if (!regEx.test(fileName)) {								//파일이름의 확장자부분을 regEx로 테스트
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




//첨부파일 선택 이벤트 처리 : 폴더에 추가되고, 업로드 결과 출력됨 (showUploadedFile함수) --------------------------------------

var csrfHeaderName = '${_csrf.headerName}';		//CSRF 토큰 관련 변수
var csrfTokenValue = '${_csrf.token}';						//CSRF 

$('input[type="file"]').on('change', function(){		//인풋 타입의 파일이 상태가 바뀌면~ (파일이 첨부되면)
	
	console.log('>>파일 첨부 로직');									//함수 들어와졌는지 확인
	var formData = new FormData();							//파일이 추가되면, FormData 객체에 파일들이 추가될 예정
	var files = $('input[name="uploadFile"]')[0].files;	// [0]: 선택된 요소들 중 첫 번째 요소를 선택, .files: 선택된 파일의 목록을 가져옴
	
	console.log(files);		//파일 여러 개 선택 후 upload버튼 눌렀을 때, 콘솔에 파일객체들(files) 불러와지는지 확인
	
	//formData 객체에 선택된 파일들 추가
	for(var i=0; i<files.length; i++){
				
		if(!checkExtension(files[i].name, files[i].size)){	//업로드 제한 사항이 있으면 폼에 추가 X. 중단
			return false;
		}
		
		formData.append('uploadFile', files[i]);		//업로드 제한 사항에 걸리지 않는다면, formData객체에 해당 파일 추가
	}//END for
	
	//ajax로 전송
	$.ajax({
		type	: 'post',															//get	|| post
		url		: '/upload/ajaxAction',									//전송할 곳 (컨트롤러 맵핑)
		data	: formData,													//위의 formData객체를 서버로 보낼 것 , data:서버로 보낼 요청 데이터를 정의
		dataType : 'json',													//서버에서 받아온 응답 데이터의 예상 형식을 지정
		contentType	: false,												//컨텐트 타입 및 인코딩
		processData : false,
		beforeSend : function(xhr){		//xhr ; XML Http Request	, beforeSend : 서버로 전송하기 전 과정
			//서버로 전송 전 CSRF 헤더 설정
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);		//csrfHeaderName, csrfTokenValue는 위에서 변수 선언해둠
		},
		success	:	function(result, status, xhr){					//성공 시 (result에 success 담겨있음 -> 컨트롤러에서 설정)
							console.log('업로드 성공!');
							console.log(result);							//result에 뭐가 들어오지?
							// 리스트 내용 출력
				            for (var i=0; i < result.length; i++) {
				                $('input[type="file"]').val('');		//업로드 성공 시 "파일 2개"가 초기화돼야 함. input 타입이 file인 걸 찾아서 value 지우기 -> "선택파일없음" 출력됨
				                showUploadedFile(result);			//업로드결과를 출력하는 li를 붙이는 showUploadedFile함수 호출
				            }
						},
		error	:	function(xhr, status, er){							//에러 시
						console.log('업로드 실패!');
					}		
	});//END ajax()
});//END 첨부파일 선택 이벤트 처리 -----------------------------------------






//썸네일 원본 이미지 표시
function showOriginal(originImg){
	//showUploadedFile 함수에서 썸네일 이미지에 a태그, href속성 만들기 : showOriginal 함수호출하도록
	//<div>태그 사이에 <img src=>이라고 태그가 생겨야 함

//	alert(originImg);		//originImg : 2023/08/30/77b3d29a-b069-40f3-a844-a9005cb8ecf2_P1237.png 연월일폴더, 파일명 출력됨
	
	$('.originImgDiv').css('display', 'flex').show();		//스타일에서 display가 none이었어서 flex로 바꿔줌. -> 회색 배경 추가

    // div에 이미지 태그를 추가
    $(".originImg").html('<img src="/display?fileName=' + originImg + '">')
    						.animate({width:'100%', height:'100%'}, 1000); //1초  = 1000  (.amimate부터 추가)
    //.originImg 요소의 내용을 이미지로 바꾼 후에, 이미지의 너비와 높이를 0.5초(1000 밀리초) 동안 100%로 애니메이션화하는 코드
}
//END 썸네일 원본 이미지 표시



//썸네일 원본 이미지 클릭 이벤트 처리 -> 이미지 클릭 시 다시 숨겨지도록 -----
$('.originImgDiv').on('click', function(){
	 $(".originImg").animate({width:'0%', height:'0%'}, 1000);		//사진을 0으로 바꾸고
    $(this).fadeOut(500); 															//Div를 0.5초 동안 페이드아웃
});
//END 썸네일 원본 이미지 클릭 이벤트 처리-------------------------------



//X버튼 클릭 이벤트 처리 ---------------------------------------------------




//아까는 span을 클릭하면 파일을 지우는 거였는데,
//이제 버튼을 클릭하면 li를 remove

$('.uploadResult').on('click', 'button', function(){		//uploadResult를 찾아서 'button'에 이벤트 걸기
	var x = $(this).closest('li'); 						// 클릭된 X버튼과 가장 가까운 li 요소 선택
	
	$.ajax({
		type : 'POST',
		url: '/deleteFile',										//전송할 곳 : 컨트롤러 맵핑
		data : {fileName : $(this).data('file'), type : $(this).data('type')},			//전송할 데이터 : 컨트롤러에서 매개변수로 지정해둔 이름들
		dataType : 'text',										//"deleted"를 받을 거니까
		beforeSend : function(xhr){		//xhr ; XML Http Request	, beforeSend : 서버로 전송하기 전 과정
			//서버로 전송 전 CSRF 헤더 설정 (register.jsp에서는 파라미터네임이었는데, ajax에서는 헤더네임으로 사용)
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);		//위에 변수 선언해논 것들임
		},
		success : function(result, status, xhr){		//성공하면 가장 가까운 li 지우기 (화면/서버 모두에서 지워지도록)
			alert(result);
			x.remove();								//X버튼 눌러서 삭제성공하면, 화면에서 list 지우기
		},
		error : function(xhr, status, er){
			console.log("delete error");
		}
	});
});
	
//END X버튼 이벤트 처리 ----------------------------------------------
						



</script>


</body>
</html>
