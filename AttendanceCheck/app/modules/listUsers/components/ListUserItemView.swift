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
        var status: Bool
        
        var body: some View {
            Capsule()
                .fill(status ? .green : .red)
                .frame(width: 5)
                .padding(.leading, -15)
        }
    }
    
    struct ImageAvatar: View {
        
        var image: Data?
        
        var body: some View {
            
            if let image = image {
                SuccessImage(image: image)
            } else {
                FailedImage()
            }
            
        }
        
        private struct SuccessImage: View {
            var image: Data
            
            var body: some View {
                Image(uiImage: UIImage(data: image) ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 60))
                    .shadow(radius: 10)
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
            
            StatusCapsule(status: user.isActive)
            
            ImageAvatar(image: user.photo)
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
