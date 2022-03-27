/**
 * 
 */
 
 
 

$(function() {
	
	
	
	//날짜별로 감싸기 containBox
 	arr2 = [];
	uniqueArr = [];
	$('#update0 ul .liList3').each(function() {
		outsed = $(this).text();
		sliceEnd = outsed.lastIndexOf("-");
		outsedSlice = outsed.slice(0,sliceEnd);
		
		$(this).parent().addClass(outsedSlice);
		$(this).text(outsedSlice);
		
		arr2.push(outsedSlice);
	
	}) 

	$.each(arr2, function(i, el){
		if($.inArray(el, uniqueArr) === -1) uniqueArr.push(el);
	    
	    
	});


	for(let i=0; i<=uniqueArr.length; i++){	
	
		//unqar.push( uniqueArr[i].silce(0,uniqueArr[i].lastIndexOf("-")) );
		$('.'+uniqueArr[i]).wrapAll('<div class="containBox"></div>');	
		
		
		
	}
	
	$('.containBox').prepend('<div class="DateTit"></div>');
	
	for(let i=0; i<=uniqueArr.length; i++){
			$('.containBox .DateTit').eq(i).text(uniqueArr[i]);
	} 

	
	//만약 #text에 데이터가 없다면 경고
	$('#sendClick').on('click', function() {
		str = $('#text').val().trim().length;
		if( str == 0){
			alert(" 공백이거나 \n 입력값이 존재하지 않습니다. \n 다시 입력해주세요.");	
		}else{
			//추가성공
			alert("TodoList에 등록되었습니다!");	
			$('#smMain').submit();
		}

	});
	
	
	
 	//글삭제 시작
	$('#deleteCheck').on('click', function() {
		
		$('#update0 #todoList').each(function() {
			$(this).remove();
		})
		
		$('#update0 ul #deleteList').css('display','inline-block');
		$(this).after('<input type="submit" value="삭제하기" id="deletchoice">');
		//delete이벤트 발생시 form의 속성을 delete로 수정한다.
		$('#update0').attr('action','delete.jsp').attr('id','delete0').attr('name','delete0');
		$('#submitCheck').remove();
		$(this).remove();
		
	})
	

	//삭제할 글 선택전송
	$(document).delegate('#deletchoice','click', function() {


		
		//만약 선택한 글이 없을경우 경고창
		deleteErr = 0;
		$("input:checkbox[id='deleteList']:checked").each(function() {		
			deleteErr++;	
		})

		if(deleteErr == 0){
			alert("아무것도 선택하지 않았습니다.");
		}else{
			alert("삭제성공!");
			 var del = document.getElementById("delete0");
				del.submit(); 
			
		}
		
		
	})
	
	
	
	
	//글수정 시작
	str2 =""
		$('#submitCheck').on('click', function() {
			
			$('#update0 ul #todoList').css('display','inline-block');
			$(this).after('<input type="button" value="선택완료" id="choice">');
			$('#deleteCheck').remove();
			$(this).remove();
			$('#update0 #deleteList').each(function() {
				$(this).remove();
			})
		
		})

		
		chk_arr = [];
	//수정할 글 선택하기
		$(document).delegate('#choice', 'click', function() {
			
			//만약 선택한 글이 없을경우 경고창
			updateErr = 0;
			$("input:checkbox[id='todoList']:checked").each(function() {		
				updateErr++;	
			})

			if(updateErr == 0){
				alert("아무것도 선택하지 않았습니다.");
			}else{
				
				//$(".클래스/#아이디").find('input:checked')
				$('input:checkbox[name=todoList]:checked').each(function() {
					//todolist내용을 저장
					chk = $(this).next().text();
					chk_arr.push(chk);
					str2 += chk;
					
					
					$(this).parent().children('.liList1').css('display','none');
					$(this).parent().prepend('<input type="text" value="'+chk+'" id="updateSm" name="updateSm">');
					$(this).parent().children('.liList2').append('<input type="checkbox" name="updateCk" id="updateCk" value="완료" > <input type="hidden" name="updateCk" id="updateCk_hidden" value="미완료" > <span>완료로 변경하기</span>');
					
					$(this).attr('type','hidden');

					
					//선택한 게시물의 상태가 완료라면 완료변경하기 버튼 hide 및 hidden 버튼의 value=완료로 수정
					if($(this).next().next().children('b').text() == "완료"){
						$(this).next().next().children('#updateCk').remove();
						$(this).next().next().children('#updateCk_hidden').attr('value','완료');
						$(this).next().next().children('span').remove();
					
					}
					
				})
				
				//선택하지않은 #update0 ul #todoList삭제
				$('#update0 ul #todoList').css('display','none');
				$(this).after('<input type="submit" value="수정취소" id="cancel">');			
				$(this).after('<input type="submit" value="수정완료" id="completion">');
				$(this).css('display','none');
				
				
			}
		
		
			
			

			
		
		})
		
		

		
	
		//수정취소
		$(document).delegate('#cancel', 'click', function() {
			location.replace(location.href);
			
		})
		
		
		
		//수정완료클릭시
		$(document).delegate('#completion','click', function() { 

			
			
			//checkbox 완료 미완료 처리
			//만약 체크를 했다면 바로 다음에 오는 #updateCk_hidden는 disabled한다.
			$("input:checkbox[id='updateCk']:checked").each(function() {
				$("input:checkbox[id='updateCk']:checked").next().attr('disabled','true');
			})
				
			
			//일정 form에 값이 없다면 경고창
			//공백제외 값이 있다면 submit
			updateSmlen =[];
			$('#update0 .containBox ul #updateSm').each(function() {
				updateSmlen.push($(this).val().trim().length)
				
			})

			
 			if( updateSmlen.indexOf(0) == -1){
				alert("수정완료!");

				
/* 				if(document.getElementById("updateCk").checked) {
				    document.getElementById("updateCk_hidden").remove();
				} */
					
				
				 var inf = document.getElementById("update0");
						inf.submit(); 
				
			}else{
				alert("일정은 공백이거나 비워둘수없습니다");
			} 
	
			


					
		
		})	
		

		
		
		

	
})
				