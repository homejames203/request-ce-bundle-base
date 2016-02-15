<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<bundle:layout page="${bundle.path}/layouts/layout.jsp">
    <bundle:scriptpack>
        <bundle:script src="${bundle.location}/js/search.js" />
    </bundle:scriptpack>
    <bundle:variable name="head">
        <title>${text.escape(space.name)} Search</title>
    </bundle:variable>


    <section class="content-header">
        <h1>
            Management Dashboard
        </h1>
        <ol class="breadcrumb">
            <li><a href="${bundle.kappLocation}">
                <i class="fa fa-search"></i> 
                Home</a>
            </li>
            <li class="active">Dashboard</li>
        </ol>
    </section>
    <section class="content">
        
    </section>
</bundle:layout>