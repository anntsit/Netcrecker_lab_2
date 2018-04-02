<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Users List</title>
    <link href="<c:url value='/static/css/bootstrap.css' />" rel="stylesheet"></link>
    <link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
</head>

<body>
<sec:authorize access="hasRole('ADMIN')">
    <a href="#bottom_page" class="absolute_button"><img src="/static/image/down-arrow.png" alt=""></a>
</sec:authorize>

<div class="generic-container">
    <%@include file="../back/authheader.jsp" %>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading"><span class="lead">List of Users </span></div>
        <table class="table table-hover">
            <thead>
            <tr>
                <th>Id</th>
                <th>Name</th>
                <th>Job</th>
                <th>Attribute</th>
                <th>Empno</th>
                <th>Mgr</th>
                <th>Hirerdate</th>
                <th>Sal</th>
                <th>Com</th>
                <th>Deptno</th>
                <th class="center_text" colspan="2">Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="employee" items="${listContact}">
                <tr>
                    <td>${employee.objectId}</td>
                    <td>${employee.object}</td>
                    <td>${employee.oType}</td>
                    <td>${employee.attrName}</td>
                    <td>${employee.empno}</td>
                    <td>${employee.mgr}</td>
                    <td>${employee.hirerDate}</td>
                    <td>${employee.sal}</td>
                    <td>${employee.com}</td>
                    <td>${employee.city}</td>
                    <sec:authorize access="hasRole('ADMIN') or hasRole('CUST')">
                        <td><a href="<c:url value='/edit-user-${employee.objectId}' />"
                               class="btn btn-success custom-width">edit</a></td>
                    </sec:authorize>

                    <sec:authorize access="hasRole('ADMIN')">
                        <td><a href="<c:url value='/delete-user-${employee.objectId}' />"
                               class="btn btn-danger custom-width">delete</a></td>
                    </sec:authorize>

                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="well">
        <sec:authorize access="hasRole('ADMIN')">
            <a class="btn btn-primary" id="bottom_page" href="<c:url value='/newuser' />">Add New User</a>
        </sec:authorize>
        <sec:authorize access="hasRole('ADMIN') or hasRole('CUST') or hasRole('USER')">
            <a class="btn btn-primary" href="<c:url value='/listProjects' />">Project LIST</a>
        </sec:authorize>
    </div>

</div>
</body>
</html>