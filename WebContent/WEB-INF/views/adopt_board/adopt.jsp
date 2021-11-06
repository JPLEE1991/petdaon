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
  img{
  	margin-bottom: 10px;
  	height: 190px;
  	width: 190px;
  }
</style>
<style>
  .flex {
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    list-style: none;
    padding-left: 0;
  }
  .flex li {
    /* width: 100px;
    height: 100px; */
    background-color: rgb(255, 255, 255);
    margin: 30px;
  }
  p{
  	font-size: 1em;
  	color: black;
  }

  a:link { 
  	text-decoration: none;
  }
  .content{
  	width:80%;
  }
  </style>
    
  </head>
  <body>
    
    
<header>

  <div class="title">
  	<h2>입양/임보  게시판</h2>	
  </div>
  <br />
  <br />
  <br />
  
  <!-- 검색창 
  	<form class="d-flex">
       <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
       <button class="btn btn-outline-success" type="submit">Search</button>
    </form>
  -->

  <!-- animal icon nav -->
  
<hr class="content"/>
  <ul class="flex justify-content-center">
    

    <li class="nav-item">
      <a href="https://animal.seoul.go.kr/index">
          <img src="<%= request.getContextPath() %>/images/서울 동물복지 지원센터.png" width="420"; />
          <p class="card-text">[서울 동물복지 지원센터]</p>
       
      <li class="nav-item">
      	<a href="https://www.animal.go.kr/front/awtis/institution/institutionList.do?boardId=shop&page=1&pageSize=0&regNo=&menuNo=1000000059&searchUprCd=&searchOrgCd=&searchText=">
          <img src="<%= request.getContextPath() %>/images/동물 보호 관리시스템.png" width="420"; />
			<p class="card-text">[동물 보호 관리 시스템]</p>
			
     <li class="nav-item">
      <a href="https://dmanimal.co.kr">
          <img src="<%= request.getContextPath() %>/images/도그마루 보호소.png" width="420"; />
<p class="card-text">[도그마루 보호소]</p>
    
         <li class="nav-item">
      <a href="http://www.com2petcare.co.kr/theme/daontheme_ver2_02/html/company/01.php">
          <img src="<%= request.getContextPath() %>/images/컴투펫케어.png" width="420"; />
          <p class="card-text">[컴투펫케어]</p>
        </li>

   
</li>

  </ul>
  <br />
  <hr class="content"/>
  <br />
  <ul class="flex justify-content-center">

    <li class="nav-item">
      <a href="http://flowerway-shelter.com/?n_media=27758&n_query=%EC%9C%A0%EA%B8%B0%EB%8F%99%EB%AC%BC%EB%B3%B4%ED%98%B8%EC%84%BC%ED%84%B0&n_rank=7&n_ad_group=grp-a001-01-000000018869257&n_ad=nad-a001-01-000000152369017&n_keyword_id=nkw-a001-01-000003358507448&n_keyword=%EC%9C%A0%EA%B8%B0%EB%8F%99%EB%AC%BC%EB%B3%B4%ED%98%B8%EC%84%BC%ED%84%B0&n_campaign_type=1&n_ad_group_type=1">
          <img src="<%= request.getContextPath() %>/images/꽃길 분양소.png" width="420"; />
          <p class="card-text">[꽃길 분양소]</p>
        
<li class="nav-item">
      <a href="https://www.ijoa.co.kr/home">
          <img src="<%= request.getContextPath() %>/images/아이조아.png" width="420"; />
          <p class="card-text">[아이조아]</p>
        </li>
  <li class="nav-item">
      <a href="http://daengtopia.com/?n_media=122875&n_query=%EC%9C%A0%EA%B8%B0%EB%8F%99%EB%AC%BC%EB%B3%B4%ED%98%B8%EC%84%BC%ED%84%B0&n_rank=15&n_ad_group=grp-a001-01-000000020019607&n_ad=nad-a001-01-000000144263546&n_keyword_id=nkw-a001-01-000003520445864&n_keyword=%EC%9C%A0%EA%B8%B0%EB%8F%99%EB%AC%BC%EB%B3%B4%ED%98%B8%EC%84%BC%ED%84%B0&n_campaign_type=1&n_ad_group_type=1">
          <img src="<%= request.getContextPath() %>/images/댕토피아.png" width="420"; />
          <p class="card-text">[댕토피아]</p>
        </li>


<li class="nav-item">
      <a href="https://laonshelter.co.kr/">
          <img src="<%= request.getContextPath() %>/images/라온보고서.png" width="420"; />
          <p class="card-text">[라온 보고서]</p>
        </li>



  
  </ul>
  <br />
  <hr class="content" />
  <br />
  <ul class="flex justify-content-center">

  <li class="nav-item">
      <a href="https://myohagae.com/">
          <img src="<%= request.getContextPath() %>/images/묘하개.png" width="420"; />
          <p class="card-text">[묘하개]</p>
       
   <li class="nav-item">
      <a href="http://harishelter.com/?n_media=27758&n_query=%EA%B0%95%EC%95%84%EC%A7%80%EC%9E%85%EC%96%91%EC%82%AC%EC%9D%B4%ED%8A%B8&n_rank=2&n_ad_group=grp-a001-01-000000020236437&n_ad=nad-a001-01-000000126277093&n_keyword_id=nkw-a001-01-000003541348788&n_keyword=%EA%B0%95%EC%95%84%EC%A7%80%EC%9E%85%EC%96%91%EC%82%AC%EC%9D%B4%ED%8A%B8&n_campaign_type=1&n_ad_group_type=1">
          <img src="<%= request.getContextPath() %>/images/하리네 쉼터.png" width="420"; />
          <p class="card-text">[하리네 쉼터]</p>
       
  <li class="nav-item">
      <a href="http://hibyeshelter.com/?n_media=122875&n_query=%EC%9C%A0%EA%B8%B0%EB%8F%99%EB%AC%BC%EB%B3%B4%ED%98%B8%EC%86%8C&n_rank=12&n_ad_group=grp-a001-01-000000018716771&n_ad=nad-a001-01-000000115385079&n_keyword_id=nkw-a001-01-000003339052432&n_keyword=%EC%9C%A0%EA%B8%B0%EB%8F%99%EB%AC%BC%EB%B3%B4%ED%98%B8%EC%86%8C&n_campaign_type=1&n_ad_group_type=1">
          <img src="<%= request.getContextPath() %>/images/하이바이 보호소.png" width="420"; />
  <p class="card-text">[하이바이 보호소]</p>
  
        <li class="nav-item">
      	<a href="https://www.zooseyo.com/main/main.php?">
          <img src="<%= request.getContextPath() %>/images/주세요닷컴.png" width="420"; />
			<p class="card-text">[주세요 닷컴]</p>
        
        <li class="nav-item">
      <a href="../petdaon/WepContent/WEB-INF/views/adopt_board/adoptWriting.jsp">
          
        </li>
  
  


    <script src = "../petdaon/WepContent/WEB-INF/views/adopt_board/adoptWriting.jsp"></script>
</div>
<div class="btn-w">

<br>


</div>
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<%@ include file="/WEB-INF/views/common/footer.jsp" %>    
