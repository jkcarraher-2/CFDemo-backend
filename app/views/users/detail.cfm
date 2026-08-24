<cfset user = request.user>

<cfif user.recordCount EQ 0>

    <h1>User Not Found</h1>

<cfelse>

    <cfoutput>
        <div class="">
            <h1>#user.first_name# #user.last_name#</h1>

            <dl>
                <dt>ID</dt>
                <dd>#user.id#</dd>

                <dt>First Name</dt>
                <dd>#user.first_name#</dd>

                <dt>Last Name</dt>
                <dd>#user.last_name#</dd>

                <dt>Email</dt>
                <dd>#user.email#</dd>
            </dl>

            <p>
                <a href="/users">← Back to Users</a>
            </p>
        </div>
    </cfoutput>

</cfif>