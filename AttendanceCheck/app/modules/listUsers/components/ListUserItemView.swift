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
                .frame(width: 5)
                .padding(.leading, -15)
        }
    }
    
    private struct ImageAsyncAvatar: View {
        @State var clientEmail: String
        
        let urlImage = "https://i.pravatar.cc/150?u="
        
        private struct EmptyImage: View {
            var body: some View {
                ProgressView()
                    .frame(width: 60, height: 60)
            }
        }
        
        private struct FailedImage: View {
            var body: some View {
                Image(systemName: "person.crop.circle.badge.exclamationmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.gray)
            }
        }
        
        private struct SuccessImage: View {
            let image: Image
            
            var body: some View {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
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
            VStack(alignment: .leading) {
                Text(user.name + " " + user.lastName)
                    .font(.system(size: 14, weight: .bold))
                Divider()
                Text(user.email)
                    .font(.system(size: 13))
                Text(user.phone)
                    .font(.system(size: 13))
            }
        }
    }
    
    private struct AsissteceButton: View {
        
        @State private var hasAssistance: Bool = false
        
        var body: some View {
            HStack {
                Button {
                    hasAssistance.toggle()
                } label: {
                    Image(systemName: hasAssistance ? "checkmark.circle" : "circle")
                        .foregroundColor(.green)
                        .font(.system(size: 30, weight: .bold))
                }
                .buttonStyle(.borderless)
            }
        }
    }
    
    var body: some View {
        HStack {
            
            StatusCapsule()
            
            ImageAsyncAvatar(clientEmail: user.email)
                .padding(-10)
            
            VStack(alignment: .leading) {
                
                ClientInfo(user: user)
                
            }
            .padding()
            
            AsissteceButton()
            
        }
        .frame(height: 70)
    }
}
