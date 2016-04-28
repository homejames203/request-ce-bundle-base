<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="bundle/initialization.jspf" %>
<script>debugger;</script>
<c:choose>
    <c:when test="${identity.anonymous}">
        <c:set var="kapp" scope="request" value="${kapp}"/>
        <c:redirect url="/${space.slug}/app/login?kapp=${kapp.slug}"/>
    </c:when>
    <c:otherwise>
      <bundle:layout page="layouts/form.jsp">
         <bundle:scriptpack>
            <bundle:script src="${bundle.location}/js/form.js" />
            <bundle:script src="${bundle.location}/js/formTables.js" />
         </bundle:scriptpack>
         <bundle:variable name="head">
            <title>${text.escape(form.name)}</title>
         </bundle:variable>
            <section class="content-header">
               <img class="formlogo pull-left" src="${bundle.location}/images/forms/${form.getAttributeValue('Image')}"/>
               <h1>
                  ${text.escape(form.name)}
               </h1>
               <c:if test="${param.review eq null}">
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
      <script>
         // Initialize Bootstrappy field overrides.
         bundle.config.fields = {
           text: function(field, triggerFn) {
             $(field.wrapper()).addClass('form-group');
             $(field.wrapper()).find('label').addClass('control-label');
             $(field.element()).addClass('form-control');
             $(field.element()).on('change', triggerFn);
           },
           dropdown: function(field, triggerFn) {
             $(field.wrapper()).addClass('form-group');
             $(field.wrapper()).find('label').addClass('control-label');
             $(field.element()).addClass('form-control');
             $(field.element()).on('change', triggerFn);
           },
           checkbox: function(field, triggerFn) {
             $(field.wrapper()).removeClass('checkbox');
             $(field.wrapper()).find('label').first().addClass('control-label');
             $(field.wrapper()).find('label').first().removeClass('field-label');
             $(field.wrapper()).children().not(':first-child').addClass('checkbox');
             $(field.wrapper()).children().not(':first-child').attr('style', 'margin-left:20px;');
             $(field.element()).on('change', triggerFn);
          },
           radio: function(field, triggerFn) {
             $(field.wrapper()).removeClass('radio');
             $(field.wrapper()).find('label').first().addClass('control-label');
             $(field.wrapper()).find('label').first().removeClass('field-label');
             $(field.wrapper()).children().not(':first-child').addClass('radio');
             $(field.wrapper()).children().not(':first-child').attr('style', 'margin-left:20px;');
             $(field.element()).on('change', triggerFn);
           }
         };
         bundle.config.ready = function() {
           $('[data-element-type="button"]').addClass('btn btn-default');
           $('[data-element-name="Submit Button"]').addClass('pull-right');
         };
      </script>
   </c:otherwise>
</c:choose>

