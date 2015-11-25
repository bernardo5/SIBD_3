delimiter $$
create trigger check_overlap_time_period_Patient_PAN 
										before insert on Wears
for each row
begin
if(
   exists(SELECT start, end FROM Wears
	WHERE(				
	(Wears.start <= new.end) and  (Wears.end >= new.start)
		 	 
	AND ((new.patient != Wears.patient) AND
	 (new.pan = Wears.pan))
	OR ((new.patient = Wears.patient) AND
	 (new.pan != Wears.pan))
	)
   )
)
	then	
	call overlaping_time_periods_for_Patient_PAN();
end if;
end$$
delimiter ;

delimiter $$
create trigger check_overlap_time_period_Device_PAN 
					before insert on Connects
for each row
begin
if(
   exists(SELECT start, end FROM Connects
	WHERE(	
	(Connects.start <= new.end) and (Connects.end >= new.start)		
	AND ((new.snum = Connects.snum) and 
			(new.manuf = Connects.manuf))
	AND (new.pan != Connects.pan)
	)
   )
)
	then		
	call overlaping_time_periods_for_Device_PAN();
end if;
end$$
delimiter ;
