<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta charset="UTF-8">
		
		<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
		<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
		
		<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
		<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
		<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
		
		<script type="text/javascript">
		
			$(function(){
				
				
				
			});
			
		</script>
	</head>
	<body>
	
		<!-- 创建市场活动的模态窗口 -->
		<div class="modal fade" id="createActivityModal" role="dialog">
			<div class="modal-dialog" role="document" style="width: 85%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
					</div>
					<div class="modal-body">
					
						<form class="form-horizontal" role="form">
						
							<div class="form-group">
								<label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="create-marketActivityOwner">
									  <option>zhangsan</option>
									  <option>lisi</option>
									  <option>wangwu</option>
									</select>
								</div>
								<label for="create-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-marketActivityName">
								</div>
							</div>
							
							<div class="form-group">
								<label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-startTime">
								</div>
								<label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-endTime">
								</div>
							</div>
							<div class="form-group">
	
								<label for="create-cost" class="col-sm-2 control-label">成本</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-cost">
								</div>
							</div>
							<div class="form-group">
								<label for="create-describe" class="col-sm-2 control-label">描述</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="create-describe"></textarea>
								</div>
							</div>
							
						</form>
						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal">保存</button>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 修改市场活动的模态窗口 -->
		<div class="modal fade" id="editActivityModal" role="dialog">
			<div class="modal-dialog" role="document" style="width: 85%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
					</div>
					<div class="modal-body">
					
						<form class="form-horizontal" role="form">
						
							<div class="form-group">
								<label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="edit-marketActivityOwner">
									  <option>zhangsan</option>
									  <option>lisi</option>
									  <option>wangwu</option>
									</select>
								</div>
								<label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-marketActivityName" value="发传单">
								</div>
							</div>
	
							<div class="form-group">
								<label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-startTime" value="2020-10-10">
								</div>
								<label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-endTime" value="2020-10-20">
								</div>
							</div>
							
							<div class="form-group">
								<label for="edit-cost" class="col-sm-2 control-label">成本</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-cost" value="5,000">
								</div>
							</div>
							
							<div class="form-group">
								<label for="edit-describe" class="col-sm-2 control-label">描述</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="edit-describe">市场活动Marketing，是指品牌主办或参与的展览会议与公关市场活动，包括自行主办的各类研讨会、客户交流会、演示会、新产品发布会、体验会、答谢会、年会和出席参加并布展或演讲的展览会、研讨会、行业交流会、颁奖典礼等</textarea>
								</div>
							</div>
							
						</form>
						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal">更新</button>
					</div>
				</div>
			</div>
		</div>
		
		
		
		
		<div>
			<div style="position: relative; left: 10px; top: -10px;">
				<div class="page-header">
					<h3>市场活动列表</h3>
				</div>
			</div>
		</div>
		<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
			<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
			
				<div class="btn-toolbar" role="toolbar" style="height: 80px;">
					<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
					  
					  <div class="form-group">
						<div class="input-group">
						  <div class="input-group-addon">名称</div>
						  <input class="form-control" type="text">
						</div>
					  </div>
					  
					  <div class="form-group">
						<div class="input-group">
						  <div class="input-group-addon">所有者</div>
						  <input class="form-control" type="text">
						</div>
					  </div>
	
	
					  <div class="form-group">
						<div class="input-group">
						  <div class="input-group-addon">开始日期</div>
						  <input class="form-control" type="text" id="startTime" />
						</div>
					  </div>
					  <div class="form-group">
						<div class="input-group">
						  <div class="input-group-addon">结束日期</div>
						  <input class="form-control" type="text" id="endTime">
						</div>
					  </div>
					  
					  <button type="submit" class="btn btn-default">查询</button>
					  
					</form>
				</div>
				<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
					<div class="btn-group" style="position: relative; top: 18%;">
					  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createActivityModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
					  <button type="button" class="btn btn-default" data-toggle="modal" data-target="#editActivityModal"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
					  <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
					</div>
					
				</div>
				<div style="position: relative;top: 10px;">
					<table class="table table-hover">
						<thead>
							<tr style="color: #B3B3B3;">
								<td><input type="checkbox" /></td>
								<td>名称</td>
								<td>所有者</td>
								<td>开始日期</td>
								<td>结束日期</td>
							</tr>
						</thead>
						<tbody id="activityTbody">
							<%--
							<tr class="active">
								<td><input type="checkbox" /></td>
								<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.html';">发传单</a></td>
								<td>zhangsan</td>
								<td>2020-10-10</td>
								<td>2020-10-20</td>
							</tr>
							--%>
						</tbody>
					</table>
				</div>
				
				<div id="pages" style="height: 50px; position: relative;top: 30px;">
					<div id="activityPage"></div>
					<%--分页--%>
					<%--<div>
						<button type="button" class="btn btn-default" style="cursor: default;">共<b>50</b>条记录</button>
					</div>
					<div class="btn-group" style="position: relative;top: -34px; left: 110px;">
						<button type="button" class="btn btn-default" style="cursor: default;">显示</button>
						<div class="btn-group">
							<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
								10
								<span class="caret"></span>
							</button>
							<ul class="dropdown-menu" role="menu">
								<li><a href="#">20</a></li>
								<li><a href="#">30</a></li>
							</ul>
						</div>
						<button type="button" class="btn btn-default" style="cursor: default;">条/页</button>
					</div>
					<div style="position: relative;top: -88px; left: 285px;">
						<nav>
							<ul class="pagination">
								<li class="disabled"><a href="#">首页</a></li>
								<li class="disabled"><a href="#">上一页</a></li>
								<li class="active"><a href="#">1</a></li>
								<li><a href="#">2</a></li>
								<li><a href="#">3</a></li>
								<li><a href="#">4</a></li>
								<li><a href="#">5</a></li>
								<li><a href="#">下一页</a></li>
								<li class="disabled"><a href="#">末页</a></li>
							</ul>
						</nav>
					</div>--%>
				</div>

			</div>
			
		</div>
		<link rel="stylesheet" href="jquery/bs_pagination/jquery.bs_pagination.min.css" />
		<script src="jquery/bs_pagination/en.js"></script>
		<script src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
		<script>

			var rsc_bs_pag = {
				go_to_page_title: 'Go to page',
				rows_per_page_title: 'Rows per page',
				current_page_label: 'Page',
				current_page_abbr_label: 'p.',
				total_pages_label: 'of',
				total_pages_abbr_label: '/',
				total_rows_label: 'of',
				rows_info_records: 'records',
				go_top_text: '首页',
				go_prev_text: '上一页',
				go_next_text: '下一页',
				go_last_text: '末页'
			};
			/*//发送异步请求，获取所有市场活动
			$.get("workbench/activity/list", function (data) {
				$('#activityTbody').html("");
				for (var i = 0; i < data.list.length; i++) {
					var activity = data.list[i];
					$("#activityTbody").append("<tr class=\"active\">\n" +
							"\t\t\t\t\t\t\t\t<td><input type=\"checkbox\" /></td>\n" +
							"\t\t\t\t\t\t\t\t<td><a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='detail.html';\">"+ activity.name +"</a></td>\n" +
							"\t\t\t\t\t\t\t\t<td>"+ activity.owner +"</td>\n" +
							"\t\t\t\t\t\t\t\t<td>"+ activity.startDate +"</td>\n" +
							"\t\t\t\t\t\t\t\t<td>"+ activity.endDate +"</td>\n" +
							"\t\t\t\t\t\t\t</tr>")
				}
				for (var i = 1; i <= data.t; i++) {
					$("#pages").append("<a style='margin-left: 5px' onclick='otherPage("+ i +")' href='javascript:;'>"+ i +"</a>")
				}
			}, "json");

			function otherPage(i) {
				$.get("workbench/activity/list", {'page':i}, function (data) {
					$('#activityTbody').html("");
					for (var i = 0; i < data.list.length; i++) {
						var activity = data.list[i];
						$("#activityTbody").append("<tr class=\"active\">\n" +
								"\t\t\t\t\t\t\t\t<td><input type=\"checkbox\" /></td>\n" +
								"\t\t\t\t\t\t\t\t<td><a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='detail.html';\">"+ activity.name +"</a></td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+ activity.owner +"</td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+ activity.startDate +"</td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+ activity.endDate +"</td>\n" +
								"\t\t\t\t\t\t\t</tr>")
					}
				}, "json");
			}*/

			$.get("workbench/activity/list", function (data) {
				console.log(data);
				$('#activityTbody').html("");
				for (var i = 0; i < data.list.length; i++) {
					var activity = data.list[i];
					$("#activityTbody").append("<tr class=\"active\">\n" +
							"\t\t\t\t\t\t\t\t<td><input type=\"checkbox\" /></td>\n" +
							"\t\t\t\t\t\t\t\t<td><a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='detail.html';\">"+ activity.name +"</a></td>\n" +
							"\t\t\t\t\t\t\t\t<td>"+ activity.owner +"</td>\n" +
							"\t\t\t\t\t\t\t\t<td>"+ activity.startDate +"</td>\n" +
							"\t\t\t\t\t\t\t\t<td>"+ activity.endDate +"</td>\n" +
							"\t\t\t\t\t\t\t</tr>")
				}
			}, "json");

			$("#activityPage").bs_pagination({
				currentPage: 1, // 页码
				rowsPerPage: 30, // 每页显示的记录条数
				maxRowsPerPage: 20, // 每页最多显示的记录条数
				totalPages: 20, // 总页数
				totalRows: 50, // 总记录条数
				visiblePageLinks: 3, // 显示几个卡片
				showGoToPage: true,
				showRowsPerPage: true,
				showRowsInfo: true,
				showRowsDefaultInfo: true,
				//该函数只要操作分页插件都会触发该函数
				onChangePage : function(event, obj){
					$.get("workbench/activity/list",{
						'page':obj.currentPage
					},function (data) {
						//data:List<Activity>
						$('#activityTbody').html("");
						for(var i = 0; i < data.list.length; i++){
							var activity = data.list[i];
							//append:在指定元素的末尾拼接内容
							$('#activityTbody').append("<tr class=\"active\">\n" +
									"\t\t\t\t\t\t\t<td><input type=\"checkbox\" /></td>\n" +
									"\t\t\t\t\t\t\t<td><a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='detail.html';\">"+activity.name+"</a></td>\n" +
									"                            <td>"+activity.owner+"</td>\n" +
									"\t\t\t\t\t\t\t<td>"+activity.startDate+"</td>\n" +
									"\t\t\t\t\t\t\t<td>"+activity.endDate+"</td>\n" +
									"\t\t\t\t\t\t</tr>");
						}
					},'json');
					//pageList(obj.rowsPerPage,obj.currentPage);
				}
			});
		</script>
	</body>
</html>