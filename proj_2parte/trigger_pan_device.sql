
drop trigger if exists check_overlap_time_period_Device_PAN;


delimiter $$

create trigger check_overlap_time_period_Device_PAN before insert on Connects

for each row
begin
if(exists(SELECT start FROM Connects WHERE(
		(((new.start<=Connects.start)AND(new.end<=Connects.end)AND(new.end>=Connects.start))
		OR((new.start>=Connects.start)AND((Connects.end IS NULL)OR(new.end<=Connects.end)))
		OR((new.start>=Connects.start)AND(new.start<=Connects.end)AND(new.end>=Connects.end)))
		AND(new.snum=Connects.snum)AND(new.manuf=Connects.manuf)))) then
			
	call overlaping_time_periods_for_Device_PAN();

end if;

end$$

delimiter ;
