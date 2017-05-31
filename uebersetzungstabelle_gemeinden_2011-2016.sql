--CREATE MATERIALIZED VIEW uebersetungstabelle_ags_gemeinde as

WITH step2011 as
(
 SELECT 
	bkg2011.ags AS bkg_ags_2011,
	bkg2011.gen AS bkg_gen_2011,
	g.ags_neu as ch_ags_2011,
	g.gem_name_neu as ch_gen_2011
FROM 
	bkg.vg250_gem_2011 bkg2011
        LEFT JOIN public."Gemeindeaenderungen_2011_2016" g ON  bkg2011.ags = g."Amtlicher Gemeindeschlüssel (AGS)" 
        ----Jahr anpassen-----
        AND g."Jahr" = 2011 
        AND g."Aenderungsart" IN ( '1', '3', '4')  AND g."Regionaleinheit" = 'Gemeinde' AND g."Amtlicher Gemeindeschlüssel (AGS)" is NOT NULL
          
GROUP BY
	bkg2011.ags, bkg2011.gen, g.ags_neu, g.gem_name_neu
          ),

case11 as
(
          SELECT
		bkg_ags_2011,
		bkg_gen_2011,
		ch_ags_2011, ch_gen_2011,
		
	CASE 
	WHEN ch_ags_2011 is NULL
		THEN bkg_ags_2011
	WHEN ch_ags_2011 is NOT NULL
		THEN ch_ags_2011
	END AS new_ags_2012,

	CASE 
	WHEN ch_ags_2011 is NULL
		THEN bkg_gen_2011
	WHEN ch_ags_2011 is NOT NULL
		THEN ch_gen_2011
	END AS new_gen_2012
							
          FROM step2011 
          ),

step2012 as
 (
 SELECT  
	bkg_ags_2011, bkg_gen_2011,
	ch_ags_2011, ch_gen_2011,
	new_ags_2012, new_gen_2012,
	y.ags as bkg_ags_2012,
	y.gen as bkg_gen_2012
     FROM 
	case11 c
	FULL JOIN bkg.vg250_gem_2012 y ON c.new_ags_2012 = y.ags::text
     
          ),
step2012_b as
(
SELECT 
	bkg_ags_2011, bkg_gen_2011,
	ch_ags_2011, ch_gen_2011,
	new_ags_2012, new_gen_2012,
	bkg_ags_2012,
	bkg_gen_2012,
	g.ags_neu as ch_ags_2012,
	g.gem_name_neu as ch_gen_2012

FROM 
	step2012 s12	
	LEFT JOIN public."Gemeindeaenderungen_2011_2016" g ON  s12.new_ags_2012 = g."Amtlicher Gemeindeschlüssel (AGS)" 
        ----Jahr anpassen-----
        AND g."Jahr" = 2012 
        AND g."Aenderungsart" IN ( '1', '3', '4')  AND g."Regionaleinheit" = 'Gemeinde' AND g."Amtlicher Gemeindeschlüssel (AGS)" is NOT NULL
          
GROUP BY
	bkg_ags_2011, bkg_gen_2011,
	ch_ags_2011, ch_gen_2011,
	new_ags_2012, new_gen_2012,
	bkg_ags_2012, bkg_gen_2012,
	g.ags_neu, g.gem_name_neu
          
),

case12 as
(
SELECT
	bkg_ags_2011, bkg_gen_2011,
	ch_ags_2011, ch_gen_2011,
	new_ags_2012, new_gen_2012,
	bkg_ags_2012,
	bkg_gen_2012,
	ch_ags_2012,
	ch_gen_2012,

		CASE 
		WHEN ch_ags_2012 is NULL
			THEN new_ags_2012
		WHEN ch_ags_2012 is NOT NULL
			THEN ch_ags_2012
		END AS new_ags_2013,

		CASE 
		WHEN ch_ags_2012 is NULL
			THEN new_gen_2012
		WHEN ch_ags_2012 is NOT NULL
			THEN ch_gen_2012
		END AS new_gen_2013
							
          FROM step2012_b 
          ),

