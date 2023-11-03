<%@ include file="../includes/header.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
@import
	url('https://fonts.googleapis.com/css?family=Poppins:400,500,600,700,800,900')
	;

body {
	font-family: 'Poppins', sans-serif;
	font-weight: 700;
	font-size: 17px;
	line-height: 1.7;
	color: var(- -color-secondary);
	margin-bottom: 20px;
	background-color: white;
	overflow-x: hidden;
}

a {
	cursor: pointer;
	transition: all 200ms linear;
}

a:hover {
	text-decoration: none;
}

.link {
	color: #c4c3ca;
}

.link:hover {
	color: #ffeba7;
}

p {
	font-weight: 500;
	font-size: 14px;
	line-height: 1.7;
}

h4 {
	font-weight: 600;
}

h6 span {
	padding: 0 20px;
	text-transform: uppercase;
	font-weight: 700;
}

.section {
	position: relative;
	width: 100%;
	display: block;
}

.full-height {
	min-height: 100vh;
}

.card-front, .card-back {
	width: 100%;
	height: 100%;
	background-color: #2a2b38;
	background-image:
		url('https://cdn.pixabay.com/photo/2014/02/25/22/06/staircase-274614_1280.jpg');
	/* url ('https: //s3-us-west-2.amazonaws.com/s.cdpn.io/1462889/pat.svg'); */
	background-position: bottom center;
	background-repeat: no-repeat;
	background-size: 300%;
	position: absolute;
	border-radius: 6px;
	left: 0;
	top: 0;
	-webkit-transform-style: preserve-3d;
	transform-style: preserve-3d;
	-webkit-backface-visibility: hidden;
	-moz-backface-visibility: hidden;
	-o-backface-visibility: hidden;
	backface-visibility: hidden;
}

.center-wrap {
	position: absolute;
	width: 100%;
	padding: 0 35px;
	top: 50%;
	left: 0;
	transform: translate3d(0, -50%, 35px) perspective(100px);
	z-index: 20;
	display: block;
}

.form-group {
	position: relative;
	display: block;
	margin: 0;
	padding: 0;
}

.form-style {
	padding: 13px 20px;
	padding-left: 55px;
	height: 48px;
	width: 100%;
	font-weight: 500;
	border-radius: 4px;
	font-size: 14px;
	line-height: 22px;
	letter-spacing: 0.5px;
	outline: none;
	color: #c4c3ca;
	background-color: #1f2029;
	border: none;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
	box-shadow: 0 4px 8px 0 rgba(21, 21, 21, .2);
}

.form-style:focus, .form-style:active {
	border: none;
	outline: none;
	box-shadow: 0 4px 8px 0 rgba(21, 21, 21, .2);
}

.form-group input:-ms-input-placeholder {
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
	font-size: 26px;
	font-weight: 700;
	margin-bottom: 20px;
	color: var(- -color-secondary);
}

.form-group input:-moz-placeholder {
	color: var(- -color-secondary);
	opacity: 0;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
}

.form-group input::-webkit-input-placeholder {
	color: var(- -color-secondary);
	opacity: 0;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
}

.form-group input:focus:-ms-input-placeholder {
	opacity: 0;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
}

.form-group input:focus::-moz-placeholder {
	opacity: 0;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
}

.form-group input:focus:-moz-placeholder {
	opacity: 0;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
}

.form-group input:focus::-webkit-input-placeholder {
	opacity: 0;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
}

.btn {
	border-radius: 4px;
	height: 44px;
	width: 20%;
	font-size: 13px;
	font-weight: 600;
	text-transform: uppercase;
	-webkit-transition: all 200ms linear;
	transition: all 200ms linear;
	padding: 0 30px;
	letter-spacing: 1px;
	display: -webkit-inline-flex;
	display: -ms-inline-flexbox;
	display: inline-flex;
	-webkit-align-items: center;
	-moz-align-items: center;
	-ms-align-items: center;
	align-items: center;
	-webkit-justify-content: center;
	-moz-justify-content: center;
	-ms-justify-content: center;
	justify-content: center;
	-ms-flex-pack: center;
	text-align: center;
	border: none;
	background-color: #ffeba7;
	color: #102770;
	box-shadow: 0 8px 24px 0 rgba(255, 235, 167, .2);
}

