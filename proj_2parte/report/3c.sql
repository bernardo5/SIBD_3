SELECT distinct manufacturer
  FROM Device as d, Connects as c, Wears as w, Lives as l
  WHERE( 
	((w.start >= '2014-01-01') OR (w.end <= '2014-12-31')) 	
	AND (c.start <= w.end) AND (c.end >= w.start) 
	AND (l.start <= w.end) AND (l.end >= w.start) 
	AND (w.pan = c.pan)	AND (w.patient = l.patient) 						
	AND ((d.manufacturer = c.manuf) AND (d.serialnum = c.snum))
	AND (d.description = 'scale'));									
