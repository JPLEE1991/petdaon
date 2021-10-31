<%@page import="com.petdaon.mvc.findMe_board.model.vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "java.io.File"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/findMe_board/map.css" />

<%
	Board board = (Board) request.getAttribute("board");
%>

<script>
const updateBoard = 
() => location.href = "<%= request.getContextPath() %>/findMe_board/boardUpdate?no=<%= board.getNo() %>";
/**
 * 삭제할 때 저장된 첨부파일이 있다면, 파일삭제!
 * - java.io.File API참조
 */
const deleteBoard = () => {
	if(confirm("정말 이 게시물을 삭제하시겠습니까?")){
		$(document.deleteBoardFrm).submit();
	}
};
</script>



<style>
#menu_wrap{
	visibility: hidden;
}
img {
    width: 100%;
    border-radius: 15px;
}
</style>
<div class="container">
	<h2>나를 찾아줘</h2>
<hr class="my-3" />
	
		<div class="row">
<!--지도영역 시작  -->
	      <div class="">
	        <div class="form-outline">
				<p>신고 위치</p>	
<hr class="my-3" />
				
			<div class="map_wrap">
			    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
			
			    <div id="menu_wrap" class="bg_white">
			        <div class="option">
			            <div style="">
			                    키워드 : <input type="text" value="<%= board.getAddress() %>" id="keyword" size="15"> 
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
	    //+마커 1개만 표시
	    for ( var i=0; i<1; i++ ) {
	
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

	        </div>
	      </div>
	      
<!--지도 영역 끝  -->
		</div>
	      <hr class="my-3" />
	
	
	
	
		<div class="row">
			<div class="col-6 mr-3">
			<!--이미지 불러오기  -->
<% 	if(board.getAttach() != null){ %>
				<%-- 첨부파일이 있을경우만, 이미지와 함께 original파일명 표시 --%>
				<img alt="첨부파일" src="<%= request.getContextPath() %>/upload/findMe_board/<%= board.getAttach().getRenamedFilename() %>" >
<% 	} else { %>
				<img class="" src="<%= request.getContextPath() %>/images/findMe_sampleImg.png" alt=""/>
<% } %>		
			</div>
			
			<div class="col-6 row justify-content-center align-self-center">
				<table class="table">
				  <thead>
				    <tr>
				      <th colspan="4" style="text-align: center"><%= board.getTitle() %></th>
				    </tr>
				  </thead>
				  <tbody>
				  	<tr>
				      <th scope="row">상태</th>
				      <td><%= board.getStatus() %></td>
				      <th>완료여부</td>
				      <td><%= board.getCompleYN()=="Y"?"완료":"진행중" %></td>
				    </tr>
				    <tr>
				      <th scope="row">작성자</th>
				      <td colspan="3"><%= board.getWriter() %></td>
				    </tr>				  
				    <tr>
				      <th scope="row">연락처</th>
				      <td colspan="3"><%= board.getPhone() %></td>
				    </tr>
				    <tr>
				      <th scope="row">분류</th>
				      <td><%= board.getAnimalType() %></td>
				      <th>종</td>
				      <td><%= board.getBreed() %></td>
				    </tr>
				    <tr>
				      <th scope="row">성별</th>
				      <td><%= board.getGender() %></td>
				      <th>몸무게</td>
				      <td><%= board.getWeight() %> kg</td>
				    </tr>
				    <tr>
				      <th scope="row">털색</th>
				      <td colspan="3"><%= board.getColor() %></td>
				    </tr>
				   	<tr>
				      <th scope="row">특징</th>
				      <td colspan="3"><%= board.getCharacter() %></td>
				    </tr>
				    <tr>
				      <td colspan="4" ><%= board.getContent() %></th>
				    </tr>		
				  </tbody>
				</table>
			<button type="button" class="btn btn-primary btn-lg" onclick="updateBoard()">수정</button>
			
			<button type="button" class="btn btn-primary btn-lg" onclick="deleteBoard()">삭제</button>
			
			
			</div>

		</div>
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />

</div>


