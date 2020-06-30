<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
		content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
	
	<title>온습도 - Main</title>
	
	<!-- Custom fonts for this template-->
	<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
	
	<!-- Custom styles for this template-->
	<link href="css/sb-admin-2.min.css" rel="stylesheet">
	
	<!-- Bootstrap core JavaScript-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="js/sb-admin-2.min.js"></script>

	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script><!-- google charts -->
	
	<link rel="stylesheet" type="text/css" href="css/bootstrap-datepicker.css" />
	<script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="js/bootstrap-datepicker.ko.min.js"></script>

</head>

<body id="page-top">
	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

			<!-- Sidebar - Brand -->
			<a class="sidebar-brand d-flex align-items-center justify-content-center" href="main">
				<div class="sidebar-brand-icon rotate-n-15">
					<i class="fas fa-laugh-wink"></i>
				</div>
				<div class="sidebar-brand-text mx-3">
					온습도 관리 <sup>v.0.1</sup>
				</div>
			</a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			<li class="nav-item active"><a class="nav-link"
				href="main"> <i class="fas fa-fw fa-tachometer-alt"></i> <span>Main</span></a>
			</li>
		</ul>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

					<!-- Topbar Navbar -->
					<ul class="navbar-nav ml-auto">
						<li>
							<script type="text/javascript">
								function logoutButton() {
									location.href="logout";
								}
							</script>
							<a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal" onclick="logoutButton()">
								<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
								Logout
							</a>
						</li>
					</ul>

				</nav>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
					</div>

					<!-- Content Row -->
					<div class="row">

						<!-- Earnings (Monthly) Card Example -->
						<div class="col-xl-3 col-md-6 mb-4">
							<div class="card border-left-primary shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div
												class="text-xs font-weight-bold text-primary text-uppercase mb-1">날짜 설정</div>
											<div class="h5 mb-0 font-weight-bold text-gray-800">
												<!-- datePicker -->
												<form action="mainDatePicker" name="dateForm" method="post">
													<div>
														<input type="text" id="datePicker" name="datePicker" style="width: 140px; font-size: 15px;" value="${datePicker}">
													</div>
												</form>
												
												<script type="text/javascript">
													$('#datePicker').datepicker({
														 format: "yyyy-mm-dd",
														 language: "ko",
														 todayHighlight: true
													 });
												</script>
												<!-- datePicker -->
											</div>
										</div>
										<div class="col-auto">
											<a href="#" class="btn btn-success btn-circle" onclick="datePick()">
	                    						<i class="fas fa-check"></i>
	                 						</a>
											<script type="text/javascript">
												function datePick() {
													if($('#datePicker').val() == ''){
														alert('날짜를 입력해주세요!');
													}
													else{
														var dateForm = document.dateForm;
														dateForm.submit();
													}
												}
											</script>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- Earnings (Monthly) Card Example -->
						<div class="col-xl-3 col-md-6 mb-4">
							<div class="card border-left-success shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div class="text-xs font-weight-bold text-success text-uppercase mb-1">작동상태</div>
											<c:choose>
												<c:when test="${jsonList[0].isOn > 0}">
													<div class="h5 mb-0 font-weight-bold text-gray-800">켜짐(ON)</div>												
												</c:when>
												<c:otherwise>
													<div class="h5 mb-0 font-weight-bold text-gray-800">꺼짐(OFF)</div>
												</c:otherwise>
											</c:choose>
										</div>
										<div class="col-auto">
											<i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- Pending Requests Card Example -->
						<div class="col-xl-3 col-md-6 mb-4">
							<div class="card border-left-warning shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div class="text-xs font-weight-bold text-warning text-uppercase mb-1">불쾌지수</div>
											<div class="h5 mb-0 font-weight-bold text-gray-800">${discomfortRate}</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-comments fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Content Row -->
					<div class="row">
						<!-- Area Chart -->
						<div class="col-xl-12 col-lg-7">
							<div class="card shadow mb-4">
								<!-- Card Header - Dropdown -->
								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">온도 습도 실시간 그래프 (${datePicker})</h6>
									<div class="dropdown no-arrow">
										<a class="dropdown-toggle" href="#" role="button"
											id="dropdownMenuLink" data-toggle="dropdown"
											aria-haspopup="true" aria-expanded="false">
											<i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
										</a>
										<div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
											<div class="dropdown-header">Dropdown Header:</div>
											<a class="dropdown-item" href="#">Action</a> <a class="dropdown-item" href="#">Another action</a>
											<div class="dropdown-divider"></div>
											<a class="dropdown-item" href="#">Something else here</a>
										</div>
									</div>
								</div>
								<!-- Card Body -->
								<div class="card-body">
									<div>
										<!-- google graph -->
										<div id="Line_Controls_Chart">
											<!-- 라인 차트 생성할 영역 -->
											<div id="lineChartArea"></div>
											<!-- 컨트롤바를 생성할 영역 -->
											<div id="controlsArea"></div>
											<hr>
				                			<code>새로고침해야 새로운 데이터를 받을 수 있습니다.</code>
										</div>
										
										<script>
											var chartDrowFun = {
										
												chartDrow : function() {
													var chartData = '';
										
													//날짜형식 변경하고 싶으시면 이 부분 수정하세요.
													var chartDateformat = 'HH시mm분';
													//라인차트의 라인 수
													var chartLineCount = 10;
													//컨트롤러 바 차트의 라인 수
													var controlLineCount = 10;
										
													function drawDashboard() {
										
														var data = new google.visualization.DataTable();
														//그래프에 표시할 컬럼 추가
														data.addColumn('datetime', '날짜');
														data.addColumn('number', '내부 습도');
														data.addColumn('number', '내부 온도');
														data.addColumn('number', '외부 습도');
														data.addColumn('number', '외부 온도');
										
														//그래프에 표시할 데이터
														var dataRow = [];
														var jsonData = ${jsonList};

														for(var ele in jsonData){
															var date = new Date();
															var timestamp = jsonData[ele].time.time;
															var date = new Date(timestamp);
															
													        dataRow = [
													        	new Date(date.getYear(),date.getMonth(),date.getDay(),date.getHours()-9, date.getMinutes(), date.getSeconds()),
													        	jsonData[ele].hud_in,
													        	jsonData[ele].temp_in,
													        	jsonData[ele].hud_out,
													        	jsonData[ele].temp_out
													        ];
															data.addRow(dataRow); 
													    }
										
														var chart = new google.visualization.ChartWrapper({
															chartType : 'LineChart',
															containerId : 'lineChartArea', //라인 차트 생성할 영역
															options : {
																isStacked : 'percent',
																focusTarget : 'category',
																height : 500,
																width : '100%',
																legend : {
																	position : "top",
																	textStyle : {
																		fontSize : 13
																	}
																},
																pointSize : 5,
																tooltip : {
																	textStyle : {
																		fontSize : 12
																	},
																	showColorCode : true,
																	trigger : 'both'
																},
																hAxis : {
																	format : chartDateformat,
																	gridlines : {
																		count : chartLineCount,
																		units : {
																			hours : {
																				format : [ 'HH시' ]
																			},
																			minutes : {
																				format : [ 'mm분' ]
																			}
																		}
																	},
																	textStyle : {
																		fontSize : 12
																	}
																},
																vAxis : {
																	minValue : 100,
																	viewWindow : {
																		min : 0
																	},
																	gridlines : {
																		count : -1
																	},
																	textStyle : {
																		fontSize : 12
																	}
																},
																animation : {
																	startup : true,
																	duration : 1000,
																	easing : 'in'
																},
																annotations : {
																	pattern : chartDateformat,
																	textStyle : {
																		fontSize : 15,
																		bold : true,
																		italic : true,
																		color : '#871b47',
																		auraColor : '#d799ae',
																		opacity : 0.8,
																		pattern : chartDateformat
																	}
																}
															}
														});
										
														var control = new google.visualization.ControlWrapper({
															controlType : 'ChartRangeFilter',
															containerId : 'controlsArea', //control bar를 생성할 영역
															options : {
																ui : {
																	chartType : 'LineChart',
																	chartOptions : {
																		chartArea : {
																			'width' : '60%',
																			'height' : 80
																		},
																		hAxis : {
																			'baselineColor' : 'none',
																			format : chartDateformat,
																			textStyle : {
																				fontSize : 12
																			},
																			gridlines : {
																				count : controlLineCount,
																				units : {
																					hours : {
																						format : [ 'HH시' ]
																					},
																					minutes : {
																						format : [ 'mm분' ]
																					}
																				}
																			}
																		}
																	}
																},
																filterColumnIndex : 0
															}
														});
										
														var date_formatter = new google.visualization.DateFormat({
															pattern : chartDateformat
														});
														date_formatter.format(data, 0);
										
														var dashboard = new google.visualization.Dashboard(document.getElementById('Line_Controls_Chart'));
														window.addEventListener('resize', function() {
															dashboard.draw(data);
														}, false); //화면 크기에 따라 그래프 크기 변경
														dashboard.bind([ control ], [ chart ]);
														dashboard.draw(data);
										
													}
													google.charts.setOnLoadCallback(drawDashboard);
												}
											}
										
											$(document).ready(function() {
												google.charts.load('current', {
													'packages' : [ 'line', 'controls' ]
												});
												chartDrowFun.chartDrow(); //chartDrow() 실행
											});
										</script>
										<!-- google graph -->
										
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright &copy; 이상준 정진식 최광복 2020</span>
					</div>
				</div>
			</footer>
			<!-- End of Footer -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top">
		<i class="fas fa-angle-up"></i>
	</a>

</body>
</html>
