//
//  JobHelper.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 17/05/2023.
//

import Foundation


enum JobHelper {
    static func getValues(from job: Job) -> [String] {
        extractValues(job)
    }
    
    private static func extractValues(_ anyValue: Any) -> [String] {
        var allValues = [String]()
        let propertiesValues = Mirror(reflecting: anyValue).children.compactMap { $0.value }
        
        propertiesValues.forEach {
            let mirrorDisplay = Mirror(reflecting: $0).displayStyle
            
            if let date = $0 as? Date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "M/d/yyyy, h:mm a"
                allValues.append(dateFormatter.string(from: date))
            } else if let url = $0 as? URL {
                allValues.append(url.absoluteString)
            } else if mirrorDisplay == .struct {
                allValues.append(contentsOf: extractValues($0))
            } else if mirrorDisplay == .optional, !($0 is CustomStringConvertible) {
                allValues.append("")
            }else if mirrorDisplay == .collection, let arr = $0 as? (any Collection) {
                if let rawArray = arr as? [any RawRepresentable] {
                    let stringValues = rawArray.compactMap { $0.rawValue as? String }.joined(separator: ", ")
                    allValues.append(stringValues)
                    
                } else {
                    allValues.append(contentsOf: extractValues($0))
                }
            } else if mirrorDisplay == .enum, let enumValue = ($0 as? (any RawRepresentable))?.rawValue as? String {
                allValues.append(enumValue)
            } else if let stringable = $0 as? CustomStringConvertible {
                allValues.append(stringable.description)
            } else {
                fatalError("Could not decode \($0) with mirrow \(String(describing: mirrorDisplay))")
            }
        }
        
        return allValues
    }
    
    private static func nilIfEmpty(_ value: String) -> String? {
        value.isEmpty ? nil : value
    }
    
    static func getJob(from values: [String]) -> Job? {
        guard values.count == 18 else {
            return nil
        }
        
        guard let jobLink = URL(string: values[3]) else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yyyy, h:mm a"
        
        let id = values[0]
        let title = values[1]
        let postDate = dateFormatter.date(from: values[2]) ?? Date()
        
        let description = values[4]
        
        let companyName = values[5]
        let companyDescription = nilIfEmpty(values[6])
        let companyLogoURL = URL(string: values[7])
        let companyLocation = values[8]
        let companyWebsite = URL(string: values[9])
        let company = JobCompany(name: companyName,
                                 description: companyDescription,
                                 logoURL: companyLogoURL,
                                 location: companyLocation,
                                 website: companyWebsite)
        
        let type = JobType(rawValue: values[10]) ?? .other
        let category = JobCategory(rawValue: values[11]) ?? .other
        let location = values[12]
        
        let contactEmail = nilIfEmpty(values[13])
        let contactWhatsapp = nilIfEmpty(values[14])
        let contact = JobContact(email: contactEmail, whatsapp: contactWhatsapp)
        
        let tags = values[15].components(separatedBy: ", ").map { JobTag(rawValue: $0) ?? .other }
        let skills = values[16].components(separatedBy: ", ").map { JobSkill($0) }
        let views = Int(values[17]) ?? 0
        
        
        return Job(id: id, title: title, postDate: postDate, jobLink: jobLink, description: description, company: company, type: type, category: category, location: location, contact: contact, tags: tags, skills: skills, views: views)
    }
}
