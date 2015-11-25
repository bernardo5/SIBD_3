drop trigger if exists check_overlap_time_period_Patient_PAN_update;

delimiter $$

create trigger check_overlap_time_period_Patient_PAN_update before update on Wears

for each row
begin
if(
	exists(SELECT start, end FROM Wears
		WHERE(
			(Wears.start <= new.end) and  (Wears.end >= new.start) 	/*Condição de Sobreposição*/ 
			AND ((new.patient != Wears.patient) AND (new.pan = Wears.pan))
			OR ((new.patient = Wears.patient) AND (new.pan != Wears.pan))
		)
	)
)
	then	
	call overlaping_time_periods_for_Patient_PAN();

end if;

end$$

delimiter ;
