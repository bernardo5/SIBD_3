drop trigger if exists check_overlap_time_period_Device_PAN_update;


delimiter $$

create trigger check_overlap_time_period_Device_PAN_update before update on Connects

for each row
begin
if(exists(SELECT start FROM Connects WHERE(
		(((new.end<=Connects.end)AND(new.end>=Connects.start))
		OR((new.start>=Connects.start)AND((new.start<=Connects.end))))
		AND(new.snum=Connects.snum)AND(new.manuf=Connects.manuf) /*AND 
		(old.start!=Connects.start AND old.end!=Connects.end AND old.snum!=Connects.snum AND old.manuf!=Connects.manuf)*/
		
		))) 

then
			
	call overlaping_time_periods_for_Device_PAN();

end if;

end$$

delimiter ;

