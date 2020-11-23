<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
  <!-- img파일을 불러오기위해 spring taglib사용 -->
  <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
  <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
  <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>main</title>
    
    <!-- fontawesome-->
    <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
      />
      
    <!-- 제이쿼리 cdn -->
    <script
    src="https://code.jquery.com/jquery-3.5.1.min.js"
    integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
    crossorigin="anonymous"></script>
    
    <script>
		var csrfHeaderName ="${_csrf.headerName}"; 
		var csrfTokenValue="${_csrf.token}";
	</script>

</head>

<%@ include file="../includes/board_main_top.jsp" %>

<style>

	#getPage{
                width: 100%;
                border: 1px solid #e7e7e7;
                border-radius: 15px;
                padding: 30px;
                float: left;
                padding-bottom: 50px;
            }
            #getCategory{
                font-size: 20px;
                color: #ED4264;
                margin-bottom: 10px;
            }
            #getTitle{
                font-size: 32px;
                font-weight: 600;
                margin-bottom: 10px;
            }
            #getProfile{
                width: 100%;
            }
            #getProfile i{
                float: left;
                margin-right: 5px;
                font-size: 32px;
            }
            #getProfile i img{
                height: 35px;
                width: 35px;
                border-radius: 10px
            }
            #getProfile div{
                font-size: 14px;
                color: rgb(51, 51, 51);
            }
            .getBorder{
                width: 100%;
                height: 1px;
                background-color: #e7e7e7;
                margin: 26px 0px;
            }
            #getContent{
                width: 100%;
                padding: 20px 0px;
            }
            #getContent img{
            	max-width: 80%;
            }
            #reply_zone{
                width: 100%;
                font-size: 22px;
                font-weight: 600;
                padding-bottom: 20px;
                border-bottom: 1px solid rgb(212, 212, 212);
                float: left;
            }
            #do_reply_zone{
                width: 100%;
                padding: 10px;
            }
            #replying1 i, #replying1 span{
                width: 100%;
                font-size: 17px;
                color: rgb(63, 63, 63);
            }
            #replying2 textarea{
                width: 96%;
                height: 70px;
                padding: 10px;
                border: 1px solid rgb(119, 119, 119);
                border-radius: 9px;
            }
            #replying3 input{
                float: right;
                margin-right: 12px;
                padding: 6px 20px;
                border: 1px solid rgb(121, 121, 121);
                border-radius: 6px;
                background-color: white;
                color: rgb(95, 95, 95);
            }
            #replying3 input:hover{
                border: 1px solid black !important;
                color:  black;
            }



            .gerReplyList{
                width: 100%;
                min-height: 44px;
                padding: 16px 0;
                padding-left: 3px;
                border-bottom: 1px solid rgb(212, 212, 212);
                float: left;
            }
            .getReplyProfile{
                width: 24%;
                float: left;
            }
            .getReplyProfile i{
                font-size: 32px;
                float: left;
                margin-right: 10px;
            }
            .getReplyProfile i img{
                height: 34px;
                width: 34px;
                border-radius: 10px
            }
            .getReplyUserid{
                font-size: 18px;
                color: rgb(46, 46, 46);
            }
            .getReplyProfileDate{
                font-size: 13px;
                color: rgb(56, 56, 56);
            }
            .getReplyContent{
                width: 70%;
                float: left;
            }
            
            .idFont{
                font-weight: 600;
            }
            .contentFont{
                font-size: 14px;
                font-weight: 600;
            }
            .replyFont{
                font-size: 16px;
                font-weight: 600;
                margin : 0px;
            }
            .reply_delBtn{
                margin-top: 10px;
                border-radius: 5px;
                border: none;
                color: rgb(61, 61, 61);
                border: 1px solid rgb(21, 21, 21);
                background-color: white;
                cursor: pointer;
                padding: 2px 7px;
            }
            .reply_delBtn:hover{
                background-color: rgb(120, 120, 120);
                color: white;
                border: none;
            }
            
            
            .gerReReplyList{
                width: 90%;
                min-height: 44px;
                padding: 16px 0;
                padding-left: 80px;
                border-bottom: 1px solid rgb(212, 212, 212);
                float: left;
            }
            .write_reple{
                width: 99%;
                margin-top: 5px !important;
            }
            .write_reple_txtarea{
                width: 100%;
                height: 86px;
                border: 1px solid rgb(223, 223, 223);
                border-radius: 3px;
            }
            
            .float_right{
            	float: right !important;
            	margin-right: 5px;
            }
