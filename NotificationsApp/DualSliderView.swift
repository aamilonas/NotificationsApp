//
//  DualSliderView.swift
//  NotificationsApp
//
//  Created by Angelo Milonas on 4/20/25.
//

import SwiftUI

struct DualSlider: View {
    @Binding var startValue: Double
    @Binding var endValue: Double
    let minimumValue: Double
    let maximumValue: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 4)
                
                Rectangle()
                    .fill(Color.pink)
                    .frame(width: CGFloat((endValue - startValue) / (maximumValue - minimumValue)) * geometry.size.width,
                           height: 4)
                    .offset(x: CGFloat((startValue - minimumValue) / (maximumValue - minimumValue)) * geometry.size.width)
                
                // Start Handle
                Circle()
                    .fill(Color.white)
                    .frame(width: 24, height: 24)
                    .shadow(radius: 4)
                    .offset(x: CGFloat((startValue - minimumValue) / (maximumValue - minimumValue)) * geometry.size.width - 12)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newValue = min(endValue - 1, minimumValue + (maximumValue - minimumValue) * Double(value.location.x / geometry.size.width))
                                startValue = max(minimumValue, newValue)
                            }
                    )
                
                // End Handle
                Circle()
                    .fill(Color.white)
                    .frame(width: 24, height: 24)
                    .shadow(radius: 4)
                    .offset(x: CGFloat((endValue - minimumValue) / (maximumValue - minimumValue)) * geometry.size.width - 12)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newValue = max(startValue + 1, minimumValue + (maximumValue - minimumValue) * Double(value.location.x / geometry.size.width))
                                endValue = min(maximumValue, newValue)
                            }
                    )
            }
        }
        .frame(height: 24)
    }
}
