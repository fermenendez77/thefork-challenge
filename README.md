# thefork-challenge

## Arquitecture :

* This project uses MVVM as a main Arquitecture Pattern. In order to keep the things simple, I've created a Binding class for making the data binding between the ViewModel and the View. In a real scenario, we should use a more complex DataBinding framework like RxSwift, Combine, etc.
* Every layer receives their dependencies as protocols parameters, appliying the Dependency Injection pattern.
* For persistance, the app is using CoreData

## Application :

* The application requests the data using the default URLSession
* There are two buttons over the NavigationBar. The first one is for sorting the data by name and rating. The second one is for accesing to another ViewController that shows the saved restaurants.

## Testing :

* There are a couple of Unitests, just for showing how we could Mock the dependencies and test all of the scenarios .

If you have any questions, you can write me to fermenendez77@gmail.com
