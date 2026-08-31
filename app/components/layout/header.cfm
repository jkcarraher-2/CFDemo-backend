<cfimport prefix="ui" taglib="/components/ui">
<header class="relative">
    <nav class="w-full flex items-stretch justify-between px-6
        <!--- STYLE: Gradient Background --->
        bg-linear-to-t from-btn-blue-t to-btn-blue-b "
    >
        <a href="/" class="py-3 text-lg font-bold text-white">
            <span class="text-yellow-500">schedule</span>Builder
        </a>

        <!--- Navigation --->
        <div class="flex items-center">
            <a
                href="/courses"
                class="flex items-center px-3 h-full text-sm font-medium text-white hover:bg-btn-blue-light"
            >
                Courses
            </a>
            <cfif NOT isUserLoggedIn()>
                <a
                    href="/auth/login"
                    class="flex items-center px-3 py-3 h-full text-sm font-medium text-white hover:bg-btn-blue-light"
                >
                    Login
                </a>
            <cfelse>
                <ui:nav_dropdown
                    text="#request.first_name#"
                    options="#[
                        {
                            text: 'Sign Out',
                            href: '/auth/logout'
                        }
                    ]#"
                >
            </cfif>
        </div>
    </nav>
</header>