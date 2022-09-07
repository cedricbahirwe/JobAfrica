//
//  JobDetailView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI

struct JobDetailView: View {
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation {
                        isPresented.toggle()
                    }
                } label: {
                    Image(systemName: "x.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundColor(.primary)
                }
                Spacer()
            }
            VStack(spacing: 20) {
                Image("img7")
                    .resizable()
                    .frame(width: 150, height: 150)

                Text("Job Title")
                    .font(.system(.title, design: .rounded))

                Text("Job Location")
                    .font(.system(.title2, design: .monospaced))

                Text("Job Posted Date")
                    .font(.system(.callout))
                    .fontWeight(.semibold)
            }


            VStack(spacing: 20) {
                Text("Job Location")
                    .font(.system(.title2, design: .monospaced).weight(.semibold))

                Text("Local BH is hiring a Content Writer. If you want to join the Local BH family, apply now or send your resume to info@localbh.com.")
                    .font(.system(.title3))
                    .foregroundColor(.secondary)
            }
            .frame(maxHeight: .infinity)

            VStack(alignment: .leading, spacing: 20) {

                HStack {
                    Text("Email Address:").bold()

                    Text("info@localbh.com")
                }

                HStack {
                    Text("WhatsApp Number:").bold()

                    Text("info@localbh.com")
                }

//                    .font(.system(.title3))
//                    .foregroundColor(.secondary)

                Button {
                    //
                } label: {
                    Label("Apply Now", systemImage: "link")
                        .labelStyle(.titleOnly)
                        .font(.system(.body).weight(.bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(Color.main)
                        .cornerRadius(15)
                }
            }
            .frame(maxHeight: .infinity)
        }
        .padding()
        .background(Color(.secondarySystemBackground), ignoresSafeAreaEdges: .all)
    }
}

struct JobDetailView_Previews: PreviewProvider {
    static var previews: some View {
        JobDetailView(isPresented: .constant(true))
    }
}
