//
//  HomeView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 07/09/2022.
//

import SwiftUI
enum JobTags: String, Codable, CaseIterable {
    case all
    case mobile
    case iOS
    case android
    case web
    case backend
    case frontend

    var formatted: String {
        switch self {
        case .iOS:
            return "iOS"
        default:
            return rawValue.capitalized
        }
    }
}

struct ThemeToggle: View {
    init(_ sheme: Binding<ColorScheme?>) {
        _colorScheme = sheme

    }
    @Environment(\.colorScheme)
    private var activeScheme
    @Binding var colorScheme: ColorScheme?
    @State private var isDarkModeOn: Bool = false
    var body: some View {
        HStack {
            Label("Light Theme", systemImage: isDarkModeOn ?  "sun.max" : "sun.max.fill")
                .labelStyle(.iconOnly)
            Toggle("Theme Toggle", isOn: $isDarkModeOn)
                .labelsHidden()
                .scaleEffect(0.8)
                .tint(.main)
            Label("Dark Theme", systemImage: isDarkModeOn ? "moon.circle.fill" :  "moon.stars")
                .labelStyle(.iconOnly)
                .animation(.easeInOut, value: isDarkModeOn)
        }
        .onChange(of: isDarkModeOn) { colorScheme = $0 ? .dark : .light }
        .onAppear() {
            colorScheme = activeScheme
            isDarkModeOn = activeScheme == .dark
        }
    }
}
struct HomeView: View {
    @State private var colorScheme: ColorScheme? = nil
    @State var selectedJobTag: JobTags = JobTags.all
    @State var showDetailView = false

    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 20) {
                    Image(systemName: "line.3.horizontal.decrease")

                    Spacer()

                    Image(systemName: "magnifyingglass")

                    Image(systemName: "slider.horizontal.3")
                        .onTapGesture {
                            if colorScheme == .dark {
                                colorScheme = .light
                            } else {
                                colorScheme = .dark
                            }
                        }
                }
                .padding()

                VStack(alignment: .leading, spacing: 20) {
                    Text("Find the best job for you\n\(Text("in Africa 🌍").bold())")
                        .font(.system(.title, design: .rounded))
                        .layoutPriority(2)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0 ..< 10) { item in
                                VStack(alignment: .leading) {
                                    let img = item < 6 ? item+1 : 1
                                    HStack(spacing: 0) {
                                        Image("img\(img)")
                                            .resizable()
                                            .cornerRadius(5)
                                            .padding(4)
                                            .frame(width: 35, height: 35)
                                            .background(.ultraThickMaterial)
                                            .cornerRadius(10)

                                        Spacer()

                                        Text("Part time")
                                            .font(.caption)
                                            .lineLimit(1)
                                            .padding(4)
                                            .background(.background)
                                            .cornerRadius(4)
                                            .minimumScaleFactor(0.5)
                                    }

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Graphic Design")
                                            .fontWeight(.semibold)

                                        Text("Solid Design")
                                            .font(.system(.caption))
                                            .opacity(0.9)
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                    .foregroundColor(.white)
                                }
                                .padding(10)
                                .frame(width: 130, height: 130)
                                .background(Image("img1").resizable())
                                .cornerRadius(10)
                                .padding(6)
                                .background(item%2 == 0 ? Color.white : Color(.systemBackground))
                                .cornerRadius(10)
                            }
                        }
                    }

                    JobTagsView(JobTags.allCases, selection: $selectedJobTag)

                    ScrollView(.vertical, showsIndicators: false) {
                        Section {
                            ForEach(0 ..< 5) { item in
                                JobRowView()
                            }
                        } header: {
                            Text("Recently Posted")
                                .font(.title3)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }

                    }
                }

            }
            .padding(.horizontal)
            .background(Color(.secondarySystemBackground), ignoresSafeAreaEdges: .all)
        }
        .sheet(isPresented: $showDetailView) {
            JobDetailView(isPresented: $showDetailView)
        }
        .preferredColorScheme(colorScheme)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct JobTagsView: View {
    init(_ tags: [JobTags], selection: Binding<JobTags>) {
        self.tags = tags
        _selection = selection
    }

    private let tags: [JobTags]
    @Binding var selection: JobTags

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                ForEach(tags, id:\.rawValue) { tag in
                    Text(tag.formatted)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(selection == tag ? Color.white : Color.foreground)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(selection == tag ? Color.indigo : Color.primary)
                        .cornerRadius(8)
                        .onTapGesture {
                            withAnimation {
                                selection = tag
                            }
                        }
                }
            }
        }
    }
}

struct JobRowView: View {
    var body: some View {
        HStack {
            Image("img6")
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .clipped()
                .cornerRadius(8)


            VStack(alignment: .leading, spacing: 0) {
                Text("iOS Developer")
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.semibold)

                Spacer()

                Text("ABC Bank")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(1)

            Text("BHD - p/m")
                .font(.system(.caption, design: .rounded))
                .foregroundColor(.secondary)
        }
        .padding(10)
        .background(Color.foreground)
        .cornerRadius(10)
    }
}
