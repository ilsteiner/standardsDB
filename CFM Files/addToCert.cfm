<cfparam name="partNumber" default="" type="string" pattern="(^(([P]\d{10}[,])*)([P]\d{10})$)|(^([P]\d{10})$)">
<cfparam name="technician" default="" type="string" pattern="^[T]\d{2}$">

<cfset technician = "T01">
        
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

    <!--- Create a list in which to store the standards we find for each part--->
    <cfset stanList = ''>

    <!--- Get the first standard with each partnumber that does not already have a certification --->
    <cfloop index = "partNum" list = "#partNumber#">
        <cfquery
            name="getStandard"
            datasource="#Request.DSN#"
            username="#Request.username#"
            password="#Request.password#"
            result="aStandard">
            -- Get a standard that has the correct part number and doesn't already have a cert
            SELECT
                serialNumber
                FROM tbStandard
                WHERE partNumber = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="11" null="false" value="#partNum#">
                and ROWNUM = 1
                and certNumber is null
        </cfquery>
        <cfoutput query="getStandard">
            <!--- Add the serial number to the list of serial numbers --->
            <cfset stanList = ListAppend(stanList,#serialNumber#)>
        </cfoutput>
    </cfloop>       

    <cfquery
            name="addCertToStandard"
            datasource="#Request.DSN#"
            username="#Request.username#"
            password="#Request.password#"
            result="addedCerts">

            -- Set all the standards we found (by serial number) to the certNumber we just added
            UPDATE tbStandard
            SET certNumber = (SELECT certNumber from tbCertification where ROWID = '#newCertRow#')
            WHERE serialNumber in (<cfqueryparam list="true" cfsqltype="cf_sql_varchar" value="#stanList#">)
    </cfquery>

    <cfoutput>
        Updated #addedCerts.RecordCount# records.
    </cfoutput>