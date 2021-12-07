
# Documentación Scripts de Vistas

## View 1: Sentimiento de seguridad al navegar por internet 
### Código:
create view vista_1 as select s.conocimiento_leyes as leyes , s.sentimiento_proteccion as sentimiento, rs.herramientas_privacidad ,count(s.conocimiento_leyes)
from seguridad s join redes_sociales rs on rs.id_encuestado = s.id_encuestado 
group by s.conocimiento_leyes , s.sentimiento_proteccion, rs.herramientas_privacidad;
### Explicación:
Intersectamos el conocimiento sobre las leyes que protegen la navegación por internet con el conocimiento sobre las herramientas de privacidad en redes sociales junto al sentimiento de protección que experimentan los encuestados al navegar por internet.
### Respuesta a...
Esta vista nos muestra una historia acerca de cómo las personas podrían no sentirse protegidas al navegar por internet a la vez que intentamos entender si esto se debe a que no conocen las configuraciones de privacidad en las aplicaciones que usan ni las leyes existentes que los protegen al navegar por internet y otorgar sus datos personales a terceros.

## View 2: Actitudes inicio vs Actitudes finales
### Código:
create view vista_2 as select e.actitud_ciberseg as actitud_inicio, c.actitud_ciberseg as actitud_final , count(c.actitud_ciberseg) 
from encuestado e join conclusion c on e.id_encuestado = c.id_encuestado 
group by e.actitud_ciberseg, c.actitud_ciberseg;
### Explicación:
Observamos las parejas de actitudes que registraron los encuestados al inicio y al final de la encuesta.
### Respuesta a...
Esta vista nos permite saber si la actitud del encuestado frente a los problemas de ciberseguridad cambió luegode responder la encuesta.

## View 3: Eficiencia vs Privacidad
### Código:
create view vista_3 as select e.valoracion_priv_ef, rs.contenido_sin_vigilancia as atencion_personalizada, co.publicidad_personalizada , c.vigilancia as molesta_vigilancia , count(c.vigilancia)
from encuestado e join redes_sociales rs on e.id_encuestado = rs.id_encuestado join compras_online co on co.id_encuestado = e.id_encuestado join conclusion c on e.id_encuestado = c.id_encuestado 
group by e.valoracion_priv_ef, c.vigilancia,  rs.contenido_sin_vigilancia, co.publicidad_personalizada;
### Explicación:
Esta es la vista más complicada y lo que busca es hacer referencias cruzadas entre incisos que en esencia son la misma pregunta pero en diferentes aspectos de la vida digital del encuestado.
### Respuesta a...
Con esta vista buscamos la coherencia o discrepancias que puedan llegar a tener los encuestados en relación con los temas de valoración entre privacidad y eficiencia de la tecnología que usan.

## View 4: Datos bancarios
### Código:
create view vista_4 as select cp.datos_bancarios , count(cp.datos_bancarios)
from compras_online co join confianza_paginas cp on cp.id_confianza_paginas = co.id_confianza_paginas join forma_pago fp on fp.id_forma_pago = co.id_forma_pago 
where fp.credito = true or fp.debito = true
group by cp.datos_bancarios;
### Explicación:
Filtramos las respuestas de los encuestados que pagan sus compras en línea con tarjetas de débito o crédito para luego saber si confían en los sitios en los cuáles ingresan su información bancaria.
### Respuesta a...
Buscamos saber si las personas confían en los sitios a los que les otorgan sus datos bancarios.

## View 5: Impacto redes sociales
### Código:
create view vista_5 as select e.genero , rs.impacto_redes_vida , count(e.genero)
from encuestado e join redes_sociales rs on rs.id_encuestado = e.id_encuestado 
group by e.genero , rs.impacto_redes_vida ;
### Explicación:
Buscamos saber el impacto que tienen las redes sociales entre las vidas de los encuestados tomando en cuenta la perspectiva de género.
### Respuesta a...
Esta vista intenta saber si es que el impacto que los usuarios perciben que las redes sociales varía dependiendo de su género.

## View 6: Deseo de ver contenido sin ser vigilado
### Código:
create view vista_6 as select rs.contenido_observado as ver_sin_ser_visto, count(rs.contenido_observado) 
from redes_sociales rs 
group by rs.contenido_observado; 
### Explicación y respuesta:
Esta es la vista más sencilla y solo busca saber cuántas personas quisieran ver contenido en línea sin ser vigilados por nadie.

## View 7: Moralidad
### Código:
create view vista_7 as
with ext_1 as 
(select count(empleador) as empleador 
from uso_stalkeo us 
where empleador = true),
ext_2 as 
(select count(producto) as producto 
from uso_stalkeo us 
where producto = true),
ext_3 as 
(select count(nunca) as nunca 
from uso_stalkeo us 
where nunca = true),
ext_4 as 
(select count(persona) as persona 
from uso_stalkeo us 
where persona = true),
ext_5 as (select count(e.id_encuestado) as total from encuestado e)
select * from ext_1, ext_2, ext_3, ext_4, ext_5;
### Explicación:
Ya que la tabla uso_stalkeo contiene una matriz de booleanos, el análisis de dicha tabla es mejor ejecutarlo desde tablas de expresiones comunes para encontrar las situaciones en las que los encuestados piensan que se debería de poder "stalkear" a otras personas.
### Respuesta a...
Esta vista es una respuesta hacia la moralidad del uso de redes sociales y la información pública que ahí se encuentra.
