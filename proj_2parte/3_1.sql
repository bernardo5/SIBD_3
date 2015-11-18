SELECT DISTINCT W.patient , R.datetime, R.value FROM Wears as W, Connects as C, Reading as R, Device as D
	WHERE(
		(R.datetime >= DATE_SUB(CURDATE(), INTERVAL  6 MONTH)) AND
		(R.snum=D.serialnum AND R.manuf=D.manufacturer AND D.description = 'blood pressure') AND
		(R.snum=C.snum AND R.manuf= C.manuf) AND (R.datetime>=C.start AND R.datetime<=C.end) AND
		(C.pan= W.pan) AND (W.patient = '001-54245-1555555')	
	);
