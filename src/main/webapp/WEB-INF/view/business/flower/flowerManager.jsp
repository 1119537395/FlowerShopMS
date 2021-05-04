<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>鲜花进货管理页面</title>
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
    <i class="layui-icon layui-red">&#xe615;</i>
    查询条件
</blockquote>
<form class="layui-form layui-form-pane" method="post" id="searchFrom">
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">名称</label>
            <div class="layui-input-inline">
                <input type="text" name="flowerName" autocomplete="on" class="layui-input" placeholder="请输入查询的鲜花名称">
            </div>
        </div>

        <div class="layui-inline">
            <label class="layui-form-label">类型</label>
            <div class="layui-input-inline">
                <select name="flowerType">
                    <option value="">请选择鲜花类型</option>
                    <option value="木本花卉">木本花卉</option>
                    <option value="草本花卉">草本花卉</option>
                    <option value="盆花类">盆花类</option>
                    <option value="鲜切花">鲜切花</option>
                </select>
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


<!-- 数据表格开始 -->
<table class="layui-hide" id="flowerTable" lay-filter="flowerTable"></table>

<!-- 数据表格上方工具栏按钮 -->
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-containe">
        <button class="layui-btn layui-btn-normal layui-btn-sm" lay-event="addFlowerDataBtn">进货</button>
        <%--<button class="layui-btn layui-btn-danger layui-btn-sm" lay-event="deleteCarDataBtn">删除</button>--%>
    </div>
</script>

<!-- 数据表格内部操作按钮开始 -->
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delete">删除</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="View">浏览</a>
</script>
<!-- 数据表格内部操作按钮结束 -->


<!-- 表格内嵌效果开始 -->
<script type="text/html" id="switchTpl">
    <input type="checkbox" name="Unfold" value="{{d.flowerState}}" lay-skin="switch" lay-text="已上架|未上架" {{
           d.flowerState==1?'checked':''}}>
</script>
<!-- 表格内嵌效果开始 -->


<!-- 添加和修改的弹出层开始 -->
<div style="display: none" id="addAndEditModel">
    <form class="layui-form layui-form-pane layui-col-space10" id="addAndEditFlowerFrame"
          lay-filter="addAndEditFlowerFrame" style="margin: 10px">
        <blockquote class="layui-elem-quote">
            <i class="layui-icon layui-blue">&#xe609;</i>
            鲜花进货信息管理
        </blockquote>

        <div class="layui-col-md12 layui-col-xs12">
            <div class="layui-row layui-col-space10">
                <div class="layui-col-md9 layui-col-xs7">
                    <div class="layui-form-item">
                        <label class="layui-form-label">名称</label>
                        <div class="layui-input-block">
                            <input type="text" name="flowerId" id="flowerId" style="display: none">
                            <input type="text" name="flowerName" class="layui-input" lay-verify="required"
                                   placeholder="请输入鲜花名称">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">类型</label>
                        <div class="layui-input-block">
                            <select name="flowerType">
                                <option value="">请选择鲜花类型</option>
                                <option value="木本花卉">木本花卉</option>
                                <option value="草本花卉">草本花卉</option>
                                <option value="盆花类">盆花类</option>
                                <option value="鲜切花">鲜切花</option>
                            </select>
                        </div>
                    </div>

                    <div class="layui-form-item ">
                        <label class="layui-form-label">数量</label>
                        <div class="layui-input-block">
                            <input type="text" name="flowerNumber" class="layui-input" lay-verify="required"
                                   placeholder="请输入鲜花数量">
                        </div>
                    </div>
                </div>

                <!-- 鲜花图片上传 -->
                <div class="layui-col-md3 layui-col-xs5">
                    <div class="layui-upload-list thumbBox mag0 magt3" id="uploadImgId">
                        <img class="layui-upload-img thumbImg" id="showImgId">
                        <!-- 上传鲜花图片的默认图 -->
                        <input type="hidden" name="flowerImageAddress" id="hiddenSrcURLId">
                    </div>
                </div>

            </div>

            <div class="layui-form-item magb2">
                <label class="layui-form-label">上架状态</label>
                <div class="layui-input-block">
                    <select name="flowerState">
                        <option value="">请选择鲜花的上架状态</option>
                        <option value="1">已上架</option>
                        <option value="0" selected="selected">未上架</option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item magb2">
                <label class="layui-form-label">购买价格</label>
                <div class="layui-input-block">
                    <input type="text" name="flowerPurchasePrice" class="layui-input " lay-verify="required"
                           placeholder="请输入鲜花购买价格">
                </div>
            </div>

            <div class="layui-form-item magb2">
                <label class="layui-form-label">出售价格</label>
                <div class="layui-input-block">
                    <input type="text" name="flowerSellPrice" class="layui-input " lay-verify="required"
                           placeholder="请输入鲜花出售价格">
                </div>
            </div>

            <div class="layui-form-item" align="center">
                <div class="layui-input-label">
                    <button type="button" class="layui-btn layui-icon layui-icon-ok-circle  layui-btn-radius"
                            lay-submit="" lay-filter="toEditAndAddSubmit" id="toEditAndAddSubmit">&nbsp;提交
                    </button>
                    <button type="reset"
                            class="layui-btn layui-icon layui-btn-danger layui-icon-refresh layui-btn-radius">&nbsp;重置
                    </button>
                </div>
            </div>
        </div>
    </form>
</div>
<!-- 添加和修改的弹出层结束 -->


<!-- 查看大图弹出层开始 -->
<div style="display: none" id="viewLargerImage">
    <img alt="鲜花详情图" width="604" height="418" id="viewImage">
</div>
<!-- 查看大图弹出层结束 -->


<script src="${Path}/static/layui/layui.js" charset="utf-8"></script>
<script>
    var tableIns;
    layui.use(['table', 'layer', 'form', 'jquery', 'upload'], function () {
        var $ = layui.jquery;
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var upload = layui.upload;


        // 渲染表格数据
        tableIns = table.render({
            elem: '#flowerTable'
            , url: '${Path}/flower/loadFlowerDataByAll'
            , toolbar: '#toolbarDemo'
            , height: 'full-190'
            , cellMinWidth: 100
            , page: true
            , text: {
                none: "暂无相关数据"
            }
            , title: '鲜花数据表'
            , cols: [[
                {type: 'checkbox', fixed: 'left'}
                , {field: 'flowerId', title: 'ID', fixed: 'left', align: "center"}
                , {field: 'flowerName', title: '名称', align: "center"}
                , {field: 'flowerType', title: '类型', align: "center"}
                , {field: 'flowerNumber', title: '数量', align: "center"}
                , {field: 'flowerPurchasePrice', title: '购买价格', align: "center"}
                , {field: 'flowerSellPrice', title: '出售价格', align: "center"}
                , {field: 'flowerState', title: '是否上架', align: "center", width: 105, templet: "#switchTpl"}
                , {
                    field: 'flowerImageAddress', title: '缩略图', align: "center", templet: function (d) {
                        return "<img width=40 height=30 src=${Path}/file/showImgFileInformation?path=" + d.flowerImageAddress + "/>";
                    }
                }
                , {field: 'createTime', title: '进货时间',width:180,align: "center"}
                , {fixed: 'right', title: '操作', toolbar: '#barDemo', width: 180, align: "center"}
            ]]
        });

        //给查询按钮添加单击事件
        $("#doSearch").click(function () {
            // 获取表单提交的数据序列
            var parameter = $("#searchFrom").serialize();
            // 发送请求查询数据
            tableIns.reload({
                url: "${Path}/flower/loadFlowerDataByAll?" + parameter,
                page: {curr: 1}
            });
        });

        //监听头工具栏添加按钮事件
        table.on('toolbar(flowerTable)', function (obj) {
            switch (obj.event) {
                case 'addFlowerDataBtn':
                    OpenAddMenuModel();
            }
            ;
        });

        //监听行工具删除和修改和浏览按钮事件
        table.on('tool(flowerTable)', function (obj) {
            var flowerData = obj.data;  //获取到单击行的数据
            var layEvent = obj.event;
            if (layEvent === 'delete') {
                layer.confirm('确定删除【' + flowerData.flowerName + '】的信息？', {
                    icon: 3,
                    title: "提示",
                    skin: 'layui-layer-molv',
                    btnAlign: 'c'
                }, function () {
                    $.post("${Path}/flower/deleteFlowerData?", {flowerId: flowerData.flowerId}, function (returnValue) {
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
            } else if (layEvent === 'edit') {
                OpenUpdateModel(flowerData);
            } else if (layEvent === 'View') {
                OpenViewModel(flowerData);
            }
        });

        //打开添加鲜花信息模态框
        var maxIndex;
        var url;

        function OpenAddMenuModel() {
            maxIndex = layer.open({
                type: 1,
                title: "添加鲜花信息",
                content: $('#addAndEditModel'),
                area: ["980px", "510px"],
                anim: 5,
                skin: "layui-layer-molv",
                closeBtn: 2,
                success: function (index) {
                    //加载默认图片
                    $("#showImgId").attr("src", "${Path}/file/showImgFileInformation?path=images/defaultPicture.jpg");
                    //设置隐藏输入框的默认值
                    $("#hiddenSrcURLId").val("images/defaultPicture.jpg");
                    //清空表单
                    $("#addAndEditFlowerFrame")[0].reset();
                    url = "${Path}/flower/addFlowerData";
                }
            });
        }

        //打开修改鲜花信息模态框
        function OpenUpdateModel(flowerData) {
            maxIndex = layer.open({
                type: 1,
                title: "修改鲜花信息",
                content: $('#addAndEditModel'),
                area: ["980px", "510px"],
                anim: 5,                 //动画效果
                skin: "layui-layer-molv", //皮肤
                closeBtn: 2,
                success: function (index) {
                    //给表单赋值
                    form.val("addAndEditFlowerFrame", flowerData);
                    $("#flowerId").val(flowerData.flowerId);
                    //加载图片
                    $("#showImgId").attr("src", "${Path}/file/showImgFileInformation?path=" + flowerData.flowerImageAddress);
                    url = "${Path}/flower/updateFlowerData";
                }
            });
        }

        //保存添加或修改的鲜花数据
        form.on('submit(toEditAndAddSubmit)', function (data) {
            //序列化表单数据
            var params = $("#addAndEditFlowerFrame").serialize();
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


        //点击查看大图
        function OpenViewModel(flowerData) {
            maxIndex = layer.open({
                type: 1,
                title: "【" + flowerData.flowerName + "】大图",
                content: $('#viewLargerImage'),
                area: ["604px", "460px"],
                anim: 5,                 //动画效果
                skin: "layui-layer-lan", //皮肤
                closeBtn: 2,
                success: function (index) {
                    $("#viewImage").attr("src", "${Path}/file/showImgFileInformation?path=" + flowerData.flowerImageAddress);
                }
            });
        }

        //初始化上传图片功能
        upload.render({
            elem: '#uploadImgId',
            url: '${Path}/file/uploadFile',
            field: 'mf',
            acceptMime: 'image/*',
            method: "post",
            done: function (res, index, upload) {
                $('#showImgId').attr('src', "${Path}/file/showImgFileInformation?path=" + res.data.src);
                $("#hiddenSrcURLId").val(res.data.src);
                $('#uploadImgId').css("background", "#fff");
            }
        });
    });

</script>

</body>
</html>