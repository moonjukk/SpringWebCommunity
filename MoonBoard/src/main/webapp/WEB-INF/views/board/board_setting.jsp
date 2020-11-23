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
		var csrfHeaderName ="${_csrf.headerName}"; 
		var csrfTokenValue="${_csrf.token}";
	</script>

</head>

<%@ include file="../includes/board_main_top.jsp" %>

<style>
	#setting_zone{
        width: 80%;
        padding: 30px 20px;
        border: 1px solid rgb(172, 172, 172);
        border-radius: 15px;
    }
    
    .shopFont{
    	font-size: 11px;
    }
</style>

<script>
	$(document).ready(function(){
		$('#setting_title_btn').click(function(){
			
			var title = $('#setting_title_val').val();
			var no = $('#whereBoard').val();
			var change = "title";
			var go = {title, no, change};
			
			$.ajax({
            	url: '/setting/change',
            	processData: false,
            	beforeSend: function(xhr){
            		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            	},
            	data: JSON.stringify(go),
            	contentType : "application/json; charset=utf-8",
            	type: 'POST',
            	success: function(result){
            		alert('수정완료');
            		$('#navTitle').text(title);
            	},
            	fail: function(){
    				alert("시스템 에러가 발생하였습니다.");
            	},
            	complete: function(result){
            	}
            });
		});
		
		
		$('#setting_makeMotherCategory_btn').click(function(){
			
			var category_name = $('#setting_makeMotherCategory_val').val();
			var pno = $('#whereBoard').val();
			var change = "makeMotherCategory";
			var go = {category_name, pno, change};
			
			$.ajax({
            	url: '/setting/changeCategory',
            	processData: false,
            	beforeSend: function(xhr){
            		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            	},
            	data: JSON.stringify(go),
            	contentType : "application/json; charset=utf-8",
            	type: 'POST',
            	success: function(result){
            		alert('설정완료');
            		location.href = location.href;
            	},
            	fail: function(){
    				alert("시스템 에러가 발생하였습니다.");
            	},
            	complete: function(result){
            	}
            });
		});
		

		
		$('#setting_makeSonCategory_btn').click(function(){
			
			var category_name = $('#setting_makeSonCategory_val').val();
			var pno = $('#whereBoard').val();
			var pcno = $('#setting_makeSonCategory_select option:selected').val();
			var change = "makeSonCategory";
			var go = {category_name, pno, change, pcno};
			
			$.ajax({
            	url: '/setting/changeCategory',
            	processData: false,
            	beforeSend: function(xhr){
            		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            	},
            	data: JSON.stringify(go),
            	contentType : "application/json; charset=utf-8",
            	type: 'POST',
            	success: function(result){
            		alert('설정완료');
            		// 설정 후 바로 네비게이션이 수정되지않는 점
            		location.href = location.href;
            	},
            	fail: function(){
    				alert("시스템 에러가 발생하였습니다.");
            	},
            	complete: function(result){
            	}
            });
		});
		
		
		
		var fileCnt = 0;
        $("#setting_inputMainBanner_val").change(function(){
            // 멀티파일 적용, 이 파트에서는 사용하지 않음
            var fileInput = document.getElementById("setting_inputMainBanner_val");
            var files = fileInput.files;
                
            var formData = new FormData();
            for (var i = 0; i < files.length; i++) {
                if(!checkExtension(files[i].name,1000)){
                    $(this).val("");
                    return false;
                }else{
                    //var str = dragFile(files[i].name);
                    //$('#dragZone').removeClass('hidden');
                    //$('.thumbInfo').removeClass('hidden');
                    //$('#dragZoneOpen').html('▲');
                    //dragZoneFlag = true;
                    //$('#dragFileZone').append(str);
                    //$('#dragFile span').addClass('hidden');
                    formData.append("uploadFile", files[i]);
                    fileCnt++;
                }
            }
            // ajax처리
            $.ajax({
                	url: '/board/registerfiles',
                	processData: false,
                	contentType: false,
                	beforeSend: function(xhr){
                		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                	},
                	data: formData,
                	type: 'POST',
                	success: function(result){
                		showUploadResult(result);
                	},
                	fail: function(){
        				alert("파일 등록 중 예상치못한 에러가 발생하였습니다.");
                	},
                	complete: function(result){
                	}
                });
            });
        
        
        
        var regex=new RegExp("()\.(jpg|JPG|jpeg|JPEG|jfif|JFIF|TIFF|GIF|gif|png|PNG)$");
        var maxSize=8*1024*1024;//8MB
        function checkExtension(fileName,fileSize){
            if(fileSize>=maxSize){
                alert("파일사이즈 초과");
                return false;
            }
            if(!regex.test(fileName)){
                alert("해당 종류의 파일은 업로드할 수 없습니다.");
                return false;
            }
            return true;
        }
        
        
        
        
        
        function showUploadResult(uploadResultArr){
    		//첨부파일목록이 없으면 중지
    		if(!uploadResultArr || uploadResultArr.length==0){
    			return;
    		}
    		
    		console.log("@@@@@@@@@@@@@@@@@@@@@@@@@");
    		var uploadResult = $('#dragZone')
    		
    		//목록초기화
    		//uploadResult.empty();
    		
    		var str="";
    		$(uploadResultArr).each(function(i,obj){
    			var fileCallPath=encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
    			var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
				
    			str += "<div>";
    			// str += "<input type='checkbox' name='selectedImg' value='" + obj.uuid + "'>";
                str += "<i class=\"far fa-images\"></i>";
                
                // 아래의 주소로 서버의 이미지를 로드
                // http://localhost:8181/img      
                // 2020/07/16   /      9423c531-79af-4920-bb25-0d108dc698cc    _      banner.png
                str += "<a href=\"/img/"+ obj.uploadpath +"/" + obj.uuid + "_" + obj.filename + "\" onclick=\"window.open(this.href, '이미지', 'width=500, height=500'); return false;\">"+obj.filename+"</a>";
                
                console.log("!!!! 페이지에 등록 !!!!");
                console.log("uuid"+obj.uuid);
                console.log("uploadpath"+obj.uploadpath);
                console.log("filename"+obj.filename);
                console.log("!!!!!!!!!!!!!!!!!!!!!");
                
                str += "<i class=\"far fa-times-circle fileDeleteBtn getImageList\" data-uuid=\""+ obj.uuid +"\" data-filename=\""+ obj.filename+"\" data-uploadpath=\""+ obj.uploadpath +"\"></i>";
                // var a = $(this).data("uuid");
                str += "</div>";
    			
    		});
    		
    		console.log("##################################################");
    		console.log(str);
    		console.log("##################################################");
    		
    		uploadResult.empty();
    		uploadResult.append(str);
    		
    	}
        
        
        
        
        
        $('#setting_inputMainBanner_btn').click(function(){
        	var str = "";
        	var uuid = "";
        	var uploadpath = "";
        	var filename = "";
        	$('#dragZone div .getImageList').each(function(i, obj){
            	var jobj = $(obj);
            	
            	uuid = jobj.data("uuid");
            	uploadpath = jobj.data("uploadpath");
            	filename = jobj.data("filename");
            	
            });
        	var category_name = $('#setting_makeMotherCategory_val').val();
			var bno = $('#whereBoard').val();
			var type = 1;
			var go = {uuid, uploadpath, filename, bno, type};
			
        	$.ajax({
            	url: '/setting/changeBanner',
            	processData: false,
            	beforeSend: function(xhr){
            		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            	},
            	data: JSON.stringify(go),
            	contentType : "application/json; charset=utf-8",
            	type: 'POST',
            	success: function(result){
            		alert('설정완료');
            	},
            	fail: function(){
    				alert("시스템 에러가 발생하였습니다.");
            	},
            	complete: function(result){
            	}
            });
        });
        
        
        
        
        
        
        $("#setting_inputTopBanner_val").change(function(){
            // 멀티파일 적용, 이 파트에서는 사용하지 않음
            var fileInput = document.getElementById("setting_inputTopBanner_val");
            var files = fileInput.files;
                
            var formData = new FormData();
            for (var i = 0; i < files.length; i++) {
                if(!checkExtension(files[i].name,1000)){
                    $(this).val("");
                    return false;
                }else{
                    //var str = dragFile(files[i].name);
                    //$('#dragZone').removeClass('hidden');
                    //$('.thumbInfo').removeClass('hidden');
                    //$('#dragZoneOpen').html('▲');
                    //dragZoneFlag = true;
                    //$('#dragFileZone').append(str);
                    //$('#dragFile span').addClass('hidden');
                    formData.append("uploadFile", files[i]);
                    fileCnt++;
                }
            }
            // ajax처리
            $.ajax({
                	url: '/board/registerfiles',
                	processData: false,
                	contentType: false,
                	beforeSend: function(xhr){
                		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                	},
                	data: formData,
                	type: 'POST',
                	success: function(result){
                		showUploadResult(result);
                	},
                	fail: function(){
        				alert("파일 등록 중 예상치못한 에러가 발생하였습니다.");
                	},
                	complete: function(result){
                	}
                });
            });
        
        
        $('#setting_inputTopBanner_btn').click(function(){
        	var str = "";
        	var uuid = "";
        	var uploadpath = "";
        	var filename = "";
        	$('#dragZone div .getImageList').each(function(i, obj){
            	var jobj = $(obj);
            	
            	uuid = jobj.data("uuid");
            	uploadpath = jobj.data("uploadpath");
            	filename = jobj.data("filename");
            	
            });
        	var category_name = $('#setting_makeMotherCategory_val').val();
			var bno = $('#whereBoard').val();
			var type = 2;
			var go = {uuid, uploadpath, filename, bno, type};
			
        	$.ajax({
            	url: '/setting/changeBanner',
            	processData: false,
            	beforeSend: function(xhr){
            		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            	},
            	data: JSON.stringify(go),
            	contentType : "application/json; charset=utf-8",
            	type: 'POST',
            	success: function(result){
            		alert('설정완료');
            		location.href = location.href;
            	},
            	fail: function(){
    				alert("시스템 에러가 발생하였습니다.");
            	},
            	complete: function(result){
            	}
            });
        });
        
        
        $('#setting_deleteMotherCategory_btn').click(function(){
			
			var cno = $('#setting_deleteMotherCategory_val option:selected').val();
			var pno = $('#whereBoard').val();
			var change = "delMotherCategory";
			var go = {cno, pno, change};

			$.ajax({
            	url: '/setting/changeCategory',
            	processData: false,
            	beforeSend: function(xhr){
            		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            	},
            	data: JSON.stringify(go),
            	contentType : "application/json; charset=utf-8",
            	type: 'POST',
            	success: function(result){
            		alert('카테고리 삭제완료');
            		// 설정 후 바로 네비게이션이 수정되지않는 점
            		location.href = location.href;
            	},
            	fail: function(){
    				alert("시스템 에러가 발생하였습니다.");
            	},
            	complete: function(result){
            	}
            });
		});

        
        $('#setting_deleteSonCategory_btn').click(function(){
			
			var cno = $('#setting_deleteSonCategory_val option:selected').val();
			var pno = $('#whereBoard').val();
			var change = "delSonCategory";
			var go = {cno, pno, change};

			$.ajax({
            	url: '/setting/changeCategory',
            	processData: false,
            	beforeSend: function(xhr){
            		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            	},
            	data: JSON.stringify(go),
            	contentType : "application/json; charset=utf-8",
            	type: 'POST',
            	success: function(result){
            		alert('카테고리 삭제완료');
            		// 설정 후 바로 네비게이션이 수정되지않는 점
            		location.href = location.href;
            	},
            	fail: function(){
    				alert("시스템 에러가 발생하였습니다.");
            	},
            	complete: function(result){
            	}
            });
		});
        
        
        
        
        
        
	});
