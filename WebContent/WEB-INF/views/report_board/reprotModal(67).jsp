<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        body{
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
        }
        button{
            all:unset;
            background-color: rgb(8, 8, 0);
            color: white;
            padding: 5px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        .modal{
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }
        .modal_overlay{
            background-color: rgba(0, 0, 0, 0.6);
            width: 100%;
            height: 100%;
            position: absolute;
        }
        .modal_content{
            background-color: white;
            padding:50px 100px;
            text-align: center;
            position: relative;
            border-radius: 10px;
            width: 10%;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.19), 0 6px 6px rgba(0,0,0,0.23);
        }

        h1{
            margin: 0;
        }

        .hidden{
            display:none;
        }
        
        </style>
</head>
<body>
    <button>신고하기</button>
    <div class="modal">
        <div class="modal_overlay"></div>
        <div class="modal_content">
            <h1>신고사유</h1>
            <button> OK </button>
        </div>
            <h1></h1>
    </div>
    <script>
        const openButton = document.getElementById("open");
        const modal = document.querySelector(".modal");
        const overlay = modal.querySelector(".modal__overlay");
        const closeBtn = modal.querySelector("button");
        const openModal = () =>{
            modal.classList.remove("hidden");
        }
        const closeModal = () =>{
            modal.classList.add("hidden");
        }
        overlay.addEventListener("click", closeModal);
        closeBtn.addEventListener("click", closeModal);
        openButton.addEventListener("click", openModal);

    </script>
</body>
</html>