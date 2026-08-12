<cfoutput>
    Hello from ColdFusion! Current time: #now()#
</cfoutput>

<cfquery name="getUsers" datasource="sqlite">
    SELECT * 
    FROM users
</cfquery>