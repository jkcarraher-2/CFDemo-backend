<h1>Users</h1>

<cfif request.users.recordCount EQ 0>

    <p>No users found.</p>

<cfelse>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th></th>
            </tr>
        </thead>

        <tbody>
            <cfoutput query="request.users">
                <tr>
                    <td>#id#</td>
                    <td>#first_name# #last_name#</td>
                    <td>#email#</td>
                    <td>
                        <a href="/users/#id#">View</a>
                    </td>
                </tr>
            </cfoutput>
        </tbody>
    </table>

</cfif>