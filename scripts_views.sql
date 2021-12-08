--conocimiento de leyes que protegen vs sentimiento de proteccion & herramientas de privacidad
create view vista_1_herramientas as select s.sentimiento_proteccion as sentimiento, rs.herramientas_privacidad , count(s.sentimiento_proteccion) 
from seguridad s join redes_sociales rs on rs.id_encuestado = s.id_encuestado 
group by s.sentimiento_proteccion, rs.herramientas_privacidad;

create view vista_1_leyes as select s.conocimiento_leyes as leyes , s.sentimiento_proteccion as sentimiento ,count(s.sentimiento_proteccion) 
from seguridad s 
group by s.conocimiento_leyes , s.sentimiento_proteccion;

--actitud inicio vs final
create view vista_2_antes as select e.actitud_ciberseg as actitud_inicio, count(e.actitud_ciberseg) 
from encuestado e
group by e.actitud_ciberseg;

create view vista_2_despues as select c.actitud_ciberseg as actitud_final , count(c.actitud_ciberseg) 
from conclusion c  
group by c.actitud_ciberseg;

--eficiencia vs privacidad
create view vista_3 as select e.valoracion_priv_ef, rs.contenido_sin_vigilancia as atencion_personalizada, co.publicidad_personalizada , c.vigilancia as molesta_vigilancia , count(c.vigilancia)
from encuestado e join redes_sociales rs on e.id_encuestado = rs.id_encuestado join compras_online co on co.id_encuestado = e.id_encuestado join conclusion c on e.id_encuestado = c.id_encuestado 
group by e.valoracion_priv_ef, c.vigilancia,  rs.contenido_sin_vigilancia, co.publicidad_personalizada;
--desglosar en genero

--datos bancarios
create view vista_4_confianza as select cp.datos_bancarios , count(cp.datos_bancarios)
from compras_online co join confianza_paginas cp on cp.id_confianza_paginas = co.id_confianza_paginas join forma_pago fp on fp.id_forma_pago = co.id_forma_pago 
where fp.credito = true or fp.debito = true
group by cp.datos_bancarios ;

create view vista_4_complemento as
select cp.datos_bancarios , co.frecuencia_compras, count(cp.datos_bancarios)
from compras_online co join confianza_paginas cp on cp.id_confianza_paginas = co.id_confianza_paginas join forma_pago fp on fp.id_forma_pago = co.id_forma_pago 
where fp.credito = true or fp.debito = true
group by cp.datos_bancarios , co.frecuencia_compras ;

--impacto redes sociales
create view vista_5 as select e.genero , rs.impacto_redes_vida , count(e.genero)
from encuestado e join redes_sociales rs on rs.id_encuestado = e.id_encuestado 
group by e.genero , rs.impacto_redes_vida ;

--deseo de ver contenido sin ser vigilado
create view vista_6 as select rs.contenido_observado as ver_sin_ser_visto, count(rs.contenido_observado) 
from redes_sociales rs 
group by rs.contenido_observado;  

--no tenemos moralidad jaja
create view vista_7_1 as
select count(empleador) as empleador 
from uso_stalkeo us 
group by us.empleador ;

create view vista_7_2 as
select count(producto) as producto 
from uso_stalkeo us 
group by us.producto ;

create view vista_7_3 as
select count(escuela) as escuela 
from uso_stalkeo us 
group by us.escuela ;

create view vista_7_4 as
select count(persona) as persona 
from uso_stalkeo us 
group by us.producto ;

create view vista_7_5 as
select count(nunca) as nunca 
from uso_stalkeo us 
group by us.nunca ;

--tiempo en redes por género
create view vista_extra_1 as 
select e.genero , rs.tiempo_redes , count(e.genero) 
from encuestado e join redes_sociales rs on rs.id_encuestado = e.id_encuestado 
group by e.genero , rs.tiempo_redes ;

--frecuencia de compras por género
create view vista_extra_2 as 
select e.genero ,co.frecuencia_compras  , count(e.genero) 
from encuestado e join compras_online co on co.id_encuestado = e.id_encuestado 
where not co.frecuencia_compras = '-'
group by e.genero , co.frecuencia_compras ;
