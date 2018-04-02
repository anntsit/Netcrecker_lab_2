<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Project Registration Form</title>
    <link href="<c:url value='/static/css/bootstrap.css' />" rel="stylesheet"></link>
    <link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
</head>

<body class="regisration_page">
<div class="generic-container registration_content">
    <%@include file="../back/backtoprojectlistheader.jsp" %>

    <div class="well lead">Project Registration Form</div>
    <form:form method="POST" modelAttribute="project" class="form-hor izontal">
        <%--<form:input type="hidden" path="objectId" id="objectId"/>--%>

        <div class="row">
            <div class="form-group col-md-12">
                <label class="col-md-3 control-lable" for="projectName">Project Name</label>
                <div class="col-md-7">
                    <form:input type="text" path="projectName" id="projectName" class="form-control input-sm"/>
                    <div class="has-error">
                        <form:errors path="projectName" class="help-inline"/>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group col-md-12">
                <label class="col-md-3 control-lable" for="projectDiscuss">Discuss</label>
                <div class="col-md-7">
                            <form:input type="date" path="projectDiscuss" id="projectDiscuss"
                                        class="form-control input-sm"/>
                    <div class="has-error">
                        <form:errors path="projectDiscuss" class="help-inline"/>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group col-md-12">
                <label class="col-md-3 control-lable" for="projectSpecification">Specification</label>
                <div class="col-md-7">
                            <form:input type="date" path="projectSpecification" id="projectSpecification"
                                        class="form-control input-sm"/>
                    <div class="has-error">
                        <form:errors path="projectSpecification" class="help-inline"/>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group col-md-12">
                <label class="col-md-3 control-lable" for="projectSullution">Sollution</label>
                <div class="col-md-7">
                            <form:input type="date" path="projectSullution" id="projectSullution"
                                        class="form-control input-sm"/>
                    <div class="has-error">
                        <form:errors path="projectSullution" class="help-inline"/>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group col-md-12">
                <label class="col-md-3 control-lable" for="projectTechImpl">Implementaion</label>
                <div class="col-md-7">
                            <form:input type="date" path="projectTechImpl" id="projectTechImpl"
                                        class="form-control input-sm"/>
                    <div class="has-error">
                        <form:errors path="projectTechImpl" class="help-inline"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="form-group col-md-12">
                <label class="col-md-3 control-lable" for="projectStart">Start</label>
                <div class="col-md-7">
                            <form:input type="date" path="projectStart" id="projectStart"
                                        class="form-control input-sm"/>
                    <div class="has-error">
                        <form:errors path="projectStart" class="help-inline"/>
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
                        <input type="submit" value="Register" class="btn btn-primary btn-sm"/> or <a
                            class="btn btn-primary"  href="<c:url value='/listProjects' />">Cancel</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </form:form>
</div>
</body>
</html>