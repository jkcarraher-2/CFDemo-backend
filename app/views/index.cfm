<cfimport prefix="courseSearch" taglib="/components/features/courseSearch">

<div class="mx-auto max-w-7xl px-6 py-10">

    <div class="flex items-center justify-between">
        <cfoutput>#isUserLoggedIn()# #getAuthUser()#</cfoutput>
    </div>

    <courseSearch:searcher>

</div>