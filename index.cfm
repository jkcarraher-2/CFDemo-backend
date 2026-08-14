<cfquery name="getUsers" datasource="sqlite">
    SELECT * 
    FROM users
</cfquery>
<cfquery name="getClasses" datasource="sqlite">
    SELECT * 
    FROM classes
</cfquery>

<cfoutput>
    Hello from ColdFusion! Current time: #now()#<br>
    Number of users: #getUsers.recordCount#<br>
    Number of classes: #getClasses.recordCount#
</cfoutput>