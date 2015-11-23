drop trigger if exists check_overlap_time_period_Device_PAN_update;


delimiter $$

create trigger check_overlap_time_period_Device_PAN_update before update on Connects

for each row
begin
if(
	exists(SELECT start, end FROM Connects
		WHERE(
			(Connects.start <= new.end) and  (Connects.end >= new.start) 	/*Condição de Sobreposição*/ 
			and ((new.snum = Connects.snum) and (new.manuf = Connects.manuf))
			and (new.pan != Connects.pan)
		)
	)
)
	then	
	call overlaping_time_periods_for_Device_PAN();

end if;

end$$

delimiter ;
