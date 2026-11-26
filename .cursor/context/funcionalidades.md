# Funcionalidades

App Flutter (`flutter_universities_app`). El nombre del proyecto no añade pantallas ni datos: hoy solo existe el demo de contador que genera Flutter.

## Contador

Única pantalla, en `lib/main.dart`.

- Arranca en 0.
- El botón `+` (`FloatingActionButton`, icono `Icons.add`) suma 1.
- El número vive en el estado local de `MyHomePage` (`setState`). No hay almacenamiento, red ni navegación.
- Título de la página: `Flutter Demo Home Page`.
- Tema Material 3 con `ColorScheme.fromSeed(seedColor: Colors.deepPurple)`.

La prueba `test/widget_test.dart` comprueba que el contador pasa de 0 a 1 al pulsar `+`.

## Plataformas

Android, iOS y web. No hay carpetas de escritorio.

## Qué no hay

No hay listado de universidades, búsqueda, detalle, autenticación ni capa de datos. Si no aparece en este archivo, no está implementado.
