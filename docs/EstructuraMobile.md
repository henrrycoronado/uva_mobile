└── 📁lib
    ├── 📁core                     # Código compartido, configuraciones y utilidades globales
    │   ├── 📁network              # Envoltorios (wrappers) manuales del paquete HTTP nativo de Dart, interceptores y manejo de JWT
    │   ├── 📁local_storage        # Configuración e inicialización de Hive CE (esquemas y cajas/boxes)
    │   ├── 📁hardware             # Interfaces o servicios base para sensores (ej. chequeos de permisos nativos generales)
    │   ├── 📁theme                # Colores, tipografías (Material 3) y estilos globales
    │   ├── 📁routing              # Configuración de rutas (ej. GoRouter si lo usas) y nombres de pantallas
    │   └── 📁utils                # Constantes, extensiones, parseadores de fechas
    │
    ├── 📁features                 # Cada feature tiene su propio mini-universo (MVVM + Clean)
    │   │
    │   ├── 📁auth                 # Módulo de Autenticación
    │   │   ├── 📁models           # Clases puras (User, SessionToken) con métodos fromJson/toJson
    │   │   ├── 📁repositories     # Lógica de persistencia (Llamadas HTTP a la API y guardado en Hive)
    │   │   ├── 📁viewmodels       # Riverpod Providers que manejan el estado reactivo del login (AsyncValue)
    │   │   └── 📁views            # Vistas puras (LoginScreen) y widgets específicos de autenticación
    │   │
    │   ├── 📁activities           # Módulo de Exploración y Gestión de Actividades
    │   │   ├── 📁models           # Entidades de actividad, horarios y cupos
    │   │   ├── 📁repositories     # Lógica para obtener el feed de actividades
    │   │   ├── 📁viewmodels       # Controladores de estado (lista de actividades, filtros)
    │   │   └── 📁views            # ActivityListScreen, ActivityDetailScreen
    │   │
    │   ├── 📁attendance           # Módulo de Asistencia (Escáner QR)
    │   │   ├── 📁models           # Entidad del Check-in / Check-out
    │   │   ├── 📁repositories     # Llamada a la API para registrar el QR leído
    │   │   ├── 📁viewmodels       # Provider que orquesta la lectura, pausa del escáner y resultado
    │   │   └── 📁views            # QrScannerScreen (Implementación del widget de mobile_scanner)
    │   │
    │   ├── 📁location             # Módulo GIS y Geocercas
    │   │   ├── 📁models           # Coordenadas, zonas permitidas
    │   │   ├── 📁repositories     # Servicios que abstraen geolocator (LocationRepository)
    │   │   ├── 📁viewmodels       # Providers que emiten la ubicación en tiempo real o validan si está en la zona
    │   │   └── 📁views            # MapScreen (Implementación de flutter_map consumiendo los tiles de OSM)
    │   │
    │   └── 📁evidence             # Módulo de subida de reportes/fotos
    │       ├── 📁models           # Entidad del reporte/foto
    │       ├── 📁repositories     # Servicio que sube el binario hacia el endpoint de la API
    │       ├── 📁viewmodels       # Controlador que orquesta la selección y progreso de subida
    │       └── 📁views            # Formularios que implementan image_picker para acceder a cámara/galería
    │
    ├── app.dart                   # Widget principal de la aplicación (MaterialApp, config de tema, Riverpod ProviderScope)
    └── main.dart                  # Punto de entrada. Inicializa Hive CE, variables de entorno (.env) y lanza runApp()