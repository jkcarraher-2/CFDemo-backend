<cfimport prefix="symbols" taglib="/components/ui/symbols">
<cfparam name="attributes.text" type="string" default="">
<cfparam name="attributes.options" type="array" default="#[]#">

<div class="relative group h-full w-max">
    <!--- Button --->
    <a
        class="flex items-center
                h-full w-max px-3 py-3
                text-sm font-medium
                text-white hover:bg-btn-blue-light"
    >
        <cfoutput>#encodeForHtml(attributes.text)#</cfoutput>
        <symbols:down_arrow color="##daaa00">
    </a>

    <!--- Dropdown --->
    <div
        class="absolute top-full right-0
                w-max rounded-md py-3
                border border-gray-300 bg-white
                opacity-0 invisible
                group-hover:opacity-100 group-hover:visible
                transition duration-150"
    >
        <!--- Callout arrow --->
        <div
            class="absolute -top-1 right-5 h-2 w-2 z-0
                    rotate-45 border-l border-t
                    border-gray-200 bg-white"
        ></div>

        <!--- Menu --->
        <cfloop array="#attributes.options#" index="option">
            <a
                href="<cfoutput>#encodeForHtmlAttribute(option.href)#</cfoutput>"
                class="block z-10 px-4 py-1 text-md whitespace-nowrap
                        text-body-blue bg-white
                        hover:bg-body-blue hover:text-white"
            >
                <cfoutput>#encodeForHtml(option.text)#</cfoutput>
            </a>
        </cfloop>
    </div>
</div>