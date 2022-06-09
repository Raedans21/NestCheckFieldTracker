import Foundation
import SwiftUI

struct FieldSite: Identifiable, Codable, Equatable {
    let id: UUID
    var theme: Theme
    var name: String
    var dataEntries: [DataEntry]
    
    
    init(id: UUID = UUID(), name: String, dataEntries: [DataEntry]) {
        self.id = id
        self.theme = Theme.buttercup
        self.name = name
        self.dataEntries = dataEntries
    }
}

extension FieldSite {
    struct DataEntry: Identifiable, Codable, Equatable {
        let id: UUID
        var siteName: String
        var logDate: Date
        var nestHeight: Double
        var numberOfEggs: String
        var eggsIncubating: String
        var numberOfNestlings: String
        var cupStatus: String
        
        init(id: UUID = UUID(), siteName: String, logDate: Date, nestHeight: Double, numberOfEggs: String, eggsIncubating: String, numberOfNestlings: String, cupStatus: String) {
            self.id = id
            self.siteName = siteName
            self.logDate = logDate
            self.nestHeight = nestHeight
            self.numberOfEggs = numberOfEggs
            self.eggsIncubating = eggsIncubating
            self.numberOfNestlings = numberOfNestlings
            self.cupStatus = cupStatus
        }
        
        struct TempDataEntry {
            var siteName: String = ""
            var logDate: Date = Date.now
            var nestHeight: Double = 0
            var numberOfEggs: String = ""
            var eggsIncubating: String = ""
            var numberOfNestlings: String = ""
            var cupStatus: String = ""
        }

        var tempDataEntry: TempDataEntry {
            TempDataEntry(siteName: siteName, logDate: logDate, nestHeight: nestHeight, numberOfEggs: numberOfEggs, eggsIncubating: eggsIncubating, numberOfNestlings: numberOfNestlings, cupStatus: cupStatus)
        }
        
        mutating func update(from tempDataEntry: TempDataEntry) {
            siteName = tempDataEntry.siteName
            logDate = tempDataEntry.logDate
            nestHeight = tempDataEntry.nestHeight
            numberOfEggs = tempDataEntry.numberOfEggs
            eggsIncubating = tempDataEntry.eggsIncubating
            numberOfNestlings = tempDataEntry.numberOfNestlings
            cupStatus = tempDataEntry.cupStatus
        }
        
        init(tempDataEntry: TempDataEntry) {
            id = UUID()
            siteName = tempDataEntry.siteName
            logDate = tempDataEntry.logDate
            nestHeight = tempDataEntry.nestHeight
            numberOfEggs = tempDataEntry.numberOfEggs
            eggsIncubating = tempDataEntry.eggsIncubating
            numberOfNestlings = tempDataEntry.numberOfNestlings
            cupStatus = tempDataEntry.cupStatus
        }
    }

    struct TempSiteEntry {
        var name: String = ""
        var dataEntries: [DataEntry] = []
    }
    
    var tempSiteEntry: TempSiteEntry {
        TempSiteEntry(name: name, dataEntries: dataEntries)
    }
    
    mutating func update(from tempSiteEntry: TempSiteEntry) {
        name = tempSiteEntry.name
        dataEntries = tempSiteEntry.dataEntries
    }
    
    init(tempSiteEntry: TempSiteEntry) {
        id = UUID()
        theme = Theme.buttercup
        name = tempSiteEntry.name
        dataEntries = tempSiteEntry.dataEntries
    }
}

extension FieldSite {
    mutating func findAndRemove(dataEntries: [DataEntry], dataEntry: DataEntry) {
        if let pos = dataEntries.firstIndex(of: dataEntry) {
            self.dataEntries.remove(at: pos)
        }
    }
}

extension FieldSite {
    static let sampleDataEntries1: [DataEntry] =
    [
        DataEntry(siteName: "Box 5", logDate: Date.distantPast, nestHeight: 4, numberOfEggs: "0", eggsIncubating: "no", numberOfNestlings: "0", cupStatus: "Incomplete"),
        DataEntry(siteName: "Box 5", logDate: Date.distantPast, nestHeight: 5, numberOfEggs: "3", eggsIncubating: "no", numberOfNestlings: "0", cupStatus: "Elevated"),
        DataEntry(siteName: "Box 5", logDate: Date.now, nestHeight: 6, numberOfEggs: "3", eggsIncubating: "yes", numberOfNestlings: "0", cupStatus: "Elevated")
    ]
    
    static let sampleDataEntries2: [DataEntry] =
    [
        DataEntry(siteName: "Box 26", logDate: Date.distantPast, nestHeight: 1, numberOfEggs: "0", eggsIncubating: "no", numberOfNestlings: "0", cupStatus: "Incomplete"),
        DataEntry(siteName: "Box 26", logDate: Date.distantPast, nestHeight: 2, numberOfEggs: "0", eggsIncubating: "no", numberOfNestlings: "0", cupStatus: "Complete"),
        DataEntry(siteName: "Box 26", logDate: Date.distantPast, nestHeight: 4, numberOfEggs: "4", eggsIncubating: "no", numberOfNestlings: "0", cupStatus: "Elevated"),
        DataEntry(siteName: "Box 26", logDate: Date.now, nestHeight: 6, numberOfEggs: "4", eggsIncubating: "yes", numberOfNestlings: "0", cupStatus: "Elevated")
    ]
    
    static let sampleDataEntries3: [DataEntry] =
    [
        DataEntry(siteName: "Box 37", logDate: Date.distantPast, nestHeight: 1, numberOfEggs: "0", eggsIncubating: "no", numberOfNestlings: "0", cupStatus: "Incomplete"),
        DataEntry(siteName: "Box 37", logDate: Date.distantPast, nestHeight: 2, numberOfEggs: "3", eggsIncubating: "no", numberOfNestlings: "0", cupStatus: "Complete"),
        DataEntry(siteName: "Box 37", logDate: Date.distantPast, nestHeight: 3.5, numberOfEggs: "4", eggsIncubating: "yes", numberOfNestlings: "0", cupStatus: "Elevated"),
        DataEntry(siteName: "Box 37",logDate: Date.distantPast, nestHeight: 5, numberOfEggs: "4", eggsIncubating: "yes", numberOfNestlings: "0", cupStatus: "Elevated"),
        DataEntry(siteName: "Box 37", logDate: Date.now, nestHeight: 5, numberOfEggs: "0", eggsIncubating: "no", numberOfNestlings: "4", cupStatus: "Elevated")
    ]
    
    static let sampleSites: [FieldSite] = [
        FieldSite(name: "Box 5", dataEntries: sampleDataEntries1),
        FieldSite(name: "Box 26", dataEntries: sampleDataEntries2),
        FieldSite(name: "Box 37", dataEntries: sampleDataEntries3),
    ]
}
