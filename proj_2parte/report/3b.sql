SELECT max(m.name), m.nut4code
  FROM Municipality as m, Device as d, Lives as l,
	Wears as w, Connects as c, Patient as pat
  WHERE(
	(l.muni = m.nut4code) 				
	AND ((l.patient = w.patient) AND (l.patient = pat.number))  
	AND ((w.patient = pat.number) AND (w.pan = c.pan))	
	AND ((c.manuf = d.manufacturer) AND (c.snum = d.serialnum))	
	AND ((w.start <= current_date) AND (l.start <= current_date) 
	AND (c.start <= current_date)) AND ((w.end >= current_date) 
	AND (l.end >= current_date) AND (c.end >= current_date))
	AND (d.manufacturer = 'Philips'));	


	
