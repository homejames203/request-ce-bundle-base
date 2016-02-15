<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<bundle:variable name="head">
    <title>Kinetic Data ${text.escape(kapp.name)}</title>
</bundle:variable>

<section class="content-header">
    <h1>
        Enterprise Request Management System
        <small>Version ${kapp.getAttributeValue('KAPP Version')}</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#">
            <i class="fa fa-home"></i> 
            Home</a>
        </li>
    </ol>
</section>

<section class="content">
    <!-- Small boxes (Stat box) -->
    <div class="row">
        <div class="col-lg-3 col-xs-6">
            <!-- small box -->
            <div class="small-box bg-aqua">
                <div class="inner">
                    <h3>${fn:length(Submissions.searchByKapp(kapp, SubmissionHelper.requestsQueryOptions()))}</h3>
                    <p>My Requests</p>
                </div>
                <div class="icon">
                    <i class="fa fa-shopping-cart"></i>
                </div>
                <a href="${bundle.kappLocation}?page=submissions&type=request" class="small-box-footer">View Your Requests <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div><!-- ./col -->

        <div class="col-lg-3 col-xs-6">
            <!-- small box -->
            <div class="small-box bg-green">
                <div class="inner">
                    <h3>${fn:length(Submissions.searchByKapp(kapp, SubmissionHelper.approvalsQueryOptions()))}</h3>
                    <p>My Approvals</p>
                </div>
                <div class="icon">
                    <i class="fa fa-thumbs-o-up"></i>
                </div>
                <a href="${bundle.kappLocation}?page=submissions&type=approval" class="small-box-footer">View Your Approvals <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div><!-- ./col -->

        <div class="col-lg-3 col-xs-6">
            <!-- small box -->
            <div class="small-box bg-yellow">
                <div class="inner">
                    <h3>44</h3>
                    <p>My Assets</p>
                </div>
                <div class="icon">
                    <i class="fa fa-mobile"></i>
                </div>
                <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div><!-- ./col -->

        <div class="col-lg-3 col-xs-6">
            <!-- small box -->
            <div class="small-box bg-red">
                <div class="inner">
                    <h3>65</h3>
                    <p>Knowledge Base</p>
                </div>
                <div class="icon">
                    <i class="ion ion-pie-graph"></i>
                </div>
                <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div><!-- ./col -->
    </div><!-- /.row -->

    <div class="row">
        <div class="col-md-8">
            <c:set scope="request" var="submissionsList" value="${Submissions.searchByKapp(kapp, SubmissionHelper.requestsQueryOptions())}"/>
            <c:import url="${bundle.path}/partials/submissions.jsp" charEncoding="UTF-8"/>
        </div>
        <div class="col-md-4">
            <!-- PRODUCT LIST -->
              <div class="box box-primary">
                <div class="box-header with-border">
                  <h3 class="box-title">Popular Services</h3>
                  <div class="box-tools pull-right">
                    <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    <button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                  </div>
                </div><!-- /.box-header -->
                <div class="box-body">
                  <ul class="products-list product-list-in-box">
                    <c:forEach var="popForm" begin="0" end="4" items="${kapp.getCategory('Popular Requests').forms}">
                        <li class="item">
                          <div class="product-img">
                            <img src="${bundle.location}/images/forms/${popForm.getAttributeValue('Image')}" alt="${text.escape(popForm.name)}">
                          </div>
                          <div class="product-info">
                            <a href="${bundle.spaceLocation}/${kapp.slug}/${popForm.slug}" class="product-title">${text.escape(popForm.name)} <span class="label label-warning pull-right"></span></a>
                            <span class="product-description">
                              ${text.escape(popForm.description)}
                            </span>
                          </div>
                        </li><!-- /.item -->
                    </c:forEach>
                  </ul>
                </div><!-- /.box-body -->
                <div class="box-footer text-center">
                  <a href="javascript::;" class="uppercase">View All Services</a>
                </div><!-- /.box-footer -->
              </div><!-- /.box -->
        </div>
    </div>
</section>