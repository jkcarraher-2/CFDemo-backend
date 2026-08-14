<cfquery name="getUsers" datasource="sqlite">
    SELECT * 
    FROM users
</cfquery>

<cfoutput>
    Hello from ColdFusion! Current time: #now()#<br>
    Number of users: #getUsers.recordCount#<br>
    <cfloop query="getUsers">
        #first_name# #last_name#: #email#<br>
    </cfloop>
</cfoutput>