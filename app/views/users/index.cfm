<h1 class="mb-6 text-2xl font-bold text-gray-900">Users</h1>

<cfif request.users.recordCount EQ 0>

    <p class="text-gray-600">No users found.</p>

<cfelse>

    <div class="overflow-x-auto rounded-lg border border-gray-200">
        <table class="w-full text-left text-sm text-gray-600">
            <thead class="bg-gray-50 text-xs uppercase text-gray-700">
                <tr>
                    <th scope="col" class="px-6 py-3">ID</th>
                    <th scope="col" class="px-6 py-3">Name</th>
                    <th scope="col" class="px-6 py-3">Email</th>
                    <th scope="col" class="px-6 py-3"></th>
                </tr>
            </thead>

            <tbody class="divide-y divide-gray-200">
                <cfoutput query="request.users">
                    <tr class="bg-white hover:bg-gray-50">
                        <td class="px-6 py-4">
                            #id#
                        </td>

                        <td class="px-6 py-4 font-medium text-gray-900">
                            #first_name# #last_name#
                        </td>

                        <td class="px-6 py-4">
                            #email#
                        </td>

                        <td class="px-6 py-4 text-right">
                            <a
                                href="/users/#id#"
                                class="font-medium text-blue-600 hover:text-blue-800 hover:underline"
                            >
                                View
                            </a>
                        </td>
                    </tr>
                </cfoutput>
            </tbody>
        </table>
    </div>
</cfif>