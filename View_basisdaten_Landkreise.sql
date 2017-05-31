-- Materialized View: public.basisdaten_2016_langkreise

-- DROP MATERIALIZED VIEW public.basisdaten_2016_langkreise;

CREATE  VIEW public.basisdaten_2016_langkreise AS 

--WITH lk as
--(
--SELECT DISTINCT ags, gen
--FROM bkg.vg250_krs_2014

--UNION 

--SELECT DISTINCT ags,gen
--FROM bkg.vg250_krs_2015

--UNION 

--SELECT DISTINCT ags,gen
--FROM bkg.vg250_krs_2016

--UNION 

--SELECT DISTINCT ags,gen
--FROM bkg.vg250_krs_2017
--)



 SELECT DISTINCT 
	v.ags,
	jaq."Jugendquotient",
	jaq."Altenquotient", 
	bip."Bruttoinlandsprodukt Tsd EUR" as bip_tsd,
	erwt."Insgesamt_in_1000" as Erwerbstaetige_tsd,
	pkw."Pkw"
    
   FROM bkg.vg250_krs_2016 v

     LEFT JOIN destatis_kreise."173-34-4-B_Jugend_Altenquotient_2015" jaq ON v.ags::text = jaq."LK_ags"
     LEFT JOIN destatis_kreise."426-71-4-B_BIP_2014" bip ON v.ags::text = bip."LK_ags"
     LEFT JOIN destatis_kreise."638-61-4-B_Erwerbstaetige_2014" erwt ON v.ags::text = erwt."LK_ags"
     LEFT JOIN destatis_kreise."641-41-4-B_Pkw_Bestand_2016" pkw ON v.ags::text = pkw."Landkreiskennziffer"
     
  ORDER BY v.ags