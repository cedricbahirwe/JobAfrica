//
//  SubmitterView.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 12/09/2022.
//

import SwiftUI

struct SubmitterView: View {
    @State private var jobName = ""
    @State private var jobLink = ""
    @State private var jobDescription = ""
    @State private var jobLocation = ""

    @State private var companies: [JobCompany] = []
    @State private var selectedCompany: JobCompany?
    @State private var selectedType: JobType = .fullTime
    @State private var selectedCategory: JobCategory = .onsite
    @State private var selectedTags: [JobTag] = [.all]
    @State private var jobTags: [JobTag] = JobTag.allCases
    @State private var selectedSkills: [JobSkill] = []
    @State private var jobEditedSkill = ""
    @State private var jobEmail = ""
    @State private var jobWhatsapp = ""
    @State private var jobTelegram = ""

    @StateObject private var submitter = Submitter()
    var body: some View {
        ZStack {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    sectionOne
                    Divider()

                    Group {
                        HStack {
                            Text("Job Type:")
                            Picker("",
                                        selection: $selectedType) {
                                ForEach(JobType.allCases.reversed(), id:\.rawValue) { type in
                                    Text(type.rawValue.capitalized)
                                        .tag(type)
                                }
                            }
                        }
                        Divider()
                        HStack {
                            Text("Job Category:")
                            Picker("",
                                        selection: $selectedCategory) {
                                ForEach(JobCategory.allCases, id:\.rawValue) { category in
                                    Text(category.rawValue.capitalized)
                                        .tag(category)
                                }
                            }
                        }
                        Divider()
                        VStack(alignment: .leading) {
                            Text("Job Tags:")
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(JobTag.allCases, id:\.rawValue) { tag in
                                        let isSelected = selectedTags.contains(tag)
                                        Text(tag.formatted)
                                            .padding(10)
                                            .background(isSelected ? Color.main : Color.secondary)
                                            .foregroundColor(.white)
                                            .cornerRadius(14)
                                            .onTapGesture {
                                                if let index = selectedTags.firstIndex(of: tag) {
                                                    selectedTags.remove(at: index)
                                                } else {
                                                    selectedTags.append(tag)
                                                }
                                            }
                                    }
                                }
                            }
                        }
                        Divider()
                        VStack(alignment: .leading) {
                            Text("Job Skills:")

                            HStack {
                                TextField("e.g: MS Office", text: $jobEditedSkill)
                                Button {
                                    guard !jobEditedSkill.isEmpty else { return }
                                    guard !selectedSkills.map(\.name)
                                        .contains(where: { skill in
                                            return skill.lowercased() == jobEditedSkill.lowercased()
                                        }) else { return }

                                    selectedSkills.append(.init(jobEditedSkill))
                                    jobEditedSkill = ""
                                } label: {
                                    Image(systemName: "plus.circle.fill")
                                        .imageScale(.large)
                                        .foregroundColor(.main)
                                }
                            }

                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(selectedSkills, id:\.self) { skill in
                                        HStack {
                                            Text(skill.name)

                                            Image(systemName: "xmark")
                                                .imageScale(.large)
                                                .onTapGesture  {
                                                    let index = selectedSkills.firstIndex(of: skill)!
                                                    selectedSkills.remove(at: index)
                                                }
                                        }
                                        .padding(10)
                                        .background(Color.main)
                                        .cornerRadius(14)
                                        .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                        Divider()
                        VStack(alignment: .leading) {
                            Text("Job Contacts:")
                            HStack {
                                Text("Email :")
                                TextField("contact@gmai.com", text: $jobEmail)
                            }
                            HStack {
                                Text("Whatsapp Number:")
                                TextField("+256 700 000 000", text: $jobWhatsapp)
                            }
                            HStack {
                                Text("Telegram:")
                                TextField("@jobcontact", text: $jobTelegram)
                            }
                        }
                    }
                }
                .padding()
            }


            Button(action: submit) {
                Text("Submit")
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.main)
                    .cornerRadius(15)
            }
            .padding(.horizontal)
        }

            if submitter.isLoading {
                Color.black.opacity(0.6).ignoresSafeArea()
                VStack {
                    ProgressView()
                    Text("Loading")
                }
            }
        }
        .onAppear() {
            initialize()
        }
    }

    private func initialize() {
        submitter.loadCompanies { self.companies = $0 }

        submitter.loadJobs {
            print("Jobs", $0)
        }
//        submitter.loadTags {
//            print("Tags", $0)
//        }
//
//        submitter.loadCategories {
//            print("Categories", $0)
//        }
//
//        submitter.loadTypes {
//            print("Types", $0)
//        }
    }

    private func submit() {
        guard !jobName.isEmpty,
              !jobName.description.isEmpty
        else { return }

        guard let selectedCompany = selectedCompany else { return }
        guard let jobURL = URL(string: jobLink) else { return }

        let newJob = JobModel(title: jobName,
                              postDate: Date(),
                              jobLink: jobURL,
                              description: .init(paragraphs: [
                                .init(head: nil, body: jobDescription)]),
                              company: selectedCompany,
                              type: selectedType,
                              category: selectedCategory,
                              location: jobLocation,
                              tags: selectedTags,
                              skills: selectedSkills)

        submitter.saveJob(newJob)

    }
}

#if DEBUG
struct SubmitterView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitterView()
    }
}
#endif

extension SubmitterView {
    var sectionOne: some View {
        Group {
            VStack(alignment: .leading) {
                Text("Job Title:")
                TextField("e.g: Engineer", text: $jobName)
            }
            Divider()
            VStack(alignment: .leading) {
                Text("Job Link:")
                TextField("e.g: www.example.com", text: $jobLink)
            }

            Divider()

            VStack(alignment: .leading) {
                Text("Job Description:")
                TextEditor(text: $jobDescription)
                    .border(.black)
                    .frame(minHeight: 80)
            }
            Divider()

            VStack(alignment: .leading) {
                Text("Job Location:")
                TextField("e.g: Nairobi, Kenya", text: $jobLocation)
            }

            Divider()

            VStack(alignment: .leading) {
                HStack {
                    Text("Job Company:")
                    if let selectedCompany = selectedCompany {
                        Text(selectedCompany.name)
                            .foregroundColor(.main)
                    }
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                        .foregroundColor(.main)
                }

                if companies.isEmpty {

                } else {
                    Picker("Choose",
                           selection: Binding(get: {
                        if let selectedCompany = selectedCompany {
                            return selectedCompany
                        } else {
                            DispatchQueue.main.async {
                                selectedCompany = companies.first
                            }
                            return selectedCompany  ?? .init(name: "", location: "")
                        }

                    }, set: {
                        selectedCompany = $0
                    })) {
                        ForEach(companies, id:\.self) { company in
                            Text(company.name)
                                .tag(company)
                        }
                    }
//                    Text("Choose")
//                        .foregroundColor(.white)
//                        .padding(10)
//                        .background(Color.main)
//                        .cornerRadius(10)
//                        .contextMenu {
//                            ForEach(companies, id:\.self) { company in
//                                Button {
//                                    selectedCompany = company
//                                } label: {
//                                    Text(company.name)
//                                }
//                            }
//                        }
                }
            }
        }
    }
}