</style>
<script>
	$(document).ready(function(){
		
		
		
		
		
		
		
		<sec:authorize access="isAuthenticated()"> 
			$('#reply_submit').click(function(){
				var reply_comment = $('#reply_area').val();
				var id = "";
				id ='<sec:authentication property="principal.username" />';
				var array = id.split('&#64;');
				var array2 = array[1].split('&#46;');
				var reply_userid = array[0] + "@" + array2[0] + "." + array2[1];
				var pno = $('#getPno').val();
				var ms = {pno, reply_userid, reply_comment};
				$.ajax({
                	url: '/board/riply/new',
                	processData: false,
                	beforeSend: function(xhr){
                		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                	},
                	data: JSON.stringify(ms),
                	contentType : "application/json; charset=utf-8",
                	type: 'POST',
                	success: function(result){
                		location.reload();
                	},
                	fail: function(){
        				alert("댓글 등록 중 예상치못한 에러가 발생하였습니다.");
                	},
                	complete: function(result){
                	}
                });
			});	
		
			$('.reply_register_btn').click(function(){
				var reply_comment = $(this).parent().children('textarea').val();
				var loginUser = "";
				loginUser ='<sec:authentication property="principal.username" />';
				var arr = loginUser.split('&#64;');
				var arr2 = arr[1].split('&#46;');
				var reply_userid = arr[0] + "@" + arr2[0] + "." + arr2[1];
				
				var go = {reply_userid, reply_comment};
				
				$.ajax({
                	url: '/board/riplies/new',
                	processData: false,
                	beforeSend: function(xhr){
                		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                	},
                	data: JSON.stringify(go),
                	contentType : "application/json; charset=utf-8",
                	type: 'POST',
                	success: function(result){
                		location.reload();
                	},
                	fail: function(){
        				alert("댓글 등록 중 예상치못한 에러가 발생하였습니다.");
                	},
                	complete: function(result){
                	}
                });
			});
			
			
			$('.reply_delBtn').click(function(){
				var rno = $(this).next().val();
				alert(rno);
				var writer = $(this).next().next().val();
				alert(writer);
				
				var loginUser = "";
				loginUser ='<sec:authentication property="principal.username" />';
				var arr = loginUser.split('&#64;');
				var arr2 = arr[1].split('&#46;');
				var reply_userid = arr[0] + "@" + arr2[0] + "." + arr2[1];
				
				var go = {reply_userid, reply_comment};
				
				
			});
			
			
		</sec:authorize>
	});
</script>
		<main>
            
            <div id="getPage" class="">
                <div id="getCategory"># <c:out value="${categoryName }"/></div>
                <div id="getTitle"><c:out value="${getPageData.title }"/></div>
                <input type="hidden" id="getPno" value="<c:out value="${getPageData.pno}"/>"/>
                <div id="getProfile">
                    <i class="fas fa-user-circle"></i>
                    <!-- 프로필 이미지가 있는 경우
                    <i class="personalImg">
                        <img src="./img/person1.jpg" alt="personalImg">
                    </i>
                    -->
                    <div class="idFont"><c:out value="${writer_nickname }"/></div>
                    <div><fmt:formatDate value="${getPageData.write_date }" pattern="YYYY.MM.dd  HH:mm"/></div>
                    <!-- 
                    <div>2020.08.20 18:21</div>  
                    <c:out value="${getPageData.write_date }"/>
                    -->
                </div>
                <div class="getBorder"></div>

                <div id="getContent">
                	<c:forEach items="${imgListData}" var="imgList">
                        <img src="/img/<c:out value='${imgList.uploadpath}'/>/<c:out value='${imgList.uuid}'/>_<c:out value='${imgList.filename}'/>">
                    </c:forEach>
                	<pre class="contentFont"><c:out value="${getPageData.content }"/></pre>
                </div>

                <div class="getBorder"></div>
                <div id="reply_zone">
                	<sec:authorize access="isAnonymous()">
						<div id="do_reply_zone">
	                        <div id="replying2">
	                            <textarea name="" id="" cols="" rows="" disabled="true">댓글을 작성하기 위해서는 로그인이 필요합니다.</textarea>
	                        </div>
	                        <div id="replying3">
	                            <input type="button" value="목록으로">
	                        </div>
	                    </div>
		            </sec:authorize>
					<sec:authorize access="isAuthenticated()">
						<div id="do_reply_zone">
	                        <div id="replying1">
	                            <span class=""><c:out value="${nickname}" /> 님</span>
	                        </div>
	                        <div id="replying2">
	                            <textarea name="" id="reply_area" cols="" rows=""></textarea>
	                        </div>
	                        <div id="replying3">
	                            <input type="button" id="reply_submit" value="댓글달기">
	                            <input type="button" value="목록으로">
	                            <input type="button" value="삭제하기">
	                        </div>
	                    </div>
					</sec:authorize>
					
					
					
                    
                </div>
				<div class="replyResult">
				
				</div>












				<!-- 
                <div id="getReply">
                    <div class="gerReplyList">
                        <div class="getReplyProfile">
                            <i class="fas fa-user-circle"></i>
                            <div class="getReplyUserid idFont">회원ID</div>
                            <div class="getReplyProfileDate">2020.08.20 18:21</div>
                        </div>
                        <div class="getReplyContent">
                            <pre class="replyFont">
