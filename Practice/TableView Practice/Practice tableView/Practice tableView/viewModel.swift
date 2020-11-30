//
//  viewModel.swift
//  Practice tableView
//
//  Created by 임현규 on 2020/11/29.
//

import UIKit

enum CellType: String {
   case detailTitle
   case `switch`
   case checkmark
}

struct PhotosSettingItem {
   let title: String
   let subTitle: String?
   let type: CellType
   let on: Bool
   var imageName: String?
}

struct PhotosSettingSection {
   let items: [PhotosSettingItem]
   let header: String?
   let footer: String?
   
   static func generateData() -> [PhotosSettingSection] {
      return [
         PhotosSettingSection(items:
            [PhotosSettingItem(title: "Siri & Search", subTitle: "Search & Siri Suggestions", type: .detailTitle, on: false, imageName: "Siri")], header: "Allow Photos to Access", footer: nil),
         PhotosSettingSection(items: [
            PhotosSettingItem(title: "Summarize Photos", subTitle: nil, type: .switch, on: true, imageName: nil)
            ], header: "Photos Tab", footer: "The Photos tab shows every photo in your library in all views. You can choose compact, summarized views for Collections and Years."),
         PhotosSettingSection(items: [
            PhotosSettingItem(title: "Show Holiday Events", subTitle: nil, type: .switch, on: true, imageName: nil)
            ], header: "Memories", footer: "You can choose to see holiday events for your home country."),
         PhotosSettingSection(items: [
            PhotosSettingItem(title: "Automatic", subTitle: nil, type: .checkmark, on: true, imageName: nil),
            PhotosSettingItem(title: "Keep Originals", subTitle: nil, type: .checkmark, on: true, imageName: nil)
            ], header: "Transfer to mac or PC", footer: "Automatically transfer photos and videos in a compitable format, or always transfer the original file without checking for compatibility.")
      ]
   }
}
