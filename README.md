## Giphy:

iOS Coding Challenge: Giphy

![AppDemonstrations-GIF][appdemonstrations-link]
![01][01-link]
![02][02-link]
![03][03-link]
![04][04-link]
![05][05-link]
![06][06-link]

## Requirements:

- iOS 13.0+
- Xcode 12+
- Swift 5.0+

## Tools & Library used:

- [Alamofire](https://github.com/Alamofire/Alamofire) - To manage network communication.
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) - To easy to deal with JSON data in Swift.
- [Kingfisher](https://github.com/onevcat/Kingfisher) - To load GIFs image in Cells & UIViews.
- [CHTCollectionViewWaterfallLayout](https://github.com/chiahsien/CHTCollectionViewWaterfallLayout) - For better UIs experience.

## Assets:

List of assets your can find here, including application icons:
https://github.com/aareusoftnet/Giphy/tree/main/Assets

- **[AppIcons](https://github.com/aareusoftnet/Giphy/tree/main/Assets/AppIcons)** - It contains application icons.
- **[AppleStore](https://github.com/aareusoftnet/Giphy/tree/main/Assets/AppleStore)** - It contains Apple store screenshots.
- **[Video](https://github.com/aareusoftnet/Giphy/tree/main/Assets/Videos)** - It contains application video demonstrations.
- [Giphy.sketch](https://github.com/aareusoftnet/Giphy/blob/main/Documents/2021_iOS_Coding_Challenge__Giphy.pdf) - Design source file.

## Documents:

List of project related document here.

- [2021_iOS_Coding_Challenge\_\_Giphy.pdf](https://github.com/aareusoftnet/giphy/blob/main/Documents/2021_iOS_Coding_Challenge__Giphy.pdf) - Project requirement document.

## SourceCode:

Find here project source code.

- [Giphy](https://github.com/aareusoftnet/giphy/tree/main/SourceCode/Giphy) - Project root directory, open **Giphy.xcodeproj** file in your xCode.

### Terms use in coding:

- `TVC` - It's a postfix for any TVC(Table View Cell) file.
- `CVC` - It's a postfix for any CVC(Collection View Cell) file.
- `MO` - It's a postfix for any MO(NSManageObject) file.
- `CDM` - It's a postfix for any CDM(Coredatabase model) file.
- `VC` - It's a postfix for any VC(UIViewController) file.
- `VM` - It's a postfix for any VM(ViewModel) file.
- `XIBs` - It's a directory which contains list of NIBs, also known as Views.
- `APIs` - It's a directory which contains list of GiphyAPIs call and APIManager.

### Features Included:

- [x] **Screen 1 - Now Trending Feed**
- A table view that displays the Trending GIFs feed
- Contains a search bar.
- Contains a table view that displays searched gifs.
- Loading indicator while searching
- The default items in the table view should be the trending GIFs (if nothing in search bar)

- [x] **Screen 2 - Favourites Feed**
- A collection view that displays a grid of favourited GIFs
- Favourites should be viewable when offline
- Favourites should persist between launches

- [x] **Screen 3 - Detail view for GIF**
- The ability to see a full screen view of a selected GIF

- [x] **GIF Cells**
- Contain a running GIF
- Ability for the user to favourite/unfavourite a GIF

- [x] **Bonus**
- Pagination (or infinite scroll) of trending, search and/or favourited lists
- Use of UIContextMenuInteraction
  - Share menu to share GIF using iOS Native share window.
  - Add/Remove GIF from/to Favourite lists.
- [Use of URLSession](https://github.com/aareusoftnet/giphy/blob/main/SourceCode/Giphy/Giphy/APIs/APIManager/APIDataManager.swift) - You can find here `APIDataManager` class.

## Contact:

[![linkedINContact][linkedincontactme-badge]][linkedin-link]
[![UpworkContact][upworkcontactme-badge]][upwork-link]

<!-- MARKDOWN LINKS & IMAGES -->

[linkedincontactme-badge]: https://img.shields.io/badge/linkedIN-CONTACT%20ME-blue?style=for-the-badge
[linkedin-link]: https://www.linkedin.com/in/aareusoftnet
[upworkcontactme-badge]: https://img.shields.io/static/v1?style=for-the-badge&label=UPWORK&message=CONTACT%20ME&color=OOOOOO
[upwork-link]: https://www.upwork.com/freelancers/~012d5b6e889c57a2a1
[appdemonstrations-link]: https://github.com/aareusoftnet/Giphy/blob/main/Assets/Videos/AppDemonstrations.gif
[01-link]: https://github.com/aareusoftnet/Giphy/blob/main/Assets/Screens/01.PNG
[02-link]: https://github.com/aareusoftnet/Giphy/blob/main/Assets/Screens/02.PNG
[03-link]: https://github.com/aareusoftnet/Giphy/blob/main/Assets/Screens/03.PNG
[04-link]: https://github.com/aareusoftnet/Giphy/blob/main/Assets/Screens/04.PNG
[05-link]: https://github.com/aareusoftnet/Giphy/blob/main/Assets/Screens/05.PNG
[06-link]: https://github.com/aareusoftnet/Giphy/blob/main/Assets/Screens/06.PNG
