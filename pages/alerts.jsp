<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<c:set var="broadcastAlerts" value="${SubmissionHelper.broadcastAlertsSubmissions()}"/>

<bundle:layout page="${bundle.path}/layouts/layout.jsp">
    <bundle:variable name="head">
        <title>${kapp.getAttribute('Company Name').value} - Alerts</title>
    </bundle:variable>
    <section class="content-header">
        <h1>
            My Alerts
        </h1>
        <ol class="breadcrumb">
            <li><a href="${bundle.kappLocation}">
                <i class="fa fa-home"></i> 
                Home</a>
            </li>
            <li class="active">My Alerts</li>
        </ol>
    </section>

    <section class="content">
        <div class="box">
            <div class="box-header">
                <h3 class="box-title">My Alerts</h3>
            </div><!-- /.box-header -->
            <div class="box-body table-responsive no-padding">
                <table class="table table-hover">
                    <tbody>
                        <tr>
                            <th>Item Requested</th>
                            <th>Details</th>
                            <th>Requested By</th>
                            <th>Date Submitted</th>
                            <c:if test="${type eq 'Approvals'}">
                                <th>Decision</th>
                            </c:if>
                            <c:if test="${type eq 'Requests'}">
                                <th>Status</th>
                            </c:if>
                        </tr>
                        <c:forEach items="${submissionsList}" var="submission">
                            <tr>
                                <td>${text.escape(submission.form.name)}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${submission.coreState eq 'Draft'}">
                                            <a href="${bundle.spaceLocation}/submissions/${submission.id}">${text.escape(submission.label)}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${bundle.kappLocation}?page=submission&id=${submission.id}">${text.escape(submission.label)}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${submission.createdBy}</td>
                                <td>${submission.createdAt}</td>
                                <c:if test="${type eq 'Approvals'}">
                                    <td><span class="label label-success">${submission.getValue('Decision')}</span></td>
                                </c:if>
                                <c:if test="${type eq 'Requests'}">
                                    <td><span class="label label-success">${submission.coreState}</span></td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div><!-- /.box-body -->
            <div class="box-footer text-center">
            </div><!-- /.box-footer -->
        </div>
    </section>
</bundle:layout>