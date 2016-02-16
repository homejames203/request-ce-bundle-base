<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<!-- The time line -->
<c:if test="${empty submission}">
	<c:set var="submission" value="${Submissions.retrieve(param.submission_id)}" scope="request"/>
</c:if>

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