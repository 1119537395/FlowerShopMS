<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>系统用户管理界面</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${Path}/static/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="${Path}/static/css/public.css" media="all"/>
</head>
<body style="margin: 10px">

<!-- 搜索条件开始 -->
<blockquote class="layui-elem-quote">
    <i class="layui-icon layui-purple">&#xe615;</i>
    查询条件
</blockquote>

<form class="layui-form layui-form-pane" method="post" id="searchFrom">

    <div class="layui-form-item">

        <div class="layui-inline">
            <label class="layui-form-label">账户名</label>
            <div class="layui-input-inline">
                <input type="text" name="userAccount" autocomplete="off" class="layui-input" placeholder="请输入账户名称">
            </div>
        </div>

        <div class="layui-inline">
            <label class="layui-form-label">手机号</label>
            <div class="layui-input-inline">
                <input type="text" name="userPhone" autocomplete="off" class="layui-input" placeholder="请输入手机号码">
            </div>
        </div>

        <div class="layui-inline">
            <div class="layui-input-label">
                <button type="button" class="layui-btn layui-icon layui-icon-search" id="doSearch">&nbsp;查询</button>
                <button type="reset" class="layui-btn layui-icon layui-btn-danger layui-icon-refresh">&nbsp;重置</button>
            </div>
        </div>
    </div>
</form>
<!-- 搜索条件结束 -->

<!--表单内嵌效果展示开始-->
<script type="text/html" id="checkboxTpl">
    <input type="checkbox" name="available" value="{{d.available}}" title="可用" {{ d.available==1?'checked':''}}>
</script>
<!--表单内嵌效果展示结束-->

<!-- 数据表格开始 -->
<table class="layui-hide" id="userTable" lay-filter="userTable"></table>

<!-- 数据表格上方工具栏按钮 -->
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-containe">
        <button class="layui-btn layui-btn-normal layui-btn-sm" lay-event="addUserDataBtn">添加</button>
    </div>
</script>

<!-- 数据表格内部操作按钮 -->
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delete">注销</a>
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="assign">分配角色</a>
    <a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="reset">修改密码</a>
</script>
<!-- 数据表格结束 -->

<!-- 添加和修改的弹出层开始 -->
<div style="display: none" id="addAndEditModel">

    <form class="layui-form layui-form-pane" action="" lay-filter="addUserFrame" id="addUserFrame" style="margin: 20px">
        <blockquote class="layui-elem-quote">
            <i class="layui-icon layui-blue">&#xe609;</i>
            系统用户管理
        </blockquote>

        <div class="layui-form-item" id="option1">
            <label class="layui-form-label">账户类型</label>
            <div class="layui-input-block">
                <select name="userType">
                    <option value="">请选择账户类型</option>
                    <option value="0">系统管理员</option>
                    <option value="1">店长</option>
                    <option value="2">店员</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">昵称</label>
            <div class="layui-input-block">
                <input type="text" name="userName" autocomplete="off" class="layui-input" placeholder="请输入用户昵称">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">账户名</label>
            <div class="layui-input-block">
                <input type="text" id="userId" name="userId" style="display: none">
                <input type="text" name="userAccount" autocomplete="off" class="layui-input" placeholder="请输入用户的账户名">
            </div>
        </div>

        <div class="layui-form-item" id="userPassword">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-block">
                <input type="password" name="userPassword" autocomplete="off" class="layui-input" placeholder="请输入用户的密码">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <select name="userSex">
                    <option value="">请选择性别</option>
                    <option value="1">男</option>
                    <option value="0">女</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">手机号</label>
            <div class="layui-input-block">
                <input type="text" name="userPhone" lay-verify="required|number|phone|userPhone" autocomplete="off" class="layui-input" placeholder="请输入手机号码">
            </div>
        </div>

        <div class="layui-form-item" align="center">
            <div class="layui-input-label">
                <button type="button" class="layui-btn layui-icon layui-icon-ok-circle" lay-submit=""
                        lay-filter="doAddSubmit" id="doAddSubmit">&nbsp;提交
                </button>
                <button type="reset"
                        class="layui-btn layui-icon layui-btn-danger layui-icon-refresh">&nbsp;重置
                </button>
            </div>
        </div>
    </form>
</div>
<!-- 添加和修改的弹出层结束 -->

<!-- 分配角色权限弹出层开始 -->
<div style="display: none" id="assignMenuModel">
    <div style="margin: 10px">
        <blockquote class="layui-elem-quote">
            <i class="layui-icon layui-blue">&#xe609;</i>
            系统用户分配访问权限
        </blockquote>
        <table class="layui-hide" id="roleTable" lay-filter="roleTable"></table>
    </div>
</div>
<!-- 分配菜单权限弹出层结束 -->

