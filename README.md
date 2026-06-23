# Uvoluntapp - Mobile App (uva_mobile)
Este directorio contiene el código fuente de la aplicación móvil multiplataforma de Uvoluntapp, desarrollada con Flutter y Dart. La aplicación está diseñada para desplegarse en los sistemas operativos Android e iOS.

## Arquitectura y Tecnologías Principales
- Framework: Flutter (Channel stable).

- Gestión de Estado: Riverpod (con generación de código mediante riverpod_generator).

- Base de Datos Local: Hive CE (Community Edition, elegida para evitar conflictos de dependencias con generadores modernos).

- Mapas: flutter_map integrado con mosaicos abiertos de OpenStreetMap (100% Open Source).

- Geolocalización: geolocator para el consumo del chip GPS.

- Hardware multimedia: mobile_scanner para lectura de códigos QR e image_picker para la captura y selección de imágenes.

## Requisitos Previos y Configuración del Entorno
1. Variables de Entorno (.env)
La aplicación consume una API alojada en la nube. Por motivos de seguridad, las credenciales y URLs de producción están ignoradas en el control de versiones.

Localiza el archivo .env.example en la raíz de este directorio.

Crea una copia del archivo y renómbrala exactamente como .env.

Configura la variable API_URL con la dirección correspondiente de tu servidor de desarrollo o producción.

2. Configuración en Linux (Entorno de Desarrollo Principal)
Si desarrollas desde un sistema operativo basado en Linux (como Linux Mint/Ubuntu):

Asegúrate de tener instalado Android Studio y el SDK de Android actualizado.

Paso Crítico: Abre Android Studio, ve a Config > SDK Manager > SDK Tools e instala obligatoriamente el componente Android SDK Command-line Tools (latest).

Acepta las licencias del sistema ejecutando en la terminal:

Todos los comandos deben ejecutarse en la raíz del subdirectorio uva_mobile/.
```bash
flutter doctor --android-licenses
```

Instalar dependencias:
```bash
flutter pub get
```

Compilar y ejecutar en modo Debug (Dispositivo Android conectado/Emulador):
```bash
flutter run
```
Formatear el código automáticamente (Estándar de Dart):

```bash
dart format .
```

Analizar el código en busca de malas prácticas o errores de sintaxis:
```bash
flutter analyze
```

Generador de Código Activo (Indispensable para Riverpod y Hive CE): Dado que el proyecto utiliza metaprogramación para optimizar los Providers y adaptadores de base de datos, debes dejar este comando corriendo en una pestaña separada de la terminal mientras escribes código:
```bash
dart run build_runner watch --delete-conflicting-outputs
```

### Catálogo Visual de Componentes UI (Widgetbook)
El proyecto utiliza [Widgetbook](https://widgetbook.io/) como entorno aislado para construir y probar componentes UI (Dumb Components) de forma independiente a la lógica de negocio de la aplicación.

Para iniciar el catálogo visual de componentes:
```bash
flutter run -t lib/widgetbook.dart
```
```bash
flutter run -t lib/widgetbook.dart -d chrome
```
*(Se recomienda ejecutar este comando en un Emulador de Android o Simulador de iOS, ya que el proyecto no tiene soporte oficial para Web configurado).*

Para añadir nuevos componentes al catálogo, utiliza la anotación `@widgetbook.UseCase` sobre una función constructora de tu widget y vuelve a ejecutar el `build_runner`.

🛠️ Solución de Problemas Locales (Troubleshooting)
Error de Renderizado Gráfico (E/gralloc4 o pantallas en negro)
En ciertos dispositivos físicos (especialmente aquellos con capas de personalización como HiOS/XOS y procesadores MediaTek/Mali), el nuevo motor gráfico por defecto de Flutter (Impeller) puede presentar conflictos con los controladores de video al inicializar la cámara o los mapas, provocando bloqueos o cierres.
Solución: Forzar la ejecución del proyecto utilizando el motor gráfico clásico (Skia) con el siguiente comando:
```bash
flutter run --no-enable-impeller
```

Limpieza de caché por cambios nativos
Si se realizan modificaciones en los archivos AndroidManifest.xml o Info.plist (permisos de hardware) y el teléfono no los reconoce, ejecuta una limpieza profunda:
```bash
flutter clean
flutter pub get
flutter run
```

## Flujo de Trabajo para iOS (Desarrollo y Pruebas sin Hardware Mac)
Dado que las herramientas nativas de Apple (Xcode) no se pueden ejecutar de forma local en entornos Linux, se ha diseñado un flujo automatizado en la nube para compilar el ejecutable de iOS (.ipa) y probarlo en un iPhone físico.

### Paso 1: Compilación Automatizada (GitHub Actions)
El repositorio cuenta con una tubería de Integración Continua (CI) que se activa únicamente cuando se realiza un push o merge a la rama main.

Al subir los cambios a main, GitHub Actions levantará un entorno virtual con macos-latest.

El servidor inyectará el contenido cifrado del archivo .env (configurado de forma segura en los Secrets del repositorio bajo el nombre ENV_CONTENT).

Se compilará el proyecto en modo release sin firmar (flutter build ipa --no-codesign).

Al finalizar con éxito, ve a la pestaña Actions en la web de GitHub, selecciona la última ejecución y descarga el archivo comprimido dentro de la sección Artifacts.

### Paso 2: Instalación en el iPhone (Sideloadly + Máquina Virtual)
Para transferir el archivo .ipa descargado hacia tu iPhone desde un entorno Linux:

Inicia la máquina virtual integrada de Windows 10.

Asegúrate de mapear o activar el puente USB (USB Passthrough) en tu software de virtualización (VirtualBox/VMware) para que la máquina virtual reconozca los dispositivos físicos conectados a la laptop.

Conecta el iPhone mediante el cable USB a la computadora.

Abre el software Sideloadly dentro de la máquina virtual de Windows.

Arrastra el archivo .ipa descargado hacia Sideloadly.

Introduce tu Apple ID (se recomienda usar una cuenta secundaria gratuita de desarrollo) para generar la firma digital del certificado digital local.

Haz clic en Start. La aplicación se instalará directamente en el cajón de apps de tu iPhone.

⚠️ Nota Importante sobre iOS: Las aplicaciones instaladas mediante cuentas de Apple ID gratuitas tienen una vigencia de certificación de 7 días. Pasado este tiempo, la aplicación se cerrará al intentar abrirla. Para solucionarlo, simplemente vuelve a conectar el iPhone a la máquina virtual y repite el proceso de instalación con Sideloadly para renovar el contador por otra semana.