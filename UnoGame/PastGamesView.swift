//
//  PastGamesView.swift
//  UnoGame
//
//  Created by John Delano on 11/18/26.
//

import SwiftUI
import SwiftData

struct PastGamesView: View {
    @Query(sort: \GameRecord.date,
           order: .reverse) private var records: [GameRecord]
    @Environment(\.modelContext) private var context

    
    
    var body: some View {
        List {
            ForEach(records) { record in
                HStack {
                    Text(record.date.formatted(date: .abbreviated, time: .shortened))
                    Spacer()
                    Text(record.cardsLeft == 0 ? "Won" : "\(record.cardsPlayed) played")
                }
            }
            .onDelete { offsets in
                for index in offsets {
                    context.delete(records[index])
                }
            }
        }
        .navigationTitle("Past Games")
    }
}

#Preview {
    PastGamesView()
}
