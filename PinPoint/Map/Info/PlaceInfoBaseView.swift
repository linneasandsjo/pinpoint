
import SwiftUI
import MapKit

struct PlaceInfoBaseView<Content: View>: View {
    let place: MKMapItem
    @ViewBuilder let content: Content
    @Environment(\.dismiss) private var dismiss

    // MARK: - Placeholder states (ersätts med riktig databas senare)
    //@State private var isSavedByUser = false
    @State private var isSavedByFriends = false
    
    //private let placeService = PlaceService.shared

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

            /*// Sparstatus (placeholder just nu)
            if isSavedByUser {
                Label("Added to your list", systemImage: "heart.fill")
                    .foregroundColor(.pink)
                    .font(.subheadline)
            } else {
                Label("Add to your list", systemImage: "heart")
                    .foregroundColor(.pink)
                    .font(.subheadline)
            }*/
            
            if isSavedByFriends {
                Label("Friends have saved this place", systemImage: "person.2.fill")
                    .foregroundColor(.blue)
                    .font(.subheadline)
            } else {
                Label("No friends include this place in their list", systemImage: "person.2")
                    .foregroundColor(.blue)
                    .font(.subheadline)
            }

            Divider()

            content

            Spacer()
        }
        .padding()
        /*.onAppear {
            loadBasicInfo()
        }*/
    }

    /*private func loadBasicInfo() {
        let placeId =
            "\(place.placemark.coordinate.latitude)_\(place.placemark.coordinate.longitude)"

        Task {
            isSavedByUser = (try? await placeService.isPlaceSaved(placeId: placeId)) ?? false
        }
    }*/
}
