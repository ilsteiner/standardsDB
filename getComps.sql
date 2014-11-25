SET pagesize 50000
spool comps.txt
select 
p.partNumber,
p.targetValue,
c.symbol,
c.composition
from tbPart p inner join tbPartComponent c on c.partNumber = p.partNumber
order by p.partnumber,c.symbol,p.targetValue,c.composition;

SPOOL OFF