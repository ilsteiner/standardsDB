<cfparam name="symbolList" default="" type="string">
<cfparam name="minThick" default="0" type="integer">
<cfparam name="maxThick" default="" type="integer">

<cfquery
	name="getParts"
	datasource="#Request.DSN#"
	username="#Request.username#"
	password="#Request.password#">
	SELECT distinct
		   main.partNumber,
	       p.stock,
	       p.targetValue,
	       p.price,
	       st.typeDesc,
	       p.platedElement,
	       p.custom
	FROM tbPartComponent main inner join tbPart p on p.partNumber = main.partNumber inner join tbStandardType st on p.typeID = st.typeID
	WHERE main.symbol IN (<cfqueryparam cfsqltype="CF_SQL_VARCHAR" list="yes" maxlength="32" value="#symbolList#">)
	  AND main.partNumber NOT IN
	    (SELECT sub.partNumber
	     FROM tbPartComponent sub
	     WHERE sub.symbol NOT IN (<cfqueryparam cfsqltype="CF_SQL_VARCHAR" list="yes" maxlength="32" value="#symbolList#">))
	  AND p.targetValue >= <cfqueryparam cfsqltype="CF_SQL_TINYINT" maxlength="5" value="#minThick#"> AND p.targetValue <= <cfqueryparam cfsqltype="CF_SQL_TINYINT" maxlength="5" value="#maxThick#">;
</cfquery>

