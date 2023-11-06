<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../includes/header.jsp" %>	


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AS 목록</title>

<!-- 스타일 시트 링크, 스크립트 등의 추가 작업이 필요할 수 있습니다. -->

</head>
<body>


<main id="main">
    <!-- Breadcrumbs -->
    <div class="breadcrumbs d-flex align-items-center"
         style="background-image: url('../resources/assets/img/breadcrumbs-bg.jpg');">
        <div class="container position-relative d-flex flex-column align-items-center" data-aos="fade">
            <h2>AS 목록</h2>
        </div>
    </div>
    <!-- End Breadcrumbs -->

    <!-- AS 목록 표시 구간 -->
    <section id="asboard-mylist" class="services section-bg">
        <div class="container" data-aos="fade-up">
            <div class="row gy-4">
                <!-- AS 목록 개수 표시 구간 -->
                <h3>AS 문의목록 ${totalCount}</h3>
                <hr>
                <!-- END AS 목록 개수 표시 구간 -->
                
 <!-- AS 목록 표시 구간 -->
<section id="asboard-mylist" class="services section-bg">
    <div class="container" data-aos="fade-up">
        <table class="table table-bordered">
            <thead>
                <tr>
                <th>AS 번호</th>
                    <th>제목</th>
                    <th>AS 작성자</th>
             
                    <th>AS 날짜</th>
                    <th>처리 상황</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${mylist}" var="bvo">
                    <tr>
                     <td>${bvo.bno}</td>
                        <td><a href="/asboard/asview?bno=${bvo.bno}">${bvo.title}</a></td>
                        <td>${bvo.mid}</td>
                       
                        <td><fmt:formatDate value="${bvo.regDate}" pattern="yyyy-MM-dd"/></td>
                        <td>${bvo.status}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</section>

<div class = "d-flex justify-content-end mt-3">
    <!-- AS 문의하기 버튼 -->
    <a href="/asboard/asregister"class = "btn btn-primary">AS 문의하기</a>
    <!-- END AS 문의하기 버튼 -->
</div> 
<!-- END 검색 :: AS 번호 -->

                <!-- 페이징 -->
<div class="text-center">
<ul class="pagination justify-content-center">
<c:if test="${pageDTO.prev}">
<li class="page-item">
<a href="/asboard/asmylist?pageNum=${pageDTO.start - 1}" class="page-link">« Previous</a>
</li>
</c:if>
<c:forEach begin="${pageDTO.start}" end="${pageDTO.end}" var="i">
<li class="page-item ${pageDTO.cri.pageNum == i ? 'active' : ''}">
<a href="/asboard/asmylist?pageNum=${i}" class="page-link">${i}</a>
</li>
</c:forEach>
<c:if test="${pageDTO.next}">
<li class="page-item">
<a href="/asboard/asmylist?pageNum=${pageDTO.end + 1}" class="page-link">Next »</a>
</li>
</c:if>
</ul>
</div>
<!-- 페이징 END -->


                <!-- 현재 페이지 번호 및 출력 게시물 수, 검색 타입, 키워드 전송 폼 -->
                <form action="/asboard/asmylist" id="actionFrm">
                    <input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
                    <input type="hidden" name="amount" value="${pageDTO.cri.amount}">
                    <input type="hidden" name="type" value="${pageDTO.cri.type}">
                    <input type="hidden" name="keyword" value="${pageDTO.cri.keyword}">
                </form>
            </div>
        </div>
    </section>
    <!-- End AS 목록 표시 구간 -->
    
  
</main>

<!-- 스크립트 및 푸터 등의 내용은 필요에 따라 추가하세요. -->

</body>
</html>

<%@ include file="../includes/footer.jsp" %>
