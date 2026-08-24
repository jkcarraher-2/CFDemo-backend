<!--- REUSABLE BUTTON COMPONENT --->
<cfparam name='attributes.text' default="Button">
<cfparam name='attributes.type' default="button">
<cfparam name='attributes.class' default="">
<cfparam name='attributes.href' default="">
<cfparam name='attributes.onClick' default="">

<cfset buttonClass = "inline-block rounded-md px-5 py-2.5 text-sm font-semibold text-white " &
    <!--- unhovered bg style --->
    "bg-linear-to-t from-btn-blue-t to-btn-blue-b " &
    <!--- hovered bg-style --->
    "hover:from-btn-blue-light hover:to-btn-blue-light " &
    <!--- 3D border --->
    "border border-btn-blue-light shadow-[inset_0_1px_0_rgba(255,255,255,0.25)] " &
    <!--- Custom Classes --->
    #attributes.class#
>

<cfoutput>
    <!--- IF HREF -> use <a> tag --->
    <cfif len(attributes.href)>
        <a
            href="#encodeForHtmlAttribute(attributes.href)#"
            class="#encodeForHtmlAttribute(buttonClass)#"
            <cfif len(attributes.onClick)>
                onclick="#encodeForHtmlAttribute(attributes.onClick)#"
            </cfif>
        >
            #encodeForHtml(attributes.text)#
        </a>
    
    <!--- OTHERWISE -> use <button> --->
    <cfelse>
        <button
            type="#encodeForHtmlAttribute(attributes.type)#"
            class="#encodeForHtmlAttribute(buttonClass)#"
            <cfif len(attributes.onClick)>
                onclick="#encodeForHtmlAttribute(attributes.onClick)#"
            </cfif>
        >
            #encodeForHtml(attributes.text)#
        </button>
    </cfif>

</cfoutput>