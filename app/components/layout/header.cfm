
<header>
    <div class="w-full flex items-stretch justify-between px-6
        <!--- STYLE: Gradient Background --->
        bg-linear-to-t from-btn-blue-t to-btn-blue-b "
    >
        <a href="/" class="py-3 text-lg font-bold text-white">
            <span class="text-yellow-500">schedule</span>Builder
        </a>

        <!--- Navigation --->
        <nav class="flex items-stretch">
            <a
                href="/courses"
                class="flex items-center px-3 text-sm font-medium text-white hover:bg-btn-blue-light"
            >
                Courses
            </a>
            <cfif NOT isUserLoggedIn()>
                <a
                    href="/login"
                    class="flex items-center px-3 py-3 text-sm font-medium text-white hover:bg-btn-blue-light"
                >
                    Login
                </a>
            <cfelse>
                <a 
                    href="/logout"
                    class="flex items-center px-3 py-3 text-sm font-medium text-white hover:bg-btn-blue-light" 
                >
                    <cfoutput>#request.kerberos#</cfoutput>
                </a>
            </cfif>
        </nav>
    </div>
</header>