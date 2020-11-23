<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    
    <!-- jQuery -->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    
    <!-- Bootstrap Core CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    
    
    <!-- Google fonts-->
    <link href="https://fonts.googleapis.com/css2?family=Hi+Melody&family=Piedra&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Merriweather+Sans:400,700" rel="stylesheet" />
	<link href="https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic" rel="stylesheet" type="text/css" />
	 
	<!-- logo googlefont-->
	 <link href="https://fonts.googleapis.com/css2?family=Reenie+Beanie&display=swap" rel="stylesheet">
    
    <!-- 쿠키 cdn -->
    
    
    
    <style>
        #wrap{
            width: 70%;
            max-width: 600px;
            margin: auto;
            margin-top: 50px;
            background-color: rgb(246, 242, 242);
			
        }
        .pan{
            width: 100%;
        }
        #upPan{
        }
        #logo{
            font-size: 55px;
            text-align: center;
            padding-top: 40px;
            padding-bottom: 20px;
			font-family: 'Reenie Beanie', cursive;
			cursor: pointer;
        }
        #upPan form{
            
        }
        .inputlogin{
            display: block;
            width: 80%;
            height: 50px;
            margin: auto;
            margin-bottom: 10px;
            border: 1px solid rgb(219, 219, 219);
            padding-left: 8px;
        }
        .loginBtn{
            background-color: #001C3C;
            border: none;
            display: block;
            width: 80%;
            height: 60px;
            margin: auto;
            margin-top: 30px;
            color: white;
            font-size: 20px;
        }
		.loginBtn:hover{
			background-color:#001124; 
		}

        #autoLoginBox{
            margin-left: 10%;
            width: 30%;
            margin-top: 7px;
        }
        .font1{
            font-size: 14px;
        }
        hr{
            margin-top: 20px;
            background-color: rgb(189, 189, 189);
            margin-bottom: 20px;
        }
        #bookMark{
            text-align: center;
        }
        #bookMark a{
            text-decoration: none;
            font-size: 13px;
            color: rgb(110, 110, 110);
            margin-right: 15px;
        }
        #billBoard img{
            display: block;
            margin: auto;
            width: 90%;
            margin-top: 40px;
        }
        #centerPan{
            padding-bottom: 40px;
        }
    </style>

    <script>
			$(document).ready(function(){
				var result='${result}';
				var error='${error}';
				var message='${message}';
				if(result!=""){
					alert(result);
				}
				if(error!=""){
					alert(error);
				} 
				if(message!=""){
					alert("임시 비밀번호 [ "+message+" ]가 발급되었습니다.\n로그인 후 반드시 비밀번호를 변경해주세요.");
				}
				
				$('#logo').click(function(){
					location.href = '/';
				});
			});
	</script>

</head>
<body>

    <div id="wrap">
        <div id="upPan" class="pan">
            <div id="logo">Moon Board</div>
            <form action="/login" method="POST" accept-charset="utf-8" onsubmit="return lastCheck();">
                <input type="text" id="inputID" class="inputlogin" name="username" placeholder="  아이디"/>
                <input type="password" id="inputPW" class="inputlogin" name="password" placeholder="  비밀번호"/>
                <input type="submit" id="submitBtn" class="loginBtn" value="로그인"/>
                <div id="autoLoginBox" >
                    <input type="checkbox" id="autoLogin" name="_spring_security_remember_me" /><span class="font1"> 자동로그인</span>
                </div>
                <!-- 토큰 -->
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            </form>
            <hr>
        </div>
    
        <div id="centerPan" class="pan">
            <div id="bookMark">
                <a href="">아이디 찾기</a>
                <a href="">비밀번호 찾기</a>
                <a href="/member/join">회원가입</a>
            </div>
        </div>
    
        <!--
        <div id="downPan" class="pan">
            <div id="billBoard">
                <img src="img/samsung_banner.PNG"/>
            </div>
        </div>
        -->
    </div>
</body>
</html>