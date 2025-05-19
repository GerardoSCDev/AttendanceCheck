//
//  ListUserItemView.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 08/05/25.
//

import SwiftUI

struct UserItemView: View {
    
    let user: User
    
    private struct StatusCapsule: View {
        var body: some View {
            Capsule()
                .fill(.red)
                .frame(width: 8)
                .padding(.leading, -15)
        }
    }
    
    private struct ImageAsyncAvatar: View {
        @State var clientEmail: String
        
        let urlImage = "https://i.pravatar.cc/150?u="
        
        private struct EmptyImage: View {
            var body: some View {
                ProgressView()
                    .frame(width: 150, height: 100)
            }
        }
        
        private struct FailedImage: View {
            var body: some View {
                Image(systemName: "person.crop.circle.badge.exclamationmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 100)
                    .foregroundColor(.gray)
            }
        }
        
        private struct SuccessImage: View {
            let image: Image
            
            var body: some View {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 60))
                    .shadow(radius: 10)
            }
        }
        
        var body: some View {
            AsyncImage(url: URL(string: "\(urlImage)\(clientEmail)")) { phases in
                switch phases {
                case .empty:
                    EmptyImage()
                case .success(let image):
                    SuccessImage(image: image)
                case .failure:
                    FailedImage()
                @unknown default:
                        EmptyView()
                }
            }
        }
    }
    
    private struct ClientInfo: View {
        
        var user: User
        
        var body: some View {
            VStack(alignment: .leading, spacing: 7) {
                Text(user.name + " " + user.lastName)
                Divider()
                Text(user.email)
                Text(user.phone)
                Divider()
                Spacer()
            }
        }
    }
    
    private struct AsissteceButton: View {
        
        @State private var hasAssistance: Bool = false
        
        var body: some View {
            HStack {
                Button(ListUsersStrings.asissteceButtonTitle) {
                    hasAssistance.toggle()
                }
                .buttonStyle(.borderless)
                if hasAssistance {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.green)
                        .font(.system(size: 20, weight: .bold))
                }
            }
        }
    }
    
    var body: some View {
        HStack {
            
            StatusCapsule()
            
            ImageAsyncAvatar(clientEmail: user.email)
            
            VStack(alignment: .leading, spacing: 7) {
                
                ClientInfo(user: user)
                
                AsissteceButton()
                
            }
            .padding()
            
        }
    }
}
