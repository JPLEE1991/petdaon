<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>    
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>adopt</title>
</head>
<body>
<!------ Include the above in your HEAD tag ---------->
<style>
  .bd-placeholder-img {
    font-size: 1.125rem;
    text-anchor: middle;
    -webkit-user-select: none;
    -moz-user-select: none;
    user-select: none;
  }

  @media (min-width: 768px) {
    .bd-placeholder-img-lg {
      font-size: 3.5rem;
    }
  }
  .collapse navbar-collapse justify-content-center {
    display: flex;
    flex-direction:row;
    justify-content: space-around;
   
  }
  .nav-item {
  	margin: 30px;
  }
  .nav-item>a {
  	text-align:center;
  }
  .title>h2 {
  	display: flex;
  	justify-content: center;
  }
  
  .d-flex {
  	display: inline;
  }
</style>
<style>
  .flex {
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    border: 2px solid gray;
    list-style: none;
    padding-left: 0;
  }
  .flex li {
    /* width: 100px;
    height: 100px; */
    background-color: rgb(255, 255, 255);
    margin: 5px;
  }
  </style>
    
  </head>
  <body>
    
    
<header>
  <div class="title">
  	<h2>입양/임보  게시판</h2>	
  </div>
  
  <!-- 검색창 
  	<form class="d-flex">
       <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
       <button class="btn btn-outline-success" type="submit">Search</button>
    </form>
  -->

  <!-- animal icon nav -->
  
  <ul class="flex flex1">
    
    <li>

      <img src="<%= request.getContextPath() %>/images/all.png" width="420"; />

      <a class="nav-link" href="#">전체</a>
    
    <li>
      <img src="<%= request.getContextPath() %>/images/dog.png" width="420"; />
      <a class="nav-link" href="#">강아지</a>
    
    <li>
      <img src="<%= request.getContextPath() %>/images/cat.png" width="420"; />
      <a class="nav-link" href="#">고양이</a>
    </li>
  
  </ul>
  <ul class="flex flex2">
    

      <li class="nav-item">
      <a href="https://www.zooseyo.com/main/main.php?">
          <img src="<%= request.getContextPath() %>/images/주세요닷컴.png" width="420"; />
<p class="card-text">주세요 닷컴</p>
     <li class="nav-item">
      <a href="https://dmanimal.co.kr">
          <img src="<%= request.getContextPath() %>/images/도그마루 보호소.png" width="420"; />
<p class="card-text">도그마루 보호소</p>
      
    <li>
     
    <li class="nav-item">
      <a href="www.minipetmall.co.kr/pc/review/review_030100.html">
          <img src="<%= request.getContextPath() %>/images/미니펫.png" width="420"; />
          <p class="card-text">미니펫</p>
        </li>
        
         <li class="nav-item">
      <a href="http://www.sinsadog.com/?n_media=27758&n_query=%EA%B0%95%EC%95%84%EC%A7%80%EC%9E%85%EC%96%91%EC%82%AC%EC%9D%B4%ED%8A%B8&n_rank=9&n_ad_group=grp-a001-01-000000008843986&n_ad=nad-a001-01-000000142583531&n_keyword_id=nkw-a001-01-000001647971233&n_keyword=%EA%B0%95%EC%95%84%EC%A7%80%EC%9E%85%EC%96%91%EC%82%AC%EC%9D%B4%ED%8A%B8&n_campaign_type=1&n_ad_group_type=1&NaPm=ct%3Dkvhbjzts%7Cci%3D0zO0000OtC1vJWIqYuZD%7Ctr%3Dsa%7Chk%3D3af178f94964d4bf626d9034d8eb6afcd045043a">
          <img src="<%= request.getContextPath() %>/images/신사독.png" width="420"; />
          <p class="card-text">신사독</p>
        </li>

   
</li>

  </ul>
  
  <ul class="flex flex3">

      <li class="nav-item">
      <a href="www.dog-zzang.co.kr/main/main.php?kwqy=N%25EA%25B0%2595%25EC%2595%2584%25EC%25A7%2580%25EC%259E%2585%25EC%2596%2591%25EC%2582%25AC%25EC%259D%25B4%25ED%258A%25B8">
          <img src="<%= request.getContextPath() %>/images/도그짱.png" width="420"; />
          <p class="card-text">도그짱</p>
        </li>
  <li class="nav-item">
      <a href="ulovepetshelter.co.kr/level">
          <img src="<%= request.getContextPath() %>/images/유럽펫보호소.png" width="420"; />
          <p class="card-text">유럽펫보호소</p>
        </li>


<li class="nav-item">
      <a href="https://laonshelter.co.kr/">
          <img src="<%= request.getContextPath() %>/images/라온보고서.png" width="420"; />
          <p class="card-text">라온 보고서</p>
        </li>
