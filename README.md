# ergonomic_office_chair_manager

A simple application that sends data to the bluetooth module of an embedded microcontroller.

## Overview

This simple application has input, output and business

### Input

The inputs of the application are:

- The height of the user in cm. It must be between 165 and 185 cm.
- The selected bluetooth device.

## Output

The application has several outputs:

- Available bluetooth devices.
- Bluetooth connection state.
- Calculated chair height.

## Business

The use cases of the project are:

- Connection state.
- Connecting and disconnecting devices.
- Getting bluetooth devices.
- Sending calculated height to the device.

**Note:** This layer is the most-abstracted layer in the project. It does not know anything related to data layer and UI layer, even the type of the sending and recieving device it does not know that it is the bluetooth.

## Architecture

The project was simple but I decided to write it with Clean Architecture to practice it. I extremely abstracted everything and made the domain and data layers independent of the packages and even of the framework. This is not viable for projects of this size, but this was for practicing purposes.

The project contains:

- Core configurations.
- Domain layer.
- Data layer.
- Presentation layer.
- Dependeny injection framework.

### Core Configurations

**_Styling and UI_**

I decided to ignore styles configs as it is not much related to the domain layer. However, I used simple components in `lib/core/components/` and some constants in `lib/core/utils/`.

**_Bluetooth_**

I made an interface for bluetooth communication to implement it and use packages in implementation. By this, It is guaranteed that the data source component does is independent of the packages used for communication. You can find the interface and implementations in `lib/core/bluetooth/`.

**_Error Handling Configs_**

I wrote a simple class called `Failure` to return it in `Either` objects to avoid multi-type exception handling because I need the error messages only from all of the exceptions. I prefered not to throw String objects as I may need to add some other data to the `Failure`s.

_Note_: I used `Either` to handle errors, but it adds much boilerplate to the code and I decided to use `try/catch` and throw exceptions for error messaging.

**_Global Functions_**

You may need to use some long statements regularly like `MediaQuery.of(context).size.width`, which is annoying to write it every time. So, in `lib/core/functions/`. These functions shortened navigation, responsive UI, logging, showing sncak bars and decoding and encoding Strings.

**_Local Storage in Key/Value Pairs_**

I made an interface for this functionality to make sure that data sources are independent of the packages again. And I was so strict in typing that if the client doesn't enter the type of the data in the methods, they throw exceptions! Take a look at `lib/core/loca/`.

### Domain Layer

This is the most abstracted layer in the project. It has no dependency on presentation layer and even on data layer. The most important point of Clean Architecture is that it makes the business logic abstracted and clear. The use cases does not know about the UI, the data sources and even the communication device type! However, presentaion and Data layers depend on it by function calls and implementations.

### Data Layer

Although this layer depends on the data source, I abstracted the bluetooth connection functionality as mentioned before. It consists of data sources and repositories implementations. It has internal communication throw models and failures, and external communication throw entities, failures and implementations.

### Presentaiton Layer

This layer consists of UI and state management. It uses the use cases in the domain layer directly and uses BLoC as a state management solution.

I love to write the UI in a clean and readable pattern, which is:

- Make screen files for positioning widgets only, like Columns, Rows, Stacks and ListViews.
- Make main components for each screen, which are positioned in the screens files. The main component classes must contain positioning widgets only for the components.
- Finally, the visual widgets like texts, colors, and images are implemented alone in their own classes, and called in the main components classes, which easifies making responsive UI and reading the code!

### Dependeny Injection Framework

DI in the project is not good at all from an abstraction point of view. Although I made injection independent of `get_it`, I forgot to do that also in registering dependenies, which means that changing `get_it` package will be overwhelming!

**_Note:_** I was funny and silly that I implemented this architecture for a single-page application in about 70 files! The main reason for that is that I decided to use vertical slices depending on the use cases. Each use case has its own Cubit and Repository! This helped much when different use cases depend on the same data source but with different implementation. But using this approach made repositories useless because it was possible to implement the use cases in the data layer, not the repositories!
