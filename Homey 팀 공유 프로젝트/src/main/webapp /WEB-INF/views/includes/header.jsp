<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>HOMEY</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- Favicons -->
<link href="../resources/assets/img/favicon.png" rel="icon">
<link href="../resources/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,600;1,700&family=Roboto:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Work+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="../resources/assets/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="../resources/assets/vendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet">
<link href="../resources/assets/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet">
<link href="../resources/assets/vendor/aos/aos.css" rel="stylesheet">
<link href="../resources/assets/vendor/glightbox/css/glightbox.min.css"
	rel="stylesheet">
<link href="../resources/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

<!-- Template Main CSS File -->
<link href="../resources/assets/css/main.css" rel="stylesheet">
<!-- Vendor JS Files -->
	<script src="../resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="../resources/assets/vendor/aos/aos.js"></script>
	<script src="../resources/assets/vendor/glightbox/js/glightbox.min.js"></script>
	<script src="../resources/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
	<script src="../resources/assets/vendor/swiper/swiper-bundle.min.js"></script>
	<script src="../resources/assets/vendor/purecounter/purecounter_vanilla.js"></script>
	<script src="../resources/assets/vendor/php-email-form/validate.js"></script>

	<!-- Template Main JS File -->
	<script src="../resources/assets/js/main.js"></script>

<!-- =======================================================
  * Template Name: UpConstruction
  * Updated: Sep 18 2023 with Bootstrap v5.3.2
  * Template URL: https://bootstrapmade.com/upconstruction-bootstrap-construction-website-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->

<style type="text/css">
</style>
</head>

<body>
	<!-- ======= Header ======= -->
	<header id="header" class="header d-flex align-items-center">
		<div
			class="container-fluid container-xl d-flex align-items-center justify-content-between">

			<a href="/gen/main" class="logo d-flex align-items-center"> <!-- Uncomment the line below if you also wish to use an image logo -->
				<!-- <img src="../resources/assets/img/logo.png" alt=""> -->
				<h1>
					HOMEY<span>.</span>
				</h1>
			</a> 
			<i class="mobile-nav-toggle mobile-nav-show bi bi-list"></i> 
			<i class="mobile-nav-toggle mobile-nav-hide d-none bi bi-x"></i>
			
			<!-- 헤더 메뉴 시작 -->
			<nav id="navbar" class="navbar">
				<ul>
					<li><a href="#">시공사례</a></li>
					<li><a href="/consult/register">견적상담</a></li>
					<li><a href="#">시공후기</a></li>
					<li class="dropdown"><a href="#"><span>이벤트</span> 
					<i class="bi bi-chevron-down dropdown-indicator"></i></a>
					<ul>
						<li><a href="/oneday/list">원데이클래스</a></li>
						<li><a href="/freePdt/list">제품 나눔</a></li>
						<li><a href="#">무료 시공 이벤트</a></li>
					</ul></li>
					<li class="dropdown"><a href="#"><span>리뷰</span> <i
							class="bi bi-chevron-down dropdown-indicator"></i></a>
						<ul>
							<li><a href="/odReview/list">원데이클래스 리뷰게시판</a></li>
							<li><a href="/fpReview/list">제품 나눔 리뷰게시판</a></li>
						</ul></li>
					<li><a href="#">인테리어 매거진</a></li>
					<li class="dropdown"><a href="#"><span>기타</span> <i
							class="bi bi-chevron-down dropdown-indicator"></i></a>
						<ul>
							<li><a href="#">문의게시판</a></li>
							<li><a href="#">AS 게시판</a></li>
							<li><a href="#">공지게시판</a></li>
						</ul></li>
				</ul>
			</nav>
						<!-- common 시작, 보이는건 c:if문으로 판별해주세요 -->
			<div class="login-button">
            <a href="#"> &nbsp; 회원가입</a>
            <a href="#"> &nbsp; 로그인</a> <!-- 로그인 시 test님 로그인 중 -->
            <a href="#"> &nbsp; 마이페이지</a> <!-- 관리자 페이지 -->
            <!-- common end -->
        	</div>
			<!-- .navbar -->
			<!-- 헤더 메뉴 끝  -->

		</div>
	</header>
	<!-- End Header -->
