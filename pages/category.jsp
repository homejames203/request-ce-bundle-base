<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<%
String category = request.getParameter("category");
request.setAttribute("category", category);
%>
<bundle:layout page="${bundle.path}/layouts/layout.jsp">
    <bundle:variable name="head">
        <title>${kapp.getAttribute('Company Name').value} - ${text.escape(kapp.getCategory(category).name)}</title>
    </bundle:variable>


    <section class="content-header">
        <h1>
            ${text.escape(kapp.getCategory(category).name)}
        </h1>
        <ol class="breadcrumb">
            <li><a href="${bundle.kappLocation}">
                <i class="fa fa-search"></i> 
                Home</a>
            </li>
        <li class="active">${text.escape(kapp.getCategory(category).name)}</li>
        </ol>
    </section>


    <section class="content">
        <div class="row">
            <div class="col-md-8">
                <c:forEach var="form" items="${kapp.getCategory(category).forms}">
                <c:set var="formReviews" value="${Submissions.searchByForm(kapp.getForm('service-reviews'), SubmissionHelper.serviceReviewQueryOptions(form.slug))}"/>
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <h2 class="box-title">${text.escape(form.name)}</h2>
                        </div>
                        <div class="box-body">
                            <div class="col-sm-2 formDescription">
                                <c:choose>
                                    <c:when test="${not empty form.getAttributeValue('Image')}">
                                        <div class="icon">
                                            <img class="img-responsive" src="${bundle.location}/images/forms/${form.getAttributeValue('Image')}"/>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="icon">
                                            <img class="img-responsive" src="${bundle.location}/images/placeholder.png"/>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="col-sm-10">
                                <dl class="dl-horizontal">
                                    <dt>Service Description:</dt>
                                    <dd>${text.escape(form.description)}</dd>
                                    <dt>Approval Required:</dt>
                                    <dd>
                                        <c:choose>
                                            <c:when test="${not empty form.getAttribute('Approval Type').value}">
                                                ${form.getAttribute('Approval Type').value}
                                            </c:when>
                                            <c:otherwise>
                                                No Approval Required
                                            </c:otherwise>
                                        </c:choose>
                                    </dd>
                                    <dt>Charge for Service:</dt>
                                    <dd>
                                        <c:choose>
                                            <c:when test="${not empty form.getAttribute('Charge').value}">
                                                ${form.getAttribute('Charge').value}
                                            </c:when>
                                            <c:otherwise>
                                                Service is Free of Charge
                                            </c:otherwise>
                                        </c:choose>
                                    </dd>
                                    <dt>SLA:</dt>
                                    <dd>
                                        <c:choose>
                                            <c:when test="${not empty form.getAttribute('SLA').value}">
                                                ${form.getAttribute('SLA').value}
                                            </c:when>
                                            <c:otherwise>
                                                No SLA Defined
                                            </c:otherwise>
                                        </c:choose>
                                    </dd>
                                    <dt>Service Rating:</dt>
                                    <dd>
                                        <a href="#${form.slug}-reviews" data-toggle="collapse">
                                            STARS GO HERE (${fn:length(formReviews)})
                                        </a>
                                    </dd>
                                </dl>
                            </div>
                        </div>
                        <div id="${form.slug}-reviews" class="collapse">
                            <div class='box-footer box-comments'>
                                <c:forEach items="${formReviews}" var="review">
                                    <div class='box-comment'>
                                        <div class='comment-text'>
                                            <span class="username">
                                                ${space.getUser(comment.createdBy.username).displayName}
                                                <span class='text-muted pull-right'>${comment.createdAt}</span>
                                            </span><!-- /.username -->
                                            ${text.escape(comment.getValue('Review'))}
                                        </div><!-- /.comment-text -->
                                    </div><!-- /.box-comment -->
                                </c:forEach>
                                <form action="#" method="post">
                                    <input type="text" class="form-control input-sm" placeholder="Submit a new review here">
                                </form>
                            </div><!-- /.box-footer -->
                        </div>
                        <div class="box-footer">
                            <button href="${bundle.spaceLocation}/${kapp.slug}/${form.slug}" class="btn btn-primary pull-right">${text.escape('Request')}</button>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="col-sm-4">
                <div class="box box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">My ${text.escape(kapp.getCategory(category).name)} Tickets</h3>
                    </div>
                    <div class="box-body">
                    </div>
                </div>
            </div>
        </div>
    </section>
</bundle:layout>