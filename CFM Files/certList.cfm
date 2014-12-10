<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Product Table</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css">
    </head>
    
    <body>
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
            and ROWNUM <= 5000
            ORDER BY c.certDate DESC
        </cfquery>
    
        <table id="certTable">
            <caption>Certifications</caption>
            <thead>
                <tr>
                    <th>Certification Number</th>
                    <th>Certification Date</th>
                    <th>Technician</th>
                </tr>
            </thead>
            <tbody>
                <cfoutput query="getCerts" group="certNumber" maxrows="5000">
                    <tr>
                        <td>#certNumber#</td>
                        <td>#certDate#</td>
                        <td>#name#</td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <<table class="partNums">
                                <thead>
                                    <tr>
                                        <th>Part Number</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <cfoutput>
                                        <tr>
                                            <td>
                                                #getCerts.partNumber#
                                            </td>
                                        </tr>
                                    </cfoutput>
                                </tbody>
                            </table>
                        </td>
                        
                    </tr>
                </cfoutput>
            </tbody>
        </table>

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.10.2.min.js"><\/script>')</script>
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jqueryui-1.11.2.min.js"><\/script>')</script>
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
        <script type="text/javascript" src="js/jExpand.js"></script>

        <script>
            $("#certTable").jExpand();
        </script>      
    </body>

</html>
