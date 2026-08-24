<cfimport prefix="ui" taglib="/components/ui"/>

<div>
    <h1 class="text-2xl text-body-blue">
        Courses
    </h1>

    <cfif request.courses.recordCount EQ 0>
        <p class="text-gray-600">
            No courses found
        </p>
    <cfelse>
        <div class="mt-6 overflow-x-auto rounded-lg border border-gray-200">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-600">
                            ID
                        </th>
                        <th class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-600">
                            Subject Course
                        </th>
                        <th class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-600">
                            Title
                        </th>
                        <th class="px-6 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-600">
                            Actions
                        </th>
                    </tr>
                </thead>

                <tbody class="divide-y divide-gray-200 bg-white">
                    <cfoutput query="request.courses">
                        <tr class="hover:bg-gray-50">
                            <td class="whitespace-nowrap px-6 py-4 text-sm text-gray-500">
                                #id#
                            </td>

                            <td class="whitespace-nowrap px-6 py-4 text-sm font-medium text-gray-900">
                                #subject_code# #course_number#
                            </td>

                            <td class="whitespace-nowrap px-6 py-4 text-sm font-medium text-gray-900">
                                #title#
                            </td>

                            <td class="px-6 py-4">
                                <div class="flex items-center justify-end">
                                    <ui:button
                                        text="View"
                                        href="/courses/#id#"
                                        class=""
                                    >
                                </div>
                            </td>
                        </tr>
                    </cfoutput>
                </tbody>
            </table>
        </div>
    </cfif>
</div>