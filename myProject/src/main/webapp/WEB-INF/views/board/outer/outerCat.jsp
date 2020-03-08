<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Cats around me</title>
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
    select{
    	border-top: none;
    	border-left: none;
    	border-right: none;
    	display: inline-block;
    	font-size: 15px;
    	margin-right: 30px;
    	height: 53px;
    }
</style>
<script>
	jQuery.noConflict();
	
	jQuery(document).ready(function($){
		sidoCode();
		if("${sessionScope.sidocode}" != "" && "${sessionScope.sigungucode}" != ""){
			sigunguCode("${sessionScope.sidocode}");
		}
		CatData();
		$("#datePicker").datepicker({
			showOn : "button",
			dateFormat : "yymmdd",
			changeYear : true,
			buttonText : "날짜 선택",
			maxDate : "+0D",
			onSelect: function(dateText,inst){
				var date = dateText;
				console.log(date);
				var pagenum = 1;
				var sidocode;
				var sigungucode;
				CatData(pagenum,date,sidocode,sigungucode);
			}
		});

		$("#sido").on("change",function(){
			if(!$("#sidoSel").prop("selected")){
				var sidocode = $(this).val();

				if(sidocode == "5690000"){
					$("#sigungu").find("option").not("#sigunguSel").remove();
					var sigungucode;
					var pagenum = 1;
					var date;
					console.log("세종옴");
					CatData(pagenum,date,sidocode,sigungucode);
				}else{
					$("#sigungu").find("option").not("#sigunguSel").remove();
					sigunguCode(sidocode);
					$("#sigungu").on("change",function(){
						var sigungucode = $(this).val();
						var pagenum = 1;
						var date;
						CatData(pagenum,date,sidocode,sigungucode);
					});
				}
			}else{
				$("#sigunguSel").prop("selected",true);
				$("#sigungu").find("option").not("#sigunguSel").remove();
				var sidocode = 1;
				var sigungucode = 1;
				var pagenum = 1;
				var date;
				CatData(pagenum,date,sidocode,sigungucode);
			}
		});
	});

	function sidoCode(){
		$.ajax({
			type : "GET",
			url : "sido",
			success : function(sido){
				var parse = JSON.parse(sido);
				console.log(parse);
				var sidoArr = parse.response.body.items.item;
				var output = "";
				
				$.each(sidoArr,function(index,item){
					if("${sessionScope.sidocode}" == item.orgCd){
						output += '<option value="'+item.orgCd+'" selected>'+item.orgdownNm+'</option>';
					}else{
						output += '<option value="'+item.orgCd+'">'+item.orgdownNm+'</option>';
					}
				});

				$("#sido").append(output);
			},
			error : function(e){
				console.log(e);
			}
		});
	}

	function sigunguCode(sidocode){
		var data = {"sidocode":sidocode};
		$.ajax({
			type : "GET",
			url : "sigungu",
			data : data,
			success : function(sigungu){
				var parse = JSON.parse(sigungu);
				console.log(parse);
				var sigunguArr = parse.response.body.items.item;
				var output = "";
				
				$.each(sigunguArr,function(index,item){
					if("${requestScope.sgcode}" != item.orgCd){
						if("${sessionScope.sigungucode}" == item.orgCd){
							output += '<option value="'+item.orgCd+'" selected>'+item.orgdownNm+'</option>';
						}else{
							output += '<option value="'+item.orgCd+'">'+item.orgdownNm+'</option>';
						}
					}
				});

				$("#sigungu").append(output);
			},
			error : function(e){
				console.log(e);
			}
		});
	}

	function paging(totalRecordCount, currentPage){
		var data = {"totalRecordCount":totalRecordCount, "currentPage":currentPage};
		$.ajax({
			type : "GET",
			url : "paging",
			data : data,
			success : function(navi){
				console.log(navi);
				var pageno = '<a href="javascript:CatData('+((navi.currentPage-5) < 1 ? 1 : (navi.currentPage-5))+')" class="icon brands style2">'+'◁'+'</a>';
					pageno += '<a href="javascript:CatData('+((navi.currentPage-1) < 1 ? 1 : (navi.currentPage-1))+')" class="icon brands style2">'+'◀'+'</a>';
				for(var page = navi.startPageGroup; page<=navi.endPageGroup; page++){
					if(page == navi.currentPage){
						pageno += '<div class="currentPage">'+page+'</div>';
					}else{
						pageno += '<a href="javascript:CatData('+page+')" class="icon brands style2">'+page+'</a>';
					}

				};
				pageno += '<a href="javascript:CatData('+((navi.currentPage+1) >= navi.totalPageCount ? navi.endPageGroup : navi.currentPage+1)+')" class="icon brands style2">'+'▶'+'</a>';
				pageno += '<a href="javascript:CatData('+((navi.currentPage+5) >= navi.totalPageCount ? navi.endPageGroup : navi.currentPage+5)+')" class="icon brands style2">'+'▷'+'</a>';
				
				$("#paging").html(pageno);
			},
		});
	};

	function CatData(pagenum,date,sidocode,sigungucode){
		var code = "${requestScope.type}";
		var data = {
					"type":code,
					"pagenum":pagenum,
					"dateSelect":date,
					"sidocode":sidocode,
					"sigungucode":sigungucode
					};
		console.log(data);
		$.ajax({
			type : "GET",
			data : data,
			url : "outerAnimaldata",
			success : function(result){
				if(result == "no"){
					$("#dataOutput").html("<p>확인하고자 하는 지역의 주소를 선택해주세요</p>");
					return;
				}
				var parse = JSON.parse(result);
				var CatArr = parse.response.body.items.item;
				var totalRecordCount = parse.response.body.totalCount;
				var currentPage = parse.response.body.pageNo;

				console.log("고양이 데이터 출력");
				console.log(JSON.parse(result));
				console.log(CatArr);
				var output = "";

				if(Array.isArray(CatArr)){
					output = '<section class="tiles">';
						$.each(CatArr,function(index,item){
							output += '<article class="style1">';
							output += '<span class="image">';
							output += '<img src="'+item.popfile+'"/>';
							output += '</span>';
							output += '<a href="'+detail(item,currentPage)+'">';
							output += '<div class="content">';
							output += '<p>발견된 장소 : '+item.happenPlace+'</p>';
							output += '<p>현재 상태 : '+item.processState+'</p>';
							output += '<p>나이 : '+item.age+'</p>';
							output += '</div>';
							output += '</a>';
							output += '</article>';
						});
					}else if(!Array.isArray(CatArr) && CatArr != null){
						output = '<section class="tiles">';
						output += '<article class="style1">';
						output += '<span class="image">';
						output += '<img src="'+CatArr.popfile+'"/>';
						output += '</span>';
						output += '<a href="'+detail(CatArr,currentPage)+'">';
						output += '<div class="content">';
						output += '<p>발견된 장소 : '+CatArr.happenPlace+'</p>';
						output += '<p>현재 상태 : '+CatArr.processState+'</p>';
						output += '<p>나이 : '+CatArr.age+'</p>';
						output += '</div>';
						output += '</a>';
						output += '</article>';
					}else{
						output += '<p>해당 기간에 데이터가 존재하지 않습니다.</p>'
					};
					output += '</section>';

					$("#dataOutput").html(output);

					paging(totalRecordCount,currentPage);
				},
				beforeSend : function(){
					$(".wrap-loading").removeClass("display-none");
				},
				complete : function(){
					$(".wrap-loading").addClass("display-none");
				},
				error : function(e){
					console.log("고양이 데이터 출력 에러");
					console.log(e);
				}
			});
		}

		function detail(item,currentPage){
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
			location += "fromWhere="+encodeURIComponent("outerCat");
			
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
								<h1>Cats around me</h1>
							</header>
							
							<div style="height: 50px;">
								<span style="font-style: italic;">유기된 날짜를 기준으로 오늘까지 유기된 동물을 확인할 수 있습니다.(기본 6개월)</span>
								<div style="display: inline-block; float: right;">
									<input type="hidden" id="datePicker">
								</div>
								<div style="float: right;">
									<select id="sido" style="width: 150px; padding-left: 20px;">
										<option id="sidoSel">시도</option>
									</select>
									<select id="sigungu" style="width: 100px; padding-left: 10px;">
										<option id="sigunguSel">시군구</option>
									</select>
								</div>
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