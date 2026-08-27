<cfscript>
    request.action = structKeyExists(url, "action")
        ? url.action
        : "index";

    authController = new controllers.authController();

    if (request.action == "login") {
        authController.login(form);
    }
</cfscript>

<cfoutput>
    <h1>Login</h1>

    <form method="post" action="/login?action=login">
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