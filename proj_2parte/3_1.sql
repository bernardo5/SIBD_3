SELECT C.snum, C.manuf, C.pan FROM Connects as C WHERE(
	(C.pan IN (SELECT Wears.pan FROM Wears
					WHERE (Wears.end>=DATE_SUB(CURDATE(), INTERVAL  6 MONTH))
							AND('001-54245-1555555'=Wears.patient))) AND
	(C.end>=DATE_SUB(CURDATE(), INTERVAL  6 MONTH))

);
