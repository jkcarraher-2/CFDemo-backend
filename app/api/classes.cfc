<cfcomponent rest="true" restPath="classes">
    <!--- TEST --->
    <cffunction
        name="test"
        access="remote"
        returnType="string"
        httpMethod="GET"
        restPath="test">

        <cfreturn "Connected to classes endpoint">

    </cffunction>

    <!--- GET ALL --->
    <cffunction
        name="getAllClasses"
        access="remote"
        returntype="string"
        httpMethod="GET"
        restPath=""
        produces="application/json"
    >
        <cftry>
            <cfquery name="qClasses" datasource="sqlite">
                SELECT id, crn, subject_code, course_number, title, description, units, seats
                FROM classes
                ORDER BY id
            </cfquery>

            <cfset classes = []>

            <cfloop query="qClasses">
                <cfset arrayAppend(classes, {
                    "id": qClasses.id,
                    "crn": qClasses.crn,
                    "subject_code": qClasses.subject_code,
                    "course_number": qClasses.course_number,
                    "title": qClasses.title,
                    "description": qClasses.description,
                    "units": qClasses.units,
                    "seats": qClasses.seats
                })>
            </cfloop>

            <cfreturn serializeJSON(classes)>
            <cfcatch>
                 <cfreturn serializeJSON({ "error": cfcatch.message, "detail": cfcatch.detail })>
            </cfcatch>
        </cftry>
    </cffunction>

    <!--- CREATE --->
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
                    crn,
                    subject_code,
                    course_number,
                    title,
                    description,
                    units,
                    seats
                )
                VALUES (
                    <cfqueryparam value="#body.crn#" cfsqltype="cf_sql_integer">,
                    <cfqueryparam value="#body.subject_code#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#body.course_number#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#body.title#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#body.description#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#body.units#" cfsqltype="cf_sql_integer">,
                    <cfqueryparam value="#body.seats#" cfsqltype="cf_sql_integer">
                )
            </cfquery>

            <cfquery name="qNewClass" datasource="sqlite">
                SELECT id, crn, subject_code, course_number, title, description, units, seats
                FROM classes
                WHERE id = last_insert_rowid()
            </cfquery>

            <!--- SUCCESS --->
            <cfset restSetResponse({
                status=201
            })>
            <cfreturn {
                "id": qNewClass.id,
                "crn": qNewClass.crn,
                "subject_code": qNewClass.subject_code,
                "course_number": qNewClass.course_number,
                "title": qNewClass.title,
                "description": qNewClass.description,
                "units": qNewClass.units,
                "seats": qNewClass.seats
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

