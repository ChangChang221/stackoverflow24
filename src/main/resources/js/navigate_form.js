const navigate_form = (to) => {
  const ele = document.getElementsByClassName("form-auth-container")[0];
  switch (to) {
    case "sign_up": {
      ele.innerHTML = `<form:form class="form-auth" modelAttribute="user" action="/signup">
      <label>Display name</label>
      <form:input path="name" />
      <label>Email</label>
      <form:input path="email" />
      <label>Password</label>
      <form:input path="password"/>
      <p>
        Passwords must contain at least eight characters, including at least
        1 letter and 1 number.
      </p>
      <button class="btn-primary" type="submit">Sign up</button>
      <span>
        By clicking “Sign up”, you agree to
        <a href="#">our terms of service</a>,
        <a href="#">privacy policy </a>and
        <a href="#"> cookie policy</a>
      </span>
    </form:form>
    <span style="font-size: 14px; color: #868585" ;
      >Already have an account?
      <a
        style="text-decoration: none; color:#0095ff; cursor:pointer"
        onclick="navigate_form('sign_in')"
        >Log in</a>
    </span>`;
      break;
    }

    case "sign_in": {
      ele.innerHTML = `<form class="form-auth">
        <label>Email</label>
        <input />
        <label>Password</label>
        <input />
        <a style="text-decoration: none; color:#0095ff; cursor:pointer; margin:10px 0px"
        onclick="navigate_form('forgot_password')"
        <button class="btn-primary">Sign in</button>
      </form>
      <span style="font-size: 14px; color: #868585; " ;
        >Don’t have an account?
        <a style="text-decoration: none; color:#0095ff; cursor:pointer"
        onclick="navigate_form('sign_up')"
        >Sign up</a></span>`;
      break;
    }
    case "forgot_password": {
      ele.innerHTML = `<form:form class="form-auth">
      <p style="margin: 10px 0px"> Forgot your account’s password or having trouble logging into your Team? Enter your email address and we’ll send you a recovery code.
      </p>
        <label>Email</label>
        <form:input path="email"/>
        <button class="btn-primary" style="margin:10px 0px" onclick="navigate_form('type_code_forgot_password')" >Send recovery email</button>
      </form:form>
        `;
      break;
    }

    case "type_code_forgot_password": {
      ele.innerHTML = `<form class="form-auth">
      <p style="margin: 10px 0px"> Type vefify code you received.
      </p>
        <label>Code</label>
        <input />
        <button class="btn-primary" style="margin :10px 0px">Type verify code</button>
      </form>
        `;
      break;
    }
  }
};
