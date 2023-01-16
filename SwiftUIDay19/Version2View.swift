//
//  ContentView.swift
//  SwiftUIDay19
//
//  Created by Fatih Durmaz on 16.01.2023.
//

import SwiftUI

struct Version2View: View {
    @State private var deger = 10.0
    @State private var girisBirimi = UnitLength.meters
    @State private var cikisBirimi = UnitLength.kilometers
    @FocusState private var klavyeGizle: Bool
    
    let formatter: MeasurementFormatter
    
    let birimler : [UnitLength] = [.feet, .kilometers, .meters, .miles, .yards]
    
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
                    Picker("Giriş Birimi Seçiniz", selection: $girisBirimi) {
                        ForEach(birimler, id: \.self){
                            Text(formatter.string(from: $0).capitalized)
                        }
                    }
                    
                    Picker("Çıkış Birimi Seçiniz", selection: $cikisBirimi) {
                        ForEach(birimler, id: \.self){
                            Text(formatter.string(from: $0).capitalized)
                        }
                    }
                }
                Section{
                    Text(sonuc).bold()
                } header: {
                    Text("Sonuç")
                }
            }
            .navigationTitle("Birim Çevirici v2")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Tamam") {
                        klavyeGizle = false
                    }
                }
            }
        }
    }
    
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
}

struct Version2View_Previews: PreviewProvider {
    static var previews: some View {
        Version2View()
    }
}

