SELECT max(m.name), m.nut4code
	FROM Municipality as m, Device as d, Lives as l, Wears as w, Connects as c, Patient as pat
	WHERE(
		(l.muni = m.nut4code) 												/* "liga" municipalities a lives*/
		AND ((l.patient = w.patient) AND (l.patient = pat.number))  		/*liga Lives a Wears e Patient */
		AND ((w.patient = pat.number) AND (w.pan = c.pan))					/*liga Wears a Patient e a Connects */
		AND ((c.manuf = d.manufacturer) AND (c.snum = d.serialnum))			/*Liga Connects a Device*/
		AND ((w.start <= current_date) AND (l.start <= current_date) AND (c.start <= current_date)) /*Verificação de Períodos*/
		AND ((w.end >= current_date) AND (l.end >= current_date) AND (c.end >= current_date))	/*Verificação de Períodos*/
		AND (d.manufacturer = 'Philips'));									/* Condição Philips em manufacturer*/


	