.btn
:active
,
.btn
:focus

	
background-color
:
 
#102770
;

	
color
:
 
#ffeba7
;

	
box-shadow
:
 
0
 
8px
 
24px
 
0
 
rgba
(
16
,
39
,
112
,
.2
)
;


}
.btn:hover {
	background-color: #102770;
	color: #ffeba7;
	box-shadow: 0 8px 24px 0 rgba(16, 39, 112, .2);
}

/* callout 문구 강조 */
#callout {
	background-color: #FFAF00;
	color: white;
	padding: 20px;
	border-radius: 40px 80px;
	width: 100%;
	text-align: left; /* 왼쪽 정렬로 변경 */
	margin: 20px;
	font-size: 14px;
}

.checkbox-inline {
	display: flex;
	align-items: center;
}

.checkbox-inline input[type="number"] {
	margin-left: 5px; /* 원하는 간격으로 조정합니다. */
}
</style>

<c:if test="${!empty msg }">
	<script>
		alert('${msg}');
	</script>
</c:if>
<main id="main">

	<!-- ======= Breadcrumbs ======= -->
	<div class="breadcrumbs d-flex align-items-center"
		style="background-image: url('https://images.pexels.com/photos/2227832/pexels-photo-2227832.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1');">
		<!-- 	../resources/assets/img/breadcrumbs-bg.jpg -->
		<div
			class="container position-relative d-flex flex-column align-items-center"
			data-aos="fade">
			<h2>시공의뢰 목록</h2>
		</div>
	</div>
	<!-- End Breadcrumbs -->

	<!-- ======= Projet Details Section (시공의뢰 입력 폼)======= -->
	<section id="project-details" class="project-details blog">
		<div class="container" data-aos="fade-up" data-aos-delay="100">
			<div class="row justify-content-between gy-4 mt-4">
				<div class="col-lg-8">
					<div class="portfolio-description">
						<!-- 포트폴리오 설명 등의 내용을 추가하실 수 있습니다. -->
					<div class="col-lg-9">
						<div class="panel panel-default">
							<div class="panel-heading">Sireq myList Page</div>
							<div class="panel-body">

								<div class="row">
									<div class="col-lg-12">
										<div class="panel panel-default">
											<!-- /.panel-heading -->
											<div class="panel-body">

												<!-- 의뢰내역이 있는 경우 -->
												<c:if test="${!empty mySireqList }">
													<table class="table table-hover">
														<thead>
															<tr>
																<th>시공의뢰번호</th>
																<th>견적서 번호</th>
																<th>의뢰인</th>
																<th>시공의뢰등록일</th>
																<th>의뢰진행현황</th>
																<th>결제진행현황</th>
																<th>수정일</th>
																
															</tr>
														</thead>
														<c:forEach items="${mySireqList}" var="sireq">
															<tr>
																<td><a href="/sirequest/sireqView?sireqNo=${sireq.sireqNo}"> <c:out
																			value="${sireq.sireqNo}" />
																</a></td>
																<td><c:out value="${sireq.quotationvo.quoNo}" /></td>
																<td><c:out value="${sireq.mvo.mname}" /></td>
																<td><fmt:formatDate value="${sireq.sireqDate}"
																		pattern="yyyy-MM-dd" /></td>
																<td>${sireq.sireqStatus}</td>
																<td>${sireq.payStatus}</td>
																<td><fmt:formatDate
																		value="${sireq.sireqUpdateDate}" pattern="yyyy-MM-dd" /></td>
																<td><button type="button" class="btn btn-primary" id="cancelButton">계약취소</button></td>
															</tr>
														</c:forEach>
													</table>
												</c:if>
											</div>
										</div>
									</div>
								</div>
								<!-- 수정된 부분 끝 -->
							</div>
						</div>
					</div><!-- col-lg-9 -->
					<!-- 사이드바 -->
					<%@ include file="../includes/sideMenuMem.jsp"%>	
				</div>
			</div>
		<!-- col-lg-8 -->	
		</div>
	</div>
