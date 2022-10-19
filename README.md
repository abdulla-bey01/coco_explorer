# coco_exp

A test project painting colors on searched object on image

## structure

Viper is one of the creational design patters to develop mobile application, it is used to develop this project.

3 main part of the structure of application are app, data, ui

### app
app is bussiness part of layers, which we make ui side and data side related, we develop commands, mapping, interactors in app part.
## commands
Command is a little part of app side doing only one job for application.
For instance - command can get data from interactor and send it to presenter
There is base command class(ICommand), so all the command classes should extend their from ICommand.
Developer need to override canExecute and execute methods of ICommand. It developer does not want to call execute method of command after checking canExecute, they should call doExecute method. 
## interctors
Interactors are objects that can keep bussines data, do some bussines jobs, etc
For instance - in this app there is search interactor, and search interactor, join seperated image datas to one class
For instance - developer can map the data transfers object to model in interactor with help of mapper
## mapping
Mapping is part of app side which convert data transfer object to model(properties of class to properties of other class)


### data
data is a main part of application layer, that provide app with data it need
## abstraction
Developer keeps base classes of data managers on this layer(folder).
For instance - there is IImageManager class in this application, this is base class for all image repositories(repository may be remote or local).
All the image manager classes should implement IImageManager and ovverride its methods, properties.
## dtos 
are classes to pass data from server or local storage, they are models for transfer the data from somewhere to app, or from app to somewhere
## local
local layer(folder) keeps local data abstraction anc concrency inside of it
## remote
remote layer(folder) keeps remote data abstarction adn concrency inside of it
    - inside of remote
        1 - abstraction -> main keep main parents of network manager. For example we keep INetworkManager in this layer. INetworkManager keep some parts of network operations, properties. 
        every network manager should extend from INetworkManager
        2 - asbtraction -> api_based keep parents of api based network managers. For example ICocoNetworkManager extends from INetworkManager, set its baseUrl inside of itself. Keep headers for its requests and keep some api spesific informations like success, unsucces, etc. For example ICocoNetworkManager keep ok property with value of 200 as success. Maybe success code is some number.
        3 - concrency keep api based main classes doing job, these classes should extends from api based abstraction. For example CocoImageNetworkManager extends from ICocoImageNetworkManager. So it get properties of coco network manager(like baseUrl). And it shoul ovverride IImageNetworkManager methods, because ICocoImageNetworkManager is extended from ImaheNetworkManager


### ui
main structure of ui is that we have some screens and every screen has own presenter
## screens(views)
we develop code of only ui side(screens, pages, widgets) in this folder and providing it with data it need by its presenter
every view element(screen, page, widget) should have presenter, if it is not "so tiny"




######
i get data from api in data layer, convert the data to form i need to use easier to develop in "app layer"(join seperated data in one image class keeping image source link, its captures, its segmentations),  and show the data to user. 
Coco dataset is providing us with points-coordinates of segments, i groupped segments based on explore icon data.
If user tap on explore icon, the app will draw segment which is related image parts to 'explore' icon