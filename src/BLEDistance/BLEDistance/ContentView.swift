import SwiftUI
import CoreBluetooth

// Variables globales para almacenar las distancias
var d1: Double = 0
var d2: Double = 0
var d3: Double = 0

struct Beacon: Identifiable {
    let id = UUID()
    var info: String
    var distance: Double?
}

struct ContentView: View {
    @StateObject private var bleManager = BLEManager()
    
    var body: some View {
        VStack {
            Text("Beacon Scanner")
                .font(.largeTitle)
                .padding()
            if bleManager.beacons.isEmpty {
                Text("Buscando beacons...")
                    .font(.headline)
                    .padding()
            } else {
                List(bleManager.beacons) { beacon in
                    HStack {
                        Text(beacon.info)
                            .font(.headline)
                        if let distance = beacon.distance {
                            Text("Distancia: \(String(format: "%.2f", distance)) metros")
                                .font(.headline)
                        }
                    }
                }
            }
            // Mostrar coordenadas calculadas
            Text("Posición calculada: (X: \(String(format: "%.2f", bleManager.x)), Y: \(String(format: "%.2f", bleManager.y)))")
        }
        .onAppear {
            bleManager.startScanning()
        }
        .onDisappear {
            bleManager.stopScanning()
            bleManager.stopUpdating()
        }
    }
}

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    private var centralManager: CBCentralManager!
    private var discoveredPeripherals: [CBPeripheral] = []
    private let targetUUIDs: [CBUUID] = [
        CBUUID(string: "12345678-1234-1234-1234-123456789012"),
        CBUUID(string: "87654321-4321-4321-4321-210987654321"),
        CBUUID(string: "9abcdef0-1234-5678-9abc-def012345678")
    ]
    
    @Published var beacons: [Beacon] = []
    
    // Variables para almacenar la posición
    @Published var x: Float = 0.0
    @Published var y: Float = 0.0
    
    private var timer: Timer?
    
    private let A: Double = -52
    private let n: Double = 3.0
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func startScanning() {
        if centralManager.state == .poweredOn {
            centralManager.scanForPeripherals(withServices: targetUUIDs, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
        }
    }

    func stopScanning() {
        centralManager.stopScan()
    }

    func startUpdating() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.updateRSSI()
        }
    }

    func stopUpdating() {
        timer?.invalidate()
        timer = nil
    }

    func updateRSSI() {
        for peripheral in discoveredPeripherals {
            peripheral.readRSSI()
        }
    }
    
    func calculateDistance(rssi: NSNumber) -> Double {
        let rssiValue = rssi.doubleValue
        return pow(10, (A - rssiValue) / (10 * n))
    }
    
    func calculatePosition() {
        // Coordenadas de los sensores
        let sensor1 = (x: 0.0, y: 0.0)
        let sensor2 = (x: 0.0, y: 2.0)
        let sensor3 = (x: 1.0, y: 2.0)
        
        let d1 = Double(d1)
        let d2 = Double(d2)
        let d3 = Double(d3)
        
        let x1 = sensor1.x
        let y1 = sensor1.y
        let x2 = sensor2.x
        let y2 = sensor2.y
        let x3 = sensor3.x
        let y3 = sensor3.y
        
        let A = 2 * (x2 - x1)
        let B = 2 * (y2 - y1)
        let C = 2 * (x3 - x1)
        let D = 2 * (y3 - y1)
        
        let E = d1 * d1 - d2 * d2 - x1 * x1 + x2 * x2 - y1 * y1 + y2 * y2
        let F = d1 * d1 - d3 * d3 - x1 * x1 + x3 * x3 - y1 * y1 + y3 * y3
        
        // Resolver para x
        let denominatorX = A * D - B * C
        let numeratorX = E * D - B * F
        let x = denominatorX != 0 ? numeratorX / denominatorX : 0.0
        
        // Resolver para y
        let denominatorY = C * B - A * D
        let numeratorY = E * C - A * F
        let y = denominatorY != 0 ? numeratorY / denominatorY : 0.0
        
        // Actualizar coordenadas
        self.x = Float(x)
        self.y = Float(y)
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            startScanning()
        } else {
            print("Bluetooth no está activado o no está disponible.")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !discoveredPeripherals.contains(peripheral) {
            discoveredPeripherals.append(peripheral)
            let beaconInfo = "Dispositivo: \(peripheral.name ?? "Sin nombre"), RSSI: \(RSSI)"
            let distance = calculateDistance(rssi: RSSI)
            let newBeacon = Beacon(info: beaconInfo, distance: distance)
            beacons.append(newBeacon)
            centralManager.connect(peripheral, options: nil)
            startUpdating()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Conectado a \(peripheral.name ?? "Sin nombre")")
        peripheral.delegate = self
        peripheral.discoverServices(targetUUIDs)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("No se pudo conectar a \(peripheral.name ?? "Sin nombre"). Error: \(error?.localizedDescription ?? "desconocido")")
        // Intenta reconectar
        centralManager.connect(peripheral, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Desconectado de \(peripheral.name ?? "Sin nombre"). Intentando reconectar...")
        // Intenta reconectar al dispositivo
        centralManager.connect(peripheral, options: nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        if error == nil {
            if let index = discoveredPeripherals.firstIndex(of: peripheral) {
                let beaconInfo = "Dispositivo: \(peripheral.name ?? "Sin nombre"), RSSI: \(RSSI)"
                let distance = calculateDistance(rssi: RSSI)
                beacons[index] = Beacon(info: beaconInfo, distance: distance)
                
                // Actualizar distancias globales
                switch peripheral.name {
                case "ESP32_Beacon":
                    d1 = distance // Guardar la distancia en d1
                    print("Distancia d1 actualizada: \(d1) metros")
                case "ESP32_Beacon_2":
                    d2 = distance // Guardar la distancia en d2
                    print("Distancia d2 actualizada: \(d2) metros")
                case "ESP32_Beacon_3":
                    d3 = distance // Guardar la distancia en d3
                    print("Distancia d3 actualizada: \(d3) metros")
                default:
                    break // No hacer nada si no coincide
                }
                
                // Calcular posición después de actualizar distancias
                calculatePosition()
            }
        } else {
            print("Error al leer RSSI: \(error?.localizedDescription ?? "desconocido")")
        }
    }
}