sdawdwad
정말로!!</pre>
                            <input type="button" class="reply_delBtn" value="삭제하기">
                            <input type="button" class="reply_delBtn rereplyBtn" value="댓글달기">
                        </div>
                        <div id="getReply" class="write_reple hidden">
                            <div class="gerReplyList">
                                <div class="getReplyProfile">
                                    <i class="far fa-comment-dots"></i>
        
                                    <div class="getReplyUserid idFont">댓글작성</div>
                                </div>
                                <div class="getReplyContent">
                                    <form action="">
                                        <textarea name="" class="write_reple_txtarea" cols="30" rows="10"></textarea>
                                        <br>
                                        <input type="button" class="reply_delBtn reply_register_btn" value="등록하기">
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                 </div>
                     -->
                    
                    
                    <!-- 
                    <div id="getReply">
	                    <div class="gerReReplyList">
	                        <div class="getReplyProfile">
	                            <i class="fas fa-user-circle"></i>
	                            <div class="getReplyUserid idFont">회원ID</div>
	                            <div class="getReplyProfileDate">2020.08.20 18:21</div>
	                        </div>
	                        <div class="getReplyContent">
	                            <pre class="replyFont">여기는
이것은 대댓글</pre>
								<input type="button" class="reply_delBtn" value="삭제하기">
	                        </div>
	                    </div>
                	</div>
                	 -->
                	
                	
                	
                	
                	
                	
                	
                	
                	
                </div>
            
        </main>
