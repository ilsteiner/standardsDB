<cfparam name="elements" default="Au" type="string" pattern="((([A-Z][a-z][,])*)([A-Z][a-z])(?!,)$)|(^([A-Z][a-z][^,]))">
<cfparam name="minThick" default="0" type="integer">
<cfparam name="maxThick" default="1000" type="integer">

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
	  AND main.partNumber NOT IN
	    (SELECT sub.partNumber
	     FROM tbPartComponent sub
	     WHERE sub.symbol NOT IN (<cfqueryparam cfsqltype="CF_SQL_VARCHAR" list="yes" maxlength="32" value="#elements#">))
	  AND p.targetValue >= <cfqueryparam cfsqltype="CF_SQL_NUMERIC" maxlength="5" value="#minThick#"> AND p.targetValue <= <cfqueryparam cfsqltype="CF_SQL_NUMERIC" maxlength="5" value="#maxThick#">
</cfquery>

<!--- <cfoutput>
	Elements: #elements#
	Min Thickness: #minThick#
	Max Thickness: #maxThick#
	Records: #theParts.RecordCount#
</cfoutput> --->

<table>
	<caption>Products Found</caption>
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
				<td>#targetValue#</td>
				<td>#price#</td>
				<td>#stock#</td>
			</tr>
		</cfoutput>
	</tbody>
</table>


