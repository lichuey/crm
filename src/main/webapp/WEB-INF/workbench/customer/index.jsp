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
		<%--layer--%>
		<script type="text/javascript" src="jquery/layer/layer.js"></script>
		
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
	
		<!-- 创建客户的模态窗口 -->
		<div class="modal fade" id="createCustomerModal" role="dialog">
			<div class="modal-dialog" role="document" style="width: 85%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title" id="myModalLabel1">创建客户</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" id="saveForm" role="form">
						
							<div class="form-group">
								<label for="create-customerOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" name="owner" id="create-customerOwner">
										<c:forEach items="${userList}" var="user">
											<option value="${user.id}">${user.name}</option>
										</c:forEach>
									</select>
								</div>
								<label for="create-customerName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" name="name" id="create-customerName">
								</div>
							</div>
							
							<div class="form-group">
								<label for="create-website" class="col-sm-2 control-label">公司网站</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" name="website" id="create-website">
								</div>
								<label for="create-phone" class="col-sm-2 control-label">公司座机</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" name="phone" id="create-phone">
								</div>
							</div>
							<div class="form-group">
								<label for="create-describe" class="col-sm-2 control-label">描述</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" name="description" id="create-describe"></textarea>
								</div>
							</div>
							<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
	
							<div style="position: relative;top: 15px;">
								<div class="form-group">
									<label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
									<div class="col-sm-10" style="width: 81%;">
										<textarea class="form-control" rows="3" name="contactSummary" id="create-contactSummary"></textarea>
									</div>
								</div>
								<div class="form-group">
									<label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
									<div class="col-sm-10" style="width: 300px;">
										<input type="text" class="form-control" name="nextContactTime" id="create-nextContactTime">
									</div>
								</div>
							</div>
	
							<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>
	
							<div style="position: relative;top: 20px;">
								<div class="form-group">
									<label for="create-address1" class="col-sm-2 control-label">详细地址</label>
									<div class="col-sm-10" style="width: 81%;">
										<textarea class="form-control" rows="1" name="address" id="create-address1"></textarea>
									</div>
								</div>
							</div>
						</form>
						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" onclick="saveOrUpdate($(this).text())" id="saveCustomer" class="btn btn-primary" data-dismiss="modal">保存</button>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 修改客户的模态窗口 -->
		<div class="modal fade" id="editCustomerModal" role="dialog">
			<div class="modal-dialog" role="document" style="width: 85%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">修改客户</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" id="updateForm" role="form">
						
							<div class="form-group">
								<label for="edit-customerOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" name="owner" id="edit-customerOwner">
										<c:forEach items="${userList}" var="user">
											<option value="${user.id}">${user.name}</option>
										</c:forEach>
									</select>
								</div>
								<label for="edit-customerName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<%--隐藏域，客户id--%>
									<input type="hidden" name="id" id="id">
									<input type="text" class="form-control" name="name" id="edit-customerName">
								</div>
							</div>
							
							<div class="form-group">
								<label for="edit-website" class="col-sm-2 control-label">公司网站</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" name="website" id="edit-website">
								</div>
								<label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" name="phone" id="edit-phone">
								</div>
							</div>
							
							<div class="form-group">
								<label for="edit-describe" class="col-sm-2 control-label">描述</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" name="description" id="edit-describe"></textarea>
								</div>
							</div>
							
							<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
	
							<div style="position: relative;top: 15px;">
								<div class="form-group">
									<label for="create-contactSummary1" class="col-sm-2 control-label">联系纪要</label>
									<div class="col-sm-10" style="width: 81%;">
										<textarea class="form-control" rows="3" name="contactSummary" id="create-contactSummary1"></textarea>
									</div>
								</div>
								<div class="form-group">
									<label for="create-nextContactTime2" class="col-sm-2 control-label">下次联系时间</label>
									<div class="col-sm-10" style="width: 300px;">
										<input type="text" class="form-control" name="nextContactTime" id="create-nextContactTime2">
									</div>
								</div>
							</div>
	
							<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>
	
							<div style="position: relative;top: 20px;">
								<div class="form-group">
									<label for="create-address" class="col-sm-2 control-label">详细地址</label>
									<div class="col-sm-10" style="width: 81%;">
										<textarea class="form-control" rows="1" name="address" id="create-address"></textarea>
									</div>
								</div>
							</div>
						</form>
						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" onclick="saveOrUpdate($(this).text())" class="btn btn-primary" data-dismiss="modal">更新</button>
					</div>
				</div>
			</div>
		</div>
		
		
		<%------------------------------------------------------------------------------------------------------------------------------%>
		
		<div>
			<div style="position: relative; left: 10px; top: -10px;">
				<div class="page-header">
					<h3>客户列表</h3>
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
						  <input class="form-control" type="text" id="name">
						</div>
					  </div>
					  
					  <div class="form-group">
						<div class="input-group">
						  <div class="input-group-addon">所有者</div>
						  <input class="form-control" type="text" id="owner">
						</div>
					  </div>
					  
					  <div class="form-group">
						<div class="input-group">
						  <div class="input-group-addon">公司座机</div>
						  <input class="form-control" type="text" id="phone">
						</div>
					  </div>
					  
					  <div class="form-group">
						<div class="input-group">
						  <div class="input-group-addon">公司网站</div>
						  <input class="form-control" type="text" id="website">
						</div>
					  </div>
					  
					  <button type="button" onclick="queryCustomer();" class="btn btn-default">查询</button>
					  
					</form>
				</div>
				<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
					<div class="btn-group" style="position: relative; top: 18%;">
					  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createCustomerModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
					  <button type="button" class="btn btn-default" onclick="showModel()" data-target="#editCustomerModal"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
					  <button type="button" class="btn btn-danger" onclick="deleteCustomer()"><span class="glyphicon glyphicon-minus"></span> 删除</button>
					</div>
					
				</div>
				<div style="position: relative;top: 10px;">
					<table class="table table-hover">
						<thead>
							<tr style="color: #B3B3B3;">
								<td><input id="father" type="checkbox" /></td>
								<td>名称</td>
								<td>所有者</td>
								<td>公司座机</td>
								<td>公司网站</td>
							</tr>
						</thead>
						<tbody id="customerTbody">
							<%--
							<tr>
								<td><input type="checkbox" /></td>
								<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.html';">动力节点</a></td>
								<td>zhangsan</td>
								<td>010-84846003</td>
								<td>http://www.bjpowernode.com</td>
							</tr>
							--%>
						</tbody>
					</table>
				</div>
				
				<div style="height: 50px; position: relative;top: 30px;">
					<div id="customerPage">
					</div>
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
		<%--分页--%>
		<link rel="stylesheet" href="jquery/bs_pagination/jquery.bs_pagination.min.css"/>
		<script src="jquery/bs_pagination/en.js"></script>
		<script src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
		<script>

			//分页
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

			//刷新页面
			refresh(1, 2);

			//刷新
			function refresh(page,pageSize) {
				//清空
				$("#customerTbody").html("");
				$.get("workbench/customer/selectCustomer", {
					"page": page,
					"pageSize": pageSize,
					"name": $("#name").val(),
					"owner": $("#owner").val(),
					"phone": $("#phone").val(),
					"website": $("#website").val()
				},function (data) {
					//data:PageInfo
					var customerList = data;
					for (var i = 0; i < customerList.list.length; i++) {
						var customer = customerList.list[i];
						$("#customerTbody").append("<tr>\n" +
								"\t\t\t\t\t\t\t\t<td><input class='son' type=\"checkbox\" onclick='clickSon()' value='"+ customer.id +"' /></td>\n" +
								"\t\t\t\t\t\t\t\t<td><a style=\"text-decoration: none; cursor: pointer;\" href='toView/workbench/customer/detail?id=" + customer.id + "'>" + customer.name + "</a></td>\n" +
								"\t\t\t\t\t\t\t\t<td>" + customer.owner + "</td>\n" +
								"\t\t\t\t\t\t\t\t<td>" + customer.phone + "</td>\n" +
								"\t\t\t\t\t\t\t\t<td>" + customer.website + "</td>\n" +
								"\t\t\t\t\t\t\t</tr>")
					}
					$("#customerPage").bs_pagination({
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
				}, "json");
			}

			//查询客户
			function queryCustomer() {
				refresh(1, 2);
			}

			/*//查询所有用户
			$.get("workbench/customer/queryUser", function (data) {
				var userList = data;
				for (var i in userList) {
					//用户
					var user = userList[i];
					$("#create-customerOwner").append("<option value='" + user.id + "'>" + user.name + "</option>");
				}
			}, "json");*/

			//保存更新客户
			function saveOrUpdate(text) {
				var form;
				if ("保存" == text) {
					form = $("#saveForm").serialize();
				} else if ("更新" == text) {
					form = $("#updateForm").serialize();
				}
				$.post("workbench/customer/saveOrUpdate", form, function (data) {
					//data:resultVo
					if (data.resOK) {
						alert(data.message);

						//刷新数据
						refresh(1, 2);

						//重置表单
						document.querySelectorAll("#saveForm").reset();
					}
				}, "json");
			}
			
			//father被选中
			$("#father").click(function () {
				$(".son").prop("checked",$(this).prop("checked"))
			});

			//son被选中
			function clickSon(){
				var checkedLength = $(".son:checked").length;
				var length = $(".son").length;
				if (checkedLength == length) {
					$("#father").prop("checked", true);
				} else {
					$("#father").prop("checked", false);
				}
			}

			//展现模态框
			function showModel() {
				var checkedLength = $(".son:checked").length;
				if (checkedLength === 0) {
					alert("至少选择一个");
				} else if (checkedLength > 1) {
					alert("选择不能多于一个");
				} else {
					//展现模态框
					$("#editCustomerModal").modal("show");

					//获取选中客户的id
					var id = $($(".son:checked")[0]).val();
					//异步获取所有客户数据
					$.get("workbench/customer/queryCustomerById", {
						"id": id
					}, function (data) {
						//data:Customer
						var customer = data;
						//给模态框中数据赋值
						$("#edit-customerName").val(customer.name);
						$("#edit-website").val(customer.website);
						$("#edit-phone").val(customer.phone);
						$("#edit-describe").val(customer.description);
						$("#create-contactSummary1").val(customer.contactSummary);
						$("#create-nextContactTime2").val(customer.nextContactTime);
						$("#create-address").val(customer.address);
						//把客户的id设置到隐藏域中
						$("#id").val(customer.id);

						$("#edit-customerOwner").val(customer.owner);
						/*//查询所有owner
						$.get("workbench/customer/queryAllUser", function (data) {
							$("#edit-customerOwner").html("");
							var userList = data;
							for (var i = 0; i < userList.length; i++) {
								var user = userList[i];
								if (customer.owner == user.id) {
									$("#edit-customerOwner").append("<option selected value='" + user.id + "'>" + user.name + "</option>\n");
								} else {
									$("#edit-customerOwner").append("<option value='" + user.id + "'>" + user.name + "</option>\n");
								}
							}
						},"json");*/
					}, "json");
				}
			}

			//删除客户
			function deleteCustomer() {
				var checkedLength = $(".son:checked").length;
				if (checkedLength === 0) {
					alert("至少选择一个客户");
				} else {
					layer.alert('你确定删除这'+ checkedLength +'个客户吗？', {
						time: 0 //不自动关闭
						,btn: ['删除', '取消']
						,yes: function(index){
							layer.close(index);

							var ids = [];
							$(".son:checked").each(function () {
								ids.push($(this).val());
							});
							//异步删除客户
							$.post("workbench/customer/deleteCustomerById", {
								"ids": ids.join()
							}, function (data) {
								//data:resultVo
								if (data.resOK) {
									alert(data.message);
									refresh(1, 2);

									//所有的选中都不选中
									$("#father").prop("checked", false);
								}
							}, "json");
						}
					});
				}
			}
		</script>
	</body>
</html>