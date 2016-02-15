<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="bundle/initialization.jspf" %>
<bundle:layout page="layouts/form.jsp">
   <bundle:scriptpack>
      <bundle:script src="${bundle.location}/js/form.js" />
   </bundle:scriptpack>
   <bundle:variable name="head">
      <title>${text.escape(form.name)}</title>
   </bundle:variable>
   <section class="content-header">
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
      <c:if test="${param.review != null && pages.size() > 1}">
         <c:import url="partials/review.jsp" charEncoding="UTF-8"></c:import>
      </c:if>
   <div class="errors"></div>
   <div class="box box-primary">
      <app:bodyContent/>
   </div>
   </section>
</bundle:layout>

