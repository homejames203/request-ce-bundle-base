<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<c:choose>
    <c:when test="${param['type'] eq 'approval'}">
        <c:set scope="request" var="submissionsList" value="${Submissions.searchByKapp(kapp, SubmissionHelper.approvalsQueryOptions())}"/>
        <c:set scope="request" var="type" value="Approvals"/>
    </c:when>
    <c:otherwise>
        <c:set scope="request" var="submissionsList" value="${Submissions.searchByKapp(kapp, SubmissionHelper.requestsQueryOptions())}"/>
        <c:set scope="request" var="type" value="Requests"/>
    </c:otherwise>
</c:choose>
<bundle:layout page="${bundle.path}/layouts/layout.jsp">
    <bundle:variable name="head">
        <title>${text.escape(space.name)} Profile</title>
    </bundle:variable>
    <section class="content-header">
        <h1>
            My ${type}
            <small>Version 2.0</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#">
                <i class="fa fa-home"></i> 
                Home</a>
            </li>
            <li class="active">My ${type}</li>
        </ol>
    </section>

    <section class="content">
        <div class="box">
            <div class="box-header">
                <h3 class="box-title">My ${type}</h3>
                <div class="box-tools">
                    <div class="input-group" style="width: 150px;">
                        <input type="text" name="table_search" class="form-control input-sm pull-right" placeholder="Search">
                        <div class="input-group-btn">
                            <button class="btn btn-sm btn-default"><i class="fa fa-search"></i></button>
                        </div>
                    </div>
                </div>
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
                            <c:set var="statusColor" value="label-success"/>
                            <c:choose> 
                                <c:when test="${submission.coreState eq 'Draft'}">
                                    <c:set var="statusColor" value="label-warning"/>
                                </c:when>
                                <c:when test="${submission.coreState eq 'Submitted'}">
                                    <c:set var="statusColor" value="label-success"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="statusColor" value="label-primary"/>
                                </c:otherwise>
                            </c:choose>
                            <tr>
                                <td>${text.escape(submission.form.name)}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${submission.coreState eq 'Draft'}">
                                            <a href="${bundle.spaceLocation}/submissions/${submission.id}">${text.escape(submission.label)}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${bundle.kappLocation}?submission_id=${submission.id}">${text.escape(submission.label)}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${space.getUser(submission.createdBy).displayName}</td>
                                <td><fmt:formatDate type="date" value="${submission.createdAt}" dateStyle="medium"/></td>
                                <c:if test="${type eq 'Approvals'}">
                                    <c:if test="${submission.getValue('Decision') eq 'Approved'}">
                                        <c:set var="statusColor" value="label-success"/>
                                    </c:if>
                                    <c:if test="${submission.getValue('Decision') eq 'Denied'}">
                                        <c:set var="statusColor" value="label-danger"/>
                                    </c:if>
                                    <c:set var="approvalStatus" value="${submission.getValue('Decision')}"/>
                                    <c:if test="${submission.coreState eq 'Draft'}">
                                        <c:set var="approvalStatus" value="Pending Approval"/>
                                    </c:if>
                                    <td><span class="label ${statusColor}">${approvalStatus}</span></td>
                                </c:if>
                                <c:if test="${type eq 'Requests'}">
                                    <td><span class="label ${statusColor}">${submission.coreState}</span></td>
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