SELECT W.patient, R.datetime, R.value FROM Wears as W, Connects as C, Readings as R, Device as D
	WHERE(
		(W.patient='001-54245-1555555') AND (W.end >= DATE_SUB(CURDATE(), INTERVAL  6 MONTH))
		AND (W.pan=C.pan) AND (C.start<=W.end) AND (R.datetime >= DATE_SUB(CURDATE(), INTERVAL  6 MONTH))
		AND (R.datetime>=C.start AND R.datetime<=C.end AND R.datetime<=W.end)
		AND (C.snum=D.serialnum AND C.manuf=D.manufacturer AND D.description='blood pressure' AND R.snum=C.snum AND R.manuf=C.manuf)

	);
