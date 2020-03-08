<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>My animals</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="resources/css/main.css" />
<script src="resources/js/jquery.min.js"></script>
<script src="resources/js/jquery-ui.js"></script>
<link rel="stylesheet" href="resources/css/jquery-ui.css" />
<style type="text/css">
	.wrap-loading{
	    position: fixed;
	    left:0;
	    right:0;
	    top:0;
	    bottom:0;
	    filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000');
	}

    .wrap-loading div{
        position: fixed;
        top:50%;
        left:50%;
        margin-left: -21px;
        margin-top: -21px;
    }

    .display-none{
        display:none;
    }
    
    .photo{
    	width: 45px;
    }
</style>
<script>
	
	$(document).ready(function($){
		myAnimalsData();
	});

	function paging(navi){
		var pageno = '<a href="javascript:myAnimalsData('+(navi.currentPage-5)+')" class="icon brands style2">'+'◁'+'</a>';
		pageno += '<a href="javascript:myAnimalsData('+(navi.currentPage-1)+')" class="icon brands style2">'+'◀'+'</a>';
		for(var page = navi.startPageGroup; page<=navi.endPageGroup; page++){
			if(page == navi.currentPage){
				pageno += '<div class="currentPage">'+page+'</div>';
			}else{
				pageno += '<a href="javascript:myAnimalsData('+page+')" class="icon brands style2">'+page+'</a>';
			}

		};
		pageno += '<a href="javascript:myAnimalsData('+(navi.currentPage+1)+')" class="icon brands style2">'+'▶'+'</a>';
		pageno += '<a href="javascript:myAnimalsData('+(navi.currentPage+5)+')" class="icon brands style2">'+'▷'+'</a>';
				
		$("#paging").html(pageno);
	}

	function myAnimalsData(pagenum){
		var data = {"currentPage":pagenum};
		$.ajax({
			type : "GET",
			url : "myAnimalList",
			data : data,
			success : function(map){
				console.log(map);
				var currentPage = map.navi.currentPage;
				var totalRecordCount = map.navi.totalRecordCount;
				var output = "";

				if(map.list.length != 0){
					output = '<section class="tiles">';
						$.each(map.list,function(index,item){
							output += '<article class="style1">';
							output += '<span class="image">';
							output += '<img src="'+item.popfile+'"/>';
							output += '</span>';
							output += '<a href="'+detail(item)+'">';
							output += '<div class="content">';
							output += '<p>발견된 장소 : '+item.happenPlace+'</p>';
							output += '<p>현재 상태 : '+item.processState+'</p>';
							output += '<p>나이 : '+item.age+'</p>';
							output += '</div>';
							output += '</a>';
							output += '</article>';
						});
					}else{
						output += '<p>관심 등록한 동물이 없습니다.</p>'
					};
					output += '</section>';

					$("#dataOutput").html(output);

					paging(map.navi);
				},
				beforeSend : function(){
					$(".wrap-loading").removeClass("display-none");
				},
				complete : function(){
					$(".wrap-loading").addClass("display-none");
				},
				error : function(e){
					console.log("그 외 동물들 데이터 출력 에러");
					console.log(e);
				}
			});
		}

	function detail(item){
		var location = "detail?";
		location += "desertionNo="+encodeURIComponent(item.desertionNo)+"&";
		location += "age="+encodeURIComponent(item.age)+"&";
		location += "careAddr="+encodeURIComponent(item.careAddr)+"&";
		location += "careNm="+encodeURIComponent(item.careNm)+"&";
		location += "careTel="+encodeURIComponent(item.careTel)+"&";
		location += "colorCd="+encodeURIComponent(item.colorCd)+"&";
		location += "happenDt="+encodeURIComponent(item.happenDt)+"&";
		location += "happenPlace="+encodeURIComponent(item.happenPlace)+"&";
		location += "kindCd="+encodeURIComponent(item.kindCd)+"&";
		location += "processState="+encodeURIComponent(item.processState)+"&";
		location += "sexCd="+encodeURIComponent(item.sexCd)+"&";
		location += "neuterYn="+encodeURIComponent(item.neuterYn)+"&";
		location += "specialMark="+encodeURIComponent(item.specialMark)+"&";
		location += "weight="+encodeURIComponent(item.weight)+"&";
		location += "popfile="+encodeURIComponent(item.popfile)+"&";
		location += "insertDate="+encodeURIComponent(item.insertDate)+"&";
		location += "fromWhere="+encodeURIComponent("myAnimal");
		
		return location;
	}
</script>
</head>
<body class="is-preload">
		<!-- loading 처리 -->
			<div class="wrap-loading display-none">
				<div><img class="photo" src="resources/images/loading.gif"></div>
			</div>
		
		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Header -->
					<header id="header">
						<div class="inner">
							<!-- Nav -->
								<nav>
									<ul>
										<li><a href="#menu">Menu</a></li>
									</ul>
								</nav>
						</div>
					</header>

				<!-- Menu -->
					<nav id="menu">
						<h2>Menu</h2>
						<ul>
							<li><a href="./">Home</a></li>
							<c:if test="${sessionScope.loginId == null}">
								<li><a href="login">Login / Signup</a></li>
							</c:if>
							<c:if test="${sessionScope.loginId != null}">
								<li><a href="around">내 주위 유기동물</a></li>
							</c:if>
							<c:if test="${sessionScope.loginId != null}">
								<li><a href="outer">내가 사는 곳 너머의 유기동물</a></li>
							</c:if>
							<c:if test="${sessionScope.loginId != null}">
								<li><a href="myAnimal">내 관심 동물</a></li>
							</c:if>
							<c:if test="${sessionScope.loginId != null}">
								<li><a href="mypage">개인정보수정</a></li>
							</c:if>
							<c:if test="${sessionScope.loginId != null}">
								<li><a href="logout">Logout</a></li>
							</c:if>
						</ul>
					</nav>

				<!-- Main -->
						<div id="main">
						<div class="inner">
							<header>
								<h1>myAnimals</h1>
							</header>
							
							<div>
								<p>자신이 관심등록한 유기동물들을 볼 수 있습니다.</p>
							</div>
							
							<div id="dataOutput" style="padding-top: 67px;">
							
							</div>
							
							<div id="paging" style="text-align: center; padding-top: 40px;">
								
							</div>
						</div>
					</div>
			</div>

		<!-- Scripts -->
			<script src="resources/js/jquery.min.js"></script>
			<script src="resources/js/browser.min.js"></script>
			<script src="resources/js/breakpoints.min.js"></script>
			<script src="resources/js/util.js"></script>
			<script src="resources/js/main.js"></script>

</body>
</html>