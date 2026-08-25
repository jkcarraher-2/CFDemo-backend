<cfimport prefix="courseSearch" taglib="/components/features/courseSearch">

<!--- COURSE SEARCH COMPONENT --->

<cfscript>
    searchQuery = trim(form.query ?: "");
    courses = queryNew("");

    if (len(searchQuery)) {
        courseModel = new models.Course();

        courses = courseModel.search(
            searchQuery = searchQuery
        );
    }
</cfscript>

<cfoutput>
    <div class="w-full rounded-md border border-gray-300 bg-amber-200 items-center gap-2">
        <div class="h-[39px] rounded-t-md border-b border-amber-900 px-2 flex items-center">
            <span class="font-extrabold text-sm text-blue-950">
            SEARCH FOR COURSES
            </span>
        </div>
        <div class="p-3 space-y-2 bg-amber-100">
            <p class="text-sm"> 
                Search for courses by CRN, subject, instructor last name, or keyword: 
            </p>

            <courseSearch:searchBar
                query="#searchQuery#"
            >

            <!--- Results --->
            <cfif len(searchQuery)>
                <cfif courses.recordCount GT 0>
                    <div class="">
                        <cfloop query="courses">
                            <courseSearch:courseItem
                                course="#{
                                    id: id,
                                    title: title,
                                    description: description
                                }#"
                            >
                        </cfloop>
                    </div>
                <cfelse>
                    <div class="bg-white px-2 py-2">
                        <p class="text-gray-600">
                            No courses found.
                        </p>
                    <div>
                </cfif>

            </cfif>
        </div>
    </div>
</cfoutput>