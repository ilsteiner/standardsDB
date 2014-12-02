<cfparam name="elements" default="Au" type="string" pattern="(^(([A-Z][a-z][,])*)([A-Z][a-z])$)|(^([A-Z][a-z])$)">
<cfparam name="minThick" default="0" type="integer">
<cfparam name="maxThick" default="1000" type="integer">
<cfparam name="types" default="F" type="string" pattern="^([FP],)[FP]$|^[FP]$">
<cfparam name="partialPart" default="" type="string" pattern="^[P]\d{0,10}$">

<!---If we are including infinites, add them to the type list
<cfif #minThick# gt 1000 or #maxThick# gt 1000>
	#types# := #types# | ",I"
</cfif>
--->
<cfif #partialPart# neq "">
	<cfquery
		name="getParts"
		datasource="#Request.DSN#"
		username="#Request.username#"
		password="#Request.password#"
		result="theParts">
	SELECT distinct
		   main.partNumber,
	       p.stock,
	       p.targetValue,
	       p.price,
	       st.typeDesc,
	       p.platedElement,
	       p.custom
	FROM tbPartComponent main inner join tbPart p on p.partNumber = main.partNumber inner join tbStandardType st on p.typeID = st.typeID
	WHERE main.partNumber <cfif len(#partialPart#) eq 11> = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="11" value="#partialPart#"><cfelse> LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="11" value="#partialPart#%"></cfif> 
	</cfquery>
<cfelse>
	<cfquery
		name="getParts"
		datasource="#Request.DSN#"
		username="#Request.username#"
		password="#Request.password#"
		result="theParts">
		SELECT distinct
			   main.partNumber,
		       p.stock,
		       p.targetValue,
		       p.price,
		       st.typeDesc,
		       p.platedElement,
		       p.custom
		FROM tbPartComponent main inner join tbPart p on p.partNumber = main.partNumber inner join tbStandardType st on p.typeID = st.typeID
		WHERE main.symbol IN (<cfqueryparam cfsqltype="CF_SQL_VARCHAR" list="yes" maxlength="32" value="#elements#">)
		  AND NOT EXISTS
		  	(SELECT sub.partNumber
		     FROM tbPartComponent sub
		     WHERE sub.symbol NOT IN (<cfqueryparam cfsqltype="CF_SQL_VARCHAR" list="yes" maxlength="32" value="#elements#">)
		     AND sub.partNumber = main.partNumber)
		  AND p.targetValue >= <cfqueryparam cfsqltype="CF_SQL_NUMERIC" maxlength="5" value="#minThick#"> AND p.targetValue <= <cfqueryparam cfsqltype="CF_SQL_NUMERIC" maxlength="5" value="#maxThick#">
		  AND p.typeID IN (<cfqueryparam cfsqltype="CF_SQL_VARCHAR" list="yes" maxlength="8" value="#types#">)
	</cfquery>
</cfif>

<table>
	<caption><cfoutput>#getParts.RecordCount#</cfoutput> Products Found</caption>
	<thead>
		<tr>
			<td>Part Number</td>
			<td>Type</td>
			<td>Thickness</td>
			<td>Price</td>
			<td>In Stock</td>
		</tr>
	</thead>

	<tbody>
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


