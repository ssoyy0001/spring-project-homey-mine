<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 나눔 후기 조회</title>

<style>

#notice {  color: red;		}
.reqNotice{	text-align: center; 
					color: red;	}		/*이미 신청했거나 모집마감된 게시글이라고 알려줄 때 */
#odTitleBox {		border: 2px solid #FFA500; /* 진노랑색 테두리 */
    						padding: 10px; /* 텍스트와 테두리 사이의 간격을 10px로 지정 */		}

.regiItemNm {	width: 150px;
						font-weight: bold;		}
.regiItem {		width: 200px;	
						border: none; /* 테두리 없음 */
        				outline: none; /* 포커스 표시 없음 */	}
.imgNotice {	font-size: 10px; color: lightcoral;   }
#odItem {	margin-bottom: 20px; 	}
.tags, p{	 color: #F44336; 	}
.regiText{	color: #FFA000;		}
.reqForm{		background-color: #FFF8E1;		}

/* 원데이클래스 게시글 제목(링크)에 마우스 올리면 색상변화 */
.content a:hover { color : black; }		

/* 첨부파일 표시하는 li태그에 블릿 제거 */
li {    list-style: none;	}

/* 첨부파일 크기 조절*/
.uploadResult ul li img {
    max-width: 100%; /* 이미지를 부모 요소 너비에 맞게 조절 */
    max-height: auto;
    display: block;
    width : 90%;
    margin:auto;
}

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

<c:if test="${!empty msg }">
	<script>
			alert('${msg}');
	</script>
</c:if>

<!-- ======= 제품나눔 체험후기 상세조회 ======= -->

    <section id="blog" class="blog">
      <div class="container" data-aos="fade-up" data-aos-delay="100">
        <div class="row g-5">
          <div class="col-lg-8 mx-auto">
            <article class="blog-details">
              
				<h2 class="title">🎈 제품 나눔 체험후기</h2>
				<br>
				<div class="meta-top">
				  <ul>
				    <li class="d-flex align-items-center"><i class="bi bi-calendar-check-fill"></i> 후기작성일 | <fmt:formatDate value="${prvo.prDate}" pattern="yyyy/MM/dd"/> </li>
				  </ul>
				</div><!-- End meta top -->
				
			<!-- ======= 상세내용이 표시되기 시작함 ======= -->
              <div class="content">
                <br>
                <!--------------------- 후기 상세조회 -------------------->				
				<div class="form-group" id="odItem">
					<label class="regiItemNm">작성자</label>${prvo.mid}
				</div>
				
				<div class="form-group" id="odItem">
					<label class="regiItemNm">받은 물품</label>
					<a href="/freePdt/view?fpNo=${fpvo.fpNo }&mid=<sec:authentication property="principal.Username"/>">${fpvo.freePdt}</a>
				</div>
				
				<div class="form-group odTitleBox" id="odItem">
					<label class="regiItemNm prTitle">제    목 ::</label>${prvo.prTitle}
				</div>
				
				<div class="form-group">
					<textarea name="prContent" class="form-control regiItem" rows="5" readonly>${prvo.prContent }</textarea>
				</div>
				
				<br>
				<hr>
				<br>
				<!------------------------------- 첨부 파일 목록 ------------------------------->
				<div class = "row">
				   <div class = "col-lg-12">
				      <div class = "panel panel-default">
				         <div class = "panel-body">         
				               <!-- 업로드 결과 출력 -->
				               <div class = 'uploadResult'>
				                  <ul>
				                  </ul>
				               </div>
				               <!-- END 업로드 결과 출력 -->
				         </div><!-- /.panel-body -->
				      </div><!-- /.panel -->
				   </div><!-- /.col-lg-12 -->
				</div><!-- /.row -->
				<!-------------------------- END 첨부 파일 목록 -------------------------------------->

              </div><!-- End post content -->

            </article><!-- End blog post -->
          </div>
        </div>
      </div>
    </section><!-- End Blog Details Section -->
    
    <form action="/fpReview/modify" method="get" role="form" id="actionFrm">
		<input type="hidden" name="prNo" value="${prvo.prNo}">
		<input type="hidden" name="freePdt" value="${fpvo.freePdt}">
		<input type="hidden" name="mid" value="<sec:authentication property="principal.Username"/>">
        <input type="hidden" name="pageNum" value="${socri.pageNum}">
      	<input type="hidden" name="amount"  value="${socri.amount}">
        <input type="hidden" name="type"  value="${socri.type}">
        <input type="hidden" name="keyword"  value="${socri.keyword}">
               	
        <!-- 시큐리티 -->
		<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
               	
         <div class="text-center" id="btn-group">
         	<a id="ListBtn" class="btn btn-secondary">목록</a>
         	
			<sec:authorize access="${prvo.mid == pageContext.request.userPrincipal.name}">
			<input type="submit" class="btn btn-warning" value="수정"/>
			<button type="button" id="RemoveBtn" class="btn btn-danger">삭제</button>
			</sec:authorize>
		</div>
		<br><br><br>
	</form>

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

//목록 버튼 클릭 이벤트 처리 ---------------------------------

document.addEventListener("DOMContentLoaded", function() {
  // "목록" 버튼 찾아서 클릭 이벤트 핸들러를 연결
  var ListBtn = document.getElementById("ListBtn");
  if (ListBtn) {
	  ListBtn.addEventListener("click", function() {
        var form = document.getElementById("actionFrm");
        form.action = "/fpReview/list";
        form.method = "get";
        form.submit();
    });
  }
});

//END 목록 버튼 클릭 이벤트 처리 ---------------------------------



//삭제 버튼 클릭 이벤트 처리 ---------------------------------

document.addEventListener("DOMContentLoaded", function() {
  // "삭제" 버튼 찾아서 클릭 이벤트 핸들러를 연결
  var RemoveBtn = document.getElementById("RemoveBtn");
  if (RemoveBtn) {
	  RemoveBtn.addEventListener("click", function() {
      if (confirm("게시물을 삭제하시겠습니까?")){
        var form = document.getElementById("actionFrm");
        form.action = "/fpReview/remove"; 	// 삭제를 처리할 URL로 변경
        form.method = "POST"; 					// POST 요청으로 변경
        form.submit();
      }
    });
  }
});

//END 삭제 버튼 클릭 이벤트 처리 ---------------------------------

//게시물번호를 넘겨서 첨부파일 목록 가져오기 (ajax) --------------------------------------------------------

var prNoVal = '${prvo.prNo }';

(function(){ 
$.getJSON('/fpReview/attachList/',      
        		{ prNo : prNoVal },
				  function(result){                     // 잘 받아와서 성공 시
				        console.log(result);            // 첨부파일 리스트 콘솔에 찍어보기
				        showUploadedFile(result);
				  }
				);   
// ajax END   

})();

//END 첨부파일 목록 가져오기 ---------------------------------------------------



//업로드 결과 출력 -------------------------------------------------------------

var resultUL = $('.uploadResult ul');

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
						            
				//1.원본 이미지 경로 및 파일명 (URL)
				var originImg = obj.upFolder + "\\" + obj.uuid + "_" + obj.fileName;			
									
				//2. \\ >>> /로 변경  : 원본 이미지의 경로를 URL 형태로 표현하기 위해 역슬래시(\)를 슬래시(/)로 변경
				originImg = originImg.replace(new RegExp(/\\/g), "/");		

				//3.썸네일 이미지 및 파일이름과 X버튼 표시   , X버튼 : <i class="fa fa-times"></i>
				liTag += '<img src="/display?fileName=' + originImg + '"><br></li>';
							
			}
		});//END each()
					
		resultUL.append(liTag);	//출력하게 함
			
	}//END showUploadedFile()

//END 업로드 결과 출력 -------------------------------------------------------


</script>


</body>
</html>
