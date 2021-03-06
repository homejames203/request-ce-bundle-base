<%@include file="bundle/initialization.jspf" %>
<bundle:layout page="layouts/login.jsp">
    <bundle:variable name="head">
        <title>${text.escape(kapp.name)} Login</title>
    </bundle:variable>
    <!-- Logo -->
    <div class="login-logo">
      <a href="#" class="logo">
          <!-- logo for regular state and mobile devices -->
          <span class="logo-lg">
              <c:if test="${not empty kapp.getAttribute('Company Logo')}">
                <c:choose>
                  <c:when test ="${fn:containsIgnoreCase(kapp.getAttribute('Company Logo').value, 'http')}">
                    <img class="pull-left" style="width:100%;" src="${kapp.getAttribute('Company Logo').value}" alt="logo">
                  </c:when>
                  <c:otherwise>
                    <img class="pull-left" style="width:100%;" src="${bundle.location}/${kapp.getAttribute('Company Logo').value}" alt="logo">
                  </c:otherwise>
                </c:choose>
              </c:if>
          </span>
      </a>
    </div>
    <div class="login-box-body">
      <section>
        <p class="login-box-msg" style="padding-top:15px;">Sign in to start your session</p>
        <form action="<c:url value="/${space.slug}/app/login.do"/>" method="POST">
            <!-- CSRF Token field -->
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <!-- Space to login to -->
            <input type="hidden" name="j_space" value="${space.slug}"/>

            <!-- Kapp to login to -->
            <input type="hidden" name="j_kapp" value="${kapp.slug}"/>

            <!-- Username field -->
            <div class="form-group">
              <label for="j_username">${resourceBundle.getString("auth.login.username")}</label>
              <input type="text" name="j_username" id="j_username" class="form-control" autofocus/>
            </div>

            <!-- Password field -->
            <div class="form-group">
              <label for="j_password">${resourceBundle.getString("auth.login.password")}</label>
              <input type="password" name="j_password" id="j_password" class="form-control" autocomplete="off"/>
            </div>

            <div class="form-group">
              <button id="submit" type="submit" class="btn btn-primary btn-block btn-flat">${resourceBundle.getString("auth.login.submit")}</button>
            </div>
        </form>
      </section>
    </div>
</bundle:layout>

<script>        
$.fn.serializeObject = function()
    {
    var obj = {};
    var arr = this.serializeArray();
    $.each(arr, function() {
        if (obj[this.name] !== undefined) {
            if (!obj[this.name].push) {
                obj[this.name] = [obj[this.name]];
            }
            obj[this.name].push(this.value || '');
        } else {
            obj[this.name] = this.value || '';
        }
    });
    return obj;
};

$(function() {
    $('#submit').click(function() {
        var data = JSON.stringify($('form').serializeObject());
         $.ajax({
            method: 'post',
            dataType: 'json',
            contentType: 'application/json',
            url: '/kinetic/${space.slug}/app/login.do',
            data: data,
            beforeSend: function(jqXHR, settings){
               console.log('before')
            },
            success: function(data, textStatus, jqXHR){
               window.location = "${bundle.spaceLocation}/${kapp.slug}"
               console.log('success')
            },
            error: function(jqXHR, textStatus, errorThrown){
                console.log('error')
            },
            complete: function(jqXHR, settings){
                console.log('complete')
            },
        });
        
    });
});
</script>
