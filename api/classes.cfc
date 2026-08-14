<cfcomponent rest="true" restPath="classes">
    <cffunction
        name="test"
        access="remote"
        returnType="string"
        httpMethod="GET"
        restPath="test">

        <cfreturn "Connected to classes endpoint">

    </cffunction>

    <cffunction
        name="createClass"
        access="remote"
        returnType="any"
        httpMethod="POST"
        restPath="create"
        consumes="application/json">
        <cftry>
            <cfset var body = deserializeJSON(toString(getHttpRequestData().content))>

            <cfquery name="qClass" datasource="sqlite">
                INSERT INTO classes (
                    name,
                    description
                    )
                VALUES (
                    <cfqueryparam value="#body.name#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#body.description#" cfsqltype="cf_sql_varchar">
                )
            </cfquery>

            <cfquery name="qNewClass" datasource="sqlite">
                SELECT id, name, description
                FROM classes
                WHERE id = last_insert_rowid()
            </cfquery>

            <!--- SUCCESS --->
            <cfset restSetResponse({
                status=201
            })>
            <cfreturn {
                "id": qNewClass.id,
                "name": qNewClass.name,
                "description": qNewClass.description
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

