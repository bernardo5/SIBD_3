select distinct manufacturer
from Device, Connects, Wears, Lives
where description = 'scale'
and (manufacturer = Connects.manuf AND serialnum= Connects.snum)
and (((Wears.end>=Connects.start AND Wears.end<=Connects.end))OR((Wears.start>=Connects.start AND Wears.start<=Connects.end)))
and Connects.pan = Wears.pan
and ((year(Wears.start) >= year(Current_Date) - 1 or year(Wears.end) >= year(Current_Date) - 1))
and Wears.patient=Lives.patient and
(((Wears.end>=Lives.start AND Wears.end<=Lives.end))OR((Wears.start>=Lives.start AND Wears.start<=Lives.end)));
