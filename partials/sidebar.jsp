<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>

<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- Sidebar user panel -->
		<div class="user-panel">
			<div class="pull-left image">
				<i class="img-circle fa fa-user fa-3x " alt="User Image"></i>
			</div>
			<div class="pull-left info">
				<p>${text.escape(identity.user.displayName)}</p>
				<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
			</div>
		</div>
		<!-- search form -->
		<form action="${bundle.kappLocation}" method="get" class="sidebar-form">
			<div class="input-group">
				<input type="hidden" value="search" name="page">
				<input type="text" name="q" class="form-control" placeholder="Search...">
				<span class="input-group-btn">
					<button type="submit" id="search-btn" class="btn btn-flat states"><i class="fa fa-search"></i></button>
				</span>
			</div>
		</form>
		<!-- /.search form -->
		<!-- sidebar menu: : style can be found in sidebar.less -->
		<ul class="sidebar-menu">
			<li class="header">MAIN NAVIGATION</li>
			<li <c:if test="${activePage eq 'home'}">class="active"</c:if> >
				<a href="${bundle.kappLocation}">
					<i class="fa fa-home"></i> <span>Home</span>
				</a>
			</li>
			<li <c:if test="${activePage eq 'request'}">class="active"</c:if> >
				<a href="${bundle.kappLocation}?page=submissions&type=request">
					<i class="fa fa-shopping-cart"></i> <span>My Requests</span>
				</a>
			</li>
			<li <c:if test="${activePage eq 'approval'}">class="active"</c:if> >
				<a href="${bundle.kappLocation}?page=submissions&type=approval">
					<i class="fa fa-thumbs-o-up"></i> <span>My Approvals</span>
				</a>
			</li>
			<%-- For each of the categories --%>
			<c:forEach items="${kapp.categories}" var="category">
				<%-- If the category is not hidden, and it contains at least 1 form --%>
				<c:if test="${fn:toLowerCase(category.getAttribute('Hidden').value) ne 'true' && not empty category.forms}">
					<%-- Test to make sure we're only displaying top level categories at this point --%>
					<c:if test="${not fn:containsIgnoreCase(category.name,'---')}">
						<%-- Set a variable we can use to see if a category has subcategories --%>
						<c:set var="hasSub" value=""/>
						<%-- Loop over all categories again and see if a subcategory matches --%>
						<c:forEach items="${kapp.categories}" var="subCategory">
							<c:if test="${fn:startsWith(subCategory.name, category.name) && fn:containsIgnoreCase(subCategory.name,'---')}">
								<c:set var="hasSub" value="treeview"/>
							</c:if>
						</c:forEach>
							<li <c:if test="${fn:contains(activePage,category.name)}">class="active ${hasSub}"</c:if> >
								<a href="${bundle.kappLocation}?page=category&category=${text.escape(category.name)}">
									<i class="fa ${category.getAttribute('fa-logo').value}"></i> 
									<span>${text.escape(category.name)}</span>
									<%-- If Subs exist, angle-left, otherwise show form count --%>
									<c:choose>
										<c:when test="${hasSub eq 'treeview'}">
											<i class="fa fa-angle-left pull-right"></i>
										</c:when>
										<c:otherwise>
											<span class="label label-primary pull-right">${fn:length(category.forms)}</span>
										</c:otherwise>
									</c:choose>
								</a>
								<c:if test="${hasSub eq 'treeview'}">
									<ul class="treeview-menu">
										<c:forEach items="${kapp.categories}" var="subCategory">
											<c:if test="${fn:startsWith(subCategory.name, category.name) && fn:containsIgnoreCase(subCategory.name,'---')}">
												<li <c:if test="${activePage eq subCategory.name}">class="active"</c:if> >
													<a href="${bundle.kappLocation}?page=category&category=${text.escape(subCategory.name)}">
														<i class="fa fa-circle-o"></i> <span>${fn:split(text.escape(subCategory.name),'---')[1]}</span>
														<span class="label label-primary pull-right">${fn:length(subCategory.forms)}</span>
													</a>
												</li>
											</c:if>
										</c:forEach>									
									</ul>
								</c:if>
							</li>
					</c:if>
				</c:if>
			</c:forEach>
			<c:if test="${fn:toLowerCase(identity.user.getAttribute('Catalog Manager').value) eq 'true'}">
				<li <c:if test="${activePage eq 'dashboard'}">class="active"</c:if> >
					<a href="${bundle.kappLocation}?page=dashboard">
						<i class="fa fa-tachometer"></i> <span>Management Dashboard</span>
					</a>
				</li>
			</c:if>
			<!--
			<li class="header">LABELS</li>
			<li><a href="#"><i class="fa fa-circle-o text-red"></i> <span>Important</span></a></li>
			<li><a href="#"><i class="fa fa-circle-o text-yellow"></i> <span>Warning</span></a></li>
			<li><a href="#"><i class="fa fa-circle-o text-aqua"></i> <span>Information</span></a></li>
			-->
		</ul>
	</section>
	<!-- /.sidebar -->
</aside>