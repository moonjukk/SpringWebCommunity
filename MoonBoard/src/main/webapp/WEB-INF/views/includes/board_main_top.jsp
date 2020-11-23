<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<style>
    body{
        margin: 0;
        padding: 0;
    }
    header{
        width: 100%;
        height: 240px;
        margin-bottom: 30px;
        cursor: pointer;
        overflow: hidden;
    }
    header img{
    	width: 100%; 
    	height: 100%;

    	
    }

    #center{
        width: 1100px;
        margin: auto;
    }
    nav{
        width: 20%;
        margin-right: 50px;
        float: left;
        margin-bottom: 200px;
    }
    #navHeader{
        position:relative;
        height: 200px;
        padding: 20px;
        margin-bottom: 0 !important;
        border-left: 1px solid rgb(226, 226, 226);
        border-right: 1px solid rgb(226, 226, 226);
    }
    #navHeaderBtn{
        width: 99%;
        height: 50px;
        border: 1px solid rgb(226, 226, 226);
        margin-bottom: 20px;
    }
    .navHeaderBtn3{
        width: 99%;
        border-bottom: 1px solid rgb(226, 226, 226);
        margin-bottom: 20px;
    }
    #navHeaderBtn div{
        width: 49.5%;
        float: left;
        text-align: center;
        padding-top: 15px;
        cursor: pointer;
    }
    #navTitle{
        font-size: 29px;
        font-weight: 800;
        cursor: pointer;
    }

    #navHeaderBtn1{
        border-right: 1px solid rgb(226, 226, 226);
    }
   
    .navMainBtns{
        font-size: 20px;
        text-align: center;
        padding: 20px 0;
        cursor: pointer;
        margin-bottom: 20px;
    }
	
    .navLists{
        border-right: 1px solid rgb(226, 226, 226);
        border-left: 1px solid rgb(226, 226, 226);
        border-bottom: 1px solid rgb(226, 226, 226);
        padding: 10px 0;
        padding-left: 20px;
    }
    .navLists div{
        width: 93%;
        padding: 15px 0;
    }
    .navListHead{
        border-bottom: 1px solid rgb(226, 226, 226);
    }
    .navListSub:hover{
        color: rgb(122, 122, 122);
        cursor: pointer;
    }
    .navListSub i{
        margin-left: 10px;
        margin-right: 7px;
    }








    main{
        width: 75%;
        height: 1000px;
        float: left;
    }
    




    .selectBackColor{
        background: linear-gradient(45deg, #ED4264, #FFEDBC) !important;
        color: white;
    }
    .selectBorderTop{
        border-top: 3px solid #ED4264;
    }
    .boardNoticeBackColor{
        background-color: rgb(240, 240, 240);
    }
    .hidden{
        display: none;
    }
    
    
    #navInfo{
        position:absolute; 
        bottom:20px;
    }
    #nav_manager_icon{
        font-size: 8px;
        padding: 2px 6px;
        background-color: rgb(207, 83, 83);
        color: cornsilk;
    }
    .nav_main_icon{
        font-size: 8px;
        padding: 2px 6px;
        background-color: rgb(102, 151, 224);
        color: cornsilk;
    }
    .nav_nickname_eit_btn{
        border: 1px solid rgb(175, 175, 175);
        background-color: white;
        font-size: 8px;
        padding: 2px 6px;
        color: rgb(100, 100, 100);
        border-radius: 15px;
        cursor: pointer;
    }
    .nav_nickname_eit_btn:hover{
        background-color: rgb(243, 243, 243);
    }
    .nav_main_id{
        font-size: 11px;
    }
    
    #nav_login_margin{
    	height:1px;
    	width: 100%;
    	border-bottom: 1px solid rgb(226, 226, 226);
    	margin-bottom: 19px;
    }
    
    #navMainBtn2{
        font-size: 20px;
        text-align: center;
        padding: 20px 0;
        cursor: pointer;
        margin-bottom: 20px;
    }
    
    #home_btn{
        position: fixed;
        width: 60px;
        top: 10px;
        left: 10px;
        cursor: pointer;
    }
    #home_btn: hover{
    	transform: scale( 1.2 );
    }
</style>

<script>
	$(document).ready(function(){
		
        var whereBoard = $('#whereBoard').val();

		$('#navMainBtn').click(function(){
			location.href = '/board/write?no='+whereBoard;
		});
		$('#navHeaderBtn2').click(function(){
			location.href = '/member/join';
		});
		$('#navMainLogoutBtn').click(function(){
			location.href = '/member/customLogout';
		});
		
        $('.navListSub').click(function(){
            var category = $(this).next().val();
            location.href = '/board/list?no='+whereBoard+'&cno='+category;
        });
		
        $('#navHeaderBtn1').click(function(){
        	location.href = '/member/customLogin';
        });
        $('#navMainBtn3').click(function(){
        	alert('로그인이 필요한 작업입니다.');
        });
        $('#navMainBtn2').click(function(){
        	location.href = '/board/setting?no=' + whereBoard;
        });
        
        $('#navTitle').click(function(){
        	location.href = '/board/home?no=' + whereBoard;
        });
        $('header').click(function(){
        	location.href = '/board/home?no=' + whereBoard;
        });  
        $('#home_btn').click(function(){
        	location.href = '/';
        });         
	});
