<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "java.io.File"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/findMe_board/Form.css" />	
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/findMe_board/map.css" />

<script>
 	function showBreed(e){
		var dog = ["닥스훈트","달마시안","도베르만","리트리버","닥스훈트","말라뮤트","말티즈","믹스견","비글","사모예드","셰퍼드","스피츠","시바","시베리안허스키","아메리칸불독","진도견","치와와","푸들","기타"];
		var cat = ["노르웨이숲","데본렉스","러시안블루","리그돌-라가머핀","맹크스","먼치킨","메인쿤","믹스","발리네즈","버만","벵갈","봄베이","기타"];
		var etc = ["모든 동물"];
		var target = document.getElementById("breed");
		
		if($("#animalType").val()=="강아지")
			var d = dog;				
		else if($("#animalType").val()=="고양이")
			var d = cat;		
		else
			var d = etc;
				
		target.options.length = 0;
		
		console.log("target: "+target);
		for(x in d){
			console.log("doing?");
			var opt = document.createElement("option");
			opt.value = d[x];
			opt.innerHTML = d[x];
			target.appendChild(opt);
		}
	}; 
	


/**
* 유효성 검사
*/


	$(() => {
		$(document.findMeBoardEnrollFrm).submit(boardValidate);
	});
	
	function boardValidate(e){
		const $title = $("[name=title]");
		const $contents = $("[name=contents]");
		//제목을 작성하지 않은 경우 폼제출할 수 없음.
		if(!/^.+$/.test($title.val())){
			alert("제목을 입력하세요.");
			return false;
		}
						   
		//내용을 작성하지 않은 경우 폼제출할 수 없음.
		// .(임의의 문자)에는 \n(개행문자)가 포함되지 않는다.
		if(!/^(.|\n)+$/.test($contents.val())){
			alert("내용을 입력하세요.");
			return false;
		}
		return true;
	}