</body>
<script>
function displayTime(timeValue) {

	var today = new Date();

	var gap = today.getTime() - timeValue;

	var dateObj = new Date(timeValue);
	var str = "";

	if (gap < (1000 * 60 * 60 * 24)) {

		var hh = dateObj.getHours();
		var mi = dateObj.getMinutes();
		var ss = dateObj.getSeconds();

		return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi,
				':', (ss > 9 ? '' : '0') + ss ].join('');

	} else {
		var yy = dateObj.getFullYear();
		var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
		var dd = dateObj.getDate();

		return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
				(dd > 9 ? '' : '0') + dd ].join('');
	}
};









                    $(document).ready(function(){
                    	var pno='<c:out value="${getPageData.pno}"/>';
                		
                		$.getJSON("/board/getReply/"+pno,function(arr){
                			var str="";
                			$(arr).each(function(i,attach){	
                				if(attach.depth==1){
                					str += "<div id='getReply'>";
                    				str += "                    <div class='gerReplyList'>";
                    				str += "                        <div class='getReplyProfile'>";
                    				str += "                            <i class='fas fa-user-circle'></i>";
                    				str += "                            <div class='getReplyUserid idFont'>"+attach.nickname+"</div>";
                    				str += "                            <div class='getReplyProfileDate'>"+displayTime(attach.reply_date)+"</div>";
                    				str += "                        </div>";
                    				str += "                        <div class='getReplyContent'>";
                    				str += "                            <pre class='replyFont'>";
                    				str += attach.reply_comment;
                    				str += "                            </pre>";
                    				str += "                            <input type='button' class='reply_delete_Btn reply_delBtn float_right' value='삭제'>";
                        			str += "							<input type='hidden' value='"+ attach.rno +"'/>";
                        			str += "							<input type='hidden' value='"+ attach.reply_userid +"'/>";
                    				str += "                            <input type='button' class='reply_delBtn rereplyBtn float_right' value='댓글'>";
                    				str += "                        </div>";
                    				str += "                        <div id='getReply' class='write_reple hidden'>";
                    				str += "                            <div class='gerReplyList'>";
                    				str += "                                <div class='getReplyProfile'>";
                    				str += "                                    <i class='far fa-comment-dots'></i>";
                    				str += "                                    <div class='getReplyUserid idFont'>댓글</div>";
                    				str += "                                </div>";
                    				str += "                                <div class='getReplyContent'>";
                    				str += "                                    <form action=''>";
                    				str += "                                        <textarea name='' class='write_reple_txtarea' cols='30' rows='10'></textarea>";
                    				str += "										<input type='hidden' value='"+attach.pno+"'/>";
                    				str += "										<input type='hidden' value='"+attach.rno+"'/>";
                    				str += "                                        <br>";
                    				str += "                                        <input type='button' class='reply_delBtn reply_register_btn float_right' value='등록'>";
                    				str += "                                    </form>";
                    				str += "                                </div>";
                    				str += "                            </div>";
                    				str += "                        </div>";
                    				str += "                    </div>";
                    				str += "                 </div>";
                				}else{
                					str += "<div id='getReply'>";
                					str += "	<div class='gerReReplyList'>";
                					str += "		<div class='getReplyProfile'>";
                					str += "			<i class='fas fa-user-circle'></i>";
                					str += "			<div class='getReplyUserid idFont'>"+attach.nickname+"</div>";
                					str += "			<div class='getReplyProfileDate'>"+displayTime(attach.reply_date)+"</div>";
                					str += "		</div>";
                					str += "		<div class='getReplyContent'>";
                					str += "		<pre class='replyFont'>";
                    				str += attach.reply_comment;
                					str += "</pre>";
                        			str += "<input type='button' class='reply_delete_Btn reply_delBtn float_right' value='삭제'>";
                        			str += "<input type='hidden' value='"+ attach.rno +"'/>";
                        			str += "<input type='hidden' value='"+ attach.reply_userid +"'/></div></div></div>";
                				}
                				
                				
                				
                				
                				
                				
                				
                				
                				
                			});
                			$(".replyResult").html(str);
                			
                		});
                    	
                    	
                    	
                    	
                    	
                    	
                    	
                        /* $(".rereplyBtn").click(function(){
                            $(".write_reple").addClass('hidden');
                            $(this).parent().next().removeClass('hidden');
                        }); */
                        
                        // 댓글달기 버튼 클릭 시
                        $('.replyResult').delegate(".rereplyBtn", "click", function(){
                        	$(".write_reple").addClass('hidden');
                            $(this).parent().next().removeClass('hidden');
                        });
                        
                        // 대댓글 등록하기
                        <sec:authorize access="isAuthenticated()">
	                        $('.replyResult').delegate(".reply_register_btn", "click", function(){
	                        	var reply_comment = $(this).parent().children().first().val();
	                        	var pno = $(this).parent().children().first().next().val();
	                        	var reply_parentno = $(this).parent().children().first().next().next().val();
								var loginUser = "";
	            				loginUser ='<sec:authentication property="principal.username" />';
	            				var arr = loginUser.split('&#64;');
	            				var arr2 = arr[1].split('&#46;');
	            				var reply_userid = arr[0] + "@" + arr2[0] + "." + arr2[1];
	            				var depth = 2;
	            				
	            				var go = {pno, reply_parentno, reply_userid, reply_comment, depth};
	            				
	            				$.ajax({
	                            	url: '/board/riplies/new',
	                            	processData: false,
	                            	beforeSend: function(xhr){
	                            		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	                            	},
	                            	data: JSON.stringify(go),
	                            	contentType : "application/json; charset=utf-8",
	                            	type: 'POST',
	                            	success: function(result){
	                            		location.reload();
	                            	},
	                            	fail: function(){
	                    				alert("댓글 등록 중 예상치못한 에러가 발생하였습니다.");
	                            	},
	                            	complete: function(result){
	                            	}
	                            });
	                        });
	                        
	                        
	                        
                        </sec:authorize>
                        $('.replyResult').delegate(".reply_delete_Btn", "click", function(){
                        	
                        	<sec:authorize access="isAnonymous()">
                        		alert("권한이 없습니다.");
    			            </sec:authorize>
    			            
    			            <sec:authorize access="isAuthenticated()">
	    			            var rno = $(this).next().val();
	            				var writer = $(this).next().next().val();
	            				var loginUser = "";
	            				loginUser ='<sec:authentication property="principal.username" />';
	            				var arr = loginUser.split('&#64;');
	            				var arr2 = arr[1].split('&#46;');
	            				var reply_userid = arr[0] + "@" + arr2[0] + "." + arr2[1];
	            				
	            				if(reply_userid==writer){
	            					var go = {reply_userid, rno};
	            					$.ajax({
		                            	url: '/board/riplies/delete',
		                            	processData: false,
		                            	beforeSend: function(xhr){
		                            		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		                            	},
		                            	data: JSON.stringify(go),
		                            	contentType : "application/json; charset=utf-8",
		                            	type: 'POST',
		                            	success: function(result){
		                            		alert("댓글이 삭제되었습니다.");
		                            		location.reload();
		                            	},
		                            	fail: function(){
		                    				alert("댓글 삭제 중 예상치못한 에러가 발생하였습니다.");
		                            	},
		                            	complete: function(result){
		                            	}
		                            });
	            					
	            				}else{
	            					alert("작성자만이 댓글을 삭제할 수 있습니다.")
	            				}
	            				
	            				
    			            </sec:authorize>
    			            
            				
            				
            				
            				
            				
            				
            				
            			});
                        
                        
                        
                    });
                </script>
</html>