<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    
    <!-- css/js -->
    <link rel="stylesheet" href="/resources/style/main.css" />
    <script src="/resources/js/main.js"></script>
    
</head>





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
