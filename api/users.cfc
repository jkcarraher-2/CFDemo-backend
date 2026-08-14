<cfcomponent rest="true" restPath="users">
    <cffunction
        name="test"
        access="remote"
        returnType="string"
        httpMethod="GET"
        restPath="test">

        <cfreturn "Connected to users endpoint">
    </cffunction>

    <!--- GET ALL --->
    <cffunction
        name="getUsers"
        access="remote"
        returntype="string"
        httpMethod="GET"
        restPath=""
        produces="application/json">
        <cftry>
            <cfquery name="qUsers" datasource="sqlite">
                SELECT
                    id,
                    kerberos,
                    email,
                    first_name,
                    last_name
                FROM users
                ORDER BY id
            </cfquery>

            <cfset var users = []>
            <cfloop query="qUsers">
                <cfset arrayAppend(users, {
                    "id": qUsers.id,
                    "kerberos": qUsers.kerberos,
                    "first_name": qUsers.first_name,
                    "last_name": qUsers.last_name
                })>
            </cfloop>

            <cfreturn serializeJSON(users)>

            <cfcatch>
                <cfreturn { "error": cfcatch.message, "detail": cfcatch.detail }>
            </cfcatch>
        </cftry>
    </cffunction>

    <!--- CREATE --->
    <cffunction
        name="createUser"
        access="remote"
        returnType="any"
        httpMethod="POST"
        restPath="create"
        consumes="application/json">
        <cftry>
            <cfset var body = deserializeJSON(toString(getHttpRequestData().content))>

            <cfquery name="qUser" datasource="sqlite">
                INSERT INTO users (
                    kerberos,
                    email,
                    first_name,
                    last_name
                )
                VALUES (
                    <cfqueryparam value="#body.kerberos#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#body.email#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#body.first_name#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#body.last_name#" cfsqltype="cf_sql_varchar">
                )
            </cfquery>

            <cfquery name="qNewUser" datasource="sqlite">
                SELECT id, kerberos, email, first_name, last_name
                FROM users
                WHERE id = last_insert_rowid()
            </cfquery>

            <!--- SUCCESS --->
            <cfset restSetResponse({
                status=201
            })>
            <cfreturn {
                "id": qNewUser.id,
                "kerberos": qNewUser.kerberos,
                "email": qNewUser.email,
                "first_name": qNewUser.first_name,
                "last_name": qNewUser.last_name
            }>

            <cfcatch>
                <!--- ERROR --->
                <cfset restSetResponse({
                    status = 500
                })>
                <cfreturn { error = true, message = cfcatch.message, detail=cfcatch.detail }>
            </cfcatch>
        </cftry>
        
    </cffunction>

</cfcomponent>