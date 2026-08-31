<cfimport prefix="courseSearch" taglib="/components/features/courseSearch">

<div class="mx-auto max-w-7xl px-6 py-10">
    <cfif isUserLoggedIn()>
        <div class="mb-6 text-2xl text-body-blue">
            Hi, <cfoutput>#request.first_name# #request.last_name#</cfoutput>
        </div>
    </cfif>

    <courseSearch:searcher>

</div>