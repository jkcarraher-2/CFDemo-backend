<cfcomponent rest="true" restPath="enrollments">
    <!--- CREATE --->
    <cffunction
        name="createEnrollment"
        access="remote"
        returntype="string"
        httpMethod="POST"
        restPath="create"
        produces="application/json"
    >
        <cftry>
            <cfset var courseId = url.id>
            
            <cfif NOT isUserLoggedIn() >
                <cfset restSetResponse({
                    status=401,
                    content = serializeJSON({
                        success = false,
                        message = "You must be logged in."
                    })
                })>
                <cfreturn>
            </cfif>

            <cfset var courseService = new models.services.courseService() >
            <cfset courseService.enroll(userId = request.userId, courseId = courseId) >
            
            <!--- SUCCESS --->
            <cfset restSetResponse({
                status=201,
                content= serializeJSON({
                    success = true,
                    message = "Successfully enrolled user #request.userID# in course #courseId#."
                })
            })>
            <cfreturn >

            <cfcatch>
                <!--- ERROR --->
                <cfset restSetResponse({
                    status = 500,
                    content = serializeJSON({
                        success = false,
                        message = "Failed to enroll in course."
                    })
                })>
            </cfcatch>
        </cftry>
        
    </cffunction>
</cfcomponent>