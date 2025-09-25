# ₿ Bitcoiny 
Bitcoin price history explorer.

## ⚙️ Approach Summary
The **MVVM** architectural pattern was used:
- **View**: Responsible solely for UI rendering and user interaction. Communicates unidirectionally with the **ViewModel**.  
- **ViewModel**: Acts as the mediator between the **View** and other module components.  
- **Repository**: Serves as the entry point for business logic. It contains **Services** that handle specific tasks such as network data retrieval or (if the Favorites feature were completed) persistence.  
- **Dependency Injection**: All dependencies are injected via initializers and abstracted behind protocols, making components fully testable.  
- **Folder Structure**: Organized with modularization in mind.  
- **Network Layer**: Designed to be testable and focused on a single responsibility—**loading data**.  
  - `Endpoint`: Describes the resource to request.  
  - `RequestBuilder`: Builds `URLRequest` from an `Endpoint`.  
  - `Transport`: Protocol-based abstraction for `URLSession` to enable injection.  
  - `NetworkService`: Combines all components to execute requests.  
  - Data decoding and transformation are handled in the Repository layer.  
- **Testing**: Partial unit tests for the network layer demonstrate the overall testing strategy.

## ⚖️ Trade-offs & Limitations
- **Test Coverage**: Business logic not fully covered with unit/ui tests due to time constraints.   
- **Error Handling**: Could be made more robust, with clearer messages for both developers and users. 
- **Screen navigation**: Could be(and should be) more flexible, for example leveraging `NavigationStack` `path`. But in order not to overcomplicate the solution based on the requirements, `NavigationLink` was used.
- **Extra price list data**: For some reason _Coingecko_ `market_chart` api returns 2 price records for _today_: _start of a day_ and the most _recent_ one. It would make sense to additionally remove the one for the _start of a day_, but in order not to overcomplicate the solution i decided not to do so.

## 🛠️ Potential improvements and next steps

- Add _pull to refresh_
- Add _connectivity monitoring_
- Improve _navigation_, as described in __Trade-offs & Limitations__


## 📱 Environment
- **Simulator**: iPhone 16 Pro, iOS 18.3
- **Device**: iPhone 8, iOS 16.7.11
- **XCode**: 16.2
- **macOS**: 14.7.4

## 📋 How-To run

1. Download the repository.
2. Hit Run\Test.

## 🎉 Thank You!
