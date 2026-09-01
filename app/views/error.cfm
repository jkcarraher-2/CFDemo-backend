<cfimport prefix="ui" taglib="/components/ui">

<cfset code = request.errorCode>
<cfset description = request.errorDescription>

<div class="min-h-[60vh] flex flex-col items-center justify-center text-center px-6">
    <p class="text-6xl font-bold text-gray-300">
        <cfoutput>#encodeForHtml(code)#</cfoutput>
    </p>

    <h1 class="mt-4 text-3xl font-bold text-gray-900">
        Page Not Found
    </h1>

    <p class="mt-2 text-gray-600">
        <cfoutput>#encodeForHtml(description)#</cfoutput>
    </p>

    <ui:button
        text="Go Home"
        href="/"
        class="mt-6"
    >
</div>
