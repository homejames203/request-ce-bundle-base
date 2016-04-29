<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<c:set var="submission" value="${Submissions.retrieve(param.id)}" scope="page"/>
<bundle:layout page="${bundle.path}/layouts/layout.jsp">
    <section class="content-header">
        <h1>
            ${submission.label}
            <small>Submitted On: <span data-moment> ${submission.submittedAt}</span></small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#">
                <i class="fa fa-home"></i> 
                Home</a>
            </li>
            <li class="active">${submission.label}</li>
        </ol>
    </section>
    <section class="content">
        <div class="row">
            <div class="col-md-4 col-xs-12 ">
                <div class="submission-meta">
                    <h2>${submission.form.name}</h2>
                    <dl>
                        <dt>Label:</dt>
                        <dd>${submission.label}</dd>
                        <dt>Request Date:</dt>
                        <dd data-moment>${submission.submittedAt}</dd>
                        <dt>Status:</dt>
                        <dd>${submission.coreState}</dd>
                    </dl>
                    <p>${submission.form.description}</p>
                    <div class="box-body">
                        <a class="btn btn-info" href="${bundle.spaceLocation}/submissions/${submission.id}?review">Review Submitted Form</a>
                        <a class="btn btn-primary" href="${bundle.spaceLocation}/${kapp.slug}/${submission.form.slug}">Request Again</a>
                    </div>
                </div>
            </div>
            <div class="col-md-8 col-xs-12 ">
                <div id="submissionActivity" class="box-body">
                    <c:import url="partials/taskActivity.jsp" charEncoding="UTF-8"></c:import>
                </div>
            </div>
        </div>
    </section>

    <script>
    $(function(){
        setInterval(
          function(){
            $.get(bundle.kappLocation() + "?partial=taskActivity&id=" + bundle.urlParam('id'), function( data ) {
                $('#submissionActivity').html(data).fadeIn();
            });
          }, 90000);
    });
    </script>

</bundle:layout>