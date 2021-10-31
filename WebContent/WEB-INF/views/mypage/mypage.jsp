<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 
<style>
		
        .myOuter{
            width:1400px;
            height:800px;
            margin: auto;
            margin-top: 110px;
        }
        .myOuter div{box-sizing: border-box;}
        .myOuter>div{height:100%}
        .menubar{
            width:20%;
            float:left;
            
        }
        .menubar>div{
            width:90%;
            height:80%;
            border:1px solid gray;
            
        }
        .myContent{ width:80%; float:left}
        #sidenavi{
            list-style-type:none;
            font-size: 17px;
            margin-left:30px;
        }
        
        #sidenavi>li a{
            color: black;
            text-decoration: none;
            font-size: 18px;
            font-family: 'Nanum Gothic', sans-serif;
        }
        #sidenavi>li>ul li{
            list-style-type:none;
            font-size:14px;
            padding: 2px;
            margin-left:15px;
        }
        #sidenavi>li>ul a{
            text-decoration:none;
            color:black;
            font-size: 16px;
            font-family: 'Nanum Gothic', sans-serif;
        }
        #sidenavi a:hover{
            color:lightgray;
        }
</style>
</head>
<body>
	 <div class="menubar">
        <div>
        <ul id="sidenavi">
            <br><br>
            <li>MY 정보</li>
            <ul>
                 
            </ul>
       
      
</body>
</html>