</script>
<!--  -->
<h2>나를 찾아줘</h2>
<!--Form 제출  -->
<form
	name="findMeBoardEnrollFrm"
	action="<%=request.getContextPath() %>/findMe_board/boardEnroll"
	method="post"
	enctype="multipart/form-data">
	
	<div class="container">
		
			<!--이미지 업로드  -->
			<div id="photo">
				<img id="profile" src="<%= request.getContextPath() %>/images/findMe_sampleImg.png" alt="대표 사진" style="width:100px"/>					
				<br />
				<input 
					type="file" 
				    onchange="document.getElementById('profile').src = window.URL.createObjectURL(this.files[0])"
				    name="upFile">
			</div>
	 	
		    <!-- input 내용들 -->
		    
		    <!-- 제목  -->
		    <div class="row">
			      <label for="title" class="col-1.5 col-form-label" >제목</label>
					<div class="col-11.5">
					  <input type="text" placeholder="제목 입력" class="form-control" name="title" id="title" value="첫 글의 제목">
				    </div>    
		    	<br />
		    	<br />
		    	<br />
		  
		  
		    <!-- 연락처 -->
		    <div class="row">
		      <div class="col-4">
					<div class="form-outline mb-4">
				      <label class="form-label" for="form6Example4">연락처</label>
				      <input type="text" id="form6Example4" class="form-control" name="phone"/>
			    	</div>
			    	
			  		<!-- 분류  -->
					<div class="row">
						<div class="col-6">
							<label for="animalType" class="">분류</label>
							<select class="form-select" name="animalType" id="animalType" onchange="showBreed(this)">
							  <option value="" selected>동물을 선택해주세요</option>
							  <option value="강아지">강아지</option>
							  <option value="고양이">고양이</option>
							  <option value="기타">기타</option>
							</select>
						</div>
						<!-- 동물 종류에 따른 종 분류 script 처리 -->
						<div class="form-group col-6 mb-4">
							<label for="breed" class="">종</label>
							<select id="breed" class="form-control" name="breed">
								<option value="">선택해주세요</option>
							</select>
						</div>	
					</div>				  
				  
					<div class="row">
					
				  		<!-- 성별  -->
						<div class="form-outline mb-4 col-6">
							<label class="form-label" for="gender">성별</label>
							<select class="form-select" name="gender" id="gender" aria-label="Default select example" value="수컷" >
							  <option value="" selected>성별</option>
							  <option value="미확인">미확인</option>
							  <option value="수컷">수컷</option>
							  <option value="암컷">암컷</option>
							</select>
						</div>
						
					    <!--몸무게  -->
					    <div class="form-outline mb-4 col-6">
					      <label class="form-label" for="weight">몸무게</label>
					      <input type="number" id="weight" class="form-control" name="weight"/>
					    </div>
					</div>

			    <!-- 털색 --> 
			    <div class="form-outline mb-4">
			      <label class="form-label" for="form6Example6">털색</label>
			      <input type="text" id="form6Example6" class="form-control" name="color"/>
			    </div>
			  
			  	<!--특징 -->
			    <div class="form-outline mb-4">
			      <label class="form-label" for="form6Example6">특징</label>
			      <input type="text" id="form6Example6" class="form-control" name="character"/>
			    </div>  
			    
			  	<!--일자  -->
			  	<div class="row">
					<div class="form-outline mb-4 col-6">
						<label for="missDate" class="col-form-label">일자</label>
						<div>
							<input type="date" class="form-control" name="missDate" id="missDate">
						</div>
					</div>
					
					<div class="form-outline mb-4 col-6">
						<label for="status" class="col-form-label">상태</label>
						<select class="form-select" name="status" id="status" aria-label="Default select example" value="실종">
						  <option value="" selected>상태</option>
						  <option value="실종">실종</option>
						  <option value="목격">목격</option>
						  <option value="보호">보호</option>
						</select>
					</div>
			  	
			  	</div>
	      </div>
	      <div class="col-8">
	        <div class="form-outline">
				<p>위치공유</p>	
			<div class="map_wrap">
			    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
			
			    <div id="menu_wrap" class="bg_white">
			        <div class="option">
			            <div style="">
			                    키워드 : <input type="text" value="서울역" id="keyword" size="15"> 
			            <button onclick="searchPlaces(); return false;">검색하기</button> 
			            </div>
			        </div>
			        <hr>
			        <ul id="placesList"></ul>
			        <div id="pagination"></div>
			    </div>
			</div>
		
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=81fc3c40931e5c23dfea9c79c1a7abc4
	&libraries=services"></script>
	
	
	<script>
	// 마커를 담을 배열입니다
	var markers = [];
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places();  
	
	// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	
	// 키워드로 장소를 검색합니다
	searchPlaces();
	
	// 키워드 검색을 요청하는 함수입니다
	function searchPlaces() {
	
	    var keyword = document.getElementById('keyword').value;
	
	    if (!keyword.replace(/^\s+|\s+$/g, '')) {
	        alert('키워드를 입력해주세요!');
	        return false;
	    }
	
	    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
	    ps.keywordSearch( keyword, placesSearchCB); 
	}
	
	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {
	
	        // 정상적으로 검색이 완료됐으면
	        // 검색 목록과 마커를 표출합니다
	        displayPlaces(data);
	
	        // 페이지 번호를 표출합니다
	        //displayPagination(pagination);
	
	    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
	
	        alert('검색 결과가 존재하지 않습니다.');
	        return;
	
	    } else if (status === kakao.maps.services.Status.ERROR) {
	
	        alert('검색 결과 중 오류가 발생했습니다.');
	        return;
	
	    }
	}
	
	// 검색 결과 목록과 마커를 표출하는 함수입니다
	function displayPlaces(places) {
	
	    var listEl = document.getElementById('placesList'), 
	    menuEl = document.getElementById('menu_wrap'),
	    fragment = document.createDocumentFragment(), 
	    bounds = new kakao.maps.LatLngBounds(), 
	    listStr = '';
	    
	    // 검색 결과 목록에 추가된 항목들을 제거합니다
	    removeAllChildNods(listEl);
	
	    // 지도에 표시되고 있는 마커를 제거합니다
	    removeMarker();
	    
	    for ( var i=0; i<places.length; i++ ) {
	
	        // 마커를 생성하고 지도에 표시합니다
	        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
	            marker = addMarker(placePosition, i), 
	            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
	
	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        bounds.extend(placePosition);
	
	        // 마커와 검색결과 항목에 mouseover 했을때
	        // 해당 장소에 인포윈도우에 장소명을 표시합니다
	        // mouseout 했을 때는 인포윈도우를 닫습니다
	        (function(marker, pname, praddress, paddress, plat, plng) {
	            kakao.maps.event.addListener(marker, 'mouseover', function() {
	                displayInfowindow(marker, pname);
	            });
	
	            kakao.maps.event.addListener(map, 'mouseout', function() {
	                infowindow.close();
	            });
	            
	            // 리스트의 아이템을 클릭하면 정보들을 hidden 영역으로 전송
	            itemEl.onclick = function() {
                if (praddress) {
                document.getElementById('fulladdress').value = "[" + pname + "]" + praddress;
                } else {
                document.getElementById('fulladdress').value = "[" + pname + "]" + paddress;
                }
            	
            	document.getElementById('pname').value = pname;            	
                if (praddress) {
                	document.getElementById('paddress').value = praddress;
                } else {
                	document.getElementById('paddress').value = paddress; 
                }
            	document.getElementById('latclick').value = plat;
            	document.getElementById('lngclick').value = plng;
        	    };
            
	            itemEl.onmouseover =  function () {
	                displayInfowindow(marker, pname);
	            };
	
	            itemEl.onmouseout =  function () {
	                infowindow.close();
	            };
	        })(marker, places[i].place_name, [i].road_address_name, places[i].address_name, places[i].y, places[i].x);
	
	        fragment.appendChild(itemEl);
	    }
	
	    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
	    listEl.appendChild(fragment);
	    menuEl.scrollTop = 0;
	
	    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	    map.setBounds(bounds);
	}
	
	// 검색결과 항목을 Element로 반환하는 함수입니다
	function getListItem(index, places) {
	
	    var el = document.createElement('li'),
	    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
	                '<div class="info" style="cursor:pointer;">' +
	                '   <h5>' + places.place_name + '</h5>';
	
	    if (places.road_address_name) {
	        itemStr += '    <span>' + places.road_address_name + '</span>' +
	                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
	    } else {
	        itemStr += '    <span>' +  places.address_name  + '</span>'; 
	    }
	      itemStr += '  <span class="tel">' + places.phone + '</span>'; +
	                '</div>';           
	
	    el.innerHTML = itemStr;
	    el.className = 'item';
	
	    return el;
	}
	
	
	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, idx, title) {
	    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
	        imgOptions =  {
	            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
	            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	        },
	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	            marker = new kakao.maps.Marker({
	            position: position, // 마커의 위치
	            image: markerImage 
	        });
	
	    marker.setMap(map); // 지도 위에 마커를 표출합니다
	    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
	
	    return marker;
	}
	
	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}
	
	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker, title) {
	    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
	
	    infowindow.setContent(content);
	    infowindow.open(map, marker);
	}
	
	 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {   
	    while (el.hasChildNodes()) {
	        el.removeChild (el.lastChild);
	    }
	}
	</script>
		
    <!-- 위도 및 경도 좌표 및 위치정보 넘기기. -->
	    <div>
		    <input type="text" id="fulladdress" name="fulladdress" style="width:90%;" disabled> 
		    <input type="text" id="pname" name="pname" value="">   
		    <input type="text" id="paddress" name="paddress" value="">  
		    <input type="text" id="latclick" name="latclick" value=""> 
		    <input type="text" id="lngclick" name="lngclick" value=""> 
	    </div>
				
				
	        </div>
	      </div>
	    </div>	
	  
		<div class="mb-2 row">

			
<!-- 			<label for="day" class="col-sm-1 col-form-label">완료여부</label>
			<div class="col-sm-4">
				<select class="form-control col-6 disabled" name="day" id="day" aria-label="Default select example" disabled required>
				  <option value="" selected>진행</option>
				  <option value="완료">완료</option>
				</select>
			</div> -->
			
		</div>
	  
	   <!-- 내용 input -->
	    <div class="form-outline mb-4">
	      <textarea class="form-control" rows="4" placeholder="내용을 입력해주세요" name="content"></textarea>
	    </div>				
				
	  
	  
	    <!-- Submit button -->
	    <button type="submit" class="btn btn-primary btn-block mb-2">저장</button>
	</div>
</form>   




</body>
</html>