</section>
<!-- /.row -->

	<script type="text/javascript">
		//페이지 번호 클릭 처리 -----------------------	

		//END 페이지 번호 클릭 처리

		$(function() {
			//검색 버튼 이벤트 처리 ---------------------------

			//END 검색 버튼 이벤트 처리 -----------------------

			//페이징 이벤트 처리 ------------------------------

			//END 페이징 이벤트 처리 --------------------------
			
			//'계약취소' 버튼 누르면 의뢰진행현황 계약취소 이벤트 처리 ------------------------------
			document.getElementById('cancelButton').addEventListener('click', function () {
			  if (confirm('계약을 취소하시겠습니까?')) {
			    // sireqNo를 설정 (실제 값으로 대체하세요)
			    var sireqNo = '실제_값_대체';
			
			    // Ajax를 사용하여 서버로 상태 업데이트 요청을 보냅니다.
			    var xhr = new XMLHttpRequest();
			    xhr.open('POST', '/updateSireqStatus', true);
			    xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
			
			    // 데이터를 JSON 형식으로 전송
			    var data = JSON.stringify({ sireqNo: sireqNo, newStatus: '계약취소' });
			    
			    xhr.onload = function () {
			      if (xhr.status === 200) {
			        alert('계약이 취소되었습니다.');
			        // 페이지를 새로 고침하거나 사용자 인터페이스를 업데이트하여 변경된 상태를 반영할 수 있습니다.
			      } else {
			        alert('계약 취소 중 오류가 발생했습니다.');
			      }
			    };
			
			    xhr.send(data);
			  }
			});
			//END '계약취소' 버튼 누르면 의뢰진행현황 계약취소 이벤트 처리 -------------------
			//클라이언트 및 서버 측 코드를 작성하여 버튼 클릭 시 sireqStatus 값을 업데이트하고, 데이터베이스에 적절한 SQL 쿼리를 실행하여 sireq 테이블을 업데이트하면 됩니다.
			// -------------------
			const express = require('express');
			const app = express();
			const bodyParser = require('body-parser');
			const mysql = require('mysql'); // MySQL 데이터베이스에 연결하기 위한 모듈
			
			// MySQL 연결 설정
			const db = mysql.createConnection({
			  host: 'localhost',
			  user: 'homey',
			  password: '1111',
			  database: 'HOMEY'
			});
			
			db.connect((err) => {
			  if (err) {
			    console.error('데이터베이스 연결 오류: ' + err.stack);
			    return;
			  }
			  console.log('데이터베이스에 연결되었습니다.');
			});
			
			app.use(bodyParser.json());
			
			app.post('/updateSireqStatus', (req, res) => {
			  const { sireqNo, newStatus } = req.body;
			
			  // sireq 테이블 업데이트 SQL 쿼리 실행
			  const sql = 'UPDATE SIREQ SET sireqStatus = ? WHERE sireqNo = ?';
			  db.query(sql, [newStatus, sireqNo], (err, result) => {
			    if (err) {
			      console.error('상태 업데이트 중 오류: ' + err);
			      res.status(500).json({ error: '상태 업데이트 오류' });
			    } else {
			      console.log('상태가 업데이트되었습니다.');
			      res.json({ message: 'sireqStatus가 업데이트되었습니다.' });
			    }
			  });
			});
			
			app.listen(3000, () => {
			  console.log('서버가 3000 포트에서 실행 중입니다.');
			});
			//
		});//END $
	</script>

</main>
<!-- End #main -->
<%@ include file="../includes/footer.jsp"%>