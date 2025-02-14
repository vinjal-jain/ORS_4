<%@page import="com.rays.pro4.Model.StaffModel"%>
<%@page import="java.util.Map"%>
<%@page import="com.rays.pro4.Bean.StaffBean"%>
<%@page import="com.rays.pro4.Bean.BaseBean"%>
<%@page import="com.rays.pro4.Util.HTMLUtility"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.rays.pro4.Util.DataUtility"%>
<%@page import="com.rays.pro4.Util.ServletUtility"%>
<%@page import="com.rays.pro4.controller.StaffListCtl"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<link rel="icon" type="image/png"
	href="<%=ORSView.APP_CONTEXT%>/img/logo.png" sizes="16*16" />

<title>Staff List3</title>

<script src="<%=ORSView.APP_CONTEXT%>/js/jquery.min.js"></script>
<script src="<%=ORSView.APP_CONTEXT%>/js/Checkbox11.js"></script>

<link rel="stylesheet" href="/resources/demos/style.css">
<script>
	$(function() {
		$("#udate").datepicker({
			changeMonth : true,
			changeYear : true,
			yearRange : '1980:2002',
		//  mindefaultDate : "01-01-1962"
		});
	});
</script>

</head>
<body>
	<jsp:useBean id="bean" class="com.rays.pro4.Bean.StaffBean"
		scope="request"></jsp:useBean>
	<%@include file="Header.jsp"%>


	<form action="<%=ORSView.STAFF_LIST_CTL%>" method="post">

		<center>

			<div align="center">
				<h1>Staff List</h1>
				<h3>
					<font color="red"><%=ServletUtility.getErrorMessage(request)%></font>
					<font color="limegreen"><%=ServletUtility.getSuccessMessage(request)%></font>
				</h3>

			</div>

			<%
				List slist = (List) request.getAttribute("FullNamee");

				int next = DataUtility.getInt(request.getAttribute("nextlist").toString());
				
				
			%>
			
			<% Map map = (Map) request.getAttribute("staff"); %>


			<%
				int pageNo = ServletUtility.getPageNo(request);
				int pageSize = ServletUtility.getPageSize(request);
				int index = ((pageNo - 1) * pageSize) + 1;

				List list = ServletUtility.getList(request);
				Iterator<StaffBean> it = list.iterator();

				if (list.size() != 0) {
			%>
			<table width="100%" align="center">
				<tr>
				     <th></th>
					<td align="center">
				     &emsp; <label>Full Name</font> :
					</label> <%=HTMLUtility.getList("id", DataUtility.getStringData(bean.getFullName()),slist )%>
				
				
					<label>Previous Employer</font> :
					</label> <input type="text" name="previousEmployer" placeholder="Enter Previous Employer"
						value="<%=ServletUtility.getParameter("previousEmployer", request)%>">

						
						&nbsp; <label>Division</font> :
					</label><%=HTMLUtility.getList2("division",  String.valueOf(bean.getDivision()), map)%>
						
						


						&nbsp; <input type="submit" name="operation"
						value="<%=StaffListCtl.OP_SEARCH%>"> &nbsp; <input
						type="submit" name="operation" value="<%=StaffListCtl.OP_RESET%>">
					</td>
				</tr>
			</table>

			<table border="1" width="100%" align="center" cellpadding=6px
				cellspacing=".2">
				<tr style="background: orange">
					<th><input type="checkbox" id="select_all" name="select">Select
						All</th>

					<th>S.No.</th>
					<th>FullName</th>
					<th>JoiningDate</th>
					<th>Division</th>
					<th>PreviousEmployer</th>
					<th>Edit</th>
				</tr>

				<%
					while (it.hasNext()) {
							bean = it.next();
				%>


				<tr align="center">
			<%--<td><%=map.get(Integer.parseInt(bean.getImportance()))%></td> --%>
					<td><input type="checkbox" class="checkbox" name="ids"
						value="<%=bean.getId()%>"></td>
					<td><%=index++%></td>
					<td><%=bean.getFullName()%></td>
					<td><%=bean.getJoiningDate()%></td>
					<td><%=map.get(bean.getDivision())%></td>
					<td><%=bean.getPreviousEmployer()%></td>
					<td><a href="StaffCtl?id=<%=bean.getId()%>">Edit</a></td>
				</tr>
				<%
					}
				%>
			</table>

			<table width="100%">
				<tr>
					<th></th>
					<%
						if (pageNo == 1) {
					%>
					<td><input type="submit" name="operation" disabled="disabled"
						value="<%=StaffListCtl.OP_PREVIOUS%>"></td>
					<%
						} else {
					%>
					<td><input type="submit" name="operation"
						value="<%=StaffListCtl.OP_PREVIOUS%>"></td>
					<%
						}
					%>

					<td><input type="submit" name="operation"
						value="<%=StaffListCtl.OP_DELETE%>"></td>
					<td><input type="submit" name="operation"
						value="<%=StaffListCtl.OP_NEW%>"></td>
					<td align="right"><input type="submit" name="operation"
						value="<%=StaffListCtl.OP_NEXT%>"
						<%=(list.size() < pageSize || next == 0) ? "disabled" : ""%>></td>



				</tr>
			</table>
			<%
				}
				if (list.size() == 0) {
			%>
			<td align="center"><input type="submit" name="operation"
				value="<%=StaffListCtl.OP_BACK%>"></td>
			<%
				}
			%>

			<input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
				type="hidden" name="pageSize" value="<%=pageSize%>">
	</form>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>

	</center>

	<%@include file="Footer.jsp"%>
</body>
</html>
