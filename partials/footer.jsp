<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<footer class="main-footer">
  <div class="pull-right hidden-xs">
    <b>Version</b> ${kapp.getAttributeValue('KAPP Version')}
  </div>
  <strong>Copyright &copy; 2014-2016 <a href="${kapp.getAttribute('Company Website').value}">${kapp.getAttribute('Company Name').value}</a>.</strong> All rights reserved.
</footer>
