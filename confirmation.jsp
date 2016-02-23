<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="bundle/initialization.jspf" %>
<c:set var="submission" value="${submission}" scope="request"/>

<bundle:layout page="layouts/layout.jsp">
   <bundle:scriptpack>
   </bundle:scriptpack>
  <bundle:variable name="head">
  <title>${text.escape(form.name)}</title>
  </bundle:variable>

  <section class="content-header">
    <img class="formlogo pull-left" src="${bundle.location}/images/forms/${form.getAttributeValue('Image')}"/>
    <h1>
       ${text.escape(form.name)}
    </h1>
    <c:if test="${param.review != null && pages.size() > 1}">
       <ol class="breadcrumb">
          <li><a href="${bundle.kappLocation}">
             <i class="fa fa-home"></i> 
             Home</a>
          </li>
          <li class="active">${text.escape(form.name)}</li>
       </ol>
    </c:if>
  </section>
    <section class="content page " data-page="${page.name}">
      <c:set var="colClass" value="col-md-6"/>
      <c:if test="${submission.form.type.name eq 'Approval'}">
        <c:set var="colClass" value="col-md-12"/>
      </c:if>
      <div class="${colClass}">
        <div class="box box-primary">
          <div class="box-body">
            <c:choose>
              <c:when test='${empty submission.currentPage}'>
                <h4>Thank you for your submission</h4>
                <p><a href="${bundle.kappLocation}/${form.slug}">Submit again</a></p>
                <p><a href="${bundle.kappLocation}">Return to the catalog</a></p>
              </c:when>
              <c:otherwise>
                <app:bodyContent/>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>
      <c:if test="${submission.form.type.name ne 'Approval'}">
        <div class="col-md-6">
          <div class="box box-primary">
            <div class="box-header">
              <i class="fa fa-search"></i>
              <h3 class="box-title">Request Activity</h3>
            </div>
            <div id="submissionActivity" class="box-body">
              <c:import url="partials/taskActivity.jsp" charEncoding="UTF-8"></c:import>
            </div>
          </div>
        </div>
      </c:if>
    </section>
  
</bundle:layout>

<script>
// Function which refreshes submission activity on page load
$(function(){
    setInterval(
      function(){
        $.get(bundle.kappLocation() + "?partial=taskActivity&submission_id=" + window.location.pathname.split('/')[4], function( data ) {
            $('#submissionActivity').html(data).fadeIn();
        });
      }, 10000);
});
</script>

