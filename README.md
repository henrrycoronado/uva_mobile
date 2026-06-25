# Uvoluntapp Mobile

La aplicación móvil oficial de Uvoluntapp construida con Flutter.

## 🏛️ Arquitectura y Contexto Actual

- **Gestión de Estado**: Utilizamos Riverpod (`riverpod_annotation`, `flutter_riverpod`) para todo el estado de la aplicación.
- **Enrutamiento**: Se usa `go_router` para la navegación entre pantallas.
- **Design System**: **TODA** la interfaz de usuario (componentes visuales, tarjetas, formularios, temas, colores y modelos compartidos) ha sido extraída a un repositorio independiente llamado `uva_design_system`. Esta aplicación lo consume de manera remota. 
  - *Regla principal:* Los widgets en esta aplicación solo deben actuar como "Conectores" o "Pantallas" que unen el estado de Riverpod con los widgets visuales puros que provee el paquete de diseño.
- **Almacenamiento Local**: `hive_ce` para caché rápido y `flutter_secure_storage` para tokens de autenticación.

## 🚀 Cómo ejecutar el proyecto por primera vez

Sigue estos pasos cuidadosamente para levantar el proyecto desde cero:

### 1. Clonar e Instalar
```bash
git clone https://github.com/henrrycoronado/uva_mobile.git
cd uva_mobile
flutter pub get
```

### 2. Generar código automático
El proyecto depende fuertemente de la generación de código (Riverpod, Hive). Debes correr este comando obligatoriamente:
```bash
dart run build_runner build -d
```

### 3. Configurar Entorno
Crea un archivo `.env` en la raíz del proyecto (junto a `pubspec.yaml`) y configura tus variables, por ejemplo:
```env
API_BASE_URL=https://tu-api.com/api/v1
```

### 4. Ejecutar la App
Asegúrate de tener un emulador abierto o un dispositivo conectado y corre:
```bash
flutter run
```
*(Para aplicar cambios en caliente durante el desarrollo presiona `r`, y para reiniciar completamente el estado presiona `R`).*