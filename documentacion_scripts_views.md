
# Documentación Scripts de Vistas

## View 1: Sentimiento de seguridad al navegar por internet 
### Código 1:
create view vista_1_herramientas as select s.sentimiento_proteccion as sentimiento, rs.herramientas_privacidad , count(s.sentimiento_proteccion) 
from seguridad s join redes_sociales rs on rs.id_encuestado = s.id_encuestado 
group by s.sentimiento_proteccion, rs.herramientas_privacidad;
### Explicación:
Intersectamos el sentimiento de protección del usuario con su conocimiento sobre las herramientas existentes enfocadas a la privacidad en redes sociales. 
### Código 2:
create view vista_1_leyes as select s.conocimiento_leyes as leyes , s.sentimiento_proteccion as sentimiento ,count(s.sentimiento_proteccion) 
from seguridad s 
group by s.conocimiento_leyes , s.sentimiento_proteccion;
### Explicación:
Intersectamos el conocimiento sobre las leyes que protegen la navegación por internet con el sentimiento de protección que experimentan los encuestados al navegar por internet.
### Respuesta a...
Estas vistas nos muestran una historia acerca de cómo las personas podrían no sentirse protegidas al navegar por internet a la vez que intentamos entender si esto se debe a que no conocen las configuraciones de privacidad en las aplicaciones que usan ni las leyes existentes que los protegen al navegar por internet y otorgar sus datos personales a terceros.

## View 2: Actitudes inicio vs Actitudes finales
### Código 1:
create view vista_2_antes as select e.actitud_ciberseg as actitud_inicio, count(e.actitud_ciberseg) 
from encuestado e
group by e.actitud_ciberseg;
### Explicación:
Esta tabla nos muestra la actitud en la red de los ecuenstados al principio de la evaluación.
### Código 2:
create view vista_2_despues as select c.actitud_ciberseg as actitud_final , count(c.actitud_ciberseg) 
from conclusion c  
group by c.actitud_ciberseg;
### Explicación:
Esta tabla nos muestra la actitud en la red de los ecuenstados al final de la evaluación.
### Respuesta a...
Estas vistas nos permiten saber si la actitud del encuestado frente a los problemas de ciberseguridad cambió luego de responder la encuesta.

## View 3: Eficiencia vs Privacidad (en construcción)
### Código:
create view vista_3 as select e.valoracion_priv_ef, rs.contenido_sin_vigilancia as atencion_personalizada, co.publicidad_personalizada , c.vigilancia as molesta_vigilancia , count(c.vigilancia)
from encuestado e join redes_sociales rs on e.id_encuestado = rs.id_encuestado join compras_online co on co.id_encuestado = e.id_encuestado join conclusion c on e.id_encuestado = c.id_encuestado 
group by e.valoracion_priv_ef, c.vigilancia,  rs.contenido_sin_vigilancia, co.publicidad_personalizada;
### Explicación:
Esta es la vista más complicada y lo que busca es hacer referencias cruzadas entre incisos que en esencia son la misma pregunta pero en diferentes aspectos de la vida digital del encuestado.
### Respuesta a...
Con esta vista buscamos la coherencia o discrepancias que puedan llegar a tener los encuestados en relación con los temas de valoración entre privacidad y eficiencia de la tecnología que usan.

## View 4: Datos bancarios (en construcción)
### Código 1:
create view vista_4_confianza as select cp.datos_bancarios , count(cp.datos_bancarios)
from compras_online co join confianza_paginas cp on cp.id_confianza_paginas = co.id_confianza_paginas join forma_pago fp on fp.id_forma_pago = co.id_forma_pago 
where fp.credito = true or fp.debito = true
group by cp.datos_bancarios ;
### Código 2:
create view vista_4_complemento_1 as select cp.datos_bancarios , co.frecuencia_compras, count(cp.datos_bancarios)
from compras_online co join confianza_paginas cp on cp.id_confianza_paginas = co.id_confianza_paginas join forma_pago fp on fp.id_forma_pago = co.id_forma_pago 
where (fp.credito = true or fp.debito = true) and cp.datos_bancarios = 'Confío'
group by cp.datos_bancarios , co.frecuencia_compras ;
### Código 3:
create view vista_4_complemento_2 as select cp.datos_bancarios , co.frecuencia_compras, count(cp.datos_bancarios)
from compras_online co join confianza_paginas cp on cp.id_confianza_paginas = co.id_confianza_paginas join forma_pago fp on fp.id_forma_pago = co.id_forma_pago 
where (fp.credito = true or fp.debito = true) and cp.datos_bancarios = 'Ni confío ni desconfío'
group by cp.datos_bancarios , co.frecuencia_compras ;
### Código 4:
create view vista_4_complemento_3 as 
select cp.datos_bancarios , co.frecuencia_compras, count(cp.datos_bancarios)
from compras_online co join confianza_paginas cp on cp.id_confianza_paginas = co.id_confianza_paginas join forma_pago fp on fp.id_forma_pago = co.id_forma_pago 
where (fp.credito = true or fp.debito = true) and cp.datos_bancarios = 'Desconfío'
group by cp.datos_bancarios , co.frecuencia_compras ;
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
group by rs.contenido_observado
### Explicación y respuesta:
Esta es la vista más sencilla y solo busca saber cuántas personas quisieran ver contenido en línea sin ser vigilados por nadie.

## View 7: Moralidad
### Código 1:
create view vista_7_1 as
select count(empleador) as empleador 
from uso_stalkeo us 
group by us.empleador ;
### Explicación:
Esta vista nos muestra si el encuestado considera moralmente correcto "stalkear" a una persona para ser contratada en una empresa.
### Código 2:
create view vista_7_2 as
select count(producto) as producto 
from uso_stalkeo us 
group by us.producto ;
### Explicación:
Esta vista nos muestra si el encuestado considera moralmente correcto "stalkear" a una persona para la venta de productos.
### Código 3:
create view vista_7_3 as
select count(escuela) as escuela 
from uso_stalkeo us 
group by us.escuela ;
### Explicación:
Esta vista nos muestra si el encuestado considera moralmente correcto "stalkear" a una persona para la admisión de esta a una institución.
### Código 4:
create view vista_7_4 as
select count(persona) as persona 
from uso_stalkeo us 
group by us.producto ;
### Explicación:
Esta vista nos muestra si el encuestado considera moralmente correcto "stalkear" a una persona.
### Código 5:
create view vista_7_5 as
select count(nunca) as nunca 
from uso_stalkeo us 
group by us.nunca ;
### Explicación:
Esta vista nos muestra si el encuestado considera moralmente incorrecto "stalkear" a una persona.
### Respuesta a...
Estas vistas son una respuesta hacia la moralidad del uso de redes sociales y la información pública que ahí se encuentra.
