SET pagesize 50000
spool comps.txt
select 
s.serialNumber,
p.partNumber,
p.symbol,
p.composition
from tbStandard s inner join tbPartComponent p on s.partNumber = p.partNumber;

SPOOL OFF