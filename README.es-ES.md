

<h1 align="center">
  <!-- <br>
  <img alt="logo" src="https://raw.githubusercontent.com/abehidek/abehidek/main/assets/logo%203%20inverted.svg" width="150px" />
  <br> -->
  hidek.xyz
  <br>
</h1>

<h4 align="center">Mi sitio web personal</h4>

<p align="center">
  <img alt="RSS" src="https://img.shields.io/badge/rss-F88900?style=for-the-badge&logo=rss&logoColor=white">
  <img alt="SQLite" src="https://img.shields.io/badge/sqlite-%2307405e.svg?style=for-the-badge&logo=sqlite&logoColor=white">
  <img alt="Elixir" src="https://img.shields.io/badge/elixir-%234B275F.svg?style=for-the-badge&logo=elixir&logoColor=white">
  <img alt="Rust" src="https://img.shields.io/badge/rust-%23000000.svg?style=for-the-badge&logo=rust&logoColor=white">
  <img alt="JavaScript" src="https://img.shields.io/badge/javascript-%23323330.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E">
  <img alt="Nix" src="https://img.shields.io/badge/NIX-5277C3.svg?style=for-the-badge&logo=NixOS&logoColor=white">
</p>

<p align="center">
  <!-- 
  <a href="#about">Acerca de</a> •
  <a href="#key-features">Características principales</a> •
  -->
  <a href="#getting-started">Primeros Pasos</a> •
  <a href="#roadmap">Hoja de ruta</a> •
  <a href="#license">Licencia</a>
</p>

![Captura(s) de pantalla del proyecto](https://raw.githubusercontent.com/abehidek/abehidek/main/assets/banner%20-%20x.png)

<!--
## Acerca de

Visión general simple del uso/propósito.
-->

<!--
## Características principales

- Característica 1
- Característica 2
  - Característica 2.1
  - Característica 2.2
- Característica 3
-->

## Primeros Pasos

### Requisitos previos

- Última versión de Elixir y Erlang
- Node.js versión > 18
- Cadena de herramientas Rust versión 2021 (estable) instalada

### Instalación y Ejecución

A continuación se muestra un ejemplo de cómo puedes indicar a tu audiencia cómo instalar y configurar tu aplicación. Esta plantilla no depende de ninguna dependencia o servicio externo.

```bash
# Clone this repository
$ git clone https://github.com/abehidek/hidek.xyz

# Go into the repository
$ cd hidek.xyz

# Setup developer environment
$ mix setup

# the command above will:
# - install all dependencies from Elixir/Rust/Node.js
# - prepare SQLite3 database
# - build assets
# - run migrations
# - seed database.

# Run the Phoenix server
$ mix phx.server
```

## Definiciones

- modo oscuro completo
- la misma fuente para todo
- contenido > características
- cada publicación es un artículo, que se define en la carpeta /content

## Ideas

### Características

- crear un sistema de diseño personal para todos mis proyectos secundarios (incluido este)
  - ¿penpot o quant-ux?
  - ¿similar a shadcn/ui pero para phx?
- implementar algunas medidas de seguridad (paraxial.io) para no permitir explorar la aplicación
- mdx o web-components dentro de los artículos de contenido
- usar turso como base de datos sqlite y cambiar el despliegue de fly.io a otra plataforma de alojamiento (para mayor velocidad)
- incrustar modelo 3D usando blender? y three.js
- ¿marcador de posición de imagen borrosa?
- usar rustler con funciones en rust para un mejor análisis de markdown
- usar rust para analizar MDX a HTML + JS
- convertir bóveda de obsidian en páginas
- pronunciación de hidek usando IPA (Alfabeto Fonético Internacional)
- música/películas/libros favoritos
- mi página de equipo/herramientas
- currículum: mi cv e historial laboral
- página para recibir criptomonedas
- impulso de señal (amigos y personas buscando trabajo)
- mis cosas autoalojadas
- página de proyectos
- libro de visitas
- componentes en vivo
  - en lo que estoy trabajando actualmente
  - lo que estoy escuchando
  - estado del servidor doméstico
  - estado del sitio web (número de req/s, commit, información de compilación y otras cosas de monitoreo)

### Contenido

- pensamiento de primeros principios
- pers rice y por qué deberíamos aspirar a la simplicidad
- futuro de livebook
- brillantez de los sistemas de impermanencia
- cosas de zfs?
- rss podría ser mejor, pero es lo mejor que tenemos hoy
- ¿estado de nostr?
- temas recomendados por pers para profundizar en la comprensión de la ciencia de la computación
- sobre código limpio y otras prácticas de la "industria"
- usando elixir para simplificar la infraestructura
- cosas de autoalojamiento
  - descargos de responsabilidad sobre el autoalojamiento
  - tunelización y cómo exponer correctamente tu servicio autoalojado
  - conceptos básicos de red para autoalojamiento
  - por qué deberías reemplazar el router de tu ISP
- ¡muestra tu trabajo!
- futuro de elixir en dx
- opiniones sobre economía/finanzas
- hacking de remarkable 2
- por qué los sistemas de tipos son importantes
- microservicios, nosql y etc...
- obsidian para gestión del conocimiento
- re: [correo electrónico vs capitalismo, o, Por qué no podemos tener cosas bonitas](https://www.youtube.com/watch?v=mrGfahzt-4Q&t=11s)

## Hoja de ruta

- [ ] contenido: por qué deberías usar nix
- [ ] característica: agregar componentes de liveview como me gusta, contador de visitas, presencia
  - [x] presencia
  - [x] contador de visitas
  - [ ] me gusta
- [x] característica: rss.xml generado automáticamente
- [x] característica: usar liveview para transición de página (suave)
  - [Improve UX With Liveview Page Transitions](https://alembic.com.au/blog/improve-ux-with-liveview-page-transitions)

## Contribuir

Si tienes una sugerencia que lo haría mejor, por favor haz un fork del repositorio y crea una solicitud de extracción (pull request). También puedes simplemente abrir un problema (issue) con la etiqueta "enhancement".
¡No olvides darle una estrella al proyecto! ¡Gracias de nuevo!

1. Haz un fork del proyecto
2. Clónalo y abre el repositorio en la línea de comandos
3. Crea tu rama de característica (`git checkout -b feature/amazing-feature`)
4. Confirma tus cambios (`git commit -m 'Agregar alguna característica increíble'`)
5. Empuja a la rama (`git push origin feature/amazing-feature`)
6. Abre una solicitud de extracción (pull request) desde tu rama de característica desde tu repositorio hacia la rama principal de este repositorio, y proporciona una descripción de tus cambios

## Licencia

```
Copyright (c) 2023 Guilherme Hidek Abe

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

> [hidek.xyz](https://hidek.xyz) &nbsp;&middot;&nbsp;
> GitHub [@abehidek](https://github.com/abehidek) &nbsp;&middot;&nbsp;
> Twitter [@guilhermehabe](https://twitter.com/guilhermehabe)
