<cfcomponent
    rest="true"
    restpath="users"
    produces="application/json">

    <cffunction
        name="createUser"
        access="remote"
        returntype="struct"
        httpmethod="POST"
        restpath=""
        consumes="application/json">

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
    </cffunction>

</cfcomponent>

