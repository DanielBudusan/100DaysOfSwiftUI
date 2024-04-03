//
//  CardView.swift
//  Flashzilla
//
//  Created by Daniel Budusan on 02.04.2024.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @State private var offSet = CGSize.zero
    @State private var isShowingAnswer = false
    let card: Card
    
    var removal: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    accessibilityDifferentiateWithoutColor
                    ? .white
                    : .white
                        .opacity(1 - Double(abs(offSet.width) / 50))
                )
                .background(
                    accessibilityDifferentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25)
                        .fill(offSet.width > 0 ? .green : .red)
                )
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            VStack {
                if accessibilityVoiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(offSet.width / 5.0))
        .offset(x: offSet.width * 5)
        .opacity(2 - Double(abs(offSet.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offSet = gesture.translation
                }
                .onEnded { _ in
                    if abs(offSet.width) > 100 {
                        removal?()
                    } else {
                        offSet = CGSize(width: 0, height: 0)
                    }        
                }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.default, value: offSet)
    }
}

#Preview {
    CardView(card: .example)
}
