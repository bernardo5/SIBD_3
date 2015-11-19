
SELECT DISTINCT max(m.name)
FROM Municipality as m, Device as d, Lives as l, Wears as w, PAN as p, connects as c, patient as pat
WHERE (l.muni = m.nut4code /* "liga" municipalities a lives*/
AND (l.patient = w.patient AND l.patient = pat.number AND w.patient = pat.number) /*liga wears a patient e patient a lives */
AND w.pan = p.domain /*liga wears a pan */
AND ((c.manuf = d.manufacturer AND d.manufacturer = 'Philips') AND (c.snum = d.serialnum))/* liga connects a devices*/
AND ((w.end = '2999-12-12' AND l.end = '2999-12-12' AND c.end = '2999-12-12') AND (w.end = l.end = c.end))); /* verifica as datas para wears e lives*/


	