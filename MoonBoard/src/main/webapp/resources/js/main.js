    $(document).ready(function(){
        $('#searchBtn').click(function(){
            var inputContent = $('#serach_input').val();
            alert(inputContent);
        });
        $('#btn_recomendBoard').click(function(){
            alert('인기게시판 더 보여주기');
        });
        $('.picker_box').click(function(){
            var whereboard = $(this).children().first().val();
            location.href = "/board/home?no="+whereboard;
        });
        $('#btn_recentBoard').click(function(){
            alert('최근방문 게시판 더 보여주기');
        });
        $('.recent_board_box_comment1').click(function(){
            var whereboard2 = $(this).next().val();
            alert(whereboard2 + '게시판으로 이동');
        });
        $('#loginBtn').click(function(){
        	location.href = '/member/customLogin';
        });
        $('#go_join').click(function(){
        	location.href = '/member/join';
        });
        $('#go_findId').click(function(){
            alert('아이디 찾기');
        });
        $('#go_findPw').click(function(){
            alert('비밀번호 찾기');
        });
        $('#goEditProfile').click(function(){
            alert('내정보 이동');
        });
        $('#go_myPost').click(function(){
            alert('내 글');
        });
        $('#go_myReply').click(function(){
            alert('내 답글');
        });
        $('#go_myMail').click(function(){
            alert('시스템 준비중입니다.');
        });
        $('#makeBoardBtn').click(function(){
        	window.open("/board/makeBoard", "네이버새창", "width=640, height=640, toolbar=no, menubar=no, scrollbars=no, resizable=no" );
        });
        $('.notice_boxies').click(function(){
            var wherepage = $(this).next().val();
            alert(wherepage+'페이지로 이동');
        });



        var oldVal ="";
        $('#serach_input').on("change keyup paste", function() {
            var currentVal = $(this).val();
            if(currentVal == oldVal) {
                return;
            }
        
            oldVal = currentVal;
            $('#nav_searcher').removeClass('hidden');
            if(currentVal == ""){
                $('#nav_searcher').addClass('hidden');
            }
            
            
            var pno='<c:out value="${getPageData.pno}"/>';
    		
    		$.getJSON("/board/getSearchBoard/"+currentVal,function(arr){
    			var str="";
    			var j=1;
    			$("#nav_searcher_list").empty();
    			$(arr).each(function(i,attach){
    				if(j<=8){
        				str += "<div class='searcher_list'>";
        				str += attach.title;
        				str += "</div>";
        				str += "<input type='hidden' value='";
        				str += attach.no;
        				str += "'>";
        				j++;
    				}
    			});
    			$("#nav_searcher_list").html(str);
    		});
        });

        
        $('#nav_searcher_list').delegate(".searcher_list", "click", function(){
            var bno = $(this).next().val();
            location.href = "/board/home?no=" + bno;
        });
        
        $('.recent_boards_bot_btn').click(function(){
            var bno = $(this).next().val();
            location.href = "/board/home?no=" + bno;
        });
        
        
        
        
        
    });