<!-- 修改密码的弹出层 -->
<div style="display: none" id="changePasswordModel">

    <form class="layui-form" action="" lay-filter="changePassword" id="changePassword" style="margin: 20px">

        <div class="layui-form-item" >
            <label class="layui-form-label">新密码</label>
            <div class="layui-input-block">
                <input type="hidden" id="userId2" name="userId">
                <input type="password" name="userPassword" autocomplete="off" lay-verify="required" class="layui-input" placeholder="请输入修改的密码">
            </div>
        </div>

        <div class="layui-form-item" align="center">
            <div class="layui-input-label">
                <button type="button" class="layui-btn layui-icon layui-icon-ok-circle" lay-submit=""
                        lay-filter="submit" id="submit">&nbsp;提交
                </button>
            </div>
        </div>
    </form>
</div>

<script src="${Path}/static/layui/layui.js" charset="utf-8"></script>
<script>
    var tableIns;
    layui.use(['table', 'layer', 'form', 'jquery', 'laydate'], function () {
        var $ = layui.jquery;
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var laydate = layui.laydate;
        // 管理员类型权限控制
        let typeId = ${user.userType};

        // 渲染表格数据
        tableIns = table.render({
            elem: '#userTable'
            , url: '${Path}/user/loadUserDataInfo'
            , toolbar: '#toolbarDemo'
            , height: 'full-190'
            , cellMinWidth: 100
            , page: true
            , text: {
                none: "暂无相关数据"
            }
            , title: '菜单数据表'
            , cols: [[
                {type: 'checkbox', fixed: 'left'}
                , {field: 'userId', title: '用户ID', align: "center"}
                , {
                    field: 'userSex', title: '性别', align: "center", templet: function (sexData) {
                        return sexData.userSex == '1' ? '<font color="#87cefa">男</font>' : '<font color="#ffc0cb">女</font>';
                    }
                }
                , {field: 'userName', title: '用户昵称', align: "center"}
                , {field: 'userPhone', title: '手机号码', align: "center"}
                , {field: 'userAccount', title: '账户名', align: "center"}
                , {
                    field: 'userType', title: '账户类型', align: "center", templet: function (typeData) {
                        if (typeData.userType == '0') {
                            return '<font color="red">系统管理员</font>';
                        }
                        if (typeData.userType == '1') {
                            return '<font color="blue">店长</font>';
                        }
                        if (typeData.userType == '2') {
                            return '<font color="blue">店员</font>';
                        }
                    }
                }
                , {fixed: 'right', title: '操作', toolbar: '#barDemo', width: 300, align: "center"}
            ]]
        });

        //给查询按钮添加单击事件
        $("#doSearch").click(function () {
            //获取表单提交的数据序列
            var parameter = $("#searchFrom").serialize();
            console.log(parameter);
            tableIns.reload({
                url: "${Path}/user/loadUserDataInfo?" + parameter,
                page: {curr: 1}
            });
        });

        //监听头工具栏添加按钮和删除按钮事件
        table.on('toolbar(userTable)', function (obj) {
            switch (obj.event) {
                case 'addUserDataBtn':
                    OpenAddMenuModel();
                    break;
                case 'deleteUserDataBtn':
                    deleteBatchData(obj);
            }
            ;
        });

        //监听行工具删除和修改按钮事件
        table.on('tool(userTable)', function (obj) {
            var userData = obj.data;  //获取到单击行的数据
            if (obj.event === 'delete') {
                layer.confirm('确定注销【' + userData.userName + '】该用户的信息吗？', {
                    icon: 3,
                    title: "提示",
                    skin: 'layui-layer-molv',
                    btnAlign: 'c'
                }, function () {
                    $.post("${Path}/user/deleteUserInfo?", {userId: userData.userId}, function (returnValue) {
                        if (returnValue.code == 200) {
                            layer.msg(returnValue.msg, {
                                icon: 6
                            });
                            //刷新表格
                            tableIns.reload();
                        } else {
                            layer.msg(returnValue.msg, {
                                icon: 5
                            });
                        }
                    });
                });
            } else if (obj.event === 'edit') {
                OpenUpdateModel(userData);
            } else if (obj.event === 'assign') {
                if (typeId==1){
                    layer.msg("没有权限访问！",{
                        icon:5,
                        anim:6
                    });
                    return;
                }
                openAssignModel(userData);
            } else if (obj.event === 'reset'){
                resetUserPassword(userData);
            }
        });

        //表单验证
        form.verify({
            userPhone: function(value){
                var userId = $("#userId").val();
                var formData = new FormData();
                formData.append("userId", userId);
                formData.append("userPhone", value);
                var message = '';
                $.ajax({
                    url: "${Path}/user/checkUserPhone",
                    type: 'POST',
                    data: formData,
                    async: false,
                    cache: false,
                    processData: false,
                    contentType: false,
                    dataType: "json",
                    success: function (data) {
                        if (data){
                            message = "手机号已存在，请重新输入";
                        }
                    }
                });
                if (message !== ''){
                    return message;
                }
            }
        });


        //添加用户信息模态框
        var maxIndex;
        var url;

        function OpenAddMenuModel() {
            maxIndex = layer.open({
                type: 1,
                title: "添加系统用户",
                content: $('#addAndEditModel'),
                area: ["700px", "490px"],
                anim: 5,
                skin: "layui-layer-molv",
                closeBtn: 2,
                success: function (index) {
                    $("#userPassword").css("display","block");
                    // 清空表单
                    $("#addUserFrame")[0].reset();
                    // 发送Ajax请求获取当前登录的用户类型
                    var sendType = 1;
                    var formData = new FormData();
                    formData.append("sendType", sendType);
                    $.ajax({
                        url: "${Path}/user/getUserType",
                        type: 'post',
                        cache: false,
                        data: formData,
                        processData: false,
                        contentType: false,
                        dataType: "json",
                        success: function (result) {
                            if (result === 1) {
                                $("#option1").css("display", "none");
                            } else {
                                $("#option1").css("display", "block");
                            }
                        }
                    });
                    url = "${Path}/user/addUserInfo";
                }
            });
        }

        //修改用户信息模态框
        function OpenUpdateModel(data) {
            maxIndex = layer.open({
                type: 1,
                title: "修改用户信息",
                content: $('#addAndEditModel'),
                area: ["700px", "470px"],
                anim: 5,                 //动画效果
                skin: "layui-layer-molv", //皮肤
                closeBtn: 2,
                success: function (index) {
                    $("#userPassword").css("display","none");
                    //给表单赋值
                    form.val("addUserFrame", data);
                    $("#userId").val(data.userId);
                    url = "${Path}/user/updateUserInfo";
                }
            });
        }

        //保存添加或修改的用户数据
        form.on('submit(doAddSubmit)', function (data) {
            //序列化表单数据
            var params = $("#addUserFrame").serialize();

            $.post(url, params, function (obj) {
                //弹出成功或失败的提示信息
                layer.msg(obj.msg, {
                    icon: 6
                });
                //关闭弹出层
                layer.close(maxIndex);
                //刷新表格
                tableIns.reload();
            });
        });


        //给用户分配角色权限的模态框
        function openAssignModel(userData) {
            maxIndex = layer.open({
                type: 1,
                title: "给用户【" + userData.userName + "】分配角色权限",
                content: $('#assignMenuModel'),
                area: ["800px", "500px"],
                anim: 5,
                skin: "layui-layer-lan",
                closeBtn: 2,
                btnAlign: 'c',
                btn: ["确认", "取消"],
                yes: function (index, layero) {
                    var checkStatus = table.checkStatus("roleTable");
                    var roleData = checkStatus.data;
                    var params = "userId=" + userData.userId;

                    //判断是否有数据被选中
                    if (roleData.length == 0) {
                        layer.msg("请先勾选需要分配的角色权限！", {
                            icon: 5,
                            anim: 6
                        });
                    } else {
                        $.each(roleData, function (i, item) {
                            params += "&userIds=" + item.roleId;
                        });

                        $.post("${Path}/user/saveUserHasRole", params, function (returnValue) {
                            if (returnValue.code == 200) {
                                layer.msg(returnValue.msg, {icon: 6});
                                layer.close(maxIndex);
                                //刷新表格
                                tableIns.reload();
                            } else {
                                layer.msg(returnValue.msg, {icon: 5, anim: 6});
                            }
                        });

                    }
                },
                success: function (index) {
                    // 渲染表格数据
                    table.render({
                        elem: '#roleTable'
                        , url: '${Path}/user/loadAssignRoleData?userId=' + userData.userId
                        , cellMinWidth: 100
                        , text: {
                            none: "暂无相关数据"
                        }
                        , title: '角色数据表'
                        , cols: [[
                            {type: 'radio', fixed: 'left'}
                            , {field: 'roleId', title: '角色编号', fixed: 'left', align: "center"}
                            , {field: 'roleName', title: '角色名称', align: "center"}
                            , {field: 'roleDesc', title: '权限描述', align: "center"}
                            , {field: 'available', title: '功能状态', align: "center", templet: '#checkboxTpl'}
                        ]]
                    });

                }
            });
        }

        //重置用户密码
        function resetUserPassword(userData) {
            maxIndex = layer.open({
                type: 1,
                title: "修改密码",
                content: $('#changePasswordModel'),
                area: ["400px", "200px"],
                anim: 5,
                skin: "layui-layer-lan",
                closeBtn: 2,
                success: function (index) {
                    // 清空表单
                    $("#changePassword")[0].reset();
                    $("#userId2").val(userData.userId);
                }
            });
        }
        form.on('submit(submit)', function (data) {
            //序列化表单数据
            var params = $("#changePassword").serialize();
            $.post("${Path}/user/resetUserPassword", params, function (obj) {
                //弹出成功或失败的提示信息
                layer.msg(obj.msg, {
                    icon: 6
                });
                //关闭弹出层
                layer.close(maxIndex);
            });
        });


    });

</script>

</body>
</html>
