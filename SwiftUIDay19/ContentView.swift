//
//  ContentView.swift
//  SwiftUIDay19
//
//  Created by Fatih Durmaz on 16.01.2023.
//
// Diğer ekranlar için SwiftUIDay19App dosyasına bakın.
import SwiftUI

struct ContentView: View {
    @State private var deger = 100.0
    @State private var girisBirimi = "Metre"
    @State private var cikisBirimi = "Kilometre"
    @FocusState private var klavyeGizle: Bool
    
    let birimler = ["Fet", "Kilometre", "Metre", "Mil", "Yarda"]
    
    var sonuc: String {
        let girisCarpani: Double
        let cikisCarpani: Double
        
        switch girisBirimi {
        case "Fet":
            girisCarpani = 0.3048
        case "Kilometre":
            girisCarpani = 1000
        case "Mil":
            girisCarpani = 1609.34
        case "Yarda":
            girisCarpani = 0.9144
        default:
            girisCarpani = 1.0
        }
        
        switch cikisBirimi {
        case "Fet":
            cikisCarpani = 3.28084
        case "Kilometre":
            cikisCarpani = 0.001
        case "Mil":
            cikisCarpani = 0.000621371
        case "Yarda":
            cikisCarpani = 1.09361
        default:
            cikisCarpani = 1.0
        }
        
        let girilenOlcuBirimi = deger * girisCarpani
        let sonuc = girilenOlcuBirimi * cikisCarpani
        
        let sonucString = sonuc.formatted()
        return "\(sonucString) \(cikisBirimi.lowercased())"
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
                            Text($0)
                        }
                    }
                    
                    Picker("Çıkış Birimi Seçiniz", selection: $cikisBirimi) {
                        ForEach(birimler, id: \.self){
                            Text($0)
                        }
                    }
                }
                Section{
                    Text(sonuc).bold()
                } header: {
                    Text("Sonuç")
                }
            }
            .navigationTitle("Birim Çevirici v1")
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
