<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
  <!-- img파일을 불러오기위해 spring taglib사용 -->
  <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
  <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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
	$(document).ready(function(){
		var message='${message}';
		if(message!=""){
			alert(message);
		}
	});
	</script>

</head>

<%@ include file="../includes/board_main_top.jsp" %>


<style>
    main{
        width: 75%;
        height: 1000px;
        float: left;
    }
    #searcher input[type="text"]{
        width: 80%;
        height: 40px;
        margin-top: 10px;
        border: 1px solid rgb(206, 206, 206);
        border-radius: 8px;
        padding-left: 20px;
    }
    #searcher input[type="button"]{
        width: 10%;
        height: 43px;
        background-color: rgb(235, 235, 235);
        margin-top: 10px;
        border: 1px solid rgb(206, 206, 206);
        border-radius: 8px;
        cursor: pointer;
    }
    #searcher input[type="button"]:hover{
        border: 1px solid black;
    }


    #board{
        margin-top: 30px;
        width: 100%;
    }
    #boardTitle{
        font-size: 34px;
        font-weight: 700;
        margin-bottom: 5px;
    }
    #boardBoarder{
        width: 105%;
        height: 3px;
    }
    .boardList{
        width: 100%;
        height: 26px;
        padding: 10px 25px;
        border-bottom: 1px solid rgb(201, 201, 201);
    }
    .boardList div{
        float: left;
    }
    .boardBox{
        width: 56px;
        background-color: rgb(56, 56, 56);
        color: white;
        font-size: 12px;
        font-weight: 600;
        padding: 5px 0px;
        text-align: center;
        margin-right: 30px;
    }
    .boardListTitle{
        width: 45%;
        margin-top: 4px;
        font-size: 15px;
    }
    .boardListTitle a{
    	text-decoration: none;
    	color: black;
    }
    .boardListTitle a:hover{
        color: rgb(121, 121, 121);
    }
    .boardListTitle:hover{
        color: rgb(121, 121, 121);
        cursor: pointer;
    }
    .boardWriter{
        width: 113px;
        margin-top: 4px;
        font-size: 15px;
        color: rgb(71, 71, 71);
    }
    .boardWriter i{
        margin-left: 2px;
        margin-right: 2px;
    }
    .boardWriter i img{
    }
    .boardInfo{
        margin-top: 4px;
        font-size: 15px;
        margin-left: 40px;
        color: rgb(71, 71, 71);
    }
    .boardTime{
        width: 77px;
    }
    .boardView{
        width: 82px;
    }
    .boardLike{
        width: 55px;
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
            #main_banner{
                width: 106%;
            }
            #main_banner img{
                width: 100%;
            }
</style>


		<main>
            <div id="main_banner">
                <c:if test="${mainBannerImg != null}">
                	<img src="/img/<c:out value='${mainBannerImg.uploadpath}'/>/<c:out value='${mainBannerImg.uuid}'/>_<c:out value='${mainBannerImg.filename}'/>" alt="메인 배너이미지">
                </c:if>
                <c:if test="${mainBannerImg == null}">
                	<img src="/resources/img/choice_banner.png" alt="메인 배너이미지">
                </c:if>
            </div>

            <div id="zone_board" class="">
                <div id="board">
                    <div id="boardTitle">공지사항</div>
                    <div id="boardBoarder" class="selectBackColor"></div>
                    <!-- <div class="boardList boardNoticeBackColor">
                        <div class="boardBox">공지</div>
                        <div class="boardListTitle">HTML게시판 관련 규정사항 안내</div>
                        <div class="boardWriter"><i class="fas fa-user-shield"></i>관리자삼육구</div>
                        <div class="boardInfo">
                            <div class="boardTime"><i class="far fa-clock"></i> 22:30</div>
                            <div class="boardView"><i class="far fa-eye"></i> 32123</div>
                            <div class="boardLike"><i class="far fa-heart"></i> 7777</div>
                        </div>
                    </div> -->
                    <!-- 
                    <div class="boardList">
                        <div class="boardBox boxHidden">112022</div>
                        <div class="boardListTitle">공지사항 샘플</div>
                        <div class="boardWriter"><i class="fas fa-user-circle"></i>달토끼</div>
                        <div class="boardInfo">
                            <div class="boardTime"><i class="far fa-clock"></i> 08/20</div>
                            <div class="boardView"><i class="far fa-eye"></i> 3</div>
                            <div class="boardLike"><i class="far fa-heart"></i> 0</div>
                        </div>
                    </div> 
                    -->
                    <c:forEach items="${noticeList}" var="list">
                    	<div class="boardList boardNoticeBackColor">
                        	<div class="boardBox boxHidden"><c:out value="${list.pno}"/></div>
	                        <div class="boardListTitle"><a href="/board/page?no=<c:out value="${no}"/>&cno=<c:out value="${cno}"/>&pno=<c:out value="${list.pno}"/>"><c:out value="${list.title}"/></a></div>
	                        <div class="boardWriter"><i class="fas fa-user-circle"></i><c:out value="${list.nickname}"/></div>
	                        <div class="boardInfo">
	                            <div class="boardTime"><i class="far fa-clock"></i> <fmt:formatDate value="${list.write_date }" pattern="MM/dd"/></div>
	                            <div class="boardView"><i class="far fa-eye"></i> 0</div>
	                            <div class="boardLike"><i class="far fa-heart"></i> <c:out value="${list.heart}"/></div>
	                        </div>
	                    </div>
                    </c:forEach>
                    
                    
                    
                    
                    <style>
                        #pagingZone{
                            width: 106%;
                            text-align: center;
                            padding-top: 30px;
                        }
                        #pagingZone a{
                            text-decoration: none;
                            font-size: 20px;
                            color: rgb(158, 158, 158);
                        }
                        #pagingZone a:hover{
                            color: rgb(46, 46, 46);
                        }
                        .pagingMargin{
                            padding: 0px 13px;
                        }
                        .pagingBtn{
                            border: 1px solid rgb(190, 190, 190);
                            padding: 0px 8px;
                            padding-bottom: 6px;
                            border-radius: 9px;
                        }
                        .pagingBtn:hover{
                            background-color: rgb(241, 241, 241);
                        }
                    </style>
                </div>
            </div>


        </main>

    </div>
</body>
</html>