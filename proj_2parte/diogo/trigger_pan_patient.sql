drop trigger if exists check_overlap_time_period_Patient_PAN;

delimiter $$

create trigger check_overlap_time_period_Patient_PAN before insert on Wears

for each row
begin
if(exists(SELECT start FROM Wears WHERE(
		(((new.start<=Wears.start)AND(new.end<=Wears.end)AND(new.end>=Wears.start))
		OR((new.start>=Wears.start)AND((Wears.end IS NULL)OR(new.end<=Wears.end)))
		OR((new.start>=Wears.start)AND(new.start<=Wears.end)AND(new.end>=Wears.end)))
		AND((new.patient=Wears.patient)OR(new.pan=Wears.pan))))) then
			
	call overlaping_time_periods_for_Patient_PAN();
	
end if;

end$$

delimiter ;