</script>

<main>
<div id="setting_zone" class="">
                    <h4>게시판 대문 설정</h4>
                    <div class="setting_input_zone">
                        <form action=""></form>
                        <span>게시판명</span>
                        <input id="setting_title_val" type="text" value="<c:out value="${getBoardData.title }" />"/>
                        <input id="setting_title_btn" type="button" value="수정하기">
                    </div>
                    <div class="setting_input_zone">
                        <form action=""></form>
                        <span>게시판 설명</span>
                        <input id="setting_subtitle_val" type="text" value="<c:out value="${getBoardData.subtitle }" />"/>
                        <input id="setting_subtitle_btn" type="button" value="수정하기">
                    </div>
                    
                    <hr/>

                    <div class="setting_input_zone2">
                        <h4>카테고리 설정</h4>

                        <div>
                            <form action=""></form>
                            <span>상위 카테고리 생성</span>
                            <input id="setting_makeMotherCategory_val" type="text" placeholder="생성할 상위카테고리 명"/>
                            <input id="setting_makeMotherCategory_btn" type="button" value="생성하기">
                        </div>
                        <div>
                            <form action=""></form>
                            <span>하위 카테고리 생성</span>
                            <select id="setting_makeSonCategory_select">
                            	<c:forEach items="${categoryList}" var="categoryList">
				     				<c:if test="${categoryList.depth eq 1}">
                                		<option value="<c:out value="${categoryList.cno}"/>">${categoryList.category_name}</option>
				     				</c:if>
				     			</c:forEach>
                            </select>
                            <input id="setting_makeSonCategory_val" type="text" placeholder="생성할 하위카테고리 명"/>
                            <input id="setting_makeSonCategory_btn" type="button" value="생성하기">
                        </div>
                        <div>
                            <form action=""></form>
                            <span>상위 카테고리 삭제</span>
                            <select id="setting_deleteMotherCategory_val">
                                <c:forEach items="${categoryList}" var="categoryList">
				     				<c:if test="${categoryList.depth eq 1}">
                                		<option value="<c:out value="${categoryList.cno}"/>">${categoryList.category_name}</option>
				     				</c:if>
				     			</c:forEach>
                            </select>
                            <input id="setting_deleteMotherCategory_btn" type="button" value="삭제하기">
                        </div>
                        <div>
                            <form action=""></form>
                            <span>하위 카테고리 삭제</span>
                            <select id="setting_deleteSonCategory_val">
                                <c:forEach items="${categoryList}" var="categoryList">
				     				<c:if test="${categoryList.depth > 1}">
                                		<option value="<c:out value="${categoryList.cno}"/>">${categoryList.category_name}</option>
				     				</c:if>
				     			</c:forEach>
                            </select>
                            <input id="setting_deleteSonCategory_btn" type="button" value="삭제하기">
                        </div>

                    </div>

                    <hr/>

                    <div class="setting_input_zone3">
                        <form action=""></form>
                        <h4>게시판 테마 설정</h4>
                        <input type="radio" name="color" checked="checked" value="Peach" />Peach
                        <input type="radio" name="color" value="Grape" />Grape
                        <input type="radio" name="color" value="Black" />Black
                        <input type="button" value="설정하기">
                        <p class="shopFont"> # 시스템 준비중</p>
                    </div>

                    <hr/>
                    <div class="setting_input_zone4">
                        <form action=""></form>
                        <h4>커뮤니티 최상단 배너이미지</h4>
                        <input id="setting_inputTopBanner_val" type="file">
                        <input id="setting_inputTopBanner_btn" type="button" value="저장하기">
                        <p class="shopFont"> # 1300*240px 크기의 이미지를 권장합니다.</p>
                        <p class="shopFont"> # 파일을 선택하지않고 저장하면 등록된 이미지를 삭제합니다.</p>
                    </div>
                    <hr/>
                    <div class="setting_input_zone4">
                        <form action=""></form>
                        <h4>커뮤니티 메인화면 배너이미지</h4>
                        <input id="setting_inputMainBanner_val" type="file">
                        <input id="setting_inputMainBanner_btn" type="button" value="저장하기">
                        <p class="shopFont"> # 커뮤니티를 대표하는 이미지로 home화면에 출력됩니다</p>
                    </div>
                    <div id="dragZone" class="hidden">
                    </div>
                
            </div>


</main>

</body>
</html>