<cfimport prefix="courseSearch" taglib="/components/features/courseSearch">

<script>
    async function enrollInCourse(courseId) {
        // Define the div where we'll be displaying errors
        const errorContainer = document.getElementById(`error-view-${courseId}`);
        errorContainer.innerHTML = '';

        try {
            const response = await fetch(`rest/api/enrollments/create?id=${courseId}`, {
                method: "POST",
                headers: { "Content-Type": "application/json" }
            });

            const result = await response.json();

            if (!response.ok) {
                showError(
                    errorContainer,
                    result.message || 'Unable to enroll in course.',
                    result.detail
                );
                return;
            }

            console.log("Enrollment created:", result);

        } catch (error) {
            console.error("Enrollment request failed:", error);
            showError(
                errorContainer, 
                'Unable to complete enrollment. Please try again.'
            );
        }
    }
</script>

<cfscript>
    searchQuery = trim(form.query ?: "");
    courses = queryNew("");

    if (len(searchQuery)) {
        courseService = new models.services.courseService();
        courses = courseService.search(
            searchQuery = searchQuery
        );
    }
</cfscript>

<!--- COURSE SEARCH COMPONENT --->
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
                    <div class="space-y-2">
                        <cfloop query="courses">
                            <div id="error-view-#id#">

                            </div>
                            <courseSearch:courseItem
                                course="#{
                                    id: id,
                                    crn: crn,
                                    subject_code: subject_code,
                                    course_number: course_number,
                                    title: title,
                                    units: units,
                                    description: description
                                }#"
                                onEnroll="enrollInCourse(#id#)"
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