step2013 as
 (
 SELECT  
	bkg_ags_2011, bkg_gen_2011,
	ch_ags_2011, ch_gen_2011,
	new_ags_2012, new_gen_2012,
	bkg_ags_2012,
	bkg_gen_2012,
	ch_ags_2012,
	ch_gen_2012,
	new_ags_2013,
	new_gen_2013,
	z.ags as bkg_ags_2013,
	z.gen as bkg_gen_2013
	
     FROM 
	case12 c
	FULL JOIN bkg.vg250_gem_2013 z ON c.new_ags_2013 = z.ags::text
     
          ) ,
          
step2013_b as
(
SELECT 
	bkg_ags_2011, bkg_gen_2011,
	ch_ags_2011, ch_gen_2011,
	new_ags_2012, new_gen_2012,
	bkg_ags_2012, bkg_gen_2012,
	ch_ags_2012, ch_gen_2012,
	new_ags_2013, new_gen_2013,
	bkg_ags_2013, bkg_gen_2013,
	g.ags_neu as ch_ags_2013,
	g.gem_name_neu as ch_gen_2013

FROM 
	step2013 s13	
	LEFT JOIN public."Gemeindeaenderungen_2011_2016" g ON  s13.new_ags_2013 = g."Amtlicher Gemeindeschlüssel (AGS)" 
        ----Jahr anpassen-----
        AND g."Jahr" = 2013 
        AND g."Aenderungsart" IN ( '1', '3', '4')  AND g."Regionaleinheit" = 'Gemeinde' AND g."Amtlicher Gemeindeschlüssel (AGS)" is NOT NULL
          
GROUP BY
	bkg_ags_2011, bkg_gen_2011,
	ch_ags_2011, ch_gen_2011,
	new_ags_2012, new_gen_2012,
	bkg_ags_2012, bkg_gen_2012,
	ch_ags_2012, ch_gen_2012,
	new_ags_2013, new_gen_2013,
	bkg_ags_2013, bkg_gen_2013,
	g.ags_neu, g.gem_name_neu
          
),

case13 as
(
SELECT
	bkg_ags_2011, bkg_gen_2011,
	ch_ags_2011, ch_gen_2011,
	new_ags_2012, new_gen_2012,
	bkg_ags_2012, bkg_gen_2012,
	ch_ags_2012, ch_gen_2012,
	new_ags_2013, new_gen_2013,
	bkg_ags_2013, bkg_gen_2013,
	ch_ags_2013,
	ch_gen_2013,

		CASE 
		WHEN ch_ags_2013 is NULL
			THEN new_ags_2013
		WHEN ch_ags_2013 is NOT NULL
			THEN ch_ags_2013
		END AS new_ags_2014,

		CASE 
		WHEN ch_ags_2013 is NULL
			THEN new_gen_2013
		WHEN ch_ags_2013 is NOT NULL
			THEN ch_gen_2013
		END AS new_gen_2014
							
          FROM step2013_b 
          ),

step2014 as
 (
 SELECT  
	bkg_ags_2011, bkg_gen_2011,
	ch_ags_2011, ch_gen_2011,
	new_ags_2012, new_gen_2012,
	bkg_ags_2012, bkg_gen_2012,
	ch_ags_2012, ch_gen_2012,
	new_ags_2013, new_gen_2013,
	bkg_ags_2013, bkg_gen_2013,
	ch_ags_2013, ch_gen_2013,
	new_ags_2014, new_gen_2014,
	f.ags as bkg_ags_2014,
	f.gen as bkg_gen_2014
	
     FROM 
	case13 c13
	FULL JOIN bkg.vg250_gem_2014 f ON c13.new_ags_2014 = f.ags::text
     
          ),
          
step2014_b as
(
SELECT 
	bkg_ags_2011, bkg_gen_2011,
	ch_ags_2011, ch_gen_2011,
	new_ags_2012, new_gen_2012,
	bkg_ags_2012, bkg_gen_2012,
	ch_ags_2012, ch_gen_2012,
	new_ags_2013, new_gen_2013,
	bkg_ags_2013, bkg_gen_2013,
	ch_ags_2013, ch_gen_2013,
	new_ags_2014, new_gen_2014,
	bkg_ags_2014, bkg_gen_2014,
	g.ags_neu as ch_ags_2014,
	g.gem_name_neu as ch_gen_2014

FROM 
	step2014 s14	
	LEFT JOIN public."Gemeindeaenderungen_2011_2016" g ON  s14.new_ags_2014 = g."Amtlicher Gemeindeschlüssel (AGS)" 
        ----Jahr anpassen-----
        AND g."Jahr" = 2014 
        AND g."Aenderungsart" IN ( '1', '3', '4')  AND g."Regionaleinheit" = 'Gemeinde' AND g."Amtlicher Gemeindeschlüssel (AGS)" is NOT NULL
          
GROUP BY
	bkg_ags_2011, bkg_gen_2011,
	ch_ags_2011, ch_gen_2011,
	new_ags_2012, new_gen_2012,
	bkg_ags_2012, bkg_gen_2012,
	ch_ags_2012, ch_gen_2012,
	new_ags_2013, new_gen_2013,
	bkg_ags_2013, bkg_gen_2013,
	ch_ags_2013, ch_gen_2013,
	new_ags_2014, new_gen_2014,
	bkg_ags_2014, bkg_gen_2014,
	g.ags_neu, g.gem_name_neu
          
),

case14 as
(
SELECT
	bkg_ags_2011, bkg_gen_2011,
	ch_ags_2011, ch_gen_2011,
	new_ags_2012, new_gen_2012,
	bkg_ags_2012, bkg_gen_2012,
	ch_ags_2012, ch_gen_2012,
	new_ags_2013, new_gen_2013,
	bkg_ags_2013, bkg_gen_2013,
	ch_ags_2013, ch_gen_2013,
	new_ags_2014, new_gen_2014,
	bkg_ags_2014, bkg_gen_2014,
	ch_ags_2014, ch_gen_2014,

		CASE 
		WHEN ch_ags_2014 is NULL
			THEN new_ags_2014
		WHEN ch_ags_2014 is NOT NULL
			THEN ch_ags_2014
		END AS new_ags_2015,

		CASE 
		WHEN ch_ags_2014 is NULL
			THEN new_gen_2014
		WHEN ch_ags_2014 is NOT NULL
			THEN ch_gen_2014
		END AS new_gen_2015
							
          FROM step2014_b 
          ),

step2015 as
 (
 SELECT  
	bkg_ags_2011, bkg_gen_2011,
	ch_ags_2011, ch_gen_2011,
	new_ags_2012, new_gen_2012,
	bkg_ags_2012, bkg_gen_2012,
	ch_ags_2012, ch_gen_2012,
	new_ags_2013, new_gen_2013,
	bkg_ags_2013, bkg_gen_2013,
	ch_ags_2013, ch_gen_2013,
	new_ags_2014, new_gen_2014,
	bkg_ags_2014, bkg_gen_2014,
	ch_ags_2014, ch_gen_2014,
	new_ags_2015, new_gen_2015,
	h.ags as bkg_ags_2015,
	h.gen as bkg_gen_2015
	
     FROM 
	case14 c14
	FULL JOIN bkg.vg250_gem_2015 h ON c14.new_ags_2015 = h.ags::text
     
          ),
          
step2015_b as
(
SELECT 
	bkg_ags_2011, bkg_gen_2011,
	ch_ags_2011, ch_gen_2011,
	new_ags_2012, new_gen_2012,
	bkg_ags_2012, bkg_gen_2012,
	ch_ags_2012, ch_gen_2012,
	new_ags_2013, new_gen_2013,
	bkg_ags_2013, bkg_gen_2013,
	ch_ags_2013, ch_gen_2013,
	new_ags_2014, new_gen_2014,
	bkg_ags_2014, bkg_gen_2014,
	ch_ags_2014, ch_gen_2014,
	new_ags_2015, new_gen_2015,
	bkg_ags_2015,
	bkg_gen_2015,
	g.ags_neu as ch_ags_2015,
	g.gem_name_neu as ch_gen_2015

FROM 
	step2015 s15	
	LEFT JOIN public."Gemeindeaenderungen_2011_2016" g ON  s15.new_ags_2015 = g."Amtlicher Gemeindeschlüssel (AGS)" 
        ----Jahr anpassen-----
        AND g."Jahr" = 2015 
        AND g."Aenderungsart" IN ( '1', '3', '4')  AND g."Regionaleinheit" = 'Gemeinde' AND g."Amtlicher Gemeindeschlüssel (AGS)" is NOT NULL
          
GROUP BY
	bkg_ags_2011, bkg_gen_2011,
	ch_ags_2011, ch_gen_2011,
	new_ags_2012, new_gen_2012,
	bkg_ags_2012, bkg_gen_2012,
	ch_ags_2012, ch_gen_2012,
	new_ags_2013, new_gen_2013,
	bkg_ags_2013, bkg_gen_2013,
	ch_ags_2013, ch_gen_2013,
	new_ags_2014, new_gen_2014,
	bkg_ags_2014, bkg_gen_2014,
	ch_ags_2014, ch_gen_2014,
	new_ags_2015, new_gen_2015,
	bkg_ags_2015,
	bkg_gen_2015,
	g.ags_neu, g.gem_name_neu
          
),

case15 as
(
SELECT
	bkg_ags_2011, bkg_gen_2011,
	ch_ags_2011, ch_gen_2011,
	new_ags_2012, new_gen_2012,
	bkg_ags_2012, bkg_gen_2012,
	ch_ags_2012, ch_gen_2012,
	new_ags_2013, new_gen_2013,
	bkg_ags_2013, bkg_gen_2013,
	ch_ags_2013, ch_gen_2013,
	new_ags_2014, new_gen_2014,
	bkg_ags_2014, bkg_gen_2014,
	ch_ags_2014, ch_gen_2014,
	new_ags_2015, new_gen_2015,
	bkg_ags_2015,
	bkg_gen_2015,
	ch_ags_2015,
	ch_gen_2015,

		CASE 
		WHEN ch_ags_2015 is NULL
			THEN new_ags_2015
		WHEN ch_ags_2015 is NOT NULL
			THEN ch_ags_2015
		END AS new_ags_2016,

		CASE 
		WHEN ch_ags_2015 is NULL
			THEN new_gen_2015
		WHEN ch_ags_2015 is NOT NULL
			THEN ch_gen_2015
		END AS new_gen_2016
							
          FROM step2015_b 
          ),

step2016 as
 (
 SELECT  
	bkg_ags_2011, bkg_gen_2011,
	ch_ags_2011, ch_gen_2011,
	new_ags_2012, new_gen_2012,
	bkg_ags_2012, bkg_gen_2012,
	ch_ags_2012, ch_gen_2012,
	new_ags_2013, new_gen_2013,
	bkg_ags_2013, bkg_gen_2013,
	ch_ags_2013, ch_gen_2013,
	new_ags_2014, new_gen_2014,
	bkg_ags_2014, bkg_gen_2014,
	ch_ags_2014, ch_gen_2014,
	new_ags_2015, new_gen_2015,
	bkg_ags_2015, bkg_gen_2015,
	ch_ags_2015, ch_gen_2015,
	new_ags_2016, new_gen_2016,
	i.ags as bkg_ags_2016,
	i.gen as bkg_gen_2016
	
     FROM 
	case15 c15
	FULL JOIN bkg.vg250_gem_2016 i ON c15.new_ags_2016 = i.ags::text
     
          ),
          
step2016_b as
(
SELECT 
	bkg_ags_2011, bkg_gen_2011,
	ch_ags_2011, ch_gen_2011,
	new_ags_2012, new_gen_2012,
	bkg_ags_2012, bkg_gen_2012,
	ch_ags_2012, ch_gen_2012,
	new_ags_2013, new_gen_2013,
	bkg_ags_2013, bkg_gen_2013,
	ch_ags_2013, ch_gen_2013,
	new_ags_2014, new_gen_2014,
	bkg_ags_2014, bkg_gen_2014,
	ch_ags_2014, ch_gen_2014,
	new_ags_2015, new_gen_2015,
	bkg_ags_2015, bkg_gen_2015,
	ch_ags_2015, ch_gen_2015,
	new_ags_2016, new_gen_2016,
	bkg_ags_2016, bkg_gen_2016,
	g.ags_neu as ch_ags_2016,
	g.gem_name_neu as ch_gen_2016

FROM 
	step2016 s16	
	LEFT JOIN public."Gemeindeaenderungen_2011_2016" g ON  s16.new_ags_2016 = g."Amtlicher Gemeindeschlüssel (AGS)" 
        ----Jahr anpassen-----
        AND g."Jahr" = 2016 
        AND g."Aenderungsart" IN ( '1', '3', '4')  AND g."Regionaleinheit" = 'Gemeinde' AND g."Amtlicher Gemeindeschlüssel (AGS)" is NOT NULL
          
GROUP BY
	bkg_ags_2011, bkg_gen_2011,
	ch_ags_2011, ch_gen_2011,
	new_ags_2012, new_gen_2012,
	bkg_ags_2012, bkg_gen_2012,
	ch_ags_2012, ch_gen_2012,
	new_ags_2013, new_gen_2013,
	bkg_ags_2013, bkg_gen_2013,
	ch_ags_2013, ch_gen_2013,
	new_ags_2014, new_gen_2014,
	bkg_ags_2014, bkg_gen_2014,
	ch_ags_2014, ch_gen_2014,
	new_ags_2015, new_gen_2015,
	bkg_ags_2015, bkg_gen_2015,
	ch_ags_2015, ch_gen_2015,
	new_ags_2016, new_gen_2016,
	bkg_ags_2016, bkg_gen_2016,
	g.ags_neu, g.gem_name_neu
          
),

case16 as
(
SELECT
	bkg_ags_2011, bkg_gen_2011,
	ch_ags_2011, ch_gen_2011,
	new_ags_2012, new_gen_2012,
	bkg_ags_2012, bkg_gen_2012,
	ch_ags_2012, ch_gen_2012,
	new_ags_2013, new_gen_2013,
	bkg_ags_2013, bkg_gen_2013,
	ch_ags_2013, ch_gen_2013,
	new_ags_2014, new_gen_2014,
	bkg_ags_2014, bkg_gen_2014,
	ch_ags_2014, ch_gen_2014,
	new_ags_2015, new_gen_2015,
	bkg_ags_2015, bkg_gen_2015,
	ch_ags_2015, ch_gen_2015,
	new_ags_2016, new_gen_2016,
	bkg_ags_2016, bkg_gen_2016,
	ch_ags_2016, ch_gen_2016,

	CASE 
	WHEN ch_ags_2016 is NULL
		THEN new_ags_2016
	WHEN ch_ags_2016 is NOT NULL
		THEN ch_ags_2016
	END AS new_ags_2017,

		CASE 
		WHEN ch_ags_2016 is NULL
			THEN new_gen_2016
		WHEN ch_ags_2016 is NOT NULL
			THEN ch_gen_2016
		END AS new_gen_2017
							
          FROM step2016_b 
          )
          
          SELECT *
          --FROM step2016_b
          FROM case16
          ORDER BY bkg_gen_2012