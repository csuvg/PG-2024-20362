# Instrucciones de Instalación

## Requisitos Previos

#### EstimoteUWB
- **SwiftUI**: Para construir la interfaz de usuario.
- **EstimoteUWB**: Para implementar las funcionalidades de Ultra-Wideband (UWB).
#### BLEDistance
- **SwiftUI**: Para construir la interfaz de usuario.
- **CoreBluetooth**: Para funcionalidades de Bluetooth.
#### Arduino
- **BLEDevice**: Proporciona la funcionalidad principal para trabajar con dispositivos BLE.
- **BLEUtils**: Incluye utilidades y herramientas para manejar conexiones y datos BLE.
- **BLEServer**: Permite configurar y gestionar un servidor BLE.

## Comandos para instalar el proyecto

### EstimoteUWB

#### Requisitos Previos

1. **Instalar Git**  
   Asegúrate de tener Git instalado en tu sistema. Verifica su instalación con:  
   ```bash
   git --version
   ```
   Si no está instalado, descárgalo de [git-scm.com](https://git-scm.com).

2. **Instalar Xcode**  
   Descarga e instala Xcode desde la Mac App Store. Asegúrate de que esté actualizado a la última versión compatible con tu sistema operativo.

#### Pasos para Abrir el Proyecto

#### 1. Clonar el Repositorio
Abre tu terminal y clona el repositorio en tu máquina local con el siguiente comando:  
```bash
git clone https://github.com/csuvg/PG-2024-20362.git
```

#### 2. Navegar al Directorio del Proyecto
Cambia al directorio donde se clonó el repositorio:  
```bash
cd PG-2024-20362/src/EstimoteUWB
```
#### 3. Ubicar el Archivo del Proyecto
Dentro de la carpeta del repositorio, busca el archivo con extensión `.xcodeproj` o `.xcworkspace`. Este archivo es necesario para abrir el proyecto en Xcode.

#### 4. Abrir el Proyecto en Xcode

1. Abre Xcode desde el Dock o el Launchpad.
2. En la barra de menú, selecciona **File > Open**.
3. Navega al directorio donde se encuentra el archivo `.xcodeproj` o `.xcworkspace`.
4. Selecciona el archivo y haz clic en **Open**.

#### 5. Ejecutar el Proyecto
1. Una vez que el proyecto esté abierto en Xcode, selecciona un dispositivo o simulador en la barra superior.
2. Haz clic en el botón **Run** (⏵) para compilar y ejecutar el proyecto.



### BLEDistance

1. **Instalar Git**  
   Asegúrate de tener Git instalado en tu sistema. Verifica su instalación con:  
   ```bash
   git --version
   ```
   Si no está instalado, descárgalo de [git-scm.com](https://git-scm.com).

2. **Instalar Xcode**  
   Descarga e instala Xcode desde la Mac App Store. Asegúrate de que esté actualizado a la última versión compatible con tu sistema operativo.

#### Pasos para Abrir el Proyecto

#### 1. Clonar el Repositorio
Abre tu terminal y clona el repositorio en tu máquina local con el siguiente comando:  
```bash
git clone https://github.com/csuvg/PG-2024-20362.git
```

#### 2. Navegar al Directorio del Proyecto
Cambia al directorio donde se clonó el repositorio:  
```bash
cd PG-2024-20362/src/BLEDistance
```
#### 3. Ubicar el Archivo del Proyecto
Dentro de la carpeta del repositorio, busca el archivo con extensión `.xcodeproj` o `.xcworkspace`. Este archivo es necesario para abrir el proyecto en Xcode.

#### 4. Abrir el Proyecto en Xcode

1. Abre Xcode desde el Dock o el Launchpad.
2. En la barra de menú, selecciona **File > Open**.
3. Navega al directorio donde se encuentra el archivo `.xcodeproj` o `.xcworkspace`.
4. Selecciona el archivo y haz clic en **Open**.

### Arduino


#### Requisitos Previos

1. **Hardware Necesario**
   - Un ESP32 
   - Cable USB para conectar el ESP32 a tu computadora.

2. **Software Necesario**
   - Arduino IDE. Puedes descargarlo desde [arduino.cc](https://www.arduino.cc/en/software)
   - Controlador USB para tu ESP32 (si es necesario).

3. **Configurar el ESP32 en Arduino IDE**
   Si es la primera vez que usas un ESP32 en Arduino IDE, sigue estos pasos para agregar soporte:

   - Abre Arduino IDE y ve a **File > Preferences**.
   - En el campo "Additional Board Manager URLs", agrega la siguiente URL:
     ```
     https://dl.espressif.com/dl/package_esp32_index.json
     ```
   - Ve a **Tools > Board > Boards Manager**, busca "esp32" e instala el paquete "esp32 by Espressif Systems".

#### 1. Clonar el Repositorio

Abre tu terminal y clona el repositorio en tu máquina local con el siguiente comando:  
```bash
git clone https://github.com/csuvg/PG-2024-20362.git
```
#### 2. Navegar al Directorio del Proyecto
Cambia al directorio donde se clonó el repositorio:  
```bash
cd PG-2024-20362/src/Arduino
```

#### 3. Abrir el Proyecto en Arduino IDE
1. Abre Arduino IDE.
2. Ve a **File > Open** y selecciona el archivo `.c++` en la carpeta clonada.


#### 4. Seleccionar la Placa y el Puerto
1. Ve a **Tools > Board > ESP32 Arduino** y selecciona tu modelo de ESP32 (por ejemplo, "ESP32 Dev Module").
2. Ve a **Tools > Port** y selecciona el puerto COM donde está conectado tu ESP32.

#### 5. Instalar las Bibliotecas Necesarias
Si no tienes las bibliotecas `BLEDevice`, `BLEUtils` y `BLEServer`, instálalas siguiendo estos pasos:
1. Ve a **Sketch > Include Library > Manage Libraries**.
2. Busca "ESP32 BLE Arduino" e instala la biblioteca desarrollada por "nkolban" o "Neil Kolban".

#### 6. Cargar el Código en el ESP32
1. Conecta el ESP32 a tu computadora mediante un cable USB.
2. Haz clic en el botón **Upload** (la flecha hacia la derecha) en Arduino IDE.
3. Si aparece un error de sincronización, mantén presionado el botón **BOOT** en tu ESP32 mientras se carga el código.

#### 7. Verificar el Funcionamiento
1. Abre el Monitor Serial en Arduino IDE (**Tools > Serial Monitor**) y establece la velocidad en baudios a `115200`.
2. Deberías ver el mensaje:
   ```
   Beacon started!
   ```
3. Usa una aplicación como "nRF Connect" en tu teléfono para escanear dispositivos BLE cercanos y verifica que el beacon "ESP32_Beacon" está visible.

## Ejecución de la aplicación

### BLEDistance
1. Una vez que el proyecto esté abierto en Xcode, selecciona un dispositivo o simulador en la barra superior.
2. Haz clic en el botón **Run** (⏵) para compilar y ejecutar el proyecto.
### EstimoteUWBS
1. Una vez que el proyecto esté abierto en Xcode, selecciona un dispositivo o simulador en la barra superior.
2. Haz clic en el botón **Run** (⏵) para compilar y ejecutar el proyecto.

