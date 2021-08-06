<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
  <#if section = "header">
    ${msg("loginAccountTitle")}
  <#elseif section = "form">
  <div id="kc-form">
    <#if realm.password && social.providers??>
      <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
        <ul class="${properties.kcFormSocialAccountListClass!}">
          <#list social.providers as p>
            <a
              id="social-${p.alias}"
              class="${properties.kcFormSocialAccountListButtonClass!}"
              type="button"
              href="${p.loginUrl}"
            >
              <#if p.iconClasses?has_content>
                <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                <span class="${properties.kcFormSocialAccountNameClass!}">
                    ${msg('doLogInWith')} ${p.displayName!}
                </span>
              <#else>
                <span class="${properties.kcFormSocialAccountNameClass!}">${msg('doLogInWith')} ${p.displayName!}</span>
              </#if>
              </a>
          </#list>
        </ul>
      </div>
    </#if>

    <div class="${properties.stDividerClass!}">
      <span class="${properties.stDividerTextClass!}">${msg("or")}</span>
    </div>

    <div id="kc-form-wrapper">
      <#if realm.password>
      <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
        <div class="${properties.kcFormGroupClass!}">
          <label for="username" class="${properties.kcLabelClass!}">
            <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>
              ${msg("usernameOrEmail")}<#else>${msg("email")}
            </#if>
          </label>

          <#if usernameEditDisabled??>
          <input
            tabindex="1"
            id="username"
            class="${properties.kcInputClass!}"
            name="username"
            value="${(login.username!'')}"
            type="text"
            disabled
          />
          <#else>
          <input
            tabindex="1"
            id="username"
            class="${properties.kcInputClass!}"
            name="username"
            value="${(login.username!'')}"
            type="text"
            placeholder="${msg('email')}"
            autofocus
            autocomplete="off"
            aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
          />

          <#if messagesPerField.existsError('username','password')>
          <span
            id="input-error"
            class="${properties.kcInputErrorMessageClass!}"
            aria-live="polite"
          >
            ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
          </span>
          </#if>
          </#if>
        </div>
        <div class="${properties.kcFormGroupClass!}">
          <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>
          <input
            tabindex="2"
            id="password"
            class="${properties.kcInputClass!}"
            name="password"
            type="password"
            autocomplete="off"
            aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
            placeholder="${msg('password')}"
          />
        </div>
        <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
          <div id="kc-form-options">
            <#if realm.rememberMe && !usernameEditDisabled??>
            <div class="checkbox">
              <label>
                <#if login.rememberMe??>
                <input
                  tabindex="3"
                  id="rememberMe"
                  name="rememberMe"
                  type="checkbox"
                  checked
                > ${msg("rememberMe")}
                <#else>
                <input
                  tabindex="3"
                  id="rememberMe"
                  name="rememberMe"
                  type="checkbox"
                > ${msg("rememberMe")}
                </#if>
              </label>
            </div>
            </#if>
          </div>
          <div class="${properties.kcFormOptionsWrapperClass!}">
            <#if realm.resetPasswordAllowed>
            <span>
              <a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
            </span>
            </#if>
          </div>
        </div>

        <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
          <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
          <input
            tabindex="4"
            class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
            name="login"
            id="kc-login"
            type="submit"
            value="${msg('doLogIn')}"
          />
        </div>
      </form>
      </#if>
    </div>
  </div>

  <div class="${properties.stDividerClass!}">
    <span class="${properties.stDividerTextClass!}">${msg("or")}</span>
  </div>
  <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
    <a
      tabindex="6"
      class="${properties.kcButtonClass!} ${properties.kcButtonBlockClass!}"
      type="button"
      href="${url.registrationUrl}"
    >${msg("signUp")}</a>
  </#if>
  </#if>

</@layout.registrationLayout>
