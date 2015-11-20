<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../../../package/initialization.jspf" %>
<footer>
    <div class="container">
      <div class="col-xs-8">
        <img src='${bundle.location}/packages/default/images/ProductName-Request.png' class='desaturate' height="40"/>
      </div>
      <div class="col-xs-4">
        <dl class="dl-horizontal">
          <dt>Build Date:</dt>
          <dd>${buildDate}</dd>
          <dt>Build Number: </dt>
          <dd>${buildNumber}</dd>
          <dt>Version:</dt>
          <dd>${buildVersion}</dd>
        </dl>
      </div>
    </div>
</footer>
