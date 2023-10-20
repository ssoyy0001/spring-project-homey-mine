<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<!-- ======= Breadcrumbs ======= -->
<div class="breadcrumbs d-flex align-items-center"
	style="background-image: url('../resources/assets/img/breadcrumbs-bg.jpg');">
	<div
		class="container position-relative d-flex flex-column align-items-center"
		data-aos="fade">

		<h2>Admin Page</h2>

	</div>
</div>
<!-- End Breadcrumbs -->
<main id="main">
	<!-- ======= Blog Details Section ======= -->
	<section id="blog" class="blog">
		<div class="container" data-aos="fade-up" data-aos-delay="100">
			<div class="row g-5">
				<div class="col-lg-8">
					<article class="blog-details">
						<div class="post-img">
							<img src="../resources/assets/img/blog/blog-1.jpg" alt=""
								class="img-fluid">
						</div>
					</article>
					<!-- End blog post -->
				</div>		
 				<%@ include file="../includes/sideMenuAdm.jsp"%>
			</div>
			<!-- row g-5 -->
		</div>

	</section>
	<!-- End Blog Details Section -->

</main>
<!-- End #main -->

<%@ include file="../includes/footer.jsp"%>