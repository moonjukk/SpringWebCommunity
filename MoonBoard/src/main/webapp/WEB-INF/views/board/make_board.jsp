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


<style>
    body{
        width: 600px;
        height: 600px;
        background-color: rgb(250, 212, 199);
        border: 6px solid rgb(102, 58, 0);
    }
    #warn{
        font-size: 14px;
    }
    #warn_title{
        width: 100%;
        font-weight: 800;
        font-size: 32px !important;
        text-align: center;
        color: rgb(78, 78, 78);
        padding: 20px 0px;
    }
    .warn_sub{
        margin-left: 16px;
        color: rgb(36, 36, 36);
        font-weight: 800;
    }
    form{
        margin-top: 30px;
        margin-left: 20px;
        font-size: 18px;
        font-weight: 600;
        color: rgb(61, 61, 61);
        
    }
    .form_input{
        width: 100%;
        margin-bottom: 14px;
        margin-left: 10px;
    }
    .form_input input{
        height: 20px;
        width: 300px;
    }
    .subTxt{
        font-size: 13px;
        margin-left: 120px;
    }
    .readonly{
        border: 1px solid rgb(197, 197, 197);
        background-color: rgb(236, 236, 236);
    }

    input[type='submit']{
        width: 90%;
        height: 40px;
        margin-top: 100px;
        margin-left: 20px;
        border: 1px solid rgb(180, 180, 180);
        background-color: white;
        font-weight: 600;
        color: rgb(95, 95, 95);
        cursor: pointer;
    }

    .marginLeft1{
        margin-left: 24px;
    }
    .marginLeft2{
        margin-left: 17px;
    }
</style>

<body>
    <div id="">
        <div id="warn">
            <div id="warn_title">게시판 작성하기</div>
            <div class="warn_sub">* 계정 1개당 최대 1개의 게시판을 생성할 수 있습니다</div>
            <div class="warn_sub">* 게시판 생성자 계정이 게시판 1대관리자가되며 게시물/댓글을 관리할 의무가 있습니다</div>
            <div class="warn_sub">* 운영정책에 위반하는 게시판 혹은 관리불가판정이되면 강제로 삭제될 수 있습니다</div>
            <div class="warn_sub">* 관리자 계정에 문제가 생겼을 경우 게시판복구에 어려움이 생길 수 있습니다</div>
            <div class="warn_sub">* 본 게시판을 상거래 목적으로 사용할 수 없습니다</div>
            <div class="warn_sub">* 게시판 대표이미지, 테마등은 생성 후 설정이 가능합니다</div>
        </div>
        <form action="/board/makeBoard" method="POST">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <div class="form_input">
                <span class="marginLeft1">게시판이름</span>
                <input type="text" name="title">
                <div class="subTxt">※ 주제와 어울리는 이름으로 설정해야 많은사람들이 방문하기 쉬워집니다.</div>
            </div>
            <div class="form_input">
                <span class="marginLeft2">게시판 설명</span>
                <input type="text" name="subtitle">
                <div class="subTxt">※ 제목과 함께 많은사람들이 찾을 수 있도록 부제목을 설정하여 주세요</div>
            </div>
            <div class="form_input">
                <span>게시판 관리자</span>
                <input type="text" value="<sec:authentication property="principal.username"/>" class="readonly" readonly>
            </div>
            <input type="submit" value="생성하기">

        </form>
    </div>
</body>
</body>
</html>