<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
  <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
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
    
    <script src="js/jquery.cookie.js"></script>
    
</head>
<style>
    body{
        margin: 0;
        height: 1400px;
    }
    #nav{
        width: 100%;
        height: 55px;
        background: linear-gradient(45deg, #b062f8, #c8e2ff) !important;
    }
    #nav_content{
        width: 1000px;
        margin: auto;
    }
    #nav_logo{
        float: left;
        font-size: 36px;
        font-weight: 800;
        color: white;
    }
    #nav_search{
        float: left;
        margin-left: 25px;
    }
    
    #nav_searcher{
        width: 254px;
        border-left: 1px solid rgb(139, 139, 139);
        border-right: 1px solid rgb(139, 139, 139);
        border-bottom: 1px solid rgb(139, 139, 139);
        border-bottom-left-radius: 9px;
        border-bottom-right-radius:9px;
        background-color: white;
        position:absolute
    }
    #searcher_top{
        padding: 6px 7px;
        font-size: 14px;
        font-weight: 600;
        color: white;
        background-color:rgb(165, 165, 165)
    }
    .searcher_list{
        padding: 4px 7px;
        font-size: 14px;
        cursor: pointer;
        color: rgb(105, 105, 105);
    }
    .searcher_list:hover{
        color: rgb(0, 0, 0);
    }
    
    
    #nav_search input[type='text']{
        height: 33px;
        width: 250px;
        margin-top: 8px;
        border: 1px solid rgb(204, 204, 204);
    }
    #nav_search input[type='button']{
        height: 36px;
        padding-top: 2px;
        padding-bottom: 4px;
        padding-left: 15px;
        padding-right: 15px;
        margin-left: 0px !important;
        border: 1px solid rgb(231, 231, 231);
        background-color: #a64cfa;
        color: rgb(231, 231, 231);
        font-weight: 600;
    }
    #nav_login{
        float: right;
        font-size: 19px;
        margin-top: 12px;
        color: rgb(255, 255, 255);
        font-weight: 600;
    }
    #nav_login i{
        margin-right: 5px;
    }


    #main{
        width: 1000px;
        margin: auto;
    }
    #main_left{
        width: 70%;
        float: left;
    }
    #main_left_content{
        margin: auto;
    }
    #main_right{
        width: 30%;
        float: left;
    }
    #main_picker_title{
        width: 100%;
        float: left;
    }
    #main_picker_title p{
        margin-top: 30px;
        margin-left: 10px;
        font-size: 22px;
        font-weight: 600;
        float: left;
    }
    #main_picker_title input{
        margin-top: 30px;
        float: right;
        margin-right: 30px;
        margin-top: 35px;
        padding: 3px 15px;
        border: 1px solid rgb(215, 173, 255);
        background-color: white;
        color: rgb(150, 38, 255);
        font-weight: 600;
        border-radius: 5px;
        cursor: pointer;
    }


    #main_picker_box{
        width: 100%;
        float: left;
    }
    #picker_margin{
        height: 1px;
        float: left;
        width: 10px;
    }
    .picker_box{
        width: 210px;
        height: 210px;
        float: left;
        margin-right: 15px;
        cursor: pointer;
    }
    .picker_box_img img{
        width: 210px;
        height: 210px;
        background: linear-gradient(45deg, #b062f8, #c8e2ff);
    }
    .picker_nav{
        width: 90%;
        height: 24%;
        position: relative;
        top: -62px;
        left: 10px;
        background-color: rgb(112, 112, 112);
        opacity: 0.6;
    }
    .picker_box_title{
        width: 90%;
        position: relative;
        top: -110px;
        left: 13px;
        color: white;
        font-weight: 600;
        font-size: 18px;
    }
    .picker_box_subtitle{
        width: 90%;
        position: relative;
        top: -110px;
        left: 14px;
        color: white;
        font-size: 14px;
    }

    #recent_board_title{
        width: 100%;
        float: left;
    }
    #recent_board_title p{
        margin-top: 30px;
        margin-left: 10px;
        font-size: 22px;
        font-weight: 600;
        float: left;
    }
    #recent_board_title input{
        margin-top: 30px;
        float: right;
        margin-right: 30px;
        margin-top: 35px;
        padding: 3px 15px;
        border: 1px solid rgb(215, 173, 255);
        background-color: white;
        color: rgb(150, 38, 255);
        font-weight: 600;
        border-radius: 5px;
        
    }
    
    #recent_board_box_zone{
        width: 100%;
        float: left;
        padding: 15px;
    }
    .recent_board_box{
        width: 93%;
        background-color: white;
        height: 55px;
        padding-top: 10px;
        border-bottom: 1px solid rgb(204, 204, 204);
    }
    .recent_board_box i{
        font-size: 32px;
        border: 1px solid rgb(185, 185, 185);
        padding: 5px 10px;
        border-radius: 8px;
        float: left;
        margin-right: 10px;
        margin-top: 2px;
    }


    .recent_board_box_comment{

    }

    .recent_board_box_comment1{
        font-weight: 600;
        font-size: 18px;
        cursor: pointer;
    }
    .recent_board_box_comment1:hover{
        color: rgb(225, 117, 247);
    }
    .recent_board_box_comment2{
        margin-left: 10px;
    }
    #main_right_content{
        margin: auto;
    }
    #login_zone{
        width: 100%;
        height: 150px;
        margin-top: 35px;
        border: 1px solid rgb(215, 147, 255);
        background-color: #fcfcfc;
    }
    #loginBtn{
        width: 80%;
        height: 55px;
        margin: auto;
        margin-top: 22px;
        margin-bottom: 20px;
        border: none;
        background: linear-gradient(45deg, #c389f8, #c8e2ff);
        text-align: center;
        font-weight: 600;
        font-size: 26px;
        padding-top: 18px;
        color: white;
        cursor: pointer;
    }
    #login_zone a{
        text-decoration: none;
        color: rgb(133, 133, 133);
        font-size: 14px;
        font-weight: 600;
    }
    #login_zone a:hover{
        color: rgb(34, 34, 34);
    }
    #go_join{
        margin-left: 30px;
    }
    #go_findId{
        margin-left: 10px;
    }
    #go_findPw{
        margin-left: 10px;
    }

    #login_info_zone{
        width: 100%;
        height: 150px;
        margin-top: 35px;
        border: 1px solid rgb(215, 147, 255);
        background-color: #fcfcfc;
    }

    #makeBoardBtn{
        width: 100%;
        height: 41px;
        background: linear-gradient(45deg, #c389f8, #c8e2ff);
        text-align: center;
        font-size: 20px;
        font-weight: 600;
        color: white;
        padding-top: 12px;
        margin-top: 30px;
        margin-bottom: 30px;
        cursor: pointer;
    }
    #moveBoardBtn{
        width: 100%;
        height: 41px;
        background: linear-gradient(45deg, #c389f8, #c8e2ff);
        text-align: center;
        font-size: 20px;
        font-weight: 600;
        color: white;
        margin-top: 30px;
        cursor: pointer;
        
        text-decoration: none;
		border: none;
		padding: 12px 76px;
    }

    #loginfo_top{
        width: 100%;
        height: 70%;

    }
    #loginfo_top_left{
        width: 35%;
        height: 100%;
        float: left;
    }
    #profileImg{
        width: 70px;
        height: 70px;
        padding-top: 17px;
        padding-bottom: 17px;
        padding-left: 22px;
        padding-right: 9px;
    }
    #loginfo_top_right{
        width: 65%;
        float: left;
        padding-top: 30px;
        font-size: 18px;
    }
    #loginfo_top_right span{

    }


    #loginfo_bottom{
        width: 100%;
        height: 30%;
        border-top: 1px solid rgb(215, 147, 255);
    }
    #loginfo_bottom div{
        float: left;
        width: 24.7%;
        height: 74%;
        text-align: center;
        font-size: 14px;
        padding-top: 12px;
        cursor: pointer;
        color: rgb(92, 92, 92);
        font-weight: 600;
    }
    #goEditProfile{
        font-size: 14px;
        margin-left: 7px;
        color: rgb(124, 124, 124);
        font-weight: 600;
        cursor: pointer;
    }

    .border_right{
        border-right: 1px solid rgb(215, 147, 255);
    }
    .myFont1{
        font-size: 15px;
        color: rgb(92, 92, 92);
    } 
    #notice_zone h4{
        color: rgb(92, 92, 92);
        margin-bottom: 10px;
    }
    #notice_box{
        width: 100%;
        border-top: 1px solid rgb(191, 80, 255);
        border-bottom: 1px solid rgb(191, 80, 255);
        padding: 10px 0px;
    }
    .notice_boxies{
        overflow: hidden;
        height: 20px;
        font-size: 14px;
        margin-bottom: 3px;
        cursor: pointer;
    }
    .notice_boxies:hover{
        color: rgb(214, 81, 255);
    }

    #btn_recentBoard{
        cursor: pointer;
    }

    .line{
        float: left;
        width: 95%;
        height: 1px;
        background-color: rgb(215, 147, 255);
        margin-left: 10px;
        margin-top: 40px;
    }
    .hidden{
        display: none;
    }
    
    #go_logout{
    	background-color: #fcfcfc;
    	border: none;
    	text-align: center;
        font-size: 14px;
        cursor: pointer;
        color: rgb(92, 92, 92);
        margin-top: 11px;
        margin-left: 4px;
        font-weight: 600;
    }
    #recent_board_zone{
        float: left;
        margin-left: 10px;
    }
    #recent_board_zone h4{
        color: rgb(107, 107, 107);
        margin-left: 30px;
    }
    .recent_boards{
        float: left;
        width: 140px;
        height: 240px;
        margin-left: 20px;
        border: 1px solid rgb(230, 230, 230);
        box-shadow: 3px 3px 5px rgb(231, 231, 231);
        border-radius: 15px;
    }
    .recent_boards_top{
        width: 100%;
        height: 40%;
        border-bottom: 1px solid rgb(230, 230, 230);
        overflow: hidden;
    }
    .recent_boards_top img{
        width: 100%;
        height: 100%;
        border-top-left-radius: 15px;
        border-top-right-radius: 15px;
    }


    
    .recent_boards_bot{
        width: 100%;
        height: 60%;
        position: relative;
        float: left;
        padding: 12px;
    }
    .recent_boards_bot_title{
        width: 85%;
        font-size: 16px;
        font-weight: 800;
        color: rgb(80, 80, 80);
        margin-bottom: 10px;
    }
    .recent_boards_bot_subtitle{
        width: 85%;
        font-size: 12px;
        color: rgb(134, 134, 134);
    }
    .recent_boards_bot_btn{
        width: 72%;
        position: absolute;
        bottom: 35px;
        border: none;
        padding: 6px 0px;
        border-radius: 10px;
        color: rgb(109, 109, 109);
        font-weight: 600;
        cursor: pointer;
    }
