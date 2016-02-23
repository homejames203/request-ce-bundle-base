<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, maximum-scale=1.0">
        <link rel="apple-touch-icon" sizes="76x76" href="${bundle.location}/images/apple-touch-icon.png">
        <link rel="icon" type="image/png" href="${bundle.location}/images/android-chrome-96x96.png" sizes="96x96">
        <link rel="icon" type="image/png" href="${bundle.location}/images/favicon-32x32.png" sizes="32x32">
        <link rel="icon" type="image/png" href="${bundle.location}/images/favicon-96x96.png" sizes="96x96">
        <link rel="icon" type="image/png" href="${bundle.location}/images/favicon-16x16.png" sizes="16x16">
        <link rel="shortcut icon" href="${bundle.location}/images/favicon.ico" type="image/x-icon"/>
        <app:headContent/>
        <bundle:stylepack>
            <bundle:style src="${bundle.location}/libraries/bootstrap/css/bootstrap.min.css" />
            <bundle:style src="${bundle.location}/libraries/jvectormap/jquery-jvectormap-1.2.2.css" />
            <bundle:style src="${bundle.location}/libraries/adminLTE/AdminLTE.min.css" />
            <bundle:style src="${bundle.location}/libraries/adminLTE/${kapp.getAttribute('Theme Skin').value}.min.css" />
            <bundle:style src="${bundle.location}/libraries/notifie/jquery.notifie.css" />
            <bundle:style src="${bundle.location}/css/custom.css "/>
        </bundle:stylepack>
        <link href="${bundle.location}/libraries/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="${bundle.location}/libraries/adminLTE/html5shiv.min.js"></script>
            <script src="${bundle.location}/libraries/adminLTE/respond.min.js"></script>
        <![endif]-->
        <bundle:scriptpack>
            <bundle:script src="${bundle.location}/libraries/jquery/jQuery-2.1.4.min.js" />
            <bundle:script src="${bundle.location}/libraries/kd-search/search.js" />
            <bundle:script src="${bundle.location}/libraries/bootstrap/js/bootstrap.min.js" />
            <bundle:script src="${bundle.location}/libraries/fastclick/fastclick.min.js" />
            <bundle:script src="${bundle.location}/libraries/adminLTE/app.min.js" />
            <bundle:script src="${bundle.location}/libraries/sparkline/jquery.sparkline.min.js" />
            <bundle:script src="${bundle.location}/libraries/jvectormap/jquery-jvectormap-1.2.2.min.js" />
            <bundle:script src="${bundle.location}/libraries/jvectormap/jquery-jvectormap-world-mill-en.js" />
            <bundle:script src="${bundle.location}/libraries/slimScroll/jquery.slimscroll.min.js" />
            <bundle:script src="${bundle.location}/libraries/chartjs/Chart.min.js" />
            <bundle:script src="${bundle.location}/libraries/chartjs/Chart.min.js" />
            <bundle:script src="${bundle.location}/libraries/notifie/jquery.notifie.js" />
            <bundle:script src="${bundle.location}/libraries/jquery-datatables/jquery.dataTables.js" />
            <bundle:script src="${bundle.location}/libraries/typeahead/typeahead.min.js" />
            <bundle:script src="${bundle.location}/js/catalog.js" />
            <bundle:script src="${bundle.location}/js/review.js" />
        </bundle:scriptpack>
        <bundle:yield name="head"/>
        <style>
            <c:if test="${not empty kapp.getAttribute('logo-height-px')}">
                .navbar-brand {height:${kapp.getAttribute('logo-height-px').value}px;}
            </c:if>
        </style>
        <script>
            <c:if test="${not empty kapp.getAttribute('Company Logo')}">
                bundle['logo'] = function(){ return "${kapp.getAttribute('Company Logo').value}" };
            </c:if>
            <c:if test="${not empty kapp.getAttribute('Company Name')}">
                bundle['logo'] = function(){ return "${kapp.getAttribute('Company Name').value}" };
            </c:if>
            bundle['urlParam'] = function(name){
                var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
                return results[1] || 0;
            };
        </script>

        <c:choose>
            <c:when test="${param['page'] eq 'submissions'}">
                <c:choose>
                    <c:when test="${param['type'] eq 'approval'}">
                        <c:set scope="session" var="activePage" value="approval"/>
                    </c:when>
                    <c:otherwise>
                        <c:set scope="session" var="activePage" value="request"/>
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:when test="${param['page'] eq 'category'}">
                <c:set scope="session" var="activePage" value="${param['category']}"/>
            </c:when>
            <c:when test="${param['page'] eq 'dashboard'}">
                <c:set scope="session" var="activePage" value="dashboard"/>
            </c:when>
            <c:otherwise>
                <c:set scope="session" var="activePage" value="home"/>
            </c:otherwise>
        </c:choose>
    </head>


    <body class="hold-transition sidebar-mini skin-black-light">
        <div class="wrapper">
            <c:if test="${not empty identity}">
                <c:import url="${bundle.path}/partials/header.jsp" charEncoding="UTF-8"/>
                <c:import url="${bundle.path}/partials/sidebar.jsp" charEncoding="UTF-8"/>
            </c:if>
            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <bundle:yield/>
            </div>
            <c:import url="${bundle.path}/partials/footer.jsp" charEncoding="UTF-8"/>
        </div>
    </body>
</html>
