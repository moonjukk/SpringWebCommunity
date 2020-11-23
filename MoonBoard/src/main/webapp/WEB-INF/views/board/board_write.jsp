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
#writeBox form select{
                width: 100%; 
                font-size: 16px; 
                padding: 11px 10px;
                margin-top: 15px;
                border: 1px solid rgb(226, 226, 226);
            }
            #writeBox form input[type='text']{
                width: 96%; 
                font-size: 16px; 
                font-weight: 600;
                padding: 10px 15px;
                margin-top: 20px; 
                border: 1px solid rgb(226, 226, 226);
            }
            #writeBox form input[type='file']{
                border: 1px solid rgb(226, 226, 226);
                width: 90%; 
                font-size: 14px; 
                padding: 8px 15px;
                margin-top: 20px; 
            }

            #dragZone{
                width: 92%;
                height: 150px;
                padding: 5px !important;
                padding-left: 8px !important;
                border: 1px solid rgb(182, 182, 182);
                background-color: rgb(240, 240, 240);
                border-bottom-left-radius: 8px;
                border-top: none;
                color: rgb(70, 70, 70);
                overflow-y: scroll;
            }
            #dragZone span{
                float: right;
                background-color: rgb(255, 255, 255);
                padding: 5px;
                border: 1px solid rgb(168, 168, 168);
                border-radius: 4px;
            }
            #dragZone div{
                width: 100%;
                height: 27px;
                padding-top: 3px;
                border-bottom: 1px solid rgb(163, 163, 163);
            }
            #dragZone div a{
                text-decoration: none;
                color: #001C3C;
                cursor: pointer;
            }
            #dragZoneOpen{
                font-size: 22px;
            }
            textarea{
                margin-top: 15px;
                border: 1px solid rgb(226, 226, 226);
                width: 97%;
                height: 240px;
                padding: 10px;
            }
            #formBtnZone{
                width: 100%;
                margin-top: 20px;
            }
            #formBtnZone input{
                padding: 11px 28px;
                border: 1px solid rgb(180, 180, 180);
                background-color: white;
            }
            #formBtnZone input:hover{
                cursor: pointer;
                border: 1px solid rgb(0, 0, 0);
            }
            #formBtnZone input[type='button']{
                margin-left: 320px;
            }
            #formBtnZone input[type='submit']{
                margin-left: 10px;
            }
</style>

