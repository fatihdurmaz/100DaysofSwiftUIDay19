//
//  ContentView.swift
//  SwiftUIDay19
//
//  Created by Fatih Durmaz on 16.01.2023.
//

import SwiftUI

struct Version3View: View {
    @State private var deger = 100.0
    @State private var girisBirimi : Dimension = UnitLength.meters
    @State private var cikisBirimi : Dimension = UnitLength.kilometers
    @FocusState private var klavyeGizle: Bool
    
    @State var secilenBirim = 0
    
    let ceviriciler = ["Uzaklık", "Ağırlık", "Sıcaklık", "Zaman"]
    
    let formatter: MeasurementFormatter
    
    let birimler = [
        [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles],
        [UnitMass.grams, UnitMass.kilograms, UnitMass.ounces, UnitMass.pounds],
        [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin],
        [UnitDuration.hours, UnitDuration.minutes, UnitDuration.seconds]

    ]
    var sonuc: String {
        let girisBirimTuru = Measurement(value: deger, unit: girisBirimi)
        let cikisBirimTuru = girisBirimTuru.converted(to: cikisBirimi)
        return formatter.string(from: cikisBirimTuru)
    }
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Değer Giriniz", value: $deger, format:.number)
                        .keyboardType(.decimalPad)
                        .focused($klavyeGizle)
                } header: {
                    Text("Girilen Değer")
                }
                Section{
                    Picker("Ölçü Birimi", selection: $secilenBirim) {
                        ForEach(0..<ceviriciler.count, id: \.self) {
                            Text(ceviriciler[$0])
                        }
                    }
                    
                    Picker("Giriş Birimi Seçiniz", selection: $girisBirimi) {
                        ForEach(birimler[secilenBirim], id: \.self) {
                            Text(formatter.string(from: $0).capitalized)
                        }
                        // ceviriciler dizisinin indis numarasına göre birimler dizisinin elemanlarını pickerlarda gösteriyoruz.
                    }
                    
                    Picker("Çıkış Birimi Seçiniz", selection: $cikisBirimi) {
                        ForEach(birimler[secilenBirim], id: \.self) {
                            Text(formatter.string(from: $0).capitalized)
                        }
                        // çeviriciler dizisinin indis numarasına göre birimler dizisinin elemanlarını pickerlarda gösteriyoruz.
                    }
                }
                Section{
                    Text(sonuc).bold()
                } header: {
                    Text("Sonuç")
                }
            }
            .navigationTitle("Birim Çevirici v3")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Tamam") {
                        klavyeGizle = false
                    }
                }
            }
            .onChange(of: secilenBirim) { newSelection in
                let birim = birimler[newSelection]
                girisBirimi = birim[0]
                cikisBirimi = birim[1]
                // ölçü birimi her değiştiğinde pickerları ilgili birimin 1. ve 2. elemanları ile dolduruyoruz.
                
            }
        }
    }
    
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
}

struct Version3View_Previews: PreviewProvider {
    static var previews: some View {
        Version3View()
    }
}


