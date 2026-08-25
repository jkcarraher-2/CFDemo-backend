<cfparam name="attributes.course">

<cfoutput>
    <article class="rounded-lg border border-gray-200 bg-white p-5">
        <h3 class="text-lg font-semibold text-gray-900">
            #encodeForHtml(attributes.course.title)#
        </h3>

        <p class="mt-2 text-sm text-gray-600">
            #encodeForHtml(attributes.course.description)#
        </p>

        <a
            href="/courses/#attributes.course.id#"
            class="mt-4 inline-block text-sm font-medium text-blue-600 hover:text-blue-800"
        >
            View Course
        </a>
    </article>
</cfoutput>