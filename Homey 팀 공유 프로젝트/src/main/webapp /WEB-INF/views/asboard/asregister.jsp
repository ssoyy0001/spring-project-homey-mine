<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>   

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js"></script>

<!--======= main ======= -->
	<main id="main">

		<!-- ======= Breadcrumbs ======= -->
		<div class="breadcrumbs d-flex align-items-center"
			style="background-image: url('../resources/assets/img/breadcrumbs-bg.jpg');">
			<div
				class="container position-relative d-flex flex-column align-items-center"
				data-aos="fade">
				<h2>AS 문의 등록</h2>
			</div>
		</div>
		<!-- End Breadcrumbs -->
<div class="row">
   <div class="col-lg-12" style="text-align: center;">
    <h1 class="page-header">AS 문의 등록</h1>
</div>
 <!-- /.col-lg-12 -->
</div>      <!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
             <!-- /.panel-heading -->
            <div class="panel-body">
               <!-- 게시물 등록 폼 -->
<form action="/asboard/asregister" method="post" role="form" enctype="multipart/form-data">
            <div class="form-group" style="display: flex; justify-content: center;">
   <label>제목</label>
   <input type="text" name="title" class="form-control" style="width: 600px;">
</div>
               
            <div class="form-group" style="display: flex; justify-content: center;">
   <label>내용</label>
   <textarea name="content" class="form-control" rows="3" style="width: 600px;height: 300px; " ></textarea>
</div>
            
               
               <div class="form-group" style="display: flex; justify-content: center;">
   <button type="reset" class="btn btn-default">새로 고침</button>
<button type="button" class="btn btn-warning" onclick="return confirmCancel()">취소</button>
   <button type="submit" class="btn btn-primary">등록</button>
</div>

               <input type="hidden" name="${_csrf.parameterName }" 
                                value="${_csrf.token }">   
            </form>
               <!-- END 게시물 등록 폼 -->
            </div>   <!-- /.panel-body -->
        </div>     <!-- /.panel -->
    </div>         <!-- /.col-lg-12 -->
</div>             <!-- /.row -->

<!-- 첨부 파일 ------------------------------->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
              <!-- /.panel-heading -->
            <div class="panel-body" style="display: flex; justify-content: center;">
                <div class="form-group uploadDiv">
                    <input type="file" name="uploadFile" multiple>
                    <!-- 미리보기 이미지 추가 -->
                </div>
            </div>
            
            <!-- 업로드 결과 출력 -->
            <div class="uploadResult" style="display: flex; justify-content: center;">
                <ul></ul>
            </div>
               <!-- END 업로드 결과 출력 -->
            </div>   <!-- /.panel-body -->
        </div>     <!-- /.panel -->
    </div>         <!-- /.col-lg-12 -->
</div>
<!-- END 첨부 파일 --------------------------->

