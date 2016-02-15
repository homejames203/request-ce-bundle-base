<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<bundle:layout page="${bundle.path}/layouts/layout.jsp">
    <bundle:scriptpack>
        <bundle:script src="${bundle.location}/js/search.js" />
    </bundle:scriptpack>
    <bundle:variable name="head">
        <title>${text.escape(space.name)} Search</title>
    </bundle:variable>

    <div class="search">
        <div class="visible-xs search-container">
            <form action="${bundle.kappLocation}" method="GET" role="form">
                <div class="form-group has-feedback">
                    <input type="hidden" value="search" name="page">
                    <input type="text" class="states form-control x" name="q" value="${param['q']}"/>
                </div>
            </form>
        </div>
    </div>

    <section class="content-header">
        <h1>
            Search results for '${param['q']}'
        </h1>
        <ol class="breadcrumb">
            <li><a href="${bundle.kappLocation}">
                <i class="fa fa-search"></i> 
                Home</a>
            </li>
            <li class="active">Search</li>
        </ol>
    </section>
    <section class="content">
        <c:if test="${text.isNotBlank(param['q'])}">
            <ul>
                <c:set var="found" value="false" />
                <c:forEach items="${kapp.forms}" var="form">
                    <c:if test="${text.equals(form.type.name, 'Service') || text.equals(form.type.name, 'Template')}">
                        <c:if test="${text.contains(text.downcase(form.name), text.downcase(param['q'])) || text.contains(text.downcase(form.description), text.downcase(param['q']))}">
                            <c:set var="found" value="true"/>
                            <li>
                                <h4>
                                    <a href="${bundle.kappLocation}/${form.slug}">
                                       ${form.name}
                                    </a>
                                </h4>
                                <c:if test="${not empty form.description}">
                                    <p>${form.description}</p>
                                </c:if>
                            </li>
                        </c:if>
                    </c:if>
                </c:forEach>
                <c:if test="${found == 'false'}">
                    <h5>No results found for ${param['q']}.</h5>
                </c:if>
                <input type="hidden" id="resultsFound" value="${found}"/>
            </ul>
        </c:if>
    </section>
</bundle:layout>