# CabifyProducts App

[English]:


This application consists of a main view with a listing of Cabify products downloaded from https://gist.githubusercontent.com/palcalde/6c19259bd32dd6aafa327fa557859c2f/raw/ba51779474a150ee4367cda4f4ffacdcca479887/Products.json 

When tapping on a product in the list the detail screen is displayed modally enabling the user to choose the quantity of items to buy for this product and the price and possible discounts are applied automatically.

If there is at least one item added to the basket, the "Checkout" button enables and the user can navigate to the Checkout screen where they can see the products summary to buy and the total price and to tap on the Buy button to finish the process.

For development, the same VIPER architecture use at the ATSistemas Expert Center has been applied as it fits with the Clean Architecture paradigm and achieves systems with the following characteristics:

Independence from frameworks: third-party frameworks and libraries are only used as tools and the architecture does not depend on them because in that case, limitations are introduced and it depends on the framework's maintenance being done correctly.
Independence from any external agent: business rules do not know anything about the implementation of any external element.
Testable: business logic can be tested without a graphical interface, database, API connection or any other external element.

It has been developed with UIKit
The closure pattern has been changed to Combine for the communication between Providers, Interactors, and Presenters of the data downloaded from the API.
It's been added Unit Testing using XCTest using Mocks from the rest of the necessary components in each SUT.
 

[Español]:


Esta aplicación consta de una vista principal con el listado de productos de Cabify descargados de https://gist.githubusercontent.com/palcalde/6c19259bd32dd6aafa327fa557859c2f/raw/ba51779474a150ee4367cda4f4ffacdcca479887/Products.json

Al pulsar sobre un producto de la lista se muestra la pantalla detalle de forma modal y habilita al usuario poder elegir el número de elementos que quiere comprar de este producto y al hacerlo se calcula el precio con los descuentos aplicados según si le pertoca y según el número de elementos elegidos. 

Si se ha añadido al carrito al menos un elemento de un producto entonces se habilita el botón "Checkout" en la pantalla del listado principal y el usuario puede navegar a la pantalla del Checkout donde podrá ver el resumen de productos seleccionados y el precio total y al pulsar sobre el botón de compra se finalizará el proceso.   

Para el desarrollo se ha aplicado la arquitectura VIPER que usamos en el Centro Experto de ATSistemas ya que encaja con el paradigma Clean Architecture y que consigue sistemas con las siguientes caracteristicas: 
- Independencia de los frameworks: los frameworks y librerias de terceros solo son usados como herramientas y la arquitectura no depende de ellos porque en tal caso se introducen limitaciones y se depende de que el mantenimiento del framework se haga correctamente.
- Independencia de cualquier agente externo: Las reglas de negocio no saben nada de la implementación de cualquier elemento exterior.
- Testable: la logica de negocio puede ser probada sin necesidad de interfaz gráfica, base de datos, conexión con la API o cualquier otro elemento externo.

Se ha desarrollado en Swift con UIKit.
Se ha cambiado del patrón closure a Combine para la comunicación entre los Providers, Interactors y Presenters de los datos descargados de la API.
Se ha añadido Unit Testing usando XCTest usando Mocks del resto de componentes necesarios en cada SUT. 

