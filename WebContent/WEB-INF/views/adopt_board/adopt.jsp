<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Gallery</title>
</head>
<body>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<%@ include file="/WEB-INF/views/common/header.jsp" %>

 <!-- Bootstrap core CSS -->
<link href="/docs/5.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <!-- Favicons -->
<link rel="apple-touch-icon" href="/docs/5.1/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/5.1/assets/img/favicons/manifest.json">
<link rel="mask-icon" href="/docs/5.1/assets/img/favicons/safari-pinned-tab.svg" color="#7952b3">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon.ico">
<meta name="theme-color" content="#7952b3">


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

    
  </head>
  <body>
    
<header>
  <div class="collapse bg-dark" id="navbarHeader">
    <div class="container">
      <div class="row">
        <div class="col-sm-8 col-md-7 py-4">
          <h4 class="text-white">About</h4>
          <p class="text-muted">Add some information about the album below, the author, or any other background context. Make it a few sentences long so folks can pick up some informative tidbits. Then, link them off to some social networking sites or contact information.</p>
        </div>
        <div class="col-sm-4 offset-md-1 py-4">
          <h4 class="text-white">Contact</h4>
          <ul class="list-unstyled">
            <li><a href="#" class="text-white">Follow on Twitter</a></li>
            <li><a href="#" class="text-white">Like on Facebook</a></li>
            <li><a href="#" class="text-white">Email me</a></li>
          </ul>
        </div>
      </div>
    </div>
  </div>
  
  <div class="title">
  	<h2>입양/임보 게시판</h2>	
  </div>
  
  <!-- 검색창 
  	<form class="d-flex">
       <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
       <button class="btn btn-outline-success" type="submit">Search</button>
    </form>
  -->

  <!-- animal icon nav -->
  <nav class="navbar navbar-expand-lg navbar-light container justify-content-end">
    <div class="collapse navbar-collapse justify-content-center">
      <ul class="navbar-nav">
        <li class="nav-item">
          <img src="<%= request.getContextPath() %>/images/all.png" width="70"; />
          <a class="nav-link" href="<%= request.getContextPath() %>/findMe_board/boardList">전체</a>
        </li>
        <li class="nav-item">
          <img src="<%= request.getContextPath() %>/images/pet.png" width="70";/>
          <a class="nav-link" href="#">강아지</a>
        </li>
        <li class="nav-item">
          <img src="<%= request.getContextPath() %>/images/cat.png" width="70"; />
          <a class="nav-link" href="#">고양이</a>
        </li>
       
      </ul>
    </div>
  </nav>
</header>

<main>

  <div class="album py-5 bg-light">
    <div class="container">

      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3"></div>
        <div class="col">
          <div class="card shadow-sm">
           

            <div class="card-body">
              <a href="link"><img src="images/미니핀.jpg/"></a>
              <p class="card-text">미니핀 "똘똘이" 강아지</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">조회수</button>
             
                </div>
           
              </div>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="card shadow-sm">
          

            <div class="card-body">
              <a href="link"><img src="images/친칠라 믹스.jpg/"></a>
              <p class="card-text">친칠라 믹스 "꼬미" 고양이</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">조회수</button>
       
                </div>
     
              </div>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="card shadow-sm">
           
            <div class="card-body">
              <a href="link"><img src="images/믹스견.jpg/"></a>
              <p class="card-text">믹스견 "복실이" 강아지</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">조회수</button>
                
                </div>
               
              </div>
            </div>
          </div>
        </div>

        <div class="col">
          <div class="card shadow-sm">

            <div class="card-body">
              <a href="link"><img src="images/코숏.jpg/"></a>
              <p class="card-text">코숏 "태희" 고양이</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">조회수</button>
       
                </div>
         
              </div>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="card shadow-sm">

            <div class="card-body">
              <a href="link"><img src="images/코숏1.jpg/"></a>
              <p class="card-text">코숏 "이월이" 고양이</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">조회수</button>
  
                </div>
  
              </div>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="card shadow-sm">

            <div class="card-body">
              <a href="link"><img src="images/페르시안친칠라.jpg/"></a>
              <p class="card-text">페르시안 친칠라 "프루" 고양이</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">조회수</button>
 
                </div>
                
              </div>
            </div>
          </div>
        </div>

        <div class="col">
          <div class="card shadow-sm">

            <div class="card-body">
              <a href="link"><img src="images/비숑.jpg/"></a>
              <p class="card-text">비숑 "까불이" 강아지</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">조회수</button>
                </div>
                
              </div>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="card shadow-sm">

            <div class="card-body">
              <a href="link"><img src="images/비숑1.jpg/"></a>
              <p class="card-text">비숑 "누리" 강아지</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">조회수</button>        
                </div>      
              </div>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="card shadow-sm">

            <div class="card-body">
              <a href="link"><img src="images/믹스견1.jpg/"></a>
              <p class="card-text">믹스견 "크림이" 강아지</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">조회수</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

</main>





<!-- <%@ include file="/WEB-INF/views/common/footer.jsp" %> --> 