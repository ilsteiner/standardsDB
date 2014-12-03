<cfparam name="elements" default="Au,Fe" type="string" <!--- pattern="(^(([A-Z][a-z][,])*)([A-Z][a-z])$)|(^([A-Z][a-z])$)" --->>
<cfparam name="minThick" default="0" type="integer">
<cfparam name="maxThick" default="1000" type="integer">
<cfparam name="types" default="F" type="string" pattern="^([FP],)[FP]$|^[FP]$">
<cfparam name="partialPart" default="P111" type="string" pattern="^[P]\d{0,10}$">

<!--- If we are including infinites, add them to the type list --->
<cfif #minThick# gt 1000>
	<cfset types &= ",I">
	<cfset minThick = 1000>
</cfif>

<cfif #maxThick# gt 1000>
	<cfset types &= ",I">
	<cfset maxThick = 1000>
</cfif>

<cfif #partialPart# neq "">
	<cfquery
		name="getAllParts"
		datasource="#Request.DSN#"
		username="#Request.username#"
		password="#Request.password#"
		result="theParts">
	SELECT distinct
		   main.partNumber,
		   main.symbol,
	       p.stock,
	       p.targetValue,
	       p.price,
	       st.typeDesc,
	       p.platedElement,
	       p.custom
	FROM tbPartComponent main inner join tbPart p on p.partNumber = main.partNumber inner join tbStandardType st on p.typeID = st.typeID
	WHERE main.partNumber <cfif len(#partialPart#) eq 11> = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="11" value="#partialPart#"><cfelse> LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="11" value="#partialPart#%"></cfif>
	</cfquery>

	<cfquery
		name="getParts"
		dbtype="query">
			SELECT distinct
			   partNumber,
		       stock,
		       targetValue,
		       price,
		       typeDesc,
		       platedElement,
		       custom
		FROM getAllParts
	</cfquery>
<cfelse>
	<cfquery
		name="getParts"
		datasource="#Request.DSN#"
		username="#Request.username#"
		password="#Request.password#"
		result="theParts">

		SELECT DISTINCT main.partNumber,
		                p.stock,
		                p.targetValue,
		                p.price,
		                st.typeDesc,
		                p.platedElement,
		                p.custom
		FROM tbPartComponent main
		INNER JOIN tbPart p ON main.partNumber = p.partNumber
		INNER JOIN tbStandardType st ON p.typeID = st.typeID
		WHERE
		<!---Check the minimum and maximum thickness--->
		  p.targetValue >= <cfqueryparam cfsqltype="CF_SQL_NUMERIC" maxlength="4" value="#minThick#">
		  AND p.targetValue <= <cfqueryparam cfsqltype="CF_SQL_NUMERIC" maxlength="4" value="#maxThick#">
		<!---Check the standard type--->
		  AND p.typeID IN (<cfqueryparam cfsqltype="CF_SQL_VARCHAR" list="yes" maxlength="8" value="#types#">)
		  <!---Make sure the parts returned ONLY have the exact elements selected--->
		  AND main.partNumber IN
		    (SELECT partNumber
		     FROM
		       (SELECT DISTINCT subsub.partNumber,
		                        subsub.symbol
		        FROM tbPartComponent subsub) sub
		     GROUP BY partNumber HAVING listagg(symbol, ',') within
		     GROUP (ORDER BY symbol) = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="32" value="#elements#">)
		    ORDER BY p.targetValue	  
	</cfquery>
</cfif>

<table id="resultTable">
	<caption><cfoutput>#getParts.RecordCount#</cfoutput> Products Found</caption>
	<thead class="ui-widget-header">
		<tr>
			<td>Part Number</td>
			<td>Type</td>
			<td>Thickness</td>
			<td>Price</td>
			<td>In Stock</td>
		</tr>
	</thead>

	<tbody class="ui-widget-content">
		<cfoutput query="getParts">
			<tr>
				<td>#partNumber#</td>
				<td>#typeDesc#</td>
				<td>#targetValue#μin</td>
				<td>$#price#</td>
				<td>#stock#</td>
			</tr>
		</cfoutput>
	</tbody>
</table>

<cfif IsDefined("getAllParts.symbol")>
	<table class="hidden">
		<tbody>
			<cfoutput query="getAllParts">
				<tr>
					<td class="chosenElem">#symbol#</td>
				</tr>
			</cfoutput>
		</tbody>
	</table>
</cfif>