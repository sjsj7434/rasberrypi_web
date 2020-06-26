<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Student List</title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script><!-- google charts -->
	<script src="https://code.jquery.com/jquery.min.js"></script><!-- jQuery -->
	
	<!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>
	
	
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span2">
		    	<!--Sidebar content-->
		    	<h1>test</h1>
		    </div>
		    <div class="span10">
		    	<!--Body content-->
		    	<c:if test="${member != null}">
					<script type="text/javascript">
						function logoutButton() {
							alert(1);
							location.href="logout";
						}
					</script>
					<button class="btn btn-large btn-primary" type="button" id="logoutBtn" onclick="logoutButton()">로그아웃</button>
					
					<div class="btn-group">
						<a class="btn btn-primary" href="#"><i class="icon-user icon-white"></i> User</a>
						<a class="btn btn-primary dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="#"><i class="icon-pencil"></i> Edit</a></li>
							<li><a href="#"><i class="icon-trash"></i> Delete</a></li>
							<li><a href="#"><i class="icon-ban-circle"></i> Ban</a></li>
							<li class="divider"></li>
							<li><a href="#"><i class="i"></i> Make admin</a></li>
						</ul>
					</div>
				</c:if>
				<c:if test="${member == null}">
					<a class="nav-link" href="/study">로그인</a>
				</c:if>
				
				<div align=center>
					<h1>온도 습도 실시간 그래프</h1><br>
					
					<div id="Line_Controls_Chart">
						<!-- 라인 차트 생성할 영역 -->
						<div id="lineChartArea" style="padding: 0px 20px 0px 0px;"></div>
						<!-- 컨트롤바를 생성할 영역 -->
						<div id="controlsArea" style="padding: 0px 20px 0px 0px;"></div>
					</div>
					
					<script>
						var chartDrowFun = {
					
							chartDrow : function() {
								var chartData = '';
					
								//날짜형식 변경하고 싶으시면 이 부분 수정하세요.
								var chartDateformat = 'yyyy년MM월dd일';
								//라인차트의 라인 수
								var chartLineCount = 10;
								//컨트롤러 바 차트의 라인 수
								var controlLineCount = 10;
					
								function drawDashboard() {
					
									var data = new google.visualization.DataTable();
									//그래프에 표시할 컬럼 추가
									data.addColumn('datetime', '날짜');
									data.addColumn('number', '온도');
									data.addColumn('number', '습도');
					
									//그래프에 표시할 데이터
									var dataRow = [];
									var test = ${jsonList};
									console.log(test);
									console.log(${jsonList[0].hudIn});
									console.log(Object.keys(${jsonList}).length);
			
									for(var ele in test){
										var date = new Date();
										var timestamp = test[ele].time.time;
										var date = new Date(timestamp);
										
								        console.log(test[ele].time);//test[ele].time.getYear()
								        dataRow = [ new Date(date.getFullYear(), date.getMonth(), date.getDate(), date.getHours(), date.getMinutes() ), test[ele].temp_in, test[ele].hud_in ];
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
														years : {
															format : [ 'yyyy년' ]
														},
														months : {
															format : [ 'MM월' ]
														},
														days : {
															format : [ 'dd일' ]
														},
														hours : {
															format : [ 'HH시' ]
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
																years : {
																	format : [ 'yyyy년' ]
																},
																months : {
																	format : [ 'MM월' ]
																},
																days : {
																	format : [ 'dd일' ]
																},
																hours : {
																	format : [ 'HH시' ]
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
					
					<c:choose>
						<c:when test= "${temp[0].isOn > 0}">
							<h1>
								환풍기 작동 상태 : 
								<svg class="bi bi-toggle-on" width="2em" height="2em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									<path fill-rule="evenodd" d="M5 3a5 5 0 0 0 0 10h6a5 5 0 0 0 0-10H5zm6 9a4 4 0 1 0 0-8 4 4 0 0 0 0 8z"/>
								</svg>
								켜짐
							</h1>
						</c:when>
						<c:otherwise>
							<h1>
								환풍기 작동 상태 :
								<svg class="bi bi-toggle-off" width="2em" height="2em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									<path fill-rule="evenodd" d="M11 4a4 4 0 0 1 0 8H8a4.992 4.992 0 0 0 2-4 4.992 4.992 0 0 0-2-4h3zm-6 8a4 4 0 1 1 0-8 4 4 0 0 1 0 8zM0 8a5 5 0 0 0 5 5h6a5 5 0 0 0 0-10H5a5 5 0 0 0-5 5z"/>
								</svg>
								꺼짐
							</h1>
						</c:otherwise>
					</c:choose>
					
					<h1>
						<svg class="bi bi-emoji-angry" width="2em" height="2em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
							<path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
							<path fill-rule="evenodd" d="M4.285 12.433a.5.5 0 0 0 .683-.183A3.498 3.498 0 0 1 8 10.5c1.295 0 2.426.703 3.032 1.75a.5.5 0 0 0 .866-.5A4.498 4.498 0 0 0 8 9.5a4.5 4.5 0 0 0-3.898 2.25.5.5 0 0 0 .183.683z"/>
							<path d="M7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5zm4 0c0 .828-.448 1.5-1 1.5s-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5z"/>
							<path fill-rule="evenodd" d="M4.053 4.276a.5.5 0 0 1 .67-.223l2 1a.5.5 0 1 1-.447.894l-2-1a.5.5 0 0 1-.223-.67zm7.894 0a.5.5 0 0 0-.67-.223l-2 1a.5.5 0 1 0 .447.894l2-1a.5.5 0 0 0 .223-.67z"/>
						</svg>
						불쾌지수 : ${temp[0].temp_in * 3}
					</h1>
					<h1>
						<svg class="bi bi-emoji-smile" width="2em" height="2em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
							<path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
							<path fill-rule="evenodd" d="M4.285 9.567a.5.5 0 0 1 .683.183A3.498 3.498 0 0 0 8 11.5a3.498 3.498 0 0 0 3.032-1.75.5.5 0 1 1 .866.5A4.498 4.498 0 0 1 8 12.5a4.498 4.498 0 0 1-3.898-2.25.5.5 0 0 1 .183-.683z"/>
							<path d="M7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5zm4 0c0 .828-.448 1.5-1 1.5s-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5z"/>
						</svg>
						불쾌지수 : ${temp[0].temp_in * 0.5}
					</h1>
			
					<table class="table table-striped">
					  <tr>
					    <th></th><th>time</th><th>temp_in</th><th>hud_in</th><th>temp_out</th><th>hud_out</th><th>on/off</th>
					  </tr>
					  <c:forEach var="item" items="${temp}" varStatus="status">
					  	  <script>
							console.log('time:' + '${item.time}');
							console.log('temp_in:' + '${item.temp_in}');
							console.log('hud_in:' + '${item.hud_in}');
							console.log('temp_out:' + '${item.temp_out}');
							console.log('hud_out:' + '${item.hud_out}');
						  </script>
					  	  
						  <tr>
						  <td><c:out value="${status.count}"/></td>
						  	<td><c:out value="${item.time}"/></td>
						    <td><c:out value="${item.temp_in}"/></td>
						    <td><c:out value="${item.hud_in}"/></td>
						    <td><c:out value="${item.temp_out}"/></td>
						    <td><c:out value="${item.hud_out}"/></td>
						    <td><c:out value="${item.isOn}"/></td>
						  </tr>
					  </c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>