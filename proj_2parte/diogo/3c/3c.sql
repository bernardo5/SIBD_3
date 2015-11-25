SELECT distinct manufacturer
	FROM Device as d, Connects as c, Wears as w, Lives as l
	WHERE( 
		((w.start >= '2014-01-01') OR (w.end <= '2014-12-31')) 		/*Verifica se são vestidos PAN durante o ano anterior*/
		AND (c.start <= w.end) AND (c.end >= w.start) /*Verifica se o ano de Wears coincide com Connects*/
		AND (l.start <= w.end) AND (l.end >= w.start) /*Verifica se o ano de Wears coincide com Lives*/
		AND (w.pan = c.pan)											/*Liga PAN de Wears a PAN de Connects*/
		AND (w.patient = l.patient) 								/*Liga Patient de Wears a Patient de Lives*/
		AND ((d.manufacturer = c.manuf) AND (d.serialnum = c.snum))	/*Liga Device a Connects*/
		AND (d.description = 'scale'));								/*Força condição de description do Device*/				
