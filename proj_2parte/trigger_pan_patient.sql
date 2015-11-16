delimiter $$

create trigger check_overlap_time_period_Patient_PAN before insert on Wears

for each row
begin

if(exists(SELECT start FROM Connects WHERE((new.start<=Wears.end)AND
		((Wears.end IS NULL)OR(Wears.end>=new.start))AND
			(Wears.pan=new.pan)))) then
			
	call overlaping_time_periods_for_Patient_PAN();

end$$

delimiter ;
