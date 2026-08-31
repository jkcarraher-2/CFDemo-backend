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
                <div class="relative group h-full">

                    <!--- User button --->
                    <a
                        class="
                            flex
                            items-center
                            h-full
                            px-3
                            py-3
                            text-sm
                            font-medium
                            text-white
                            hover:bg-btn-blue-light
                        "
                    >
                        <cfoutput>#request.userId#</cfoutput>
                    </a>


                    <!--- Dropdown --->
                    <div class="absolute top-full right-0 
                                w-full rounded-md
                                border border-gray-200 bg-white
                                opacity-0 invisible
                                group-hover:opacity-100 group-hover:visible transition duration-150"
                    >

                        <!--- Callout arrow --->
                        <div
                            class="
                                absolute
                                -top-1
                                right-5
                                h-2
                                w-2
                                rotate-45
                                border-l
                                border-t
                                border-gray-200
                                bg-white
                            "
                        ></div>


                        <!--- Menu --->
                        <a
                            href="/auth/logout"
                            class="
                                relative
                                block
                                rounded-lg
                                px-4
                                py-3
                                text-sm
                                text-gray-700
                                hover:bg-gray-50
                                hover:text-indigo-600
                            "
                        >
                            Sign Out
                        </a>

                    </div>

                </div>
            </cfif>
        </div>
    </nav>
</header>