<cfcomponent rest="true" restPath="enrollments">
    <!--- CREATE --->
    <cffunction
        name="createEnrollment"
        access="remote"
        returnType="any"
        httpMethod="POST"
        restPath="create">
        <cftry>
            <cfset var courseId = url.id>
            
            <cfif NOT isUserLoggedIn() >
                <cfset restSetResponse({
                    status=401,
                })>
                <cfreturn>
            </cfif>

            <cfset var courseService = new models.services.courseService() >
            <cfset courseService.enroll(userId = request.userId, courseId = courseId) >
            
            <!--- SUCCESS --->
            <cfset restSetResponse({
                status=201
            })>
            <cfreturn>

            <cfcatch>
                <!--- ERROR --->
                <cfset restSetResponse({
                    status = 500,
                })>
            </cfcatch>
        </cftry>
        
    </cffunction>
</cfcomponent>