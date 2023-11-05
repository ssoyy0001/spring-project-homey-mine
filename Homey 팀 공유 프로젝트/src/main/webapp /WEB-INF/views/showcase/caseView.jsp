<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
.category {
	background-color: #F2F2F2;
	padding: 5px 10px;
	margin-right: 10px;
	border-radius: 20px;
}
</style>
<head>
<meta charset="UTF-8">
<title>Portfolio Detail</title>

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
				<h2>Portfolio Detail</h2>
			</div>
		</div>
		<!-- End Breadcrumbs -->

		<!-- ======= Projet Details Section ======= -->
		<section id="project-details" class="project-details">
			<div class="container" data-aos="fade-up" data-aos-delay="100">

				<div class="position-relative h-100">
					<div class="slides-1 portfolio-details-slider swiper">
						<div class="swiper-wrapper align-items-center">
							<c:forEach items="${view.attachList}" var="attach"
								varStatus="status">
								<div class="swiper-slide">

									<img src="/display?fileName=" id="image_${status.index}">
									

								</div>
								<script type="text/javascript">
     var upFolder = "${attach.upFolder.replace("\\", "/")}";
      var uuid = "${attach.uuid}";
      var fileName = "${attach.fileName}";

      var imagePath = encodeURIComponent(upFolder + "/" + uuid + "_" + fileName);

      // 사용자마다 고유한 ID를 가진 imageId 값
      var imageId = "image_" + ${status.index};

 	document.getElementById(imageId).src = "/display?fileName="+imagePath; 

    </script>
							</c:forEach>
						</div>
						<div class="swiper-pagination"></div>
					</div>
					<div class="swiper-button-prev"></div>
					<div class="swiper-button-next"></div>

				</div>

				<div class="row justify-content-between gy-4 mt-4">

					<div class="col-lg-12">
						<div class="portfolio-description">
							<div style="display: flex; align-items: baseline;">
								<h1>${view.scTitle }</h1>
								<p>　　${view.scDate }</p>
								<div style="margin-left: auto;">
									<i class="fa-solid fa-star fa-2x" id="star"style="color:black;">${view.scrabCnt}</i>
								</div>
							</div>
							<div style="dispaly: flex;">
								<span class="category">${view.buildingType }</span>
								<span class="category">${view.sizeRange }</span> <span
									class="category">${view.totalRange }</span>
							</div>
							<br><br><br>
							<p style="font-size: 18pt">${view.scContent }</p>

						</div>
						<hr>
						<div style="text-align: center;">
						<sec:authorize access="!hasRole('ROLE_ADMIN')">
							<a
								href="javascript:history.back()"
								class="btn btn-secondary">목록으로</a>
						</sec:authorize>
							<sec:authorize access="hasRole('ROLE_ADMIN')">
							<a
								href="/showcase/caseList?pageNum=${param.pageNum }&amount=12&totalRange=${param.totalRange }&sizeRange=${param.sizeRange }&buildingType=${param.buildingType}"
								class="btn btn-secondary">목록으로</a>
								<a href="/showcase/caseModify?scid=${view.scid }"
									class="btn btn-warning">수정하기</a>
								<button type="button" class="btn btn-danger removeBtn">삭제하기</button>
							</sec:authorize>
						</div>
						<form action="/showcase/caseRemove" method="post" id="actionFrm">
							<input type="hidden" name="${_csrf.parameterName }"
								value="${_csrf.token }"> <input type="hidden"
								name="scid" value="${view.scid }">
						</form>
						<sec:authorize access="isAuthenticated()">
							<input type="hidden" id="mid"
								value="<sec:authentication property='principal.username' />">
						</sec:authorize>
						<sec:authorize access="!isAuthenticated()">
							<input type="hidden" id="mid" value="">
						</sec:authorize>
					</div>
				</div>

			</div>
		</section>
		<!-- End Projet Details Section -->

	</main>
	<!-- End #main -->

	<%@ include file="../includes/footer.jsp"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

	<script type="text/javascript">
