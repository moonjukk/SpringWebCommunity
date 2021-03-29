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

</head>

<%@ include file="../includes/board_main_top.jsp" %>

<style>
#searcher input[type="text"] {
	width: 80%;
	height: 40px;
	margin-top: 10px;
	border: 1px solid rgb(206, 206, 206);
	border-radius: 8px;
	padding-left: 20px;
}

#searcher input[type="button"] {
	width: 10%;
	height: 43px;
	background-color: rgb(235, 235, 235);
	margin-top: 10px;
	border: 1px solid rgb(206, 206, 206);
	border-radius: 8px;
	cursor: pointer;
}

#searcher input[type="button"]:hover {
	border: 1px solid black;
}

#board {
	margin-top: 30px;
	width: 100%;
}

#boardTitle {
	font-size: 34px;
	font-weight: 700;
	margin-bottom: 5px;
}

#boardBoarder {
	width: 105%;
	height: 3px;
}

.boardList {
	width: 100%;
	height: 26px;
	padding: 10px 25px;
	border-bottom: 1px solid rgb(201, 201, 201);
}

.boardList div {
	float: left;
}

.boardBox {
	width: 56px;
	background-color: rgb(56, 56, 56);
	color: white;
	font-size: 12px;
	font-weight: 600;
	padding: 5px 0px;
	text-align: center;
	margin-right: 30px;
}

.boardListTitle {
	width: 45%;
	margin-top: 4px;
	font-size: 15px;
}

.boardListTitle a {
	text-decoration: none;
	color: black;
}

.boardListTitle a:hover {
	color: rgb(121, 121, 121);
}

.boardListTitle:hover {
	color: rgb(121, 121, 121);
	cursor: pointer;
}

.boardWriter {
	width: 113px;
	margin-top: 4px;
	font-size: 15px;
	color: rgb(71, 71, 71);
}

.boardWriter i {
	margin-left: 2px;
	margin-right: 2px;
}

.boardWriter i img {
	
}

.boardInfo {
	margin-top: 4px;
	font-size: 15px;
	margin-left: 40px;
	color: rgb(71, 71, 71);
}

.boardTime {
	width: 77px;
}

.boardView {
	width: 82px;
}

.boardLike {
	width: 55px;
}

#pagingZone {
	width: 106%;
	text-align: center;
	padding-top: 30px;
}

#pagingZone a {
	text-decoration: none;
	font-size: 20px;
	color: rgb(158, 158, 158);
}

#pagingZone a:hover {
	color: rgb(46, 46, 46);
}

.pagingMargin {
	padding: 0px 13px;
}

.pagingBtn {
	border: 1px solid rgb(190, 190, 190);
	padding: 0px 8px;
	padding-bottom: 6px;
	border-radius: 9px;
}

.pg_selected {
	padding: 0px 8px;
	padding-bottom: 5px;
	border-radius: 9px;
	color: white !important;
	background-color: rgb(209, 209, 209);
}

</style>

<main>



            <div id="zone_board" class="">
                <div id="searcher">
                    <input type="text" placeholder="커뮤니티 검색">
                    <input type="button" value="검색">
                </div>
                <div id="board">
                    <div id="boardTitle"><c:out value="${categoryName} "/></div>
                    <div id="boardBoarder" class="selectBackColor"></div>
                    <!-- 
                    <div class="boardList boardNoticeBackColor">
                        <div class="boardBox">공지</div>
                        <div class="boardListTitle">HTML게시판 관련 규정사항 안내</div>
                        <div class="boardWriter"><i class="fas fa-user-shield"></i>관리자삼육구</div>
                        <div class="boardInfo">
                            <div class="boardTime"><i class="far fa-clock"></i> 22:30</div>
                            <div class="boardView"><i class="far fa-eye"></i> 32123</div>
                            <div class="boardLike"><i class="far fa-heart"></i> 7777</div>
                        </div>
                    </div>
                     -->
                     <c:forEach items="${noticeList}" var="noticeList">
                    	<div class="boardList boardNoticeBackColor">
	                        <div class="boardBox boxHidden">공지</div>
	                        <div class="boardListTitle"><a href="/board/page?no=<c:out value="${no}"/>&cno=<c:out value="${notice_cno}"/>&pno=<c:out value="${noticeList.pno}"/>"><c:out value="${noticeList.title}"/></a></div>
	                        <div class="boardWriter"><i class="fas fa-user-circle"></i><c:out value="${noticeList.nickname}"/></div>
	                        <div class="boardInfo">
	                            <div class="boardTime"><i class="far fa-clock"></i> <fmt:formatDate value="${noticeList.write_date }" pattern="MM/dd"/></div>
	                            <div class="boardView"><i class="far fa-eye"></i> 0</div>
	                            <div class="boardLike"><i class="far fa-heart"></i> <c:out value="${noticeList.heart}"/></div>
	                        </div>
	                    </div>
                    </c:forEach>
                    
                    
                    
                    <c:forEach items="${list}" var="list">
                    	<div class="boardList">
	                        <div class="boardBox boxHidden"><c:out value="${list.pno}"/></div>
	                        <div class="boardListTitle"><a href="/board/page?no=<c:out value="${no}"/>&cno=<c:out value="${cno}"/>&pno=<c:out value="${list.pno}"/>"><c:out value="${list.title}"/></a></div>
	                        <div class="boardWriter"><i class="fas fa-user-circle"></i><c:out value="${list.writer_userid}"/></div>
	                        <div class="boardInfo">
	                            <div class="boardTime"><i class="far fa-clock"></i> <fmt:formatDate value="${list.write_date }" pattern="MM/dd"/></div>
	                            <div class="boardView"><i class="far fa-eye"></i> 0</div>
	                            <div class="boardLike"><i class="far fa-heart"></i> <c:out value="${list.heart}"/></div>
	                        </div>
	                    </div>
                    </c:forEach>
                    
                    <!--
                    <div class="boardList">
                        <div class="boardBox boxHidden">112022</div>
                        <div class="boardListTitle">일반 게시글 입니다</div>
                        <div class="boardWriter"><i class="fas fa-user-circle"></i>달토끼</div>
                        <div class="boardInfo">
                            <div class="boardTime"><i class="far fa-clock"></i> 08/20</div>
                            <div class="boardView"><i class="far fa-eye"></i> 3</div>
                            <div class="boardLike"><i class="far fa-heart"></i> 0</div>
                        </div>
                    </div>
                    -->
                    
                    <!-- 페이징버튼 ------------------------------->
                    <div id="pagingZone">
                    	<input type="hidden" id="getPageNum" value="${pageMaker.cri.pageNum}">
                    	<c:if test="${pageMaker.prev}">
                        	<a href="#" class="pagingBtn"><</a>
                    	</c:if>
                    	<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
	                        <a href="#" class="pagingMargin">${num}</a>           				        
	                    </c:forEach>
	                    <!-- 
	                    <a href="#" class="pagingMargin">1</a>
                        <a href="#" class="pagingMargin">2</a>
                        <a href="#" class="pagingMargin">3</a>
                        <a href="#" class="pagingMargin">4</a>
                        <a href="#" class="pagingMargin">5</a>
	                     -->
                        <c:if test="${pageMaker.next}">
                        	<a href="#" class="pagingBtn">></a>
                        </c:if>
                    </div>
                    <!-- 페이징버튼 -->
                </div>
            </div>


        </main>

    </div>
</body>
</html>