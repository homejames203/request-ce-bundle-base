<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<c:set var="submission" value="${Submissions.retrieve(param.submission_id)}" scope="page"/>
<section class="content-header">
    <h1>
        ${submission.label}
        <small>${submission.submittedAt}</small>
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
                    <dd>${submission.submittedAt}</dd>
                    <dt>Status:</dt>
                    <dd>${submission.coreState}</dd>
                </dl>
                <p>${submission.form.description}</p>
            </div>
        </div>
        <div class="col-md-8 col-xs-12 ">
            <!-- The time line -->
            <c:forEach var="run" items="${TaskRuns.find(submission)}">
                <ul class="timeline">
                    <!-- timeline time label -->
                    <li class="time-label">
                        <span class="bg-red">
                            ${submission.submittedAt}
                        </span>
                    </li>
                    <!-- /.timeline-label -->
                    <!-- timeline item -->
                    <c:forEach var="task" items="${run.tasks}">
                        <li>
                            <i class="fa fa-envelope bg-blue"></i>
                            <div class="timeline-item">
                                <span class="time"><i class="fa fa-clock-o"></i> ${text.escape(task.createdAt)}</span>
                                <h3 class="timeline-header"><a href="#">${text.escape(task.name)}</a> FOO </h3>
                                <div class="timeline-body">
                                    <c:forEach var="entry" items="${task.messages}">
                                        <li>${text.escape(entry.message)}</li>
                                    </c:forEach>
                                </div>
                                <div class="timeline-footer">
                                    <a class="btn btn-primary btn-xs">Read more</a>
                                    <a class="btn btn-danger btn-xs">Delete</a>
                                </div>
                            </div>
                        </li>
                    </c:forEach> <!-- END timeline item -->
                    <li>
                      <i class="fa fa-clock-o bg-gray"></i>
                    </li>
                </ul>
            </c:forEach>
        </div>
    </div>
</section>

        