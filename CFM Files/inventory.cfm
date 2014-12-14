<cftry>
	<cfparam name="elements" default="Au,Fe" type="string" pattern="(^(([A-Z][a-z][,])*)([A-Z][a-z])$)|(^([A-Z][a-z])$)">
	<cfparam name="types" default="F" type="string" pattern="^([FP],)[FP]$|^[FP]$">
	<cfparam name="partialPart" default="P1111" type="string" pattern="^[P]\d{0,10}$">

	<cfcatch>
	<cfoutput>Invalid Parameter!</cfoutput>
	</cfcatch>
</cftry>

<cfparam name="minThick" default="0" type="integer">
<cfparam name="maxThick" default="1000" type="integer">

<!--- If we are including infinites, add them to the type list --->
<cfif #minThick# gt 1000>
	<cfset types &= ",I">
	<cfset minThick = 1000>
</cfif>

<cfif #maxThick# gt 1000>
	<cfset types &= ",I">
	<cfset maxThick = 1000>
</cfif>

<cfquery
	name="getAllParts"
	datasource="#Request.DSN#"
	username="#Request.username#"
	password="#Request.password#"
	result="theParts">
SELECT distinct
	   main.partNumber,
	   main.symbol,
	   main.composition,
       p.stock,
       p.targetValue,
       p.price,
       st.typeDesc,
       p.platedElement,
       p.custom,
       e.density
FROM tbPartComponent main 
inner join tbPart p on p.partNumber = main.partNumber 
inner join tbStandardType st on p.typeID = st.typeID
inner join tbElement e on e.symbol = main.symbol
WHERE main.partNumber <cfif len(#partialPart#) eq 11> = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="11" value="#partialPart#"><cfelse> LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="11" value="#partialPart#%"></cfif>
ORDER BY main.composition DESC, main.symbol
</cfquery>
	
<cfif #partialPart# neq "">
	<cfquery
		name="getParts"
		dbtype="query">
			SELECT distinct
			   partNumber,
			   symbol,
			   composition,
		       stock,
		       targetValue,
		       price,
		       typeDesc,
		       platedElement,
		       custom,
		       density
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
						main.symbol,
						main.composition,
		                p.stock,
		                p.targetValue,
		                p.price,
		                st.typeDesc,
		                p.platedElement,
		                p.custom,
		                e.density
		FROM tbPartComponent main
		INNER JOIN tbPart p ON main.partNumber = p.partNumber
		INNER JOIN tbStandardType st ON p.typeID = st.typeID
		INNER JOIN tbElement e on e.symbol = main.symbol
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
		    ORDER BY p.targetValue,main.composition DESC,main.symbol	  
	</cfquery>
</cfif>

<div id="resultTableWrapper">
	<table id="resultTable" class="tablesorter">
		<caption><cfoutput>#getParts.RecordCount#</cfoutput> Products Found - <span id="numberOfCertParts"></span> Selected for Certification</caption>
		<thead>
			<tr>
				<th><div class="headerWrapper">Part Number</div></th>
				<th><div class="headerWrapper">Type</div></th>
				<th><div class="headerWrapper">Thickness</div></th>
				<th><div class="headerWrapper">Price</div></th>
				<th><div class="headerWrapper">In Stock</div></th>
				<th><div class="headerWrapper">Composition</div></th>
				<th><div class="headerWrapper">Density</div></th>
				<th>
					<div class="headerWrapper">
						<ul class="formButtons">
							<li class="formButton" id="certifyAll" title="Create a new certification from the current list">
								Certify All
							</li>
							<li class="formButton" id="clearCertify" title="Clear the certification list">
								Clear Selections
							</li>
						</ul>
					</div>
				</th>
			</tr>
		</thead>

		<tbody class="ui-widget-content">
			<cfoutput query="getParts" group="partNumber">
				<tr>
					<td class="partNumVal">#partNumber#</td>
					<td>#typeDesc#<cfif #typeDesc# eq 'Plated'> (#platedElement#)</cfif></td>
					<td>#targetValue#μin</td>
					<td>$#price#</td>
					<td>#stock#</td>
					<td class="composition">
						<cfset elemList="">
						<cfset denSum="0">
						<cfoutput>
							<cfset currElem = composition & "%" & " " & symbol>

							<!--- Add to the sum of densities of component elements of this alloy...or just this element if it isn't an alloy --->
							<cfset currDen = (composition/100) / density>
					
							<cfset denSum = denSum + currDen>
							<cfset elemList = listAppend(elemList,currElem)>
						</cfoutput>
						#elemList#
					</td>
					<td>
						<!--- Display the density for this product --->
						<cfset theDen = (1 / denSum)>
						#numberformat(theDen,"0.00")#g/cc
					</td>
					<td>
						<ul class="formButtons">
							<li class="formButton certify" title="Add to certification list">
								Certify from Stock
							</li>
							<li class="formButton newStand" title="Create a new standard">
								Create New
							</li>
						</ul>
					</td>
				</tr>
			</cfoutput>
		</tbody>
	</table>
</div>

<cfif #partialPart# neq "">
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