</style>


<script>
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
</script>


<body>
    <div id="nav">
        <!-- 로고 / 검색 / 로그인 /  -->
        <div id="nav_content">
            <div id="nav_logo">MoonBoard</div>
            <div id="nav_search">
                <input id="serach_input" type="text">
                <input id="searchBtn" type="button" value="검색">
                <div id="nav_searcher" class="hidden">
                    <div id="searcher_top">커뮤니티 검색결과</div>
                    <div id="nav_searcher_list">
                        <!-- 
                        <div class="searcher_list">인천코딩모임</div>
                        <input type="hidden" value="6">
                         -->
                    </div>
                </div>
            </div>
			<sec:authorize access="isAuthenticated()">
				<div id="nav_login">
                	<i class="fas fa-user-circle"></i><sec:authentication property="principal.username"/>
            	</div>
			</sec:authorize>
            
        </div>
    </div>

    <div id="main">
        <div id="main_left">
            <!-- 인기 게시판 top3 -->
            <div id="main_left_content">
                <div id="main_picker">
                    <div id="main_picker_title">
                        <p>인기 게시판</p>
                        <input id="btn_recomendBoard" type="button" value="더보기">
                    </div>
                    <div id="main_picker_box">
                        <div id="picker_margin"></div>
                        <c:forEach items="${topBoard}" var="topBoard">
	                        <div class="picker_box">
	                            <input type="hidden" value="<c:out value='${topBoard.no}'/>"/>
	                            <div class="picker_box_img">
	                            	<c:if test="${topBoard.uploadpath != null}">
					                	<img src="/img/<c:out value='${topBoard.uploadpath}'/>/<c:out value='${topBoard.uuid}'/>_<c:out value='${topBoard.filename}'/>" alt="메인 배너이미지">
					                </c:if>
					                <c:if test="${topBoard.uploadpath == null}">
					                	<img src="/" alt=""/>
					                </c:if>
	                            </div>
	                            
	                            <div class="picker_nav"></div>
	                            <div class="picker_box_title"><c:out value="${topBoard.title}"/></div>
	                            <div class="picker_box_subtitle"><c:out value="${topBoard.subtitle}"/></div>
	                        </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            
            <!-- 활동 게시판? -->
            <div class="line"></div>
            <div id="recent_board">
                <div id="recent_board_title">
                    <p>최근활동 커뮤니티</p>
                    <input id="btn_recentBoard" type="button" value="더보기">
                </div>
                <div id="recent_board_zone">
                
                	<sec:authorize access="isAuthenticated()">
                		<c:forEach items="${recentBoard}" var="recentBoard">
                			<div class="recent_boards">
		                        <div class="recent_boards_top">
		                        	<img src="/img/<c:out value='${recentBoard.uploadpath}'/>/<c:out value='${recentBoard.uuid}'/>_<c:out value='${recentBoard.filename}'/>" alt="커뮤니티 이미지">
		                        </div>
		                        <div class="recent_boards_bot">
		                            <div class="recent_boards_bot_title"><c:out value="${recentBoard.title}"/></div>
		                            <div class="recent_boards_bot_subtitle"><c:out value="${recentBoard.subtitle}"/></div>
		                            <input type="button" class="recent_boards_bot_btn" value="방문하기">
		                            <input type="hidden" value="<c:out value="${recentBoard.no}"/>"/>
		                        </div>
		                    </div>
                		</c:forEach>
						
						
						
					</sec:authorize>
					
					<sec:authorize access="isAnonymous()">
						<div id="recent_board_zone">
		                    <H4>최근 게시글작성 및 댓글활동이 없습니다.<br/>다양한 커뮤니티에 방문하여 활동해주세요!</H4>
		                </div>
					</sec:authorize>

                    
                    
                    
                    
                    
                
                
                
                    
                </div>
            </div>









            
			
			
            
        </div>
    
        <div id="main_right">
            <div id="main_right_content">
	            <sec:authorize access="isAnonymous()">
					<!-- 로그인 -->
	                <div id="login_zone" class="">
	                    <div id="loginBtn">로그인</div>
	                    <a id="go_join" class="" href="#">회원가입</a>
	                    <a id="go_findId" class="" href="#">아이디 찾기</a>
	                    <a id="go_findPw" class="" href="#">비밀번호 찾기</a>
	                </div>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<!-- 회원정보 -->
	                <div id="login_info_zone" class="">
	                    <div id="loginfo_top">
	                        <div id="loginfo_top_left">
	                            <img id="profileImg" src="/resources/img/person.png" alt="">
	                        </div>
	                        <div id="loginfo_top_right">
	                            <span><c:out value="${nickname }"/> 님</span>
	                            <span id="goEditProfile">내정보</span>
	                            <br/>
	                            <span class="myFont1"><sec:authentication property="principal.username"/></span>
	                        </div>
	                    </div>
	                    <div id="loginfo_bottom">
	                        <div id="go_myPost" class="border_right">내 글</div>
	                        <div id="go_myReply" class="border_right">내 댓글</div>
	                        <div id="go_myMail" class="border_right">편지함</div>
	                        <form id="_nav_logoutForm" action="/member/customLogout" method='post'>
				                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				                <input type="submit" id="go_logout" class="" value="로그아웃">
				            </form>
	                    </div>
	                </div>
				</sec:authorize>
                
                
            </div>
            
            <!-- 게시판만들기 -->
            <div id="makeBoardBtn">게시판 만들기</div>
            
            <!-- 게시판만들기 -->
            <c:if test="${manageBoardNo ne null}">
            	<a id="moveBoardBtn" href="/board/home?no=<c:out value="${manageBoardNo }"/>" >운영중인 게시판</a>
            </c:if>
            
            <!-- 공지사항 -->
            <div id="notice_zone">
                <h4>공지사항</h4>
                <div id="notice_box">
                    <div class="notice_boxies">[공지] 11월 5일 시스템점검 공지사항</div>
                    <input type="hidden" value="pno"/>

                    <div class="notice_boxies">[안내] 닉네임 변경방법에대한 안내</div>
                    <div class="notice_boxies">[OPEN] 인천게시판이 공식오픈하였습니다</div>
                    <div class="notice_boxies">[공지] 로그인 불가 에러에대한 공지사항</div>
                    <div class="notice_boxies">[안내] 게시판 만드는 방법</div>
                    <div class="notice_boxies">[안내] 회원정보를 삭제하는 방법</div>
                    <div class="notice_boxies">[공지] 11월 5일 시스템점검 공지사항</div>
                    <div class="notice_boxies">[OPEN] KBO프로야구가 공식오픈하였습니다</div>
                    <div class="notice_boxies">[OPEN] 코딩커뮤니티가 공식오픈하였습니다</div>
                    <div class="notice_boxies">[OPEN] KT위즈가 공식오픈하였습니다</div>
                </div>
            </div>
            <!-- 내 작성 글 -->
            <!-- 내 작성 댓글 -->
        </div>
    </div>

</body>
</html>