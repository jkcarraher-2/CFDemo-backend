<cfcomponent>
        <cffunction name="login" returntype="void" access="public">
            <cfargument name="rc" type="struct" required="true">

            <cfif !structKeyExists(arguments.rc, "username") OR !structKeyExists(arguments.rc, "password")>
                <cfset arguments.rc.error = "Username and password are required.">
                <cfreturn>
            </cfif>

            <cfset var authService = new models.services.AuthService()>

            <cfset var result = authService.authenticate(
                arguments.rc.username,
                arguments.rc.password
            )>

            <cfif !result.success >
                <cfset arguments.rc.error = result.error>
                <cfreturn>
            </cfif>
            
            <cflogin>
                <cfLoginUser name = #result.user.email# 
                            password = #rc.password# 
                            roles = "user"
                >
            </cflogin>
            
            // Log user in with CFLogin
            <cfif NOT isUserLoggedIn() >
                <cfset arguments.rc.error = "cfLoginUser Failed">
                <cfreturn>
            </cfif>

            <cfset location("/")>
        </cffunction>
    
</cfcomponent>
