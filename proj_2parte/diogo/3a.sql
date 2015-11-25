drop procedure if exists blood_pressure_prev6m_readings_patient;

delimiter $$

create procedure blood_pressure_prev6m_readings_patient (in p_number varchar(40))

begin

SELECT DISTINCT W.patient , R.datetime, R.value FROM Wears as W, Connects as C, Reading as R, Device as D
	WHERE(
		(R.datetime >= DATE_SUB(CURDATE(), INTERVAL  6 MONTH))
		AND (R.snum = D.serialnum AND R.manuf = D.manufacturer AND D.description = 'blood pressure')
		AND (R.snum = C.snum AND R.manuf = C.manuf)
		AND (date(R.datetime) >= C.start AND date(R.datetime) <= C.end)
		AND (date(R.datetime) >= W.start AND date(R.datetime) <= W.end)
		AND (C.pan = W.pan) AND (W.patient = p_number));
end$$

delimiter ;
		
