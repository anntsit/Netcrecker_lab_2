<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 24.03.2018
  Time: 20:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>All employee into project</title>
    <link href="<c:url value='/static/css/bootstrap.css' />" rel="stylesheet"></link>
    <link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
</head>
<body>

    <div class="generic-container">
        <%@include file="../back/backtoprojectlistheader.jsp" %>
        <div class="panel panel-default">
            <!-- Default panel contents -->
            <div class="panel-heading"><span class="lead">All User Into Project </span></div>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>Name</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="employee" items="${getAllUserIntoProject}">
                    <tr>
                        <td>${employee.object}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

</body>
</html>