<li class="nav-item">
      <a href="www.animals.or.kr/center/adopt?utm_source=naver&utm_medium=sa&utm_campaign=pc&utm_content=%EC%9E%85%EC%96%91&utm_term=%EA%B0%95%EC%95%84%EC%A7%80%EC%9E%85%EC%96%91%EC%82%AC%EC%9D%B4%ED%8A%B8&n_media=122875&n_query=%EA%B0%95%EC%95%84%EC%A7%80%EC%9E%85%EC%96%91%EC%82%AC%EC%9D%B4%ED%8A%B8&n_rank=6&n_ad_group=grp-a001-01-000000015617002&n_ad=nad-a001-01-000000095276356&n_keyword_id=nkw-a001-01-000002932495589&n_keyword=%EA%B0%95%EC%95%84%EC%A7%80%EC%9E%85%EC%96%91%EC%82%AC%EC%9D%B4%ED%8A%B8&n_campaign_type=1&n_ad_group_type=1&NaPm=ct%3Dkvhbm47s%7Cci%3D0z40002ltC1v8SWXQvi5%7Ctr%3Dsa%7Chk%3D18ce0435e5cc56c6af092ed931d8e5ad51cc6622/">
          <img src="<%= request.getContextPath() %>/images/동물 자유연대.png" width="420"; />
          <p class="card-text">동물 자유연대</p>
        </li>



  
  </ul>
  <ul class="flex flex3">

  <li class="nav-item">
      <a href="https://www.ijoa.co.kr/44">
          <img src="<%= request.getContextPath() %>/images/아이조아.png" width="420"; />
          <p class="card-text">아이조아</p>
        </li>
   <li class="nav-item">
      <a href="http://harishelter.com/?n_media=27758&n_query=%EA%B0%95%EC%95%84%EC%A7%80%EC%9E%85%EC%96%91%EC%82%AC%EC%9D%B4%ED%8A%B8&n_rank=2&n_ad_group=grp-a001-01-000000020236437&n_ad=nad-a001-01-000000126277093&n_keyword_id=nkw-a001-01-000003541348788&n_keyword=%EA%B0%95%EC%95%84%EC%A7%80%EC%9E%85%EC%96%91%EC%82%AC%EC%9D%B4%ED%8A%B8&n_campaign_type=1&n_ad_group_type=1">
          <img src="<%= request.getContextPath() %>/images/하리네 쉼터.png" width="420"; />
          <p class="card-text">하리네 쉼터</p>
        </li>
  <li class="nav-item">
      <a href="ttp://puppynu.co.kr/?n_media=27758&n_query=%EA%B0%95%EC%95%84%EC%A7%80%EC%9E%85%EC%96%91%EC%82%AC%EC%9D%B4%ED%8A%B8&n_rank=6&n_ad_group=grp-a001-01-000000019690106&n_ad=nad-a001-01-000000122282939&n_keyword_id=nkw-a001-01-000003466012448&n_keyword=%EA%B0%95%EC%95%84%EC%A7%80%EC%9E%85%EC%96%91%EC%82%AC%EC%9D%B4%ED%8A%B8&n_campaign_type=1&n_ad_group_type=1&NaPm=ct%3Dkvge0jgo%7Cci%3D0yK0000zCBXvoS%5F9iuYE%7Ctr%3Dsa%7Chk%3Da3594b4fddb7533d6318eacb060195f0cdbf4dd2">
          <img src="<%= request.getContextPath() %>/images/퍼피앤유.png" width="420"; />
  <p class="card-text">퍼피앤유</p>
  
        
        <li class="nav-item">
      <a href="http://www.babymong.co.kr/shop/main/index.php?n_media=122875&n_query=%EA%B0%95%EC%95%84%EC%A7%80%EC%9E%85%EC%96%91%EC%82%AC%EC%9D%B4%ED%8A%B8&n_rank=11&n_ad_group=grp-m001-01-000001835836090&n_ad=nad-a001-01-000000131450203&n_keyword_id=nkw-m001-01-000001835836169&n_keyword=%EA%B0%95%EC%95%84%EC%A7%80%EC%9E%85%EC%96%91%EC%82%AC%EC%9D%B4%ED%8A%B8&n_campaign_type=1&n_ad_group_type=1&NaPm=ct%3Dkvhboe08%7Cci%3D0zK00001tS1v1uySNvmI%7Ctr%3Dsa%7Chk%3D1cb89bb8abe39835836a5931007f97a98703875b">
          <img src="<%= request.getContextPath() %>/images/베이비 몽.png" width="420"; />
          <p class="card-text">베이비 몽</p>
        </li>
        
        <li class="nav-item">
      <a href="../petdaon/WepContent/WEB-INF/views/adopt_board/adoptWriting.jsp">
          
        </li>
  
  


    <script src = "../petdaon/WepContent/WEB-INF/views/adopt_board/adoptWriting.jsp"></script>
</div>
<div class="btn-w">

<br>
<input type="button" class="btn btn-outline-secondary" value="입양/임보페이지 추가" id="btn-add" onclick="location.href='<%= request.getContextPath() %>/adopt_board/adoptWriting" />


</div>
<!-- <%@ include file="/WEB-INF/views/common/footer.jsp" %> --> 