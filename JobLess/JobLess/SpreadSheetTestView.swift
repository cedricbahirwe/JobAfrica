//
//  SpreadSheetTestView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 16/05/2023.
//

import SwiftUI

struct SpreadSheetTestView: View {
    @StateObject private var sheetStore = GoogleSheetsAPI()
    var body: some View {
        VStack(spacing: 20) {
        
            Button("Google Sign In") {
                sheetStore.googleSignIn()
            }
            .foregroundColor(sheetStore.signInState ? .green : .red)
            
            if sheetStore.signInState {
                Button("Initalize Services") {
                    sheetStore.initializeActivities()
                }
                .foregroundColor(sheetStore.servicesOn ? .green : .red)
                
                if sheetStore.servicesOn {
                    Button("Append Data") {
                        sheetStore.createJob(.customerService)
                    }
                    .foregroundColor(sheetStore.appendOn ? .green : .red)
                    
                    Button("Read Data") {
                        sheetStore.getJobs()
                    }
                    .foregroundColor(sheetStore.readOn ? .green : .red)
                    
                    
                    Button("Update Data") {
                        sheetStore.updateJob(.customerService)
                    }
                    .foregroundColor(sheetStore.sendOn ? .green : .red)
                    
                }
            }
        }
    }
}

struct SpreadSheetTestView_Previews: PreviewProvider {
    static var previews: some View {
        SpreadSheetTestView()
    }
}
