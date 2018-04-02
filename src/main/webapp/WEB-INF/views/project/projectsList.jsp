<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Projects List</title>
    <link href="<c:url value='/static/css/bootstrap.css' />" rel="stylesheet"></link>
    <link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
</head>

<body>
<div class="generic-container">
    <%@include file="../back/backtoemployeelistheader.jsp" %>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading"><span class="lead">List of Project </span></div>
        <table class="table table-hover">
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Discuss</th>
                <th>Specification</th>
                <th>Sollution</th>
                <th>Implementation</th>
                <th>Start</th>
                <th class="center_text" colspan="4">Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="project" items="${listProjects}">
                <tr>
                    <td>${project.projectId}</td>
                    <td>${project.projectName}</td>
                    <td>${project.projectDiscuss}</td>
                    <td>${project.projectSpecification}</td>
                    <td>${project.projectSullution}</td>
                    <td>${project.projectTechImpl}</td>
                    <td>${project.projectStart}</td>
                    <sec:authorize access="hasRole('ADMIN') or hasRole('CUST')">
                        <td><a href="<c:url value='/add-user-${project.projectId}' />"
                               class="btn btn-success custom-width addu_btn">AddU</a>
                        </td>
                    </sec:authorize>
                    <sec:authorize access="hasRole('ADMIN') or hasRole('CUST')">
                        <td><a href="<c:url value='/edit-project-${project.projectId}' />"
                               class="btn btn-success custom-width">EditP</a></td>
                    </sec:authorize>
                    <sec:authorize access="hasRole('ADMIN') or hasRole('CUST')">
                        <td><a href="<c:url value='/get-all-user-${project.projectId}' />"
                               class="btn btn-success custom-width addu_btn">GetAllU</a>
                        </td>
                    </sec:authorize>
                    <sec:authorize access="hasRole('ADMIN')">
                        <td><a href="<c:url value='/delete-project-${project.projectId}' />"
                               class="btn btn-danger custom-width">DeleteP</a></td>
                    </sec:authorize>

                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <sec:authorize access="hasRole('ADMIN') or hasRole('CUST')">
        <div class="well">
            <a class="btn btn-primary" href="<c:url value='/newproject' />">Add New Project</a>
        </div>
    </sec:authorize>

</div>
</body>
</html>