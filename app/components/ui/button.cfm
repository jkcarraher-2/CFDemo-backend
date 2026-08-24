<!--- REUSABLE BUTTON COMPONENT --->
<cfparam name="attributes.text" default="Button">
<cfparam name="attributes.type" default="button">
<cfparam name="attributes.href" default="">
<cfparam name="attributes.onClick" default="">
<cfparam name="attributes.class" default="">
<cfparam name="attributes.variant" default="primary">

<!--- BASE BUTTON STYLE --->
<cfset buttonClass = "inline-block rounded-md px-5 py-2.5 text-sm font-semibold ">

<!--- APPLY STYLE BASED ON VARIANT --->
<cfswitch expression="#attributes.variant#">
    <cfcase value="primary">
        <cfset buttonClass &= "text-white ">
        <cfset buttonClass &= "bg-linear-to-t from-btn-blue-t to-btn-blue-b ">
        <cfset buttonClass &= "hover:from-btn-blue-light hover:to-btn-blue-light ">
        <cfset buttonClass &= "border border-btn-blue-light ">
        <cfset buttonClass &= "shadow-[inset_0_1px_0_rgba(255,255,255,0.25)] ">
    </cfcase>

    <cfcase value="subtle">
        <cfset buttonClass &= "text-gray-700 ">
        <cfset buttonClass &= "hover:bg-gray-50 ">
        <cfset buttonClass &= "border border-gray-300 ">
    </cfcase>

    <cfcase value="ghost">
        <cfset buttonClass &= "text-gray-700 ">
        <cfset buttonClass &= "hover:bg-gray-100 ">
    </cfcase>

</cfswitch>

<!--- APPLYING VARIANT SPECFIC CLASS --->
<cfset buttonClass &= attributes.class>

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
