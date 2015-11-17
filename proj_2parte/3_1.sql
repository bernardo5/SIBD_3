
	SELECT Wears.pan, Wears.start, Wears.end FROM Wears
	WHERE (Wears.end>=DATE_SUB(CURDATE(), INTERVAL  6 MONTH))AND(patient_number=Wears.patient);
