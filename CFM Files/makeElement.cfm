<cfparam name="Attributes.number" default="1" type="number">
<cfparam name="Attributes.symbol" default="H" type="string">
<cfparam name="Attributes.name" default="Hydrogen" type="string">
<cfparam name="Attributes.density" default="0" type="number">
 
<div class="element">
    <span class="atomicNumber"><cfoutput>#number#</cfoutput></span>
    <span class="symbol"><cfoutput>#symbol#</cfoutput></span>
    <span class="density"><cfoutput>#name#</cfoutput></span>
    <span class="density"><cfoutput>#density#</cfoutput></span>
</div>
