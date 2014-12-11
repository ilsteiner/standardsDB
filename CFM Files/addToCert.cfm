<cfparam name="partNumber" default="" type="string" pattern="^[P]\d{10}$">
<cfparam name="certNumber" default="" type="string" pattern="^[C]\d{10}$">
<cfparam name="quantity" default="1" type="integer">

        <!--- Get the list of certifications and associated products --->
        <cfquery
            name="getCerts"
            datasource="#Request.DSN#"
            username="#Request.username#"
            password="#Request.password#"
            result="theStandard">
            SELECT DISTINCT
                s.partNumber,
                s.certNumber,
                c.certDate,
                t.name,
                s.actualValue,
                pc.symbol,
                pc.composition,
                p.stock,
                p.targetValue,
                p.price,
                st.typeDesc,
                p.platedElement,
                p.custom
            FROM tbStandard s 
            left join tbCertification c on s.certNumber = c.certNumber
            inner join tbPartComponent pc on s.partNumber = pc.partNumber
            inner join tbPart p on pc.partNumber = p.partNumber
            inner join tbStandardType st on p.typeID = st.typeID
            inner join tbTechnician t on c.technicianID = t.technicianID
            WHERE c.statusID IN ('P','R')
            and s.partNumber = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="11" value="#FORM.partNumber#">
            and ROWNUM <= 5000
            ORDER BY c.certDate DESC
        </cfquery>

    <cfloop from="1" to=#FORM.quantity# index="i" step="1">
        <cfquery
            name="getCerts"
            datasource="#Request.DSN#"
            username="#Request.username#"
            password="#Request.password#"
            result="theStandard">

            UPDATE tbStandard
            SET certNumber = #FORM.certNumber#
            WHERE partNumber = #FORM.partNumber#
        </cfquery>
    </cfloop>