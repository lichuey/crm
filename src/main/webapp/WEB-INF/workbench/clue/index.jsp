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
		<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
		<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
		<%--分页--%>
		<link rel="stylesheet" href="jquery/bs_pagination/jquery.bs_pagination.min.css"/>
		<script src="jquery/bs_pagination/en.js"></script>
		<script src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
		<%--弹出框--%>
		<script src="jquery/layer/layer.js"></script>

	</head>
	<body>
	
		<!-- 创建线索的模态窗口 -->
		<div class="modal fade" id="createClueModal" role="dialog">
			<div class="modal-dialog" role="document" style="width: 90%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">创建线索</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" role="form" id="createForm">
						
							<div class="form-group">
								<label for="create-clueOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="create-clueOwner" name="owner">
									  <c:forEach items="${userList}" var="user">
										  <option value="${user.id}">${user.name}</option>
									  </c:forEach>
									</select>
								</div>
								<label for="create-company" class="col-sm-2 control-label">公司<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-company" name="company">
								</div>
							</div>
							
							<div class="form-group">
								<label for="create-call" class="col-sm-2 control-label">称呼</label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="create-call" name="appellation">
									  <option></option>
									  <c:forEach items="${map['appellation']}" var="appellation">
										  <option value="${appellation.value}">${appellation.text}</option>
									  </c:forEach>
									</select>
								</div>
								<label for="create-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-surname" name="fullname">
								</div>
							</div>
							
							<div class="form-group">
								<label for="create-job" class="col-sm-2 control-label">职位</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-job" name="job">
								</div>
								<label for="create-email" class="col-sm-2 control-label">邮箱</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-email" name="email">
								</div>
							</div>
							
							<div class="form-group">
								<label for="create-phone" class="col-sm-2 control-label">公司座机</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-phone" name="phone">
								</div>
								<label for="create-website" class="col-sm-2 control-label">公司网站</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-website" name="website">
								</div>
							</div>
							
							<div class="form-group">
								<label for="create-mphone" class="col-sm-2 control-label">手机</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-mphone" name="mphone">
								</div>
								<label for="create-status" class="col-sm-2 control-label">线索状态</label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="create-status" name="state">
									  <option></option>
									  <c:forEach items="${map['clueState']}" var="clueState">
										  <option value="${clueState.value}">${clueState.text}</option>
									  </c:forEach>
									</select>
								</div>
							</div>
							
							<div class="form-group">
								<label for="create-source" class="col-sm-2 control-label">线索来源</label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="create-source" name="source">
									  <option></option>
									  <c:forEach items="${map['source']}" var="source">
										  <option value="${source.value}">${source.text}</option>
									  </c:forEach>
									</select>
								</div>
							</div>
							
	
							<div class="form-group">
								<label for="create-describe" class="col-sm-2 control-label">线索描述</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="create-describe" name="description"></textarea>
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
									<label for="create-address" class="col-sm-2 control-label">详细地址</label>
									<div class="col-sm-10" style="width: 81%;">
										<textarea class="form-control" rows="1" id="create-address" name="address"></textarea>
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
		
		<!-- 修改线索的模态窗口 -->
		<div class="modal fade" id="editClueModal" role="dialog">
			<div class="modal-dialog" role="document" style="width: 90%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title">修改线索</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" role="form" id="editForm">
						
							<div class="form-group">
								<label for="edit-clueOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="edit-clueOwner" name="owner">
									  <c:forEach items="${userList}" var="user">
										  <option value="${user.id}">${user.name}</option>
									  </c:forEach>
									</select>
								</div>
								<label for="edit-company" class="col-sm-2 control-label">公司<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-company" name="company" >
									<%--id隐藏域--%>
									<input type="hidden" id="id" name="id"/>
								</div>
							</div>
							
							<div class="form-group">
								<label for="edit-call" class="col-sm-2 control-label">称呼</label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="edit-call" name="appellation">
										<option value=""></option>
									  	<c:forEach items="${map['appellation']}" var="appellation">
										  	<option value="${appellation.value}">${appellation.text}</option>
									  	</c:forEach>
									</select>
								</div>
								<label for="edit-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-surname" name="fullname">
								</div>
							</div>
							
							<div class="form-group">
								<label for="edit-job" class="col-sm-2 control-label">职位</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-job" name="job">
								</div>
								<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-email" name="email">
								</div>
							</div>
							
							<div class="form-group">
								<label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-phone" name="phone">
								</div>
								<label for="edit-website" class="col-sm-2 control-label">公司网站</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-website" name="website">
								</div>
							</div>
							
							<div class="form-group">
								<label for="edit-mphone" class="col-sm-2 control-label">手机</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-mphone" name="mphone">
								</div>
								<label for="edit-status" class="col-sm-2 control-label">线索状态</label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="edit-status" name="state">
									  <option></option>
									  <c:forEach items="${map['clueState']}" var="clueState">
										  <option value="${clueState.value}">${clueState.text}</option>
									  </c:forEach>
									</select>
								</div>
							</div>
							
							<div class="form-group">
								<label for="edit-source" class="col-sm-2 control-label">线索来源</label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="edit-source" name="source">
									  	<option></option>
										<c:forEach items="${map['source']}" var="source">
											<option value="${source.value}">${source.text}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							
							<div class="form-group">
								<label for="edit-describe" class="col-sm-2 control-label">描述</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="edit-describe" name="description"></textarea>
								</div>
							</div>
							
							<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
							
							<div style="position: relative;top: 15px;">
								<div class="form-group">
									<label for="edit-contactSummary" class="col-sm-2 control-label">联系纪要</label>
									<div class="col-sm-10" style="width: 81%;">
										<textarea class="form-control" rows="3" id="edit-contactSummary" name="contactSummary"></textarea>
									</div>
								</div>
								<div class="form-group">
									<label for="edit-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
									<div class="col-sm-10" style="width: 300px;">
										<input type="text" class="form-control" id="edit-nextContactTime" name="nextContactTime">
									</div>
								</div>
							</div>
							
							<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>
	
							<div style="position: relative;top: 20px;">
								<div class="form-group">
									<label for="edit-address" class="col-sm-2 control-label">详细地址</label>
									<div class="col-sm-10" style="width: 81%;">
										<textarea class="form-control" rows="1" id="edit-address" name="address"></textarea>
									</div>
								</div>
							</div>
						</form>
						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="saveOrUpdate($(this).text())">更新</button>
					</div>
				</div>
			</div>
		</div>
		
		
		
		
		<div>
			<div style="position: relative; left: 10px; top: -10px;">
				<div class="page-header">
					<h3>线索列表</h3>
				</div>
			</div>
		</div>
		
		<div style="position: relative; top: -20px; left: 0; width: 100%; height: 100%;">
		
			<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
			
				<div class="btn-toolbar" role="toolbar" style="height: 80px;">
					<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
					  
					  <div class="form-group">
						<div class="input-group">
						  <div class="input-group-addon">名称</div>
						  <input class="form-control" type="text" id="fullname">
						</div>
					  </div>
					  
					  <div class="form-group">
						<div class="input-group">
						  <div class="input-group-addon">公司</div>
						  <input class="form-control" type="text" id="company">
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
						  <div class="input-group-addon">线索来源</div>
						  <select class="form-control" id="source">
							  <option></option>
							  <c:forEach items="${map['source']}" var="source">
									<option value="${source.value}">${source.text}</option>
							  </c:forEach>
						  </select>
						</div>
					  </div>
					  
					  <br>
					  
					  <div class="form-group">
						<div class="input-group">
						  <div class="input-group-addon">所有者</div>
						  <input class="form-control" type="text" id="owner">
						</div>
					  </div>
					  
					  
					  
					  <div class="form-group">
						<div class="input-group">
						  <div class="input-group-addon">手机</div>
						  <input class="form-control" type="text" id="mphone">
						</div>
					  </div>
					  
					  <div class="form-group">
						<div class="input-group">
						  <div class="input-group-addon">线索状态</div>
						  <select class="form-control" id="state">
							<option></option>
							<c:forEach items="${map['clueState']}" var="clueState">
								<option value="${clueState.value}">${clueState.text}</option>
							</c:forEach>
						  </select>
						</div>
					  </div>
	
					  <button type="button" class="btn btn-default" onclick="clueQuery()">查询</button>
					  
					</form>
				</div>
				<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 40px;">
					<div class="btn-group" style="position: relative; top: 18%;">
					  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createClueModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
					  <button type="button" class="btn btn-default" data-toggle="modal" onclick="openEditModel()"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
					  <button type="button" class="btn btn-danger" onclick="deleteClues()"><span class="glyphicon glyphicon-minus"></span> 删除</button>
					</div>
					
					
				</div>
				<div style="position: relative;top: 50px;">
					<table class="table table-hover">
						<thead>
							<tr style="color: #B3B3B3;">
								<td><input type="checkbox" id="father" /></td>
								<td>名称</td>
								<td>公司</td>
								<td>公司座机</td>
								<td>手机</td>
								<td>线索来源</td>
								<td>所有者</td>
								<td>线索状态</td>
							</tr>
						</thead>
						<tbody id="clueTbody">
							<%--<tr class="active">
								<td><input type="checkbox" /></td>
								<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.html';">李四先生</a></td>
								<td>动力节点</td>
								<td>010-84846003</td>
								<td>12345678901</td>
								<td>广告</td>
								<td>zhangsan</td>
								<td>已联系</td>
							</tr>--%>
						</tbody>
					</table>
				</div>
				
				<div style="height: 50px; position: relative;top: 60px;">
					<div id="cluePage"></div>
				</div>
			</div>
		</div>
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

			refresh(1, 3);

			//刷新页面
			function refresh(page, pageSize) {
				//查询市场活动列表
				$.get("workbench/clue/list", {
					"page": page,
					"pageSize": pageSize,
					"fullname": $("#fullname").val(),
					"company": $("#company").val(),
					"phone": $("#phone").val(),
					"source": $("#source").val(),
					"owner": $("#owner").val(),
					"mphone": $("#mphone").val(),
					"state": $("#state").val()
				}, function (data) {
					$('#clueTbody').html("");
					for (var i = 0; i < data.list.length; i++) {
						var clue = data.list[i];
						$("#clueTbody").append("<tr class=\"active\">\n" +
								"\t\t\t\t\t\t\t\t<td><input type=\"checkbox\" value='"+ clue.id +"' class='son' onclick='clickSon()'/></td>\n" +
								"\t\t\t\t\t\t\t\t<td><a style=\"text-decoration: none; cursor: pointer;\" href='toView/workbench/clue/detail?id="+ clue.id +"'>" + clue.fullname + clue.appellation + "</a></td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+ clue.company +"</td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+ clue.phone +"</td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+ clue.mphone +"</td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+ clue.source +"</td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+ clue.owner +"</td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+ clue.state +"</td>\n" +
								"\t\t\t\t\t\t\t</tr>");

					}
					$("#cluePage").bs_pagination({
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

			function clueQuery() {
				refresh(1, 3);
			}

			//保存或更新
			function saveOrUpdate(text) {
				var form;
				if ("保存" == text) {
					form = $('#createForm').serialize();
				} else if ("更新" == text) {
					form = $("#editForm").serialize();
				}
				$.post("workbench/clue/saveOrUpdate", form, function (data) {
					//data：resultVo
					if (data.resOK) {
						alert(data.message);
					}

					//手动刷新
					refresh(1, 3);

					//重置表单 jquery没有对应的函数，原生态的js有  方案一
					//document.getElementById("createForm").reset();

					//方案二
					document.querySelector("#createForm").reset();
				}, "json");
			}

			//father点击
			$("#father").click(function () {
				$(".son").prop("checked", $(this).prop("checked"));
			});

			//son全选
			function clickSon() {
				var sonCheckedLength = $(".son:checked").length;
				var sonLength = $(".son").length;
				if (sonCheckedLength == sonLength) {
					$("#father").prop("checked", true);
				} else {
					$("#father").prop("checked", false);
				}
			}

			//点击修改按钮的js判断 勾中一条记录
			function openEditModel() {
				var sonCheckedLength = $(".son:checked").length;
				if (sonCheckedLength === 0) {
					alert("选中线索数不能为空");
				}else if (sonCheckedLength > 1) {
					alert("选中线索数不能大于1");
				} else {
					//打开修改模态框
					$("#editClueModal").modal("show");
					//获取选中的选择框id
					var id = $($(".son:checked")[0]).val();
					//发送异步请求获取活动数据
					$.get("workbench/clue/queryById", {
						"id": id
					}, function (data) {
						//data:clue 获取活动数据
						var clue = data;

						$("#edit-clueOwner").val(clue.owner);
						$("#edit-company").val(clue.company);
						$("#edit-call").val(clue.appellation);
						$("#edit-surname").val(clue.fullname);
						$("#edit-job").val(clue.job);
						$("#edit-email").val(clue.email);
						$("#edit-phone").val(clue.phone);
						$("#edit-website").val(clue.website);
						$("#edit-mphone").val(clue.mphone);
						$("#edit-status").val(clue.state);
						$("#edit-source").val(clue.source);
						$("#edit-describe").val(clue.description);
						$("#edit-contactSummary").val(clue.contactSummary);
						$("#edit-nextContactTime").val(clue.nextContactTime);
						$("#edit-address").val(clue.address);
						$("#id").val(clue.id);

					}, "json");
				}
			}


			//删除线索
			function deleteClues() {
				var length = $(".son:checked").length;
				if (length == 0) {
					alert("至少选择一个活动");
				} else {
					layer.alert('你确定删除这'+ length +'条线索吗？此操作不可逆！', {
						time: 0 //不自动关闭
						,btn: ['删除', '取消']
						,yes: function(index){
							layer.close(index);
							//获取选中的id,存入数组中
							var ids = [];
							$(".son:checked").each(function () {
								ids.push($(this).val())
							});
							//删除活动
							$.get("workbench/clue/deleteBatch", {
								"ids": ids.join()
							}, function (data) {
								//data:resultVo
								if (data.resOK) {
									alert(data.message);
									refresh(1, 3);
								}
							}, "json");
						}
					});
				}
			}


		</script>
	</body>
</html>