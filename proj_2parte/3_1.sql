
	SELECT Wears.pan, Wears.start, Wears.end FROM Wears
	WHERE (Wears.end>=DATE_SUB(CURDATE(), INTERVAL  6 MONTH))AND('001-54245-1555555'=Wears.patient);
