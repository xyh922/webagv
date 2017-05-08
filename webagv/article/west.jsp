<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*,jxl.*,jxl.write.*"%>
<%
String flag = ParamUtils.getParameter(request,"flag",""); 
int id = ParamUtils.getIntParameter(request,"id",0);
%>
<style>
.tree-node {
    cursor: pointer;
    height: 28px;
    white-space: nowrap;
}
</style>
<script type="text/javascript">
	var layout_west_tree;
	var layout_west_tree_url = 'dwType.jsp?id=<%=id%>';
		
	$(function() {
		layout_west_tree = $('#layout_west_tree').tree({
			url : layout_west_tree_url,
			parentField : 'pid',
			//lines : true,
			onClick : function(node) {
				var showJz = "0";
				if(node.ajjb=="1")
				{
					//showJz="1";
				}
				
				if (showJz=="0" && node.attributes && node.attributes.url) {
					var url;
					if (node.attributes.url.indexOf('/') == 0) {/*���url��һλ�ַ���"/"����ô�����򿪵��Ǳ��ص���Դ*/
						url =  node.attributes.url;
						
					} else {/*�򿪿�����Դ*/
						url = node.attributes.url;
					}
					//alert(node.attributes.url);
					addTab({
						url : "reads.jsp?url="+url,
						title : node.text,
						iconCls : node.iconCls
					});
				}
			},
			onDblClick:function(node)
			{//˫����
				if(node.state == 'closed')
					{
					 $(this).tree('expand',node.target);
					}else
						{
						$(this).tree('collapse',node.target);
						}
			},
			onBeforeLoad : function(node, param) {
				if (layout_west_tree_url) {//ֻ��ˢ��ҳ��Ż�ִ���������
					parent.$.messager.progress({
						title : '��ʾ',
						text : '���ݴ����У����Ժ�....'
					});
				}
			},
			onLoadSuccess : function(node, data) {
				parent.$.messager.progress('close');
			}
		});
	});

	function addTab(params) {
		var iframe = '<iframe src="' + params.url + '" frameborder="0" style="border:0;width:100%;height:98%;"></iframe>';
		var t = $('#index_tabs');
		var opts = {
			title : params.title,
			closable : true,
			iconCls : params.iconCls,
			content : iframe,
			border : false,
			fit : true
		};
		if (t.tabs('exists', opts.title)) {
			t.tabs('select', opts.title);
			parent.$.messager.progress('close');
		} else {
			t.tabs('add', opts);
		}
	}
</script>
<div class="easyui-accordion" data-options="fit:true,border:false">
	<div title="�����ƶ�" style="padding: 5px;" data-options="border:false,isonCls:'anchor',tools : [ {
				iconCls : 'database_refresh',
				handler : function() {
					$('#layout_west_tree').tree('reload');
				}
			} ]">
		<div class="well well-small">
			<ul id="layout_west_tree"></ul>
		</div>
	</div>
</div>