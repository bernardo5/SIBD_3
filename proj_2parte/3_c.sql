select distinct manufacturer
from Device, Connects, Wears, Lives
where description = 'scale'
and (manufacturer = Connects.manuf AND serialnum= Connects.snum)
and (((Wears.end>=Connects.start))AND((Wears.start<=Connects.end)))
and Connects.pan = Wears.pan
and ((Wears.start >= DATE_SUB(CURDATE(), INTERVAL  1 YEAR) or Wears.end >= DATE_SUB(CURDATE(), INTERVAL  1 YEAR)))
and Wears.patient=Lives.patient and
(((Wears.end>=Lives.start))AND((Wears.start<=Lives.end)));
