
import SwiftUI
import MapKit

struct PlaceInfoBaseView<Content: View>: View {
    let place: MKMapItem
    @ViewBuilder let content: Content
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(place.name ?? "Unknown Place")
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(1)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
            }

            SavePlaceButton(place: place)
            SavedByFriendsButton(isSavedByFriends: false)
            
            Divider()
            content
            Spacer()
        }
        .padding()
    }
}
