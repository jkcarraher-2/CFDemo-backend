<cfimport prefix="symbols" taglib="/components/ui/symbols">
<cfparam name="attributes.text" type="string" default="">
<cfparam name="attributes.options" type="array" default="#[]#">

<div class="relative group h-full w-max">

    <!--- Button --->
    <a
        class="
            inline-flex items-center gap-2
            rounded-md
            px-5 py-2.5
            text-sm font-semibold
            text-white
            bg-linear-to-t from-btn-blue-t to-btn-blue-b
            hover:from-btn-blue-light hover:to-btn-blue-light
            border border-btn-blue-light
            shadow-[inset_0_1px_0_rgba(255,255,255,0.25)]
            transition-colors duration-150
            cursor-pointer
        "
    >
        <cfoutput>#encodeForHtml(attributes.text)#</cfoutput>

        <symbols:down_arrow>
    </a>

    <!--- Dropdown --->
    <div
        class="
            absolute top-full right-0
            w-max min-w-full
            rounded-md py-2
            border border-gray-300
            bg-white
            shadow-lg
            opacity-0 invisible
            group-hover:opacity-100 group-hover:visible
            transition duration-150
            z-50
        "
    >
        <!--- Callout arrow --->
        <div
            class="
                absolute -top-1 right-5
                h-2 w-2
                rotate-45
                border-l border-t border-gray-300
                bg-white
            "
        ></div>

        <!--- Menu --->
        <cfloop array="#attributes.options#" index="option">
            <cfif structKeyExists(option, "href")>
                <a
                    href="<cfoutput>#encodeForHtmlAttribute(option.href)#</cfoutput>"
                    class="
                        relative block z-10 px-4 py-2
                        text-body-blue text-sm whitespace-nowrap
                        bg-white
                        hover:bg-body-blue hover:text-white
                        transition-colors duration-100
                    "
                >
                    <cfoutput>#encodeForHtml(option.text)#</cfoutput>
                </a>
            <cfelseif structKeyExists(option, "action") >
                <button
                    type="button"
                    data-action-url="<cfoutput>#encodeForHtmlAttribute(option.action)#</cfoutput>"
                    class="
                        relative block z-10 w-full px-4 py-2
                        text-left
                        text-body-blue text-sm whitespace-nowrap
                        bg-white
                        hover:bg-body-blue hover:text-white
                        transition-colors duration-100
                        cursor-pointer
                    "
                >
                    <cfoutput>#encodeForHtml(option.text)#</cfoutput>
                </button>
            </cfif>
        </cfloop>
    </div>
</div>