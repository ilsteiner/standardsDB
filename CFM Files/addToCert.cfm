<cfparam name="certParts" default="P1111111111,P1111111113" type="string" pattern="(^(([P]\d{10}[,])*)([P]\d{10})$)|(^([P]\d{10})$)">
<cfparam name="technician" default="T01" type="string" pattern="^[T]\d{2}$">

    <!--- Create a new certification --->
    <cfquery
        name="createNewCert"
        datasource="#Request.DSN#"
        username="#Request.username#"
        password="#Request.password#"
        result="theCert">

        INSERT INTO tbCertification
        (technicianID,statusID,certDate)
        VALUES (<cfqueryparam cfsqltype="cf_sql_char" maxlength="3" null="false" value="#technician#">,'C',<cfqueryparam cfsqltype="cf_sql_date" null="false" value="#Now()#">)
    </cfquery>

    <!--- Get the ROWID for the certification we just created --->
    <cfset newCertRow = theCert.ROWID>

    <!--- Get the list of part numbers and serial numbers --->
    <cfquery
        name="getStandards"
        datasource="#Request.DSN#"
        username="#Request.username#"
        password="#Request.password#"
        result="foundStandards">
        -- Get a standard that has the correct part number and doesn't already have a cert
        SELECT
            serialNumber,
            partNumber
            FROM tbStandard
            WHERE partNumber in (<cfqueryparam cfsqltype="cf_sql_char" list="yes" maxlength="11" null="no" value="#certParts#">)
            -- and ROWNUM = 1
            and certNumber is null
    </cfquery>
        
    <cfset serialNums = StructNew()>
    
    <!--- Put the list of part numbers and serial numbers into a struct --->
    <cfoutput query="getStandards" group="partNumber">
        <cfoutput>
            <cfscript>
                try {
                    structInsert(serialNums,"#partNumber#","#serialNumber#",false);
                }
                catch (any e) {
                    // Do nothing because we expect errors as we will be trying to insert duplicates
                }
            </cfscript>
        </cfoutput>
    </cfoutput>

<!--- Update all of the standards we found --->
<cfset sumRecords = "0">

<cfloop collection="#serialNums#" item="partNum">
    <cfquery
            name="updateStandard"
            datasource="#Request.DSN#"
            username="#Request.username#"
            password="#Request.password#"
            result="updatedStandard">

            UPDATE tbStandard
            SET certNumber = (SELECT certNumber from tbCertification where ROWID = '#newCertRow#')
            WHERE serialNumber = <cfqueryparam cfsqltype="cf_sql_char" value="#serialNums[partNum]#">
    </cfquery>

    <cfset sumRecords = sumRecords + 1>
</cfloop>

<cfoutput>
    #sumRecords#
</cfoutput>