<script>
    $(document).ready(function(){
        var dragZoneFlag = false;
        $('#dragZoneOpen').click(function(e){
            if(dragZoneFlag == false){
                $('#dragZone').removeClass('hidden');
                $('.thumbInfo').removeClass('hidden');
                $('#dragZoneOpen').html('▲');
                dragZoneFlag = true;
            }
            else{
                $('#dragZone').addClass('hidden');
                $('.thumbInfo').addClass('hidden');
                $(this).html('▼');
                dragZoneFlag = false;
            }
        });

        // 이미지 드래그 존 안내 배너 닫기버튼
        $('.closeBtn').click(function(){
            $('#dragZone span').addClass('hidden');
        });
        // 파일 등록 후 삭제 하기 버튼구현 -> delegation
        $('#dragZone').delegate(".fileDeleteBtn", "click", function(){
            //$(this).closest('div').remove();
            if(confirm("정말 삭제하시겠습니까?")){
            	$(this).closest('div').remove();
            	fileCnt--;
            }
        });
        
        function checkList(){
        	return true;
        }
        
     // 등록하기 버튼 이벤트
        $("input[type='submit']").click(function(e){
        	
            e.preventDefault();
            e.stopPropagation();
            
        	// 정상적으로 input값들이 채워졌는지 확인
        	if(checkList()){
        		var str = "";
        		var thumbnailUUID = $('input[type="checkbox"]:checked').val();
                $('#dragZone div .getImageList').each(function(i, obj){
                	var jobj = $(obj);
                	
                	str += "<input type='hidden' name='imagelist["+i+"].filename' value='"+jobj.data("filename")+"'>";
                	str += "<input type='hidden' name='imagelist["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
                	str += "<input type='hidden' name='imagelist["+i+"].uploadpath' value='"+jobj.data("uploadpath")+"'>";
                	
                });
                $('form').append(str).submit();
        	}
        });


        var fileCnt = 0;
        $("input[type='file']").change(function(){
            // 멀티파일 적용
            var fileInput = document.getElementById("fileSelector");
            var files = fileInput.files;
                
            var formData = new FormData();
            for (var i = 0; i < files.length; i++) {
                if(!checkExtension(files[i].name,1000)){
                    $(this).val("");
                    return false;
                }else{
                    //var str = dragFile(files[i].name);
                    $('#dragZone').removeClass('hidden');
                    //$('.thumbInfo').removeClass('hidden');
                    $('#dragZoneOpen').html('▲');
                    dragZoneFlag = true;
                    //$('#dragFileZone').append(str);
                    $('#dragFile span').addClass('hidden');
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
            
       

            $('#dragZone').on("dragenter dragover",function(e){
                e.preventDefault();//파일이 새롭게 열리는 것을 막는다.
            });
            $('#dragZone').on("drop",function(e){
		        e.preventDefault();//파일이 새롭게 열리는 것을 막는다. 
                $('#dragFileZone span').addClass('hidden');
                var files=e.originalEvent.dataTransfer.files;
        		//formData객체에 업로드할 파일들을 추가
                var formData = new FormData();
                for(var i=0; i<files.length; i++){
                    if(!checkExtension(files[i].name,files[i].size)){
                        return false;
                    }else{
                        formData.append("uploadFile", files[i]);
                        fileCnt++;
                    }
                }
                
                // ajax처리
                
                $.ajax({
                	url: '/board/registerfiles',
                	processData:false,
                	contentType:false,
                	beforeSend: function(xhr){
                		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                	},
        			data:formData,
        			type:'POST',
        			dataType:'json',
        			success:function(result){
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
        		uploadResult.append(str);
        		
        	}
    });
</script>

<main>
            <div id="writeBox" class="">
                <form action="/board/write" method="POST">
                	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                	<input type="hidden" name="writer_userid" value="<sec:authentication property="principal.username"/>"/>
                    <select id="input_category" name="cno">
                        <option value="0">게시판을 선택해주세요</option>
                        <c:forEach items="${categoryList2}" var="categoryList">
		     				<c:if test="${categoryList.depth eq 1}">
		     					<option value="0"> ======= ${categoryList.category_name} ======= </option>
		     				</c:if>
		     				<c:if test="${categoryList.depth > 1}">
		     					<option value="${categoryList.cno}"> ${categoryList.category_name} </option>
		     				</c:if>
		     			</c:forEach>
                    </select>
                    <input id="input_title" name="title" type="text" placeholder="제목" >
                    
                    <input type="file" id="fileSelector" multiple>
                    <span id="dragZoneOpen">▼</span>
                    <div id="dragZone" class="hidden">
                        <span class="">파일을 드래그해주세요 <i class="far fa-times-circle closeBtn"></i></span>
                        <!--
                        <div>
	                    	<input type="checkbox" name="thumbnail" value="파일의uuid">
	                        <i class="far fa-images"></i>
	                        { 파일명 }
	                        <i class="far fa-times-circle fileDeleteBtn"></i>
	                    </div>
	                    -->
                    </div>

                    <textarea name="content" id="input_content" placeholder="명예 훼손, 허위 정보, 개인 정보 등 운영정책 위반 게시글 등록 시 이용이 제한 될 수 있습니다."></textarea>
					
					<input type="hidden" name="bno" value="<c:out value="${getBoardData.no }" />">
					<input type="hidden" name="writer_userid" value='<sec:authentication property="principal.username"/>' readonly/>
	                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	                
                    <div id="formBtnZone">
                        <input type="button" value="취소">
                        <input type="submit" value="등록">
                    </div>
                    
                </form>
            </div>


        </main>

    </div>
</body>
</html>