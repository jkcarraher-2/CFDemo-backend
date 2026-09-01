<cfimport prefix="ui" taglib="/components/ui">
<cfparam name="attributes.course">

<cfoutput>
    <article class="overflow-hidden rounded-md border border-gray-400 bg-white shadow-sm">

        <!-- Course header -->
        <div class="bg-gray-100 border-b border-gray-300 bg-gray-50 px-6 py-2">
            <div class="flex flex-col gap-3 lg:flex-row lg:items-center lg:justify-between">
                <div class="min-w-0">
                    <div class="flex flex-wrap items-baseline gap-x-6 gap-y-1 text-gray-900">
                        <span class="text-sm">
                            <span class="font-bold">CRN:</span>
                            #encodeForHtml(attributes.course.crn)#
                        </span>

                        <span class="text-sm">
                            <span class="font-bold">Subject Course:</span>
                            #encodeForHtml(attributes.course.subject_code)# #encodeForHTML(attributes.course.course_number)#
                        </span>

                        <span class="text-sm">
                            <span class="font-bold">Title:</span>
                            #encodeForHtml(attributes.course.title)#
                        </span>
                        <span class="text-sm">
                            <span class="font-bold">Units:</span>
                            #encodeForHtml(attributes.course.units)#
                        </span>
                    </div>
                </div>

                <ui:dropdown_button
                    text="Actions"
                    options="#[
                        {
                            text: 'View Course',
                            href: '/courses/#encodeForHtmlAttribute(attributes.course.id)#'
                        },
                        {
                            text: 'Enroll',
                            href: '/courses/enroll/#encodeForHtmlAttribute(attributes.course.id)#'
                        }
                    ]#"
                    class="inline-flex shrink-0 justify-center items-center"
                >
            </div>
        </div>

        <!-- Extra details -->
        <div class="border-b border-gray-200 bg-white px-6 py-4">
            <!-- Description -->
            <div>
                <h4 class="text-sm font-bold text-gray-900">
                    Description:
                </h4>

                <p class="mt-1 text-sm leading-6 text-gray-800">
                    #encodeForHtml(attributes.course.description)#
                </p>
            </div>
        </div>
    </article>
</cfoutput>
