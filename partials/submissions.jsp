<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>

<div class="box">
    <div class="box-header">
        <h3 class="box-title">My Requests</h3>
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
                    <th>Status</th>
                </tr>
                <c:forEach items="${submissionsList}" begin="0" end="4" var="submission">
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
                        <td>${submission.createdBy}</td>
                        <td>${submission.createdAt}</td>
                        <td><span class="label label-success">${submission.coreState}</span></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div><!-- /.box-body -->
    <div class="box-footer text-center">
        <a href="${bundle.kappLocation}?page=submissions&type=request" class="uppercase">View All Requests</a>
    </div><!-- /.box-footer -->
</div>