<cfimport prefix="ui" taglib="/components/ui">
<cfparam name="attributes.course">

<cfoutput>
    <article class="overflow-hidden rounded-md border border-gray-300 bg-white shadow-sm">

        <!-- Course header -->
        <div class="border-b border-gray-200 bg-gray-50 px-6 py-4">
            <div class="flex flex-col gap-3 lg:flex-row lg:items-center lg:justify-between">

                <div class="min-w-0">
                    <div class="flex flex-wrap items-baseline gap-x-6 gap-y-1">
                        <span class="text-sm font-semibold text-gray-800">
                            <span class="text-gray-500">CRN:</span>
                            #encodeForHtml(attributes.course.crn)#
                        </span>

                        <span class="text-sm font-semibold text-gray-800">
                            <span class="text-gray-500">Subject Course:</span>
                            #encodeForHtml(attributes.course.subject_code)# #encodeForHTML(attributes.course.course_number)#
                        </span>

                        <span class="text-sm font-semibold text-gray-800">
                            <span class="text-gray-500">Title:</span>
                            #encodeForHtml(attributes.course.title)#
                        </span>
                    </div>
                </div>

                <ui:button
                    text="View Course"
                    href="/courses/#encodeForHtmlAttribute(attributes.course.id)#"
                    class="inline-flex shrink-0 justify-center items-center"
                >
            </div>

            <!-- Schedule / metadata row -->
            <div class="mt-4 grid grid-cols-1 border-t border-gray-200 pt-3 text-sm text-gray-700 sm:grid-cols-2 lg:grid-cols-4">

                <div class="py-1">
                    <span class="font-medium text-gray-900">Units:</span>
                    #encodeForHtml(attributes.course.units)#
                </div>

            </div>
        </div>

        <!-- Important details -->
        <div class="border-b border-gray-200 bg-white">

            <div class="flex items-center gap-3 bg-amber-400 px-5 py-2.5 text-sm font-bold text-gray-900">
                <svg
                    class="h-5 w-5 text-blue-700"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    aria-hidden="true"
                >
                    <path stroke-linecap="round" stroke-linejoin="round" d="m6 15 6-6 6 6" />
                </svg>

                <span>Show Important Details</span>
            </div>

            <div class="p-5 sm:p-6">

                <!-- Alert -->
                <div class="rounded-md border border-amber-300 bg-amber-50 px-4 py-4 text-sm text-amber-900">
                    <div class="mb-1 font-semibold">Course Alerts/Notes:</div>

                    <div>
                        #encodeForHtml(
                            "No additional course alerts or notes."
                        )#
                    </div>
                </div>

                <!-- Description -->
                <div class="mt-5">
                    <h4 class="text-sm font-bold text-gray-900">
                        Description:
                    </h4>

                    <p class="mt-1 text-sm leading-6 text-gray-800">
                        #encodeForHtml(attributes.course.description)#
                    </p>
                </div>

            </div>
        </div>

    </article>
</cfoutput>