$('.fa-star').hover(
  function() {
    $(this).addClass('animate__animated animate__heartBeat');
  },
  function() {
    $(this).removeClass('animate__animated animate__heartBeat');
  }
);
	var mid=$('#mid').val();
	var scid='${view.scid}';
	var csrfHeaderName = '${_csrf.headerName}';//csrf 토큰 관련 변수
	var csrfTokenValue = '${_csrf.token}';
	var actionFrm = $('#actionFrm');
	$('.removeBtn').on('click',function(){
		if(confirm('삭제하시겠습니까?')){
			actionFrm.submit();
		}
	});
	function scrabCnt(){//게시물의 scrab수
		$.ajax({
	        url: "/scrab/scrabCnt", // AJAX 요청을 보낼 URL
	        type: "POST", // HTTP 요청 방식 (POST)
	        data: {
	            scid: scid, // scid 값 설정 (원하는 값으로 변경)
	        },
	        dataType: 'text',
	        beforeSend : function(xhr) {//xhr; xml http request
				//전송 전 csrf 헤더 설정    
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
	        success: function(result, status, xhr) {
	        	console.log(result);
	        	 $('.fa-star').html(result);
	        },
	        error: function(xhr, status, error) {
	       	console.log(error);
	        }
	    });
	}
	scrabCnt();
	function updateStar(){//개인마다 스크랩 표시
		  $.ajax({
		        url: "/scrab/isScrab", // AJAX 요청을 보낼 URL
		        type: "POST", // HTTP 요청 방식 (POST)
		        data: {
		            scid: scid, // scid 값 설정 (원하는 값으로 변경)
		            mid: mid // mid 값 설정 (원하는 값으로 변경)
		        },
		        beforeSend : function(xhr) {//xhr; xml http request
					//전송 전 csrf 헤더 설정    
					xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
				},
		        success: function(response) {
		            if (response == 'scrab') {
		                $('.fa-star').attr('style', 'color: yellow');
		                $('.fa-star').attr('name', 'yellowStar');
		            } else{
		          	  $('.fa-star').attr('style', 'color: gray');
		              $('.fa-star').attr('name', 'grayStar');
		            }
		        },
		        error: function(xhr, status, error) {      
		        }
		    });
	}
	updateStar();
	function updateScScrabCntUpdate(){//showcase 의 스크랩수 업데이트
		  $.ajax({
		        url: "/scrab/updateScrabCnt", // AJAX 요청을 보낼 URL
		        type: "POST", // HTTP 요청 방식 (POST)
		        data: {
		            scid: scid, // scid 값 설정 (원하는 값으로 변경)
		        },
		        beforeSend : function(xhr) {//xhr; xml http request
					//전송 전 csrf 헤더 설정    
					xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
				},
		        success: function(response) {
		          console.log(response);
		        },
		        error: function(xhr, status, error) {    
		        	 console.log(error);
		        }
		    });
	}
	$(document).ready(function() {
	$('#star').on('click', function() { //스크랩 추가 삭제 
		  var star = $(this);
		    var name=star.attr('name');
			console.log("click");
			console.log(name);
			if(name == 'grayStar'){
		        $.ajax({
		            url: "/scrab/regist",
		            type: "POST",
		            data: {
		                scid: scid,
		                mid: mid
		            },
		            beforeSend: function(xhr) {
		                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		            },
		            success: function(response) {
		             updateStar();
		             scrabCnt();
		             updateScScrabCntUpdate()
		             alert('스크랩 추가!');
		            },
		            error: function(xhr, status, error) {
		                alert('로그인 후 이용해 주세요');
		            }
		        });
		    } else if (name == 'yellowStar') {
		        $.ajax({
		            url: "/scrab/remove",
		            type: "POST",
		            data: {
		                scid: scid,
		                mid: mid
		            },
		            beforeSend: function(xhr) {
		                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		            },
		            success: function(response) {
				             updateStar();
				             scrabCnt();
				             updateScScrabCntUpdate()
				             alert('스크랩 취소!');
		            },
		            error: function(xhr, status, error) {
		                console.error(error);
		            }
		        });
		    }
	});
	});
	</script>
