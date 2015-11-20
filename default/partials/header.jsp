<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<nav class="navbar navbar-default">
    <div class="container">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
        data-target="${target}" aria-expanded="false">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="${bundle.kappLocation}"><i class="fa fa-home"></i> ${app:escape(kapp.name)}</a>
      </div>
      <div class="collapse navbar-collapse" id="navbar-collapse-1">
          <ul class="nav navbar-nav navbar-right">
              <li>
                  <div class="navbar-text navbar-right btn-group collapse">
                      <span class="btn btn-default" href="#"><i class="fa fa-user fa-fw"></i> ${app:escape(identity.username)}</span>
                      <a class="btn btn-default dropdown-toggle" data-toggle="dropdown" href="#">
                          <span class="fa fa-caret-down"></span></a>
                      <ul class="dropdown-menu">
                          <li><a href="#"><i class="fa fa-pencil fa-fw"></i> Edit Profile</a></li>
                          <li class="divider"></li>
                          <li><a href="${bundle.spaceLocation}/app/"><i class="fa fa-dashboard fa-fw"></i> Management Console</a></li>
                          <li class="divider"></li>
                          <li><a href="${bundle.spaceLocation}/app/logout"><i class="fa fa-sign-out fa-fw"></i> Logout</a></li>
                      </ul>
                  </div>
              </li>
          </ul>
      </div>
    </div>
</nav>
