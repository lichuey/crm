<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
    <head>
        <base href="<%=basePath%>">
        <meta charset="UTF-8">

        <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
        <link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet"/>

        <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
        <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
        <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

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

                        <form class="form-horizontal" id="createForm" role="form">

                            <div class="form-group">
                                <label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                        style="font-size: 15px; color: red;">*</span></label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <select class="form-control" name="owner" id="create-marketActivityOwner">
                                        <c:forEach items="${userList}" var="user" varStatus="sta">
                                            <option value="${user.id}">${user.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span
                                        style="font-size: 15px; color: red;">*</span></label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control" name="name" id="create-marketActivityName">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control" name="startDate" id="create-startTime">
                                </div>
                                <label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control" name="endDate" id="create-endTime">
                                </div>
                            </div>
                            <div class="form-group">

                                <label for="create-cost" class="col-sm-2 control-label">成本</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control" name="cost" id="create-cost">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="create-describe" class="col-sm-2 control-label">描述</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="3" name="description" id="create-describe"></textarea>
                                </div>
                            </div>

                        </form>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" onclick="saveOrUpdate($(this).text())" class="btn btn-primary" data-dismiss="modal">保存</button>
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

                        <form id="editForm" class="form-horizontal" role="form">

                            <div class="form-group">
                                <label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                        style="font-size: 15px; color: red;">*</span></label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <select class="form-control" name="owner" id="edit-marketActivityOwner">
                                        <c:forEach items="${userList}" var="user" varStatus="sta">
                                            <option value="${user.id}">${user.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span
                                        style="font-size: 15px; color: red;">*</span></label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control" name="name" id="edit-marketActivityName">
                                    <%--id隐藏域--%>
                                    <input type="hidden" id="id" name="id"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control" name="startDate" id="edit-startTime">
                                </div>
                                <label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control" name="endDate" id="edit-endTime">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control" name="cost" id="edit-cost">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="3" name="description" id="edit-describe"></textarea>
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
                                <input class="form-control" id="name" type="text">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">所有者</div>
                                <input class="form-control" id="owner" type="text">
                            </div>
                        </div>


                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">开始日期</div>
                                <input class="form-control" type="text" id="startTime"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">结束日期</div>
                                <input class="form-control" type="text" id="endTime">
                            </div>
                        </div>

                        <button type="button" onclick="activityQuery()" class="btn btn-default">查询</button>

                    </form>
                </div>
                <div class="btn-toolbar" role="toolbar"
                     style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
                    <div class="btn-group" style="position: relative; top: 18%;">
                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createActivityModal">
                            <span class="glyphicon glyphicon-plus"></span> 创建
                        </button>
                        <button type="button" onclick="openEditModel()" class="btn btn-default" data-toggle="modal"><span
                                class="glyphicon glyphicon-pencil"></span> 修改
                        </button>
                        <button type="button" onclick="deleteActivities()" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
                        <button type="button" onclick="importExcel()" class="btn btn-primary"><span class="glyphicon glyphicon-minus"></span> 导出报表</button>
                    </div>

                </div>
                <div style="position: relative;top: 10px;">
                    <table class="table table-hover">
                        <thead>
                        <tr style="color: #B3B3B3;">
                            <td><input type="checkbox" id="father"/></td>
                            <td>名称</td>
                            <td>所有者</td>
                            <td>开始日期</td>
                            <td>结束日期</td>
                        </tr>
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
        <%--分页--%>
        <link rel="stylesheet" href="jquery/bs_pagination/jquery.bs_pagination.min.css"/>
        <script src="jquery/bs_pagination/en.js"></script>
        <script src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
        <%--layer--%>
        <script type="text/javascript" src="jquery/layer/layer.js"></script>
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
            }
            */

            refresh(1, 3);

            //刷新页面
            function refresh(page, pageSize) {
                //查询市场活动列表
                $.get("workbench/activity/list", {
                    'page': page,
                    'pageSize': pageSize,
                    'name' : $("#name").val(),
                    'owner' : $("#owner").val(),
                    'startDate': $("#startTime").val(),
                    'endDate': $("#endTime").val()
                }, function (data) {
                    $('#activityTbody').html("");
                    for (var i = 0; i < data.list.length; i++) {
                        var activity = data.list[i];
                        $("#activityTbody").append("<tr class=\"active\">\n" +
                            "\t\t\t\t\t\t\t\t<td><input type=\"checkbox\" value='"+ activity.id +"' class='son' onclick='abc()'/></td>\n" +
                            "\t\t\t\t\t\t\t\t<td><a style=\"text-decoration: none; cursor: pointer;\" href='toView/workbench/activity/detail?id="+ activity.id +"'>" + activity.name + "</a></td>\n" +
                            "\t\t\t\t\t\t\t\t<td>" + activity.owner + "</td>\n" +
                            "\t\t\t\t\t\t\t\t<td>" + activity.startDate + "</td>\n" +
                            "\t\t\t\t\t\t\t\t<td>" + activity.endDate + "</td>\n" +
                            "\t\t\t\t\t\t\t</tr>")

                    }
                    $("#activityPage").bs_pagination({
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

            (function ($) {
                $.fn.datetimepicker.dates['zh-CN'] = {
                    days: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"],
                    daysShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日"],
                    daysMin: ["日", "一", "二", "三", "四", "五", "六", "日"],
                    months: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
                    monthsShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
                    today: "今天",
                    suffix: [],
                    meridiem: ["上午", "下午"]
                };
            }(jQuery));

            //日历插件
            $("#startTime").datetimepicker({
                language: "zh-CN",
                format: "yyyy-mm-dd",//显示格式
                minView: "month",//设置只显示到月份
                initialDate: new Date(),//初始化当前日期
                autoclose: true,//选中自动关闭
                todayBtn: true, //显示今日按钮
                clearBtn: true,
                pickerPosition: "bottom-left"
            });

            $("#endTime").datetimepicker({
                language: "zh-CN",
                format: "yyyy-mm-dd",//显示格式
                minView: "month",//设置只显示到月份
                initialDate: new Date(),//初始化当前日期
                autoclose: true,//选中自动关闭
                todayBtn: true, //显示今日按钮
                clearBtn: true,
                pickerPosition: "bottom-left"
            });

            function activityQuery() {
                refresh(1,3)
            }

            /*//查询所有用户
            $.get("workbench/activity/queryUsers", function (data) {
                //data:List<User>
                for (var i in data) {
                    var user = data[i];
                    $("#create-marketActivityOwner").append("<option value='" + user.id + "'>" + user.name + "</option>");
                }
            }, "json");*/

            //创建拟态框开始日期
            $("#create-startTime").datetimepicker({
                language: "zh-CN",
                format: "yyyy-mm-dd",//显示格式
                minView: "month",//设置只显示到月份
                initialDate: new Date(),//初始化当前日期
                autoclose: true,//选中自动关闭
                todayBtn: true, //显示今日按钮
                clearBtn: true,
                pickerPosition: "bottom-left"
            });

            //创建拟态框结束日期
            $("#create-endTime").datetimepicker({
                language: "zh-CN",
                format: "yyyy-mm-dd",//显示格式
                minView: "month",//设置只显示到月份
                initialDate: new Date(),//初始化当前日期
                autoclose: true,//选中自动关闭
                todayBtn: true, //显示今日按钮
                clearBtn: true,
                pickerPosition: "bottom-left"
            });

            //保存或更新
            function saveOrUpdate(text) {
                var form;
                if ("保存" == text) {
                    form = $('#createForm').serialize();
                } else if ("更新" == text) {
                    form = $("#editForm").serialize();
                }
                $.post("workbench/activity/saveOrUpdate", form, function (data) {
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


            //先写js勾中的脚本
            //father勾中，其他全勾中，father没勾中，其他全没勾中
            /*第一种
            $("#father").click(function () {
                var checked = $(this).prop("checked");
                if (checked) {
                    $(".son").prop("checked", true);
                } else {
                    $(".son").prop("checked", false);
                }
            })
            */
            //第二种
            $("#father").click(function () {
                $(".son").prop("checked", $(this).prop("checked"));
            });

        /*
            //通过勾中son的个数决定father是否勾中
            //动态生成的dom元素开始不会初始化到html文档中，我们操作页面元素的时候才会初始化
            //方案一:事件委托给第一个不是动态生成的父元素  动态生成的元素找不到，导致js也会失效
            //参数1:绑定的事件名称 参数2:被绑定元素 参数3:触发的函数
            $("#activityTbody").on("click",".son",function () {
                //son被勾中的个数
                var checkedLength = $(".son:checked").length;
                //son的个数
                var sonLength = $(".son").length;
                //比较
                if (checkedLength == sonLength) {
                    $("#father").prop("checked", true);
                } else
                    $("#father").prop("checked", false);
            })
        */

            //方案二:给生成的元素添加事件
            function abc() {
                //son被勾中的个数
                var checkedLength = $(".son:checked").length;
                //son的个数
                var sonLength = $(".son").length;
                //比较
                if (checkedLength == sonLength) {
                    $("#father").prop("checked", true);
                } else
                    $("#father").prop("checked", false);
            }

            //点击修改按钮的js判断 勾中一条记录
            function openEditModel() {
                var sonLength = $(".son:checked").length;
                if (sonLength === 0) {
                    alert("选中记录数不能为空");
                }else if (sonLength > 1) {
                    alert("选中记录数不能大于1");
                } else {
                    //打开修改模态框
                    $("#editActivityModal").modal("show");
                    //获取选中的选择框id
                    var id = $($(".son:checked")[0]).val();
                    //发送异步请求获取活动数据
                    $.get("workbench/activity/queryById", {
                        "id": id
                    }, function (data) {
                        //data:activity 获取活动数据
                        var activity = data;

                       /* //查询用户列表
                        $.get("workbench/activity/queryUsers", function (data) {
                            //data:List<User>
                            $("#edit-marketActivityOwner").html("");
                            for (var i in data) {
                                var user = data[i];
                                if (activity.owner == user.id) {
                                    $("#edit-marketActivityOwner").append("<option selected value='" + user.id + "'>" + user.name + "</option>");
                                } else {
                                    $("#edit-marketActivityOwner").append("<option value='" + user.id + "'>" + user.name + "</option>");
                                }
                            }
                        }, "json");*/
                        $("#edit-marketActivityOwner").val(activity.owner);

                        //将活动数据存入编辑拟态框
                        $("#edit-marketActivityName").val(activity.name);
                        $("#edit-startTime").val(activity.startDate);
                        $("#edit-endTime").val(activity.endDate);
                        $("#edit-cost").val(activity.cost);
                        $("#edit-describe").val(activity.description);
                        //将id存入隐藏域中
                        $("#id").val(activity.id);
                    }, "json");
                }
            }

            //修改拟态框开始日期
            $("#edit-startTime").datetimepicker({
                language: "zh-CN",
                format: "yyyy-mm-dd",//显示格式
                minView: "month",//设置只显示到月份
                initialDate: new Date(),//初始化当前日期
                autoclose: true,//选中自动关闭
                todayBtn: true, //显示今日按钮
                clearBtn: true,
                pickerPosition: "bottom-left"
            });

            //修改拟态框结束日期
            $("#edit-endTime").datetimepicker({
                language: "zh-CN",
                format: "yyyy-mm-dd",//显示格式
                minView: "month",//设置只显示到月份
                initialDate: new Date(),//初始化当前日期
                autoclose: true,//选中自动关闭
                todayBtn: true, //显示今日按钮
                clearBtn: true,
                pickerPosition: "bottom-left"
            });

            //删除活动
            function deleteActivities() {
                var length = $(".son:checked").length;
                if (length == 0) {
                    alert("至少选择一个活动");
                } else {
                    layer.alert('你确定删除这'+ length +'条活动吗？此操作不可逆！', {
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
                            $.get("workbench/activity/deleteBatch", {
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

            //导出报表
            function importExcel() {
                location.href = "workbench/activity/importExcel";
            }

        </script>
    </body>
</html>