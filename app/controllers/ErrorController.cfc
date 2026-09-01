<cfcomponent>
    <cffunction name="errorView" returntype="struct" access="public">
        <cfargument name="errorCode" type="integer" required="false" default=500>
        <cfargument name="errorDescription" type="string" required="false" default="Internal Server Error">

        <cfset request.errorCode = errorCode>
        <cfset request.errorDescription = errorDescription>
        <cfheader statuscode="#errorCode#" statustext="#errorDescription#" >

        <cfreturn { view: "error"}>

    </cffunction>
</cfcomponent>