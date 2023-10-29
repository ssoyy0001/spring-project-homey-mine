/**
 *    /resources/js/quotation.js
 */
 
var quotationService = ( function(){

   // 견적서 등록 --------------------------
   function register(quotation, callback) {                        		// 여기서 쓰는 quotation는 quotationVO를 받아온다!
      $.ajax({
         type : 'post',                              			// get or post
         url : '/quo/register',                        			// 전송할 곳 action
         data : JSON.stringify(quotation), // 전송할 데이터
         contentType : 'application/json; charset=UTF-8',   	// 컨텐트 타입 및 인코딩
         success : function(result, status, xhr) {         		// 성공 시 처리
            if(callback){                           			// success와 상태코드 받기
               callback(result);                     			// result는 consultManage.jsp로 넘어감
            }                                    				// 콜백 함수는 주도권을 호출한 쪽으로 넘겨줌
         },   
         error : function(xhr, status, er) {               		// 실패 시 처리
            if(error){
               error(er);
            }
         }      
      });   // ajax END   
   } // 견적서 등록 END   --------------------
   
   
	// 견적서 삭제 --------------------------
 function remove(quoNo, callback, error) {                  
      $.ajax({
         type : 'delete',                              			// mapping
         url : '/quo/' + quoNo,                    			// 전송할 곳
         success : function(result, status, xhr) {         		// 성공 시 처리
            if(callback){                           			// success와 상태코드 받기
               callback(result);                     			// result는 consultManage.jsp로 넘어감
            }                                    				// 콜백 함수는 주도권을 호출한 쪽으로 넘겨줌
         },   
         error : function(xhr, status, er) {               		// 실패 시 처리
            if(error){
               error(er);
            }
         }      
      });   // ajax END   	
	}// 견적서 삭제 END   --------------------
   
	// 견적서 수정 --------------------------
	 function modify(quotation, callback, error) {                   
	      $.ajax({
	         type : 'put',                              			
	         url : '/quo/' + quotation.quoNo,                    		
	         data : JSON.stringify(quotation),                 		 	// 전송할 데이터
	         contentType : 'application/json; charset=UTF-8',   	// 컨텐트 타입 및 인코딩
	         success : function(result, status, xhr) {         		// 성공 시 처리
	            if(callback){                           			// success와 상태코드 받기
	               callback(result);                     			// result는 consultManage.jsp로 넘어감
	            }                                    				// 콜백 함수는 주도권을 호출한 쪽으로 넘겨줌
	         },   
	         error : function(xhr, status, er) {               		// 실패 시 처리
	            if(error){
	               error(er);
	            }
	         }      
	      });   // ajax END   
   		} // 견적서 수정 END   --------------------
   		   
   // 견적서 1개 조회 --------------------------
   // http://localhost:8081/quo/92.json
   function view(quoNo, callback, error) {                  
      $.get('/quo/'+ quoNo + '.json',							// 전송할 곳
      			function(result) {								// 성공 시 처리
      		 if(callback){                           			// success와 상태코드 받기
               callback(result);                     			// result는 consultManage.jsp로 넘어감
           		 }                                    			// 콜백 함수는 주도권을 호출한 쪽으로 넘겨줌
      		}
		).fail(function(xhr, status, er){						// 실패 시 처리
			  if(error){
              	 error(er);
            }
		});      	
   } // 견적서 1개 조회 END   --------------------
   
   return { register:register, remove:remove, modify:modify, view:view};               // 콘솔에 {add: ƒ} 찍힘, 그 외에 추가하는 함수들 넣기(필수)
   
})();   // () -> 즉시 실행 함수   
 
 
