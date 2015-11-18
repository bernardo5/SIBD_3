drop trigger if exists check_overlap_time_period_Device_PAN_update;


delimiter $$

create trigger check_overlap_time_period_Device_PAN_update before update on Connects

for each row
begin
if(exists(SELECT start FROM Connects WHERE(
		(new.start>new.end)OR(exists(SELECT start FROM Connects WHERE(
		
		(((new.start<=Connects.end)AND(new.start>=Connects.start))
		OR((new.end>=Connects.start)AND((Connects.end <=Connects.end)))
		)
		
		AND(new.snum=Connects.snum)AND(new.manuf=Connects.manuf))))
		)))

then
			
	call overlaping_time_periods_for_Device_PAN();

end if;

end$$

delimiter ;

