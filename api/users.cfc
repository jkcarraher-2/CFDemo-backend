<cfcomponent rest="true" restPath="users">
    <cffunction
        name="test"
        access="remote"
        returnType="string"
        httpMethod="GET"
        restPath="">

        <cfreturn "SUCCESS">

    </cffunction>

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

            <cfreturn {
                "id": qNewUser.id,
                "kerberos": qNewUser.kerberos,
                "email": qNewUser.email,
                "first_name": qNewUser.first_name,
                "last_name": qNewUser.last_name
            }>
            <cfcatch>
                <cfreturn { error = true, message = cfcatch.message, detail=cfcatch.detail }>
            </cfcatch>
        </cftry>
        
    </cffunction>

</cfcomponent>

