<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>User Registration Form</title>
    <link href="<c:url value='/static/css/bootstrap.css' />" rel="stylesheet"></link>
    <link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
</head>

<body class="regisration_page">
<div class="generic-container registration_content">
    <%@include file="../back/backtoprojectlistheader.jsp" %>
    <form:form method="POST" modelAttribute="newuserinproject" class="form-hor izontal">
    <div class="well lead">Form for adding user to the project</div>

        <div class="row">
            <div class="form-group col-md-12">
                <label class="col-md-3 control-lable" for="objectId">Object Name</label>
                <div class="col-md-7">
                    <form:select path="objectId" items="${objects}" multiple="true" itemValue="objectId" itemLabel="object" class="form-control input-sm" />
                    <div class="has-error">
                        <form:errors path="objectId" class="help-inline"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="form-actions floatRight">
                <c:choose>
                    <c:when test="${edit}">
                        <input type="submit" value="Update" class="btn btn-primary btn-sm"/> or <a
                            class="btn btn-primary" href="<c:url value='/listProjects' />">Cancel</a>
                    </c:when>
                    <c:otherwise>
                        <input type="submit" value="Save user to project" class="btn btn-primary btn-sm"/> or <a
                            class="btn btn-primary" href="<c:url value='/listProjects' />">Cancel</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </form:form>
</div>
</body>
</html>