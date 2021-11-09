//
//  InfoLine.swift
//  Marginalen
//
//  Created by Giovanni Palusa on 2021-09-09.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

// MARK: - InfoLine

struct InfoLine: View {
    let info: Info

    struct Info: Identifiable {
        let id = UUID()
        let titleLeft: String
        let titleRight: String
        let subtitleLeft: String?
        let subtitleRight: String?

        init(titleLeft: String,
             titleRight: String,
             subtitleLeft: String? = nil,
             subtitleRight: String? = nil) {
            self.titleLeft = titleLeft
            self.titleRight = titleRight
            self.subtitleLeft = subtitleLeft
            self.subtitleRight = subtitleRight
        }
    }

    var body: some View {
        HStack(alignment: .top) {
            VStack(spacing: 0) {
                Text(info.titleLeft)
                    .leadingAlignment()
                    .font(font: .smallText)
                    .fixedSize(horizontal: false, vertical: true)
                    .layoutPriority(1)
                if let subtitleLeft = info.subtitleLeft {
                    Text(subtitleLeft)
                        .leadingAlignment()
                        .font(font: .smallText)
                }
            }

            Spacer()

            VStack(spacing: 0) {
                TextCopyable(text: info.titleRight, alignment: .right)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.vertical, 2.5)
                if let subtitleRight = info.subtitleRight {
                    TextCopyable(text: subtitleRight, alignment: .right)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.vertical, 2.5)
                }
            }
        }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }

    static func grouped(infoTexts: [Info], padding: Bool = true) -> some View {
        VStack(spacing: 16) {
            ForEach(infoTexts.indices) { index in
                InfoLine(info: infoTexts[index])
                    .padding(.top, (padding && index == infoTexts.startIndex) ? 32 : 0)
                    .padding(.bottom, (padding && index == infoTexts.endIndex - 1) ? 32 : 0)
            }
        }
    }
}

struct InfoLine_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            VStack(spacing: 16) {
                InfoLine(info: .init(titleLeft: "InfoLeft",
                                     titleRight: "InfoRight",
                                     subtitleLeft: "SubtitleLeft",
                                     subtitleRight: "SubtitleRight"))
                InfoLine(info: .init(titleLeft: "KontoTyp",
                                     titleRight: "Buffertkonto"))
            }
            Divider()
            InfoLine.grouped(infoTexts: [
                .init(titleLeft: "Försäkring låneskydd", titleRight: "590,00 kr"),
                .init(titleLeft: "Ränta", titleRight: "1400,00 kr kr"),
                .init(titleLeft: "OCR för återbetalning", titleRight: "12345273892"),
                .init(titleLeft: "Aviseringsavgift", titleRight: "10,00 kr"),
                .init(titleLeft: "Kvarvarande återbetalningstid", titleRight: "9 år & 4 mån"),
                .init(titleLeft: "Huvudlåntagare", titleRight: "Namn Namnsson",
                      subtitleLeft: "Låneskydd", subtitleRight: "Ja"),
                .init(titleLeft: "Bor medsökande på samma adress?", titleRight: "Ja")
            ])
            Divider()
        }
    }
}
