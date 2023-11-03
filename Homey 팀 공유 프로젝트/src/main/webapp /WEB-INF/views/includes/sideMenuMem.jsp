<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
				<div class="col-lg-3">
					<div class="sidebar">
						<div class="sidebar-item categories">
							<h3 class="sidebar-title">Categories</h3>
							<ul class="mt-3">
								<li><a href="/gen/memberView?mid=<sec:authentication property="principal.Username"/>">회원 정보</a></li>
								<li><a href="/consult/myList?mid=<sec:authentication property="principal.Username"/>">나의 견적 상담관리</a></li>
								<li><a href="/sirequest/mySireqList?mid=<sec:authentication property="principal.Username"/>">나의 시공의뢰</a></li>
								<li><a href="/sischedule/sicheMyList?mid=<sec:authentication property="principal.Username"/>">나의 시공팀 작업 목록</a></li>
								<li><a href="#">나의 시공 후기</a></li>
								<li><a href="#">나의 문의 게시글</a></li>
								<li><a href="/odReq/myList?mid=<sec:authentication property="principal.Username"/>">나의 [ 원데이클래스 ] 신청내역</a></li>
								<li><a href="/freePdtReq/myList?mid=<sec:authentication property="principal.Username"/>">나의 [ 제품 나눔 ] 신청내역</a></li>
								<li><a href="#">나의 무료시공 이벤트</a></li>
								<li><a href="#">나의 AS 문의</a></li>
								<li><a href="/odReview/myList?mid=<sec:authentication property="principal.Username"/>">나의 [ 원데이클래스 ] 리뷰</a></li>
								<li><a href="/fpReview/myList?mid=<sec:authentication property="principal.Username"/>">나의 [ 제품 나눔 ] 리뷰</a></li>
								<li><a href="/scrab/myScrab?mid=<sec:authentication property="principal.Username"/>&pageNum=1&amount=12">스크랩</a></li>
								
							</ul>
						</div>
						<!-- End sidebar-item categories-->

					</div>
				</div>
