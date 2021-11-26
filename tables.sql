create table frecuencia_uso(
	id_frecuencia_uso numeric(4) primary key,
	redes_sociales varchar(100) not null,
	compras_online varchar(100) not null,
	streaming varchar(100) not null
);
create table informacion_sensible(
	id_informacion_sensible numeric(4) primary key,
	nombre boolean not null,
	direccion boolean not null,
	telefono boolean not null,
	email boolean not null,
	redes_sociales boolean not null,
	info_bancaria boolean not null,
	info_preferencias boolean not null
);
create table tipo_compras(
	id_tipo_compras numeric(4) primary key,
	ropa boolean not null,
	despensa boolean not null,
	delivery boolean not null,
	suscripciones boolean not null,
	dispositivos_electronicos boolean not null,
	otros boolean not null
);
create table forma_pago(
	id_forma_pago numeric(4) primary key,
	credito boolean not null,
	debito boolean not null,
	prepago boolean not null,
	paypal boolean not null
);
create table sentimientos_post_uso(
	id_sentimientos_post_uso numeric(4) primary key,
	feliz boolean not null,
	triste boolean not null,
	enojado boolean not null,
	indiferente boolean not null,
	nostalgico boolean not null,
	celoso boolean not null,
	amenazado boolean not null
);
create table uso_stalkeo(
	id_uso_stalkeo numeric(4) primary key,
	escuela boolean not null,
	empleador boolean not null,
	producto boolean not null,
	persona boolean not null,
	nunca boolean not null
);
create table contenido_compartido( 
	id_contenido_compartido numeric(4) primary key,
	memes boolean not null,
	musica boolean not null,
	fotos boolean not null,
	ideas boolean not null,
	info_util boolean not null,
	nada boolean not null
);
create table redes_uso(
	id_redes_uso numeric(4) primary key,
	convencionales boolean not null,
	multimedia boolean not null,
	comunicacion boolean not null,
	citas boolean not null,
	penguin boolean not null,
	ninguna boolean not null
);
create table dispositivos(
	id_dispositivos numeric(4) primary key,
	laptop boolean not null,
	tablet boolean not null,
	celular boolean not null,
	computadora_escritorio boolean not null
);
create table confianza_paginas(
	id_confianza_paginas numeric(4) primary key,
	nombre varchar(100) not null,
	direccion varchar(100) not null,
	datos_bancarios varchar(100) not null,
	preferencias varchar(100) not null
);
create table encuestado (
	id_encuestado numeric(4) primary key,
	edad varchar(100) not null,
	licenciatura varchar(100) not null,
	genero varchar(100) not null,
	id_dispositivos numeric(4) references dispositivos(id_dispositivos),
	id_frecuencia_uso numeric(4) references frecuencia_uso(id_frecuencia_uso),
	valoracion_priv_ef varchar(100) not null,
	actitud_ciberseg varchar(100) not null,
	compras_en_linea varchar(100) not null
);
create table seguridad(
	id_seguridad numeric(4) primary key,
	id_encuestado numeric(4) references encuestado(id_encuestado),
	sentimiento_proteccion varchar(100) not null,
	conocimiento_ciberseg varchar(100) not null,
	conocimiento_vigilancia varchar(100) not null,
	conocimiento_leyes varchar(100) not null,
	id_informacion_sensible numeric(4) references informacion_sensible(id_informacion_sensible)
);
create table conclusion (
	id_conclusion numeric(4) primary key,
	id_encuestado numeric(4) references encuestado(id_encuestado),
	actitud_ciberseg varchar(100) not null,
	vigilancia varchar(100) not null,
	aprender_ciberseg varchar(100) not null
);
create table compras_online (
	id_compras_online numeric(4) primary key,
	id_encuestado numeric(4) references encuestado(id_encuestado),
	id_tipo_compras numeric(4) references tipo_compras(id_tipo_compras),
	compras_uso varchar(100) not null,
	frecuencia_compras varchar(100) not null,
	id_forma_pago numeric(4) references forma_pago(id_forma_pago),
	id_confianza_paginas numeric(4) references confianza_paginas(id_confianza_paginas),
	mayor_miedo varchar(100) not null,
	publicidad_personalizada varchar(100) not null
);

create table redes_sociales (
	id_red_social numeric(4) primary key,
	id_encuestado numeric(4) references encuestado(id_encuestado),
	id_redes_uso numeric(4) references redes_uso(id_redes_uso),
	tiempo_redes varchar(100) not null,
	razon_uso varchar(100) not null,
	id_contenido_compartido numeric(4) references contenido_compartido(id_contenido_compartido),
	perfiles_publicos varchar(100) not null,
	interaccion_desconocidos varchar(100) not null,
	acceso_desconocidos varchar(100) not null,
	herramientas_privacidad varchar(100) not null,
	servicios_personalizados varchar(100) not null,
	contenido_sin_vigilancia varchar(100) not null,
	contenido_observado varchar(100) not null,
	id_sentimientos_post_uso numeric(4) references sentimientos_post_uso(id_sentimientos_post_uso),
	impacto_redes_vida varchar(100) not null,
	id_uso_stalkeo numeric(4) references uso_stalkeo(id_uso_stalkeo),
	comparacion_redes varchar(100)
);
