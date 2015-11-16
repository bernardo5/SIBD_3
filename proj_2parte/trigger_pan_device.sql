
delimiter $$

create trigger check_overlap_time_period_Device_PAN before insert on Connects

for each row
begin
if(exists(SELECT start FROM Connects WHERE((new.start<=Connects.end)AND
		((Connects.end IS NULL)OR(Connects.end>=new.start))AND
			(Connects.pan=new.pan)AND(Connects.snum=new.snum AND Connects.manuf=new.manuf)))) then
			
	call overlaping_time_periods_for_Device_PAN();

end if;

end$$

delimiter ;
