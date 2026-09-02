<cfparam name="attributes.text" type="string" default="">
<cfparam name="attributes.href" type="string" default="">

<a
    href="<cfoutput>#encodeForHtmlAttribute(attributes.href)#</cfoutput>"
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
    <cfoutput>#encodeForHtml(attributes.text)#</cfoutput>
</a>