</script>

<body>
	<img id="home_btn" src="/resources/img/home.png" alt="">

    <header class="selectBackColor">
        <c:if test="${topBannerImg != null}">
           	<img src="/img/<c:out value='${topBannerImg.uploadpath}'/>/<c:out value='${topBannerImg.uuid}'/>_<c:out value='${topBannerImg.filename}'/>" alt="상단 배너이미지">
        </c:if>
    </header>

    <div id="center">
        <nav>
            <div id="navHeader" class="selectBorderTop">
            	<input type="hidden" id="whereBoard" value="<c:out value="${getBoardData.no }" />">
                <span id="navTitle"><c:out value="${getBoardData.title }" /></span>
                <br/>
                <span id="navSubTitle"><c:out value="${getBoardData.subtitle }" /></span>
                <div id="navInfo">
                    <div>
                        <span id="nav_manager_icon">관리자</span>
                        <span class="nav_main_id"><c:out value="${boardManagerID}"/></span>
                    </div>
                    <sec:authorize access="isAuthenticated()">
	                    <div>
	                        <span class="nav_main_icon">로그인</span>
	                        <span class="nav_main_id"><sec:authentication property="principal.username"/></span>
	                    </div>
	                    <div>
	                        <form id="" action="/member/customLogout" method='post'>
					            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		                        <span class="nav_main_icon">닉네임</span>
		                        <span class="nav_main_id"><c:out value="${nickname}" /></span>
		                        <span class="nav_nickname_eit_btn">수정</span>
					            <button id="navMainLogoutBtn" class="nav_nickname_eit_btn">로그아웃</button>
				            </form>
	                    </div>
	                    
                    </sec:authorize>
                </div>
            </div>
            
            
            <sec:authorize access="isAnonymous()">
	            <div id="navHeaderBtn">
	                <div id="navHeaderBtn1">로그인</div>
	                <div id="navHeaderBtn2">회원가입</div>
	            </div>
            </sec:authorize>
            
            <sec:authorize access="isAnonymous()">
            	<div id="navMainBtn3" class="navMainBtns selectBackColor">커뮤니티 글쓰기</div>
            </sec:authorize>
            
			<sec:authorize access="isAuthenticated()">
            	<div class="navHeaderBtn3"></div>
				<div id="navMainBtn" class="navMainBtns selectBackColor">커뮤니티 글쓰기</div>
			</sec:authorize>
            
            <div id="navList" class="selectBorderTop">
           		<div>
            	<c:forEach items="${categoryList}" var="categoryList">
     				<c:if test="${categoryList.depth eq 1}">
     					</div><div class="navLists"><div class="navListHead">${categoryList.category_name}</div>
     				</c:if>
     				<c:if test="${categoryList.depth > 1}">
     					<div class="navListSub"><i class="fas fa-angle-double-right"></i>${categoryList.category_name}</div>
     					<input type="hidden" value="${categoryList.cno}">
     				</c:if>
     			</c:forEach>			
            	</div>
            	<!-- 
                <div class="navLists">
                    <div class="navListHead">공지사항</div>
                    <div class="navListSub"><i class="fas fa-angle-double-right"></i>필독공지</div>
                    <div class="navListSub"><i class="fas fa-angle-double-right"></i>인기글</div>
                    <div class="navListSub"><i class="fas fa-angle-double-right"></i>이벤트</div>
                </div>
                <div class="navLists">
                    <div class="navListHead">FrontEnd</div>
                    <div class="navListSub"><i class="fas fa-angle-double-right"></i>JavsScript</div>
                    <div class="navListSub"><i class="fas fa-angle-double-right"></i>AngularJS</div>
                    <div class="navListSub"><i class="fas fa-angle-double-right"></i>Design</div>
                </div>
                <div class="navLists">
                    <div class="navListHead">BackEnd</div>
                    <div class="navListSub"><i class="fas fa-angle-double-right"></i>Spring</div>
                    <div class="navListSub"><i class="fas fa-angle-double-right"></i>NodeJS</div>
                </div>
                <div class="navLists">
                    <div class="navListHead">모임</div>
                    <div class="navListSub"><i class="fas fa-angle-double-right"></i>2020년</div>
                    <div class="navListSub"><i class="fas fa-angle-double-right"></i>2019년</div>
                </div>
                 -->
            </div>
            
            <sec:authorize access="isAuthenticated()">
            	<c:if test="${loginUserId eq boardManagerID }">
	            	<div class="navHeaderBtn3"></div>
	            	<div id="navMainBtn2" class="selectBackColor">게시판 설정</div>
            	</c:if>
			</sec:authorize>
            
        </nav>
    





