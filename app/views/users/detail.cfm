<cfimport prefix="ui" taglib="/components/ui">
<cfset user = request.user>

<cfif user.recordCount EQ 0>

    <div class="mx-auto max-w-5xl px-6 py-10">
        <h1 class="text-3xl font-bold text-gray-900">
            User Not Found
        </h1>

        <p class="mt-2 text-gray-600">
            The user you're looking for doesn't exist.
        </p>

        <ui:button
            text="← Back to Users"
            href="/users"
        >
    </div>

<cfelse>

    <cfoutput>
        <div class="mx-auto max-w-5xl px-6 py-10">

            <!--- User Header --->
            <div class="border-b border-gray-200 pb-6">
                <p class="text-sm font-medium text-body-blue">
                    User #user.id#
                </p>

                <h1 class="mt-2 text-4xl font-bold tracking-tight text-gray-900">
                    #encodeForHtml(user.first_name)# #encodeForHtml(user.last_name)#
                </h1>

                <p class="mt-2 text-gray-600">
                    #encodeForHtml(user.email)#
                </p>
            </div>


            <!--- User Information --->
            <section class="mt-8">
                <h2 class="text-xl font-semibold text-gray-900">
                    Search For Courses
                </h2>
            </section>


            <!--- Current Term --->
            <section class="mt-10">
                <div class="flex items-center justify-between">
                    <div>
                        <h2 class="text-xl font-semibold text-gray-900">
                            Current Term
                        </h2>

                        <p class="mt-1 text-sm text-gray-500">
                            Classes this user is enrolled in.
                        </p>
                    </div>
                </div>

                <div class="mt-4 rounded-lg border border-gray-200 bg-white">
                    <div class="px-6 py-10 text-center">
                        <p class="text-sm text-gray-500">
                            No classes found for this term.
                        </p>
                    </div>
                </div>
            </section>


            <!--- Actions --->
            <div class="mt-10 flex items-center gap-3">
                <ui:button
                    text="← Back to Users"
                    href="/users"
                    variant="subtle"
                >
            </div>

        </div>
    </cfoutput>

</cfif>