<%@ include file="../includes/footer.jsp" %>   
<script>
	var frm = $('form[role="form"]');
	
	//submit 버튼 이벤트 처리 -----------------
	$('button[type="submit"]').on('click', function(e){
		e.preventDefault();
		 
	    var title = $('input[name="title"]').val();
	    var content = $('textarea[name="content"]').val();

	    // 제목이나 내용이 비어 있는지 확인
	    if (!title || !content) {
	        alert('제목과 내용을 입력해주세요.');
	        return;
	    }
		var hiddenTag = '';
		
		$('.uploadResult ul li').each(function(i, obj){
			hiddenTag += '<input type="hidden" name="attachList[' + i + '].uuid" ' + 
							   ' value="' + $(obj).data('uuid') + '">';
							   
			hiddenTag += '<input type="hidden" name="attachList[' + i + '].upFolder" ' + 
			   				   ' value="' + $(obj).data('folder') + '">';
			   
			hiddenTag += '<input type="hidden" name="attachList[' + i + '].fileName" ' + 
			  				   ' value="' + $(obj).data('filenm') + '">';
			   
			hiddenTag += '<input type="hidden" name="attachList[' + i + '].image" ' + 
			  				   ' value="' + $(obj).data('image') + '">';
		});		
		
		frm.append(hiddenTag);
		frm.submit();
		// 서버로부터 응답이 온 후 실행할 코드
	    frm.ajaxSubmit({
	        success: function() {
	            alert('문의가 작성되었습니다.'); // 알림 띄우기
	        }
	    });
	});//END submit 버튼 이벤트 처리 -------------
	
	function confirmCancel() {
	    var result = confirm('주의! 작성한 글이 삭제됩니다.');
	    if (result) {
	        history.back();
	    } else {
	        return false;
	    }
	}

	
	//업로드 제한 확인 ------------------------
 	var regEx = new RegExp("(.*?)\.(exe|sh|zip)$");  
	var maxSize = 5242880;

	function checkExtension(fileName, fileSize) { 
		 if (fileSize > maxSize) { 
			alert("파일 크기(5MB)가 초과하여 업로드 할 수 없습니다.");
			return false;
		} 
		
		if (regEx.test(fileName)) { 
			alert("해당 형식의 파일은 업로드 할 수 없습니다.");
			return false;
		} 
		
		return true;	 
	}//END 업로드 제한 확인 --------------------
	
	//첨부파일 선택 이벤트 처리 -----------------
	var csrfHeaderName = '${_csrf.headerName}';	//CSRF 토큰 관련 변수
	var csrfTokenValue = '${_csrf.token}';		//
	$('input[type="file"]').on('change', function() {
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
			type : 'post',				//get | post
			url : '/asupload/ajaxAction', //전송할 곳 - replyContoller로 넘어감
			data : formData, 			//전송할 데이터 
			dataType : 'json', 			//수신할 데이터 타입
			contentType : false, //컨텐트 타입 및 인코딩
			processData : false,
			beforeSend : function(xhr){	//xhr ; XML Http Request
				//전송 전 CSRF 헤더 설정
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success : function(result, status, xhr) {
		        console.log(result); // 이 부분을 추가했습니다.
						$('input[type="file"]').val(""); 
						showUploadedFile(result);  
			}, //성공시
			error : function(xhr, status, er) {
				console.log("upload error");
			} //에러시
		}); //END ajax;
	});//END 첨부파일 선택 이벤트 처리 -------------
	
	//업로드 결과 출력 ----------------------------------------------
	var resultUL = $('.uploadResult ul');  
	function showUploadedFile(result){  
		var liTag = '';
	
		$(result).each(function(i, obj){  
			
			//서버로 전송할 정보를 li 태그의 속성으로 저장
			liTag += '<li data-uuid="' + obj.uuid + '" ' + 
						' data-folder="' + obj.upFolder + '" ' + 
						' data-filenm="' + obj.fileName + '" ' + 
						' data-image="' + obj.image + '">';
						
			if(obj.image){	//이미지는 썸네일과 파일명 표시
				var thumbImg = encodeURIComponent(
						 			obj.upFolder + "/s_" + 
						 			obj.uuid + "_" + 
						 			obj.fileName);
			
				var originImg = obj.upFolder + "\\" + obj.uuid + "_" + obj.fileName; 	
			 	originImg = originImg.replace(new RegExp(/\\/g), "/"); 
			 	
				liTag += '<img src="/display?fileName='+ thumbImg +'"></a><br>' +
						 		obj.fileName + 
						 	 '<button type="button" class="btn btn-warning btn-circle" ' +
						 	 		' data-file="' + thumbImg + '" ' +
						      		' data-type="image"> ' +
						     '<i class="fa fa-times"></i></button></li>';						 
	         } else { 		//일반 파일은 attach.png 이미지와 파일명 표시
				var filePath = encodeURIComponent(
						 			obj.upFolder + "/" + 
						 			obj.uuid + "_" + 
						 			obj.fileName);
	        	liTag += '<img src="/resources/img/attach.png"></a><br>'+ 
	        	 					obj.fileName +
						 	 '<button type="button" class="btn btn-warning btn-circle btn-xs" ' +
					 	 		' data-file="' + filePath + '" ' +
					      		' data-type="file"> ' +
					      	 '<i class="fa fa-times"></i></button></li>';	
	         }
		});//END each()
		resultUL.append(liTag);  
	}//END 업로드 결과 출력 ------------------------------------------
	

	//X 버튼 클릭 이벤트 처리 -----------------------------------------
	$('.uploadResult').on('click', 'button', function() {
		var x = $(this).closest('li');
		
		$.ajax({
			type : 'post',				 
			url : '/asdeleteFile', 		 
			data : { fileName : $(this).data('file'), 
					 type     : $(this).data('type')  },			 
			dataType : 'text', 		
			beforeSend : function(xhr){	//xhr ; XML Http Request
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

