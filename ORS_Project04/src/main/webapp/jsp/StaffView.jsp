<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.rays.pro4.Util.HTMLUtility"%>
<%@page import="com.rays.pro4.Util.DataUtility"%>
<%@page import="com.rays.pro4.Util.ServletUtility"%>
<%@page import="com.rays.pro4.controller.StaffCtl"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<html>
<head>
    <link rel="icon" type="image/png" href="<%=ORSView.APP_CONTEXT%>/img/logo.png" sizes="16x16" />
    <title>Staff Page</title>
    
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="<%=ORSView.APP_CONTEXT%>/js/Utilities.js"></script>
    
    <script>
        $(function() {
            $("#udatee").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2024:2026',
            });
        });
    </script>
</head>
<body>
    <jsp:useBean id="bean" class="com.rays.pro4.Bean.StaffBean" scope="request"></jsp:useBean>
    <%@ include file="Header.jsp" %>

    <center>
        <form action="<%=ORSView.STAFF_CTL%>" method="post">
            <div align="center">
                <h1>
                    <% if (bean != null && bean.getId() > 0) { %>
                        <font size="5px">Update Staff</font>
                    <% } else { %>
                        <font size="5px">Add Staff</font>
                    <% } %>
                </h1>

                <h3>
                    <font color="red"><%=ServletUtility.getErrorMessage(request)%></font>
                    <font color="limegreen"><%=ServletUtility.getSuccessMessage(request)%></font>
                </h3>

                <%
                    Map map = (Map) request.getAttribute("staff");
                %>
            </div>

            <table>
                <input type="hidden" name="id" value="<%=bean.getId()%>">
                
                <tr>
                    <th align="left">FullName<span style="color: red">*</span>:</th>
                    <td><input type="text" name="fullName"
                               oninput="handleLetterInput(this, 'fullNameError', 10)"
                               onblur="validateLetterInput(this, 'fullNameError', 10)"
                               placeholder="Enter Full Name" size="26" value="<%=DataUtility.getStringData(bean.getFullName())%>">
                    <font color="red" id="fullNameError" ><%=ServletUtility.getErrorMessage("fullName", request)%></font></td>
                </tr>

                <tr>
                    <th style="padding: 3px"></th>
                </tr>

                <tr>
                    <th align="left">Joining Date <span style="color: red">*</span>:</th>
                    <td><input type="text" name="joiningDate"
                               placeholder="Enter Joining Date" size="26" readonly="readonly" id="udatee"
                               value="<%=DataUtility.getDateString(bean.getJoiningDate())%>">
                    <font color="red"><%=ServletUtility.getErrorMessage("joiningDate", request)%></font></td>
                </tr>

                <tr>
                    <th style="padding: 3px"></th>
                </tr>

                <tr>
                    <th align="left">Division<span style="color: red">*</span>:</th>
                    <td>
                        <%
                            String hlist = HTMLUtility.getList2("division", String.valueOf(bean.getDivision()), map);
                        %>
                        <%=hlist%>
                        <font color="red"><%=ServletUtility.getErrorMessage("division", request)%></font>
                    </td>
                </tr>

                <tr>
                    <th style="padding: 3px"></th>
                </tr>

                <tr>
                    <th align="left">Previous Employer <span style="color: red">*</span>:</th>
                    <td><input type="text" name="previousEmployer"
                               placeholder="Enter Previous Employer" size="26"
                               oninput="handleLetterInput(this, 'previousEmployerError', 20)"
                               onblur="validateLetterInput(this, 'previousEmployerError', 20)"
                               value="<%=DataUtility.getStringData(bean.getPreviousEmployer())%>">
                        <font color="red" id="previousEmployerError"><%=ServletUtility.getErrorMessage("previousEmployer", request)%></font>
                    </td>
                </tr>

                <tr>
                    <th style="padding: 3px"></th>
                </tr>

                <tr>
                    <th></th>
                    <% if (bean.getId() > 0) { %>
                        <td colspan="2">
                            <input type="submit" name="operation" value="<%=StaffCtl.OP_UPDATE%>">
                            <input type="submit" name="operation" value="<%=StaffCtl.OP_CANCEL%>">
                        </td>
                    <% } else { %>
                        <td colspan="2">
                            <input type="submit" name="operation" value="<%=StaffCtl.OP_SAVE%>">
                            <input type="submit" name="operation" value="<%=StaffCtl.OP_RESET%>">
                        </td>
                    <% } %>
                </tr>
            </table>
        </form>
    </center>

    <%@ include file="Footer.jsp" %>
</body>
</html>
