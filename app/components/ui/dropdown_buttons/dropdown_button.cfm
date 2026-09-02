<cfparam name="attributes.text" type="string" default="">
<cfparam name="attributes.onclick" type="string" default="">
<cfoutput>
    <button
        type="button"
        onclick="enrollInCourse(1)"
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
        #encodeForHtml(attributes.text)#
    </button>
</cfoutput>
