<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
		<%--分页--%>
		<link rel="stylesheet" href="/crm/jquery/bs_pagination/jquery.bs_pagination.min.css" />
		<script src="/crm/jquery/bs_pagination/en.js"></script>
		<script src="/crm/jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
		<%--日历插件--%>
		<script type="text/javascript" src="/crm/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
		<script type="text/javascript" src="/crm/jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
		<%--弹出框--%>
		<script type="text/javascript" src="/crm/jquery/layer/layer.js"></script>
		<script type="text/javascript">
		
			$(function(){
				
				//定制字段
				$("#definedColumns > li").click(function(e) {
					//防止下拉菜单消失
					e.stopPropagation();
				});
				
			});
			
		</script>
	</head>
	<body>
	
		
		<!-- 创建联系人的模态窗口 -->
		<div class="modal fade" id="createContactsModal" role="dialog">
			<div class="modal-dialog" role="document" style="width: 85%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" onclick="$('#createContactsModal').modal('hide');">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title" id="myModalLabelx">创建联系人</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" role="form" id="saveForm">
						
							<div class="form-group">
								<label for="create-contactsOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="create-contactsOwner" name="owner">
									   <c:forEach items="${userList}" var="user">
										   <option value="${user.id}">${user.name}</option>
									   </c:forEach>
									</select>
								</div>
								<label for="create-clueSource" class="col-sm-2 control-label">来源</label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="create-clueSource" name="source">
									  	<option></option>
										<c:forEach items="${map['source']}" var="source">
											<option value="${source.value}">${source.text}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							
							<div class="form-group">
								<label for="create-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-surname" name="fullname">
								</div>
								<label for="create-call" class="col-sm-2 control-label">称呼</label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="create-call" name="appellation">
									  <option></option>
									  <c:forEach items="${map['appellation']}" var="appellation">
										  <option value="${appellation.value}">${appellation.text}</option>
									  </c:forEach>
									</select>
								</div>
								
							</div>
							
							<div class="form-group">
								<label for="create-job" class="col-sm-2 control-label">职位</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-job" name="job">
								</div>
								<label for="create-mphone" class="col-sm-2 control-label">手机</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-mphone" name="mphone">
								</div>
							</div>
							
							<div class="form-group" style="position: relative;">
								<label for="create-email" class="col-sm-2 control-label">邮箱</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-email" name="email">
								</div>
								<label for="create-birth" class="col-sm-2 control-label">生日</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-birth" name="birth">
								</div>
							</div>
							
							<div class="form-group" style="position: relative;">
								<label for="create-customerName" class="col-sm-2 control-label">客户名称</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-customerName" placeholder="支持自动补全，输入客户不存在则新建" name="customerId">
								</div>
							</div>
							
							<div class="form-group" style="position: relative;">
								<label for="create-describe" class="col-sm-2 control-label">描述</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="create-describe" name="description"></textarea>
								</div>
							</div>
							
							<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
							
							<div style="position: relative;top: 15px;">
								<div class="form-group">
									<label for="create-contactSummary1" class="col-sm-2 control-label">联系纪要</label>
									<div class="col-sm-10" style="width: 81%;">
										<textarea class="form-control" rows="3" id="create-contactSummary1" name="contactSummary"></textarea>
									</div>
								</div>
								<div class="form-group">
									<label for="create-nextContactTime1" class="col-sm-2 control-label">下次联系时间</label>
									<div class="col-sm-10" style="width: 300px;">
										<input type="text" class="form-control" id="create-nextContactTime1" name="nextContactTime">
									</div>
								</div>
							</div>
	
							<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>
	
							<div style="position: relative;top: 20px;">
								<div class="form-group">
									<label for="edit-address1" class="col-sm-2 control-label">详细地址</label>
									<div class="col-sm-10" style="width: 81%;">
										<textarea class="form-control" rows="1" id="edit-address1" name="address">北京大兴区大族企业湾</textarea>
									</div>
								</div>
							</div>
						</form>
						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="saveOrUpdate($(this).text())">保存</button>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 修改联系人的模态窗口 -->
		<div class="modal fade" id="editContactsModal" role="dialog">
			<div class="modal-dialog" role="document" style="width: 85%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title" id="myModalLabel1">修改联系人</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" role="form" id="editForm">
						
							<div class="form-group">
								<label for="edit-contactsOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="edit-contactsOwner" name="owner">
									  <c:forEach items="${userList}" var="user">
										  <option value="${user.id}">${user.name}</option>
									  </c:forEach>
									</select>
								</div>
								<label for="edit-clueSource1" class="col-sm-2 control-label">来源</label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="edit-clueSource1" name="source">
									  <option></option>
									  <c:forEach items="${map['source']}" var="source">
										  <option value="${source.value}">${source.text}</option>
									  </c:forEach>
									</select>
								</div>
							</div>
							
							<div class="form-group">
								<label for="edit-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-surname" value="李四" name="fullname">
								</div>
								<label for="edit-call" class="col-sm-2 control-label">称呼</label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="edit-call" name="appellation">
									  <option></option>
									  <c:forEach items="${map['appellation']}" var="appellation">
										  <option value="${appellation.value}">${appellation.text}</option>
									  </c:forEach>
									</select>
								</div>
							</div>
							
							<div class="form-group">
								<label for="edit-job" class="col-sm-2 control-label">职位</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-job" value="CTO" name="job">
								</div>
								<label for="edit-mphone" class="col-sm-2 control-label">手机</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-mphone" value="12345678901" name="mphone">
								</div>
							</div>
							
							<div class="form-group">
								<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-email" value="lisi@bjpowernode.com" name="email">
								</div>
								<label for="edit-birth" class="col-sm-2 control-label">生日</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-birth" name="birth">
								</div>
							</div>
							
							<div class="form-group">
								<label for="edit-customerName" class="col-sm-2 control-label">客户名称</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-customerName" placeholder="支持自动补全，输入客户不存在则新建" value="动力节点" name="customerId">
								</div>
							</div>
							
							<div class="form-group">
								<label for="edit-describe" class="col-sm-2 control-label">描述</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="edit-describe" name="description">这是一条线索的描述信息</textarea>
								</div>
							</div>
							
							<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
							
							<div style="position: relative;top: 15px;">
								<div class="form-group">
									<label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
									<div class="col-sm-10" style="width: 81%;">
										<textarea class="form-control" rows="3" id="create-contactSummary" name="contactSummary"></textarea>
									</div>
								</div>
								<div class="form-group">
									<label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
									<div class="col-sm-10" style="width: 300px;">
										<input type="text" class="form-control" id="create-nextContactTime" name="nextContactTime">
									</div>
								</div>
							</div>
							
							<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>
	
							<div style="position: relative;top: 20px;">
								<div class="form-group">
									<label for="edit-address2" class="col-sm-2 control-label">详细地址</label>
									<div class="col-sm-10" style="width: 81%;">
										<textarea class="form-control" rows="1" id="edit-address2" name="address">北京大兴区大族企业湾</textarea>
									</div>
								</div>
							</div>
							<input type="hidden" id="id" name="id" />
						</form>
						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="saveOrUpdate($(this).text())">更新</button>
					</div>
				</div>
			</div>
		</div>
		
		
		
		<%------------------------------------------------------------------------------------------------------------%>
		
		<div>
			<div style="position: relative; left: 10px; top: -10px;">
				<div class="page-header">
					<h3>联系人列表</h3>
				</div>
			</div>
		</div>
		
		<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		
			<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
			
				<div class="btn-toolbar" role="toolbar" style="height: 80px;">
					<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
					  
					  <div class="form-group">
						<div class="input-group">
						  <div class="input-group-addon">所有者</div>
						  <input class="form-control" type="text" name="owner" id="owner">
						</div>
					  </div>
					  
					  <div class="form-group">
						<div class="input-group">
						  <div class="input-group-addon">姓名</div>
						  <input class="form-control" type="text" name="fullname" id="fullname">
						</div>
					  </div>
					  
					  <div class="form-group">
						<div class="input-group">
						  <div class="input-group-addon">客户名称</div>
						  <input class="form-control" type="text" name="customerId" id="customerId">
						</div>
					  </div>
					  
					  <br>
					  
					  <div class="form-group">
						<div class="input-group">
						  <div class="input-group-addon">来源</div>
						  <select class="form-control" id="edit-clueSource" name="source">
							  <option></option>
							  <c:forEach items="${map['source']}" var="source">
								  <option value="${source.value}">${source.text}</option>
							  </c:forEach>
							</select>
						</div>
					  </div>
					  
					  <div class="form-group">
						<div class="input-group">
						  <div class="input-group-addon">生日</div>
						  <input class="form-control" type="text" id="birth" name="birth">
						</div>
					  </div>
					  
					  <button type="button" class="btn btn-default" onclick="query()">查询</button>
					  
					</form>
				</div>
				<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
					<div class="btn-group" style="position: relative; top: 18%;">
					  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createContactsModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
					  <button type="button" class="btn btn-default" data-toggle="modal" onclick="openEditModal()"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
					  <button type="button" class="btn btn-danger" onclick="deleteContacts()"><span class="glyphicon glyphicon-minus"></span> 删除</button>
					</div>
					
					
				</div>
				<div style="position: relative;top: 20px;">
					<table class="table table-hover">
						<thead>
							<tr style="color: #B3B3B3;">
								<td><input type="checkbox" id="father" /></td>
								<td>姓名</td>
								<td>客户名称</td>
								<td>所有者</td>
								<td>来源</td>
								<td>生日</td>
							</tr>
						</thead>
						<tbody id="contactsTbody">
							<%--
							<tr>
								<td><input type="checkbox" /></td>
								<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.html';">李四</a></td>
								<td>动力节点</td>
								<td>zhangsan</td>
								<td>广告</td>
								<td>2000-10-10</td>
							</tr>
							--%>
						</tbody>
					</table>
				</div>
				
				<div style="height: 50px; position: relative;top: 10px;">
					<div id="contactsPage"></div>
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
	</body>
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

		refresh(1,3);

		//刷新页面
		function refresh(page,pageSize){
			//查询市场活动数据列表
			$.get("workbench/contacts/list", {
				'page': page,
				'pageSize': pageSize,
				'owner': $('#owner').val(),
				'fullname': $('#fullname').val(),
				'customerId': $('#customerId').val(),
				'source': $('#edit-clueSource').val(),
				'birth': $('#birth').val()
			}, function (data) {
				//data:PageInfo
				$('#contactsTbody').html("");
				for (var i = 0; i < data.list.length; i++) {
					var contacts = data.list[i];
					$('#contactsTbody').append("<tr>\n" +
							"\t\t\t\t\t\t\t\t<td><input type=\"checkbox\" value="+ contacts.id +" class='son' onclick='abc()' '/></td>\n" +
							"\t\t\t\t\t\t\t\t<td><a style=\"text-decoration: none; cursor: pointer;\" href='toView/workbench/contacts/detail?id="+contacts.id+"'>" + contacts.fullname + "</a></td>\n" +
							"\t\t\t\t\t\t\t\t<td>" + contacts.customerId + "</td>\n" +
							"\t\t\t\t\t\t\t\t<td>" + contacts.owner + "</td>\n" +
							"\t\t\t\t\t\t\t\t<td>" + contacts.source + "</td>\n" +
							"\t\t\t\t\t\t\t\t<td>" + contacts.birth + "</td>\n" +
							"\t\t\t\t\t\t\t</tr>");
				}

				//分页插件
				$("#contactsPage").bs_pagination({
					currentPage: data.pageNum, // 页码
					rowsPerPage: data.pageSize, // 每页显示的记录条数
					maxRowsPerPage: 20, // 每页最多显示的记录条数
					totalPages: data.pages, // 总页数
					totalRows: data.total, // 总记录条数
					visiblePageLinks: 3, // 显示几个卡片
					showGoToPage: true,
					showRowsPerPage: true,
					showRowsInfo: true,
					showRowsDefaultInfo: true,
					//该函数只要操作分页插件都会触发该函数
					onChangePage: function (event, obj) {
						refresh(obj.currentPage, obj.rowsPerPage);
					}
				});
			}, 'json');
		}

		//模糊查询
		function query() {
			refresh(1,3);
		}

		//防止日历插件乱码
		(function($){
			$.fn.datetimepicker.dates['zh-CN'] = {
				days: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"],
				daysShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日"],
				daysMin:  ["日", "一", "二", "三", "四", "五", "六", "日"],
				months: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
				monthsShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
				today: "今天",
				suffix: [],
				meridiem: ["上午", "下午"]
			};
		}(jQuery));

		//日历插件
		$("#birth").datetimepicker({
			language:  "zh-CN",
			format: "yyyy-mm-dd",//显示格式
			minView: "month",//设置只显示到月份
			initialDate: new Date(),//初始化当前日期
			autoclose: true,//选中自动关闭
			todayBtn: true, //显示今日按钮
			clearBtn : true,
			pickerPosition: "bottom-left"
		});

		/*//异步查询所有用户信息
		$.get("workbench/contacts/queryUsers",function (data) {
			//data:List<User>
			//清空内容
			$('#create-contactsOwner').html("");
			for(var i in data){
				var user = data[i];
				$('#create-contactsOwner').append("<option value="+user.id+">"+user.name+"</option>");

			}
		},'json');*/

		//异步保存或者修改市场活动 bind:绑定所有事件 参数1:绑定的事件名称 参数2:触发的函数
		function saveOrUpdate(text){
			var form;
			if("保存" == text){
				form = $('#saveForm').serialize();
			}else if("更新" == text){
				form =  $('#editForm').serialize();
			}

			$.post("workbench/contacts/saveOrUpdate",form,function (data) {
				//data:resultVo
				if(data.resOK){
					alert(data.message);

					//手动刷新数据
					refresh(1,3);

					//重置表单 jquery没有对应的函数，原生态的js有
					//document.getElementById("form").reset();
					//html5才有
					document.querySelector("#saveForm").reset();
				}
			},'json');
		}

		//全选、反选功能
		$('#father').click(function () {
			//方式二
			$('.son').prop('checked',$(this).prop('checked'));
		});

		function abc() {
			//获取勾中的son的个数
			var checkedLength = $('.son:checked').length;
			//获取所有son的个数
			var length = $('.son').length;
			if(checkedLength == length){
				$('#father').prop('checked',true);
			}else{
				$('#father').prop('checked',false);
			}
		}

		//点击修改按钮的js判断 勾中一条记录
		function openEditModal() {
			//获取勾中的son的个数
			var checkedLength = $('.son:checked').length;
			if(checkedLength > 1){
				alert("只能选中一条记录");
			}else if(checkedLength === 0){
				alert("至少一条记录");
			}else{
				//弹出模态窗口 显示:show 隐藏:hide
				$('#editContactsModal').modal("show");

				//发送异步请求，根据主键查询市场活动信息

				//jquery-->js arr[0],arr.get(0) js-->jquery $(a)
				//$('.son:checked')[0].value;
				var id = $($('.son:checked')[0]).val();
				$.get("workbench/contacts/queryById",{'id':id},function (data) {
					var contacts = data;
					//data:Contacts owner

						$("#edit-contactsOwner").val(contacts.owner);
						//设置模态窗口中的内容
						$('#edit-clueSource1').val(contacts.source);
						$('#edit-surname').val(contacts.fullname);
						$('#edit-call').val(contacts.appellation);
						$('#edit-job').val(contacts.job);
						$('#edit-mphone').val(contacts.mphone);
						$('#edit-email').val(contacts.email);
						$('#edit-birth').val(contacts.birth);
						$('#edit-customerName').val(contacts.customerId);
						$('#edit-describe').val(contacts.description);
						$('#edit-contactSummary').val(contacts.contactSummary);
						$('#edit-nextContactTime').val(contacts.nextContactTime);
						$('#edit-address2').val(contacts.address);
						//把市场活动主键设置到隐藏域中
						$('#id').val(contacts.id);


				},'json');
			}
		}

		//点击删除按钮，删除联系人
		function deleteContacts() {
			//获取勾中的son的个数
			var length = $('.son:checked').length;
			if(length == 0){
				alert("至少选中一条记录")
			}else{
				layer.alert("删除选中的"+length+"条数据吗？", {
					time: 0 //不自动关闭
					,btn: ['确定', '取消']
					,yes: function(index){
						//index:按钮的索引
						layer.close(index);

						var ids = [];
						$('.son:checked').each(function () {
							//push:向数组中放入元素
							ids.push($(this).val());
						});
						//join:把数组中的内容按指定的分隔符拼接成字符串 默认的分隔符就是,
						$.post("workbench/contacts/deleteBatch",{'ids':ids.join()},function (data) {
							//data:resultVo
							if(data.resOK){
								alert(data.message);
								refresh(1,3);
							}
						},'json');

					}
				});
			}
		}

	</script>
</html>