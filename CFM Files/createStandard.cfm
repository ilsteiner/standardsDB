<cfparam name="partNumber" default="P1111111111" type="string" pattern="^[P]\d{10}$">
<cfparam name="actualValue" default="" type="numeric" min="0" max="1002">

<!--- Make sure that the thickness is valid --->
<cfquery
    name="checkThickness"
    datasource="#Request.DSN#"
    username="#Request.username#"
    password="#Request.password#"
    result="thickInfo">

    SELECT
        targetValue,
        -- Calculate the minimum and maximum acceptable thicknesses for this product
       (targetValue - (targetValue * .15)) minThick,
       (targetValue + (targetValue * .15)) maxThick
    FROM tbPart
    WHERE partNumber = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="11" value="#partNumber#">
</cfquery>

<!--- If the thickness supplied is in the valid range --->
<cfif #actualValue# gte #checkThickness.minThick# and #actualValue# lte #checkThickness.maxThick#>
    <cfquery
    name="createStandard"
    datasource="#Request.DSN#"
    username="#Request.username#"
    password="#Request.password#"
    result="standardInfo">

        INSERT INTO tbStandard
        (partNumber,actualValue)
        VALUES
        (<cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="11" value="#FORM.partNumber#">
            ,<cfqueryparam cfsqltype="cf_sql_float" value="#FORM.actualValue#">)
    </cfquery>

    <!--- Get the ROWID for the standard we just created --->
    <cfset newStanRow = #standardInfo.ROWID#>

    <!--- Get the serial number of the standard we just created --->
    <cfquery
        name="newStandard"
        datasource="#Request.DSN#"
        username="#Request.username#"
        password="#Request.password#">
        SELECT
            tbStandard.serialNumber,
            tbStandard.actualValue,
            ROWIDTOCHAR(rowid) id
        FROM tbStandard
        WHERE ROWIDTOCHAR(rowid) = '#standardInfo.ROWID#'
    </cfquery>
    
    <!--- Format the results as JSON and return them --->
    <cfoutput>
        <tr class="standardRow">
            <td class="serialNumber">
                #newStandard.serialNumber#
            </td>
            <td class="actualValue">
                #newStandard.actualValue#
            </td>
        </tr>
    </cfoutput>
<!--- Otherwise, throw an error back to the JS function (as JSON) --->
<cfelse>
    <cfoutput>
        Error: Invalid thickness specified!
    </cfoutput>
</cfif>