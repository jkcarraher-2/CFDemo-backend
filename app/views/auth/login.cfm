<cfoutput>
    <h1>Login</h1>

    <cfif structKeyExists(rc, "error")>
        <p class="error">#encodeForHtml(rc.error)#</p>
    </cfif>

    <form method="post" action="/auth/login">
        <label>
            Username
            <input type="text" name="username">
        </label>

        <label>
            Password
            <input type="password" name="password">
        </label>

        <button type="submit">Login</button>
    </form>
</cfoutput>