<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Student List</title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script><!-- google charts -->
	<script src="https://code.jquery.com/jquery.min.js"></script><!-- jQuery -->
	
	<script src="resources/jquery.js"></script>
	<script src="resources/jquery-ui.js"></script>
	<link href="resources/jquery-ui.css" rel="stylesheet">

</head>
<body>
	<div align=center>
		<header>온도 습도 실시간 그래프</header><br>
		
		<div>
			<!-- Datepicker -->
			<h2 class="demoHeaders">Datepicker</h2>
			<div id="datepicker"></div>
			<input type="button" value="조회" onclick="test()">
			
			<script type="text/javascript">
				$( "#datepicker" ).datepicker({
					inline: true
				});

				function test(){
					alert($( "#datepicker" ).datepicker( "getDate" ));
				}
			</script>
		</div>
		
		<div id="Line_Controls_Chart">
			<!-- 라인 차트 생성할 영역 -->
			<div id="lineChartArea" style="padding: 0px 20px 0px 0px;"></div>
			<!-- 컨트롤바를 생성할 영역 -->
			<div id="controlsArea" style="padding: 0px 20px 0px 0px;"></div>
		</div>
		
		<script>
			var chartDrowFun = {
		//재미있는 테스트
				chartDrow : function() {
					var chartData = '';
		
					//날짜형식 변경하고 싶으시면 이 부분 수정하세요.
					var chartDateformat = 'yyyy년 MM월 dd일 hh시 mm분';
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
						var now = $( "#datepicker" ).datepicker( "getDate" );
						console.log(test);
						console.log(${jsonList[0].hud});
						console.log(Object.keys(${jsonList}).length);

						for(var ele in test){
							var date = new Date();
							var timestamp = test[ele].time.time;
							var date = new Date(timestamp);

							console.log(date);
							console.log(now);
							console.log('year is ' + date.getFullYear());
							console.log('month is ' + date.getMonth());
							console.log('day is ' + date.getDate());
							console.log('hour is ' + (date.getHours() - 9));
							console.log('minute is ' + date.getMinutes());
							
					        console.log(test[ele].time);//test[ele].time.getYear()
					        dataRow = [ new Date(date.getFullYear(), date.getMonth(), date.getDate(), (date.getHours() - 9), date.getMinutes() ), 
						        test[ele].temp, test[ele].hud ];
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
		<table border="1">
		  <tr>
		    <th>time</th><th>temp</th><th>hud</th>
		  </tr>
		  <c:forEach var="item" items="${temp}" >
		  	  <script>
				console.log('time:' + '${item.time}');
				console.log('temp:' + '${item.temp}');
				console.log('hud:' + '${item.hud}');
			  </script>
		  	  
			  <tr>
			  	<td><c:out value="${item.time}"/></td>
			    <td><c:out value="${item.temp}"/></td>
			    <td><c:out value="${item.hud}"/></td>
			  </tr>
		  </c:forEach>
		</table>
	</div>
</body>
</html>