<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Home Page</title>

    <!-- External Libraries -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap">
    <link rel="stylesheet" href="https://mdbootstrap.com/previews/ecommerce-demo/css/mdb-pro.min.css">
    <link rel="stylesheet" href="https://mdbootstrap.com/previews/ecommerce-demo/css/mdb.ecommerce.min.css">

    <!-- Custom Styles -->
    <link href="css/style.css" rel="stylesheet" type="text/css"/>

    <style>
        /* Carousel styling */
        #introCarousel, .carousel-inner, .carousel-item, .carousel-item.active {
            height: 100vh;
        }
        .carousel-item:nth-child(1) {
            background-image: url('https://cdnb.artstation.com/p/assets/images/images/045/265/153/large/world-of-gaming-sports-banner.jpg?1642330191');
            background-repeat: no-repeat;
            background-size: 100% 100%;
            background-position: center center;
        }
        .carousel-item:nth-child(2) {
            background-image: url('https://th.bing.com/th/id/R.cab845dba76c581f5d45f54748720cb1?rik=l0Itc67wDt5Kfw&pid=ImgRaw&r=0');
            background-repeat: no-repeat;
            background-size: 100% 100%;
            background-position: center center;
        }
        .carousel-item:nth-child(3) {
            background-image: url('https://i.pinimg.com/originals/fa/45/96/fa4596ad9a9d39901eeb455ed4f74e44.jpg');
            background-repeat: no-repeat;
            background-size: 100% 100%;
            background-position: center center;
        }
        @media (min-width: 992px) {
            #introCarousel {
                margin-top: -58.59px;
            }
        }
        .navbar .nav-link {
            color: #fff !important;
        }

/* Chatbot styling */
.chat-wrapper {
    position: fixed;
    bottom: 20px;
    right: 20px;
    z-index: 1000;
}
.chat-container {
    background-color: #fff;
    border-radius: 20px; /* Bo tròn hơn */
    box-shadow: 0 5px 25px rgba(0, 0, 0, 0.15); /* Bóng đổ mềm mại */
    overflow: hidden;
    transition: all 0.3s ease-in-out; /* Animation mượt mà */
    display: flex;
    flex-direction: column;
}
.chat-container.minimized {
    width: 50px; /* Kích thước nhỏ gọn */
    height: 50px;
    border-radius: 50%;
    background: linear-gradient(135deg, #4285F4, #34C759); /* Gradient hiện đại */
    cursor: pointer;
}
.chat-container.maximized {
    width: 320px; /* Chiều rộng vừa phải */
    height: 70vh; /* Chiều cao hợp lý */
    max-height: 450px; /* Giới hạn chiều cao */
}
.chat-header {
    background: linear-gradient(135deg, #262626, #262626); /* Gradient cho header */
    color: white;
    padding: 12px;
    text-align: center;
    font-family: 'Roboto', sans-serif; /* Font hiện đại */
    font-weight: 500;
    font-size: 16px;
    cursor: pointer;
    position: relative;
    border-top-left-radius: 20px;
    border-top-right-radius: 20px;
    transition: background 0.3s ease;
}
.chat-header:hover {
    background: linear-gradient(135deg, #6c757d, #dc3545); /* Hiệu ứng hover */
}
.chat-messages {
    flex: 1;
    overflow-y: auto;
    padding: 15px;
    background-color: #f9f9fb; /* Màu nền nhẹ */
    display: none;
}
.chat-container.maximized .chat-messages {
    display: block;
}
.message {
    padding: 10px 15px;
    border-radius: 20px; /* Bo tròn hơn */
    margin-bottom: 10px;
    max-width: 75%;
    word-wrap: break-word;
    font-family: 'Roboto', sans-serif;
    font-size: 14px;
    line-height: 1.4;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05); /* Bóng đổ nhẹ */
    transition: transform 0.2s ease; /* Hiệu ứng khi hover */
}
.message:hover {
    transform: translateY(-2px); /* Nhấc nhẹ khi hover */
}
.user-message {
    background: linear-gradient(135deg, #262626, #262626); /* Gradient cho tin nhắn người dùng */
    color: white;
    margin-left: auto;
    border-bottom-right-radius: 5px;
}
.ai-message {
    background-color: #e8ecef; /* Màu nền nhẹ nhàng */
    color: #333;
    margin-right: auto;
    border-bottom-left-radius: 5px;
}
.chat-input {
    display: none;
    padding: 15px;
    background-color: #fff;
    border-top: 1px solid #eee;
}
.chat-container.maximized .chat-input {
    display: flex;
}
.chat-input form {
    display: flex;
    width: 100%;
    gap: 10px; /* Khoảng cách giữa input và button */
}
.chat-input input {
    flex: 1;
    padding: 10px 15px;
    border: 1px solid #ddd;
    border-radius: 25px; /* Bo tròn hơn */
    outline: none;
    font-family: 'Roboto', sans-serif;
    font-size: 14px;
    transition: border-color 0.3s ease;
}
.chat-input input:focus {
    border-color: #4285F4; /* Đổi màu viền khi focus */
}
.chat-input button {
    background: linear-gradient(135deg, #262626, #262626); /* Gradient cho nút */
    color: white;
    border: none;
    border-radius: 25px;
    padding: 10px 20px;
    cursor: pointer;
    font-family: 'Roboto', sans-serif;
    font-weight: 500;
    font-size: 14px;
    transition: background 0.3s ease, transform 0.2s ease;
}
.chat-input button:hover {
    background: linear-gradient(135deg, #262626, #262626);
    transform: translateY(-2px); /* Nhấc nhẹ khi hover */
}
.timestamp {
    font-size: 0.65em;
    color: #777;
    margin-top: 5px;
    font-family: 'Roboto', sans-serif;
}
.message-content {
    white-space: pre-wrap;
}
.chat-icon {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100%;
    font-size: 22px; /* Kích thước icon vừa phải */
    color: white;
}
.chat-container.minimized .chat-header {
    padding: 0;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
}
.chat-container.minimized .chat-header span {
    display: none;
}
    </style>
</head>
<body class="skin-light" onload="loadAmountCart()">
    <jsp:include page="Menu.jsp"></jsp:include>

    <!-- Carousel wrapper -->
    <div id="introCarousel" class="carousel slide carousel-fade shadow-2-strong" data-mdb-ride="carousel" style="margin-top:35px;">
        <ol class="carousel-indicators">
            <li data-mdb-target="#introCarousel" data-mdb-slide-to="0" class="active"></li>
            <li data-mdb-target="#introCarousel" data-mdb-slide-to="1"></li>
            <li data-mdb-target="#introCarousel" data-mdb-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
            <div class="carousel-item active"></div>
            <div class="carousel-item"></div>
            <div class="carousel-item"></div>
        </div>
        <a class="carousel-control-prev" href="#introCarousel" role="button" data-mdb-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#introCarousel" role="button" data-mdb-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>

    <!-- Card group -->
    <div class="card-group" style="margin-top:50px;">
        <div class="card" style="border-style: none;">
            <img style="height:55px; width:64px; margin: auto;" src="https://toanquoc.vn/img/bkg-active-3.png">
            <div class="card-body">
                <h5 class="card-title" style="text-align:center">GIAO HÀNG TOÀN QUỐC</h5>
                <p class="card-text" style="text-align:center">Vận chuyển khắp Việt Nam</p>
            </div>
        </div>
        <div class="card" style="border-style: none;">
            <img style="height:55px; width:64px; margin: auto;" src="https://toanquoc.vn/img/bkg-active-2.png">
            <div class="card-body">
                <h5 class="card-title" style="text-align:center">THANH TOÁN KHI NHẬN HÀNG</h5>
                <p class="card-text" style="text-align:center">Nhận hàng tại nhà rồi thanh toán</p>
            </div>
        </div>
        <div class="card" style="border-style: none;">
            <img style="height:55px; width:64px; margin: auto;" src="https://toanquoc.vn/img/bkg-active-5.png">
            <div class="card-body">
                <h5 class="card-title" style="text-align:center">BẢO HÀNH DÀI HẠN</h5>
                <p class="card-text" style="text-align:center">Bảo hành lên đến 60 ngày</p>
            </div>
        </div>
        <div class="card" style="border-style: none;">
            <img style="height:55px; width:64px; margin: auto;" src="https://toanquoc.vn/img/bkg-active-1.png">
            <div class="card-body">
                <h5 class="card-title" style="text-align:center">ĐỔI HÀNG DỄ DÀNG</h5>
                <p class="card-text" style="text-align:center">Đổi hàng thoải mái trong 30 ngày</p>
            </div>
        </div>
    </div>

    <!-- Main content -->
    <div class="container">
        <!-- Latest Products -->
        <div class="row" style="margin-top:25px">
            <h1 style="text-align:center; width:100%" id="moiNhat">SẢN PHẨM MỚI NHẤT</h1>
            <div class="col-sm-12">
                <div id="contentMoiNhat" class="row">
                    <c:forEach items="${list8Last}" var="o">
                        <div class="col-12 col-md-6 col-lg-3">
                            <div class="card">
                                <div class="view zoom z-depth-2 rounded">
                                    <img class="img-fluid w-100" src="${o.image}" alt="Card image cap">
                                </div>
                                <div class="card-body">
                                    <h4 class="card-title show_txt"><a href="detail?pid=${o.id}" title="View Product">${o.name}</a></h4>
                                    <p class="card-text show_txt">${o.title}</p>
                                    <div class="row">
                                        <div class="col">
                                            <p class="btn btn-success btn-block">${o.price} $</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <!-- Nike Products -->
        <div class="row" style="margin-top:25px">
            <h1 style="text-align:center; width:100%" id="nike">GIÀY NIKE MỚI NHẤT</h1>
            <div class="col-sm-12">
                <div id="contentNike" class="row">
                    <c:forEach items="${list4NikeLast}" var="o">
                        <div class="productNike col-12 col-md-6 col-lg-3">
                            <div class="card">
                                <div class="view zoom z-depth-2 rounded">
                                    <img class="img-fluid w-100" src="${o.image}" alt="Card image cap">
                                </div>
                                <div class="card-body">
                                    <h4 class="card-title show_txt"><a href="detail?pid=${o.id}" title="View Product">${o.name}</a></h4>
                                    <p class="card-text show_txt">${o.title}</p>
                                    <div class="row">
                                        <div class="col">
                                            <p class="btn btn-success btn-block">${o.price} $</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <button onclick="loadMoreNike()" class="btn btn-primary">Load more</button>
            </div>
        </div>

        <!-- Adidas Products -->
        <div class="row" style="margin-top:25px">
            <h1 style="text-align:center; width:100%" id="adidas">GIÀY ADIDAS MỚI NHẤT</h1>
            <div class="col-sm-12">
                <div id="contentAdidas" class="row">
                    <c:forEach items="${list4AdidasLast}" var="o">
                        <div class="productAdidas col-12 col-md-6 col-lg-3">
                            <div class="card">
                                <div class="view zoom z-depth-2 rounded">
                                    <img class="img-fluid w-100" src="${o.image}" alt="Card image cap">
                                </div>
                                <div class="card-body">
                                    <h4 class="card-title show_txt"><a href="detail?pid=${o.id}" title="View Product">${o.name}</a></h4>
                                    <p class="card-text show_txt">${o.title}</p>
                                    <div class="row">
                                        <div class="col">
                                            <p class="btn btn-success btn-block">${o.price} $</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <button onclick="loadMoreAdidas()" class="btn btn-primary">Load more</button>
            </div>
        </div>

        <!-- About Us -->
        <div class="row" style="margin-top:50px">
            <div class="col-sm-12">
                <div id="content" class="row">
                    <div class="col-12 col-md-12 col-lg-6">
                        <div class="card-body">
                            <h4 class="card-title show_txt" style="text-align:center; font-size:18pt; color:#b57b00;">Về chúng tôi</h4>
                            <h2 class="card-title show_txt" style="text-align:center; font-size:24pt;">Shoes Family</h2>
                            <p style="text-align:center;">Uy tín lâu năm chuyên cung cấp giày thể thao sneaker nam, nữ hàng Replica 1:1 - Like Auth với chất lượng đảm bảo và giá tốt nhất tại Hà Nội, tpHCM.</p>
                            <p>Bạn đang cần tìm một đôi giày thể thao sneaker đẹp và hợp thời trang và đang hot Trends đến từ các thương hiệu lớn nhưng lại không đủ hầu bao để sắm được hàng chính hãng? Hãy đến với ShoesFamily – nơi bạn thỏa lòng mong ước mà chỉ phải chi ra 1 phần nhỏ so với dòng chính hãng ngoài store mà vẫn sắm cho mình được một đôi chất lượng từ rep 1:1 đến siêu cấp like auth.</p>
                        </div>
                    </div>
                    <div class="col-12 col-md-12 col-lg-6">
                        <img class="card-img-top" src="https://minhshop.vn/_next/static/media/about-1.4c794d60.jpg" alt="Card image cap">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="Footer.jsp"></jsp:include>

    <!-- Chatbot -->
    <div class="chat-wrapper">
        <div class="chat-container minimized" id="chat-container">
            <div class="chat-header" onclick="toggleChat()">
                <span>Shoes Family</span>
                <div class="chat-icon">💬</div>
            </div>
            <div class="chat-messages" id="chat-messages">
                <c:if test="${empty chatHistory}">
                    <div class="message ai-message">
                        <div class="message-content">Shoes Family xin chào! Chúng tôi có thể giúp gì cho bạn!</div>
                    </div>
                </c:if>
                <c:forEach items="${chatHistory}" var="message">
                    <div class="message ${message.sender}-message">
                        <div class="message-content">${message.message}</div>
                        <div class="timestamp">${message.timestamp}</div>
                    </div>
                </c:forEach>
            </div>
            <div class="chat-input">
                <form id="chat-form" action="${pageContext.request.contextPath}/chat" method="post">
                    <input type="text" name="message" id="message-input" placeholder="Type your message here..." autocomplete="off" required>
                    <button type="submit">Send</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        function loadMore() {
            var amount = document.getElementsByClassName("product").length;
            $.ajax({
                url: "/ShoesStore/load",
                type: "get",
                data: { exits: amount },
                success: function(data) {
                    document.getElementById("content").innerHTML += data;
                },
                error: function(xhr) {}
            });
        }
        function loadMoreNike() {
            var amountNike = document.getElementsByClassName("productNike").length;
            $.ajax({
                url: "/ShoesStore/loadNike",
                type: "get",
                data: { exitsNike: amountNike },
                success: function(dataNike) {
                    document.getElementById("contentNike").innerHTML += dataNike;
                },
                error: function(xhr) {}
            });
        }
        function loadMoreAdidas() {
            var amountAdidas = document.getElementsByClassName("productAdidas").length;
            $.ajax({
                url: "/ShoesStore/loadAdidas",
                type: "get",
                data: { exitsAdidas: amountAdidas },
                success: function(dataAdidas) {
                    document.getElementById("contentAdidas").innerHTML += dataAdidas;
                },
                error: function(xhr) {}
            });
        }
        function searchByName(param) {
            var txtSearch = param.value;
            $.ajax({
                url: "/ShoesStore/searchAjax",
                type: "get",
                data: { txt: txtSearch },
                success: function(data) {
                    document.getElementById("content").innerHTML = data;
                },
                error: function(xhr) {}
            });
        }
        function load(cateid) {
            $.ajax({
                url: "/ShoesStore/category",
                type: "get",
                data: { cid: cateid },
                success: function(responseData) {
                    document.getElementById("content").innerHTML = responseData;
                }
            });
        }
        function loadAmountCart() {
            $.ajax({
                url: "/ShoesStore/loadAllAmountCart",
                type: "get",
                success: function(responseData) {
                    document.getElementById("amountCart").innerHTML = responseData;
                }
            });
        }

        // Chatbot functionality
        document.addEventListener('DOMContentLoaded', function() {
            const chatMessages = document.getElementById('chat-messages');
            const chatForm = document.getElementById('chat-form');
            const messageInput = document.getElementById('message-input');

            chatForm.addEventListener('submit', function(e) {
                e.preventDefault();
                const message = messageInput.value.trim();
                if (!message) return;

                addMessage(message, 'user');
                messageInput.value = '';

                fetch('${pageContext.request.contextPath}/chat', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                        'X-Requested-With': 'XMLHttpRequest'
                    },
                    body: 'message=' + encodeURIComponent(message)
                })
                .then(response => response.json())
                .then(data => {
                    addMessage(data.message, 'ai');
                })
                .catch(error => {
                    console.error('Error:', error);
                    addMessage('Sorry, something went wrong. Please try again.', 'ai');
                });
            });

            function addMessage(content, sender) {
                const messageDiv = document.createElement('div');
                messageDiv.className = `message ${sender}-message`;
                const contentDiv = document.createElement('div');
                contentDiv.className = 'message-content';
                contentDiv.textContent = content;
                const timestampDiv = document.createElement('div');
                timestampDiv.className = 'timestamp';
                timestampDiv.textContent = new Date().toLocaleTimeString();
                messageDiv.appendChild(contentDiv);
                messageDiv.appendChild(timestampDiv);
                chatMessages.appendChild(messageDiv);
                chatMessages.scrollTop = chatMessages.scrollHeight;
            }
        });

        function toggleChat() {
            const chatContainer = document.getElementById('chat-container');
            const chatMessages = document.getElementById('chat-messages');
            const chatInput = document.querySelector('.chat-input');
            if (chatContainer.classList.contains('minimized')) {
                chatContainer.classList.remove('minimized');
                chatContainer.classList.add('maximized');
                chatMessages.style.display = 'block';
                chatInput.style.display = 'flex';
                chatMessages.scrollTop = chatMessages.scrollHeight;
            } else {
                chatContainer.classList.remove('maximized');
                chatContainer.classList.add('minimized');
                chatMessages.style.display = 'none';
                chatInput.style.display = 'none';
            }
        }
    </script>

    <!-- MDB and Other Scripts -->
    <script type="text/javascript" src="js/mdb.min.js"></script>
    <script type="text/javascript" src="js/script.js"></script>
    <script type="text/javascript" src="https://mdbootstrap.com/previews/ecommerce-demo/js/popper.min.js"></script>
    <script type="text/javascript" src="https://mdbootstrap.com/previews/ecommerce-demo/js/bootstrap.js"></script>
    <script type="text/javascript" src="https://mdbootstrap.com/previews/ecommerce-demo/js/mdb.ecommerce.min.js"></script>
</body>
</html>