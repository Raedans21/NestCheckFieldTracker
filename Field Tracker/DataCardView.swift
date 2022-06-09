import SwiftUI

struct DataCardView: View {
    let entry: FieldSite.DataEntry
    var body: some View {
        VStack(alignment: .trailing) {
            Text("Entry: \(entry.logDate.formatted())")
                .font(.headline)
        }
        .padding(3)        
    }
}

struct DataCardView_Previews: PreviewProvider {
    static var previews: some View {
        DataCardView(entry: FieldSite.sampleDataEntries1[0])
            .previewLayout(.fixed(width:400, height: 60))
    }
}
