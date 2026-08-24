<cfimport prefix="ui" taglib="/components/ui">

<cfset course = request.course >

<cfif course.recordCount EQ 0>

    <h1>Course Not Found</h1>

<cfelse>
    <cfoutput query="course">
        <div class="mx-auto max-w-4xl px-6 py-10">

            <!--- Header --->
            <div class="border-b border-gray-200 pb-6">
                <p class="text-sm font-medium text-body-blue">
                    #subject_code# #course_number#
                </p>

                <h1 class="mt-2 text-4xl font-bold tracking-tight text-gray-900">
                    #encodeForHtml(title)#
                </h1>

                <p class="mt-4 text-lg leading-8 text-gray-600">
                    #encodeForHtml(description)#
                </p>
            </div>

            <!--- Details --->
            <div class="mt-8 grid gap-6 sm:grid-cols-2">

                <div class="rounded-lg border border-gray-200 bg-white p-6">
                    <p class="text-sm font-medium text-gray-500">
                        Course ID
                    </p>

                    <p class="mt-1 text-lg font-semibold text-gray-900">
                        #id#
                    </p>
                </div>

                <div class="rounded-lg border border-gray-200 bg-white p-6">
                    <p class="text-sm font-medium text-gray-500">
                        Title
                    </p>

                    <p class="mt-1 text-lg font-semibold text-gray-900">
                        #encodeForHtml(title)#
                    </p>
                </div>

            </div>

            <!--- Actions --->
            <div class="mt-8 flex items-center gap-3">
                <ui:button
                    text="Back to Courses"
                    href="/courses"
                >
            </div>

        </div>
    </cfoutput>
</cfif>