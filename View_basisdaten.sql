-- Materialized View: public.basisdaten_2016_materialized

-- DROP MATERIALIZED VIEW public.basisdaten_2016_materialized;

CREATE  VIEW public.basisdaten_2016_new AS 
 SELECT DISTINCT v.ags,
    gem.ew_insgesamt,
    gem.ew_maennlich,
    gem.ew_weiblich,
    gfk2017."Haushalte" AS haushalte,
    g."WHG_11" AS wohnungen,
    g."GEB_11" AS wohngebaeude,
    boden."Bodenfläche" AS bodenflaeche_ha,
    boden."Siedlungs- und Verkehrsfläche" AS suv_ha,
    boden."Gebäude- und Freifläche Insgesamt" AS gebaede_freiflaeche_ha,
    boden."Verkehrsfläche Insgesamt" AS verkehrsflaeche_ha,
    gfk2017."Kaufkraft ‰" AS kaufkraft,
    bevg."Insgesamt_unter 3 Jahre", 
    bevg."Insgesamt_3 bis unter 6 Jahre", 
    bevg."Insgesamt_6 bis unter 10 Jahre",
    bevg."Insgesamt_10 bis unter 15 Jahre", 
    bevg."Insgesamt_15 bis unter 18 Jahre", 
    bevg."Insgesamt_18 bis unter 20 Jahre", 
    bevg."Insgesamt_20 bis unter 25 Jahre",
    bevg."Insgesamt_25 bis unter 30 Jahre", 
    bevg."Insgesamt_30 bis unter 35 Jahre", 
    bevg."Insgesamt_35 bis unter 40 Jahre", 
    bevg."Insgesamt_40 bis unter 45 Jahre",
    bevg."Insgesamt_45 bis unter 50 Jahre", 
    bevg."Insgesamt_50 bis unter 55 Jahre", 
    bevg."Insgesamt_55 bis unter 60 Jahre", 
    bevg."Insgesamt_60 bis unter 65 Jahre", 
    bevg."Insgesamt_65 bis unter 75 Jahre", 
    bevg."Insgesamt_75 Jahre und mehr",
    bevg."Insgesamt", 
    t."Gästeübernachtungen", 
    a."Arbeitslose insgesamt"
   




    
   FROM bkg.vg250_gem_2016 v
   
     LEFT JOIN zensus.bevoelkerung2011 b ON v.ags::text = b."AGS_8"
     LEFT JOIN zensus.gebaeude2011 g ON v.ags::text = g."AGS_8"
     LEFT JOIN destatis_gemeinden."173_01_5_2016" gem ON v.ags::text = gem.ags_8_stellig::text
     LEFT JOIN gfk.gfk2017 ON v.ags::text = gfk2017."Kennziffer Gemeinde"::text
     LEFT JOIN destatis_gemeinden."449-01-5-B_2016" boden ON v.ags::text = boden."AGS"::text

     LEFT JOIN destatis_gemeinden."173-21-5-B­Bevoelkerungsstadt_nach_Geschlecht_2015" bevg ON v.ags::text = bevg.ags::text
     
     LEFT JOIN destatis_gemeinden."469-11-5-B­Tourismus_2015" t ON v.ags::text = t.ags::text
     
     LEFT JOIN destatis_gemeinden."659-21-5-B_Arbeitslose_2016" a ON v.ags::text = a.ags::text


     
  ORDER BY v.ags
