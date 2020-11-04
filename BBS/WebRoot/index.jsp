<%@ page language="java" import="java.util.*,entity.*,dao.*,dao.impl.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<% 
	BoardDao boardDao =new BoardDaoImpl();
	Map mapBoard=boardDao.findBoard(); 
	TopicDao topicDao = new TopicDaoImpl();
	UserDao userDao = new UserDaoImpl();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>">

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>标题</title>
<style type="text/css">


#apDiv1 {
	position: absolute;
	left: 8px;
	top: 1px;
	width: 800px;
	height: 50px;
	z-index: 1;
	text-align: center;
	font-weight: bold;
	font-size: 36px;
	color: #06F;
}

#apDiv2 {
	position: absolute;
	left: 8px;
	top: 52px;
	width: 800px;
	height: 25px;
	z-index: 3;
	background-color: #e0f0f9;
	font-size: 12px;
	color: #004c7d;
}
#apDiv3 {
	position: absolute;
	left: 8px;
	top: 81px;
	width: 800px;
	height: 500px;
	z-index: 4;
}
#apDiv3 table tr td {
	font-size: 12px;
	color: #004c7d;
}
</style>
</head>

<body>
<div id="apDiv1">校园BBS系统</div>
<div id="apDiv2">欢迎进入本破站，您尚未<a href="login.html"> 登录</a> or <a href="reg.html">注册</a></div>
<div id="apDiv3">
  <table width="800" border="1" cellspacing="0" cellpadding="0">
    <tr>
      <td colspan="2">论坛</td>
      <td width="43">主题</td>
      <td width="352">最后发表</td>
    </tr>
    <!--  主板块 -->
 	<%  
 	     List  listMainBoard = (List)mapBoard.get(new Integer(0));
    	for(int i=0;i<listMainBoard.size();i++){
    		Board mainBoard = ((Board)listMainBoard.get(i));
       	%>
       	<tr class="tr3">
       		<td colspan="4"><%=mainBoard.getBoardName() %></td>
       	</tr>
       	<!--  -->
    	<% 
    		List listSonBoard =(List)mapBoard.get(new Integer(mainBoard.getBoardId()));
    		for(int j=0;j<listSonBoard.size();j++){
    			Board sonBoard =(Board)listSonBoard.get(j);
    			Topic topic =new Topic();
    			User user =new User();
    			int boardId =sonBoard.getBoardId();
    			List listTopic =topicDao.findListTopic(1,boardId);
    			
    			if(listTopic!=null&&listTopic.size()>0){
    				topic =(Topic)listTopic.get(0);
    				user=userDao.findUser(topic.getUid());
   			}
   		%>
   		<tr class="tr3">
   			<td width="5%">&nbsp</td>
   			<th align="left">
   			<IMG src ="image/board.gif">
   			<A herf="list.jsp"><%=sonBoard.getBoardName() %></A>
   			</th>
   			<td align="center"><%=topicDao.findCountTopic(boardId) %></td>
   			<th>
   				<span>
   					<A herf="detail.jsp"><%=topic.getTitle() %></A>
   				</span>
   				<br/>
   				<span><%=user.getUName()%></span>
   				<span class="gray">[<%=topic.getPublishTime() %>]</span>
   				</th>
   				</tr>
   <%
		}
    }
    %>
  </table>
</div>
</body>
</html>
