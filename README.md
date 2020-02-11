# TabDemoappDeliotte
Please Check out the develop branch .
Master branch is kept empty for a while

Pod used in this project
1 - Alamofire version 4.3 for networking
2 - Realmswift and Realm for Database 

Project Working Highlights
- No specific pattern included
- Used tab bar and UITableView for populating screen data
- Realm migration code is written in app delegate if in future there is change in 
ProductModelObject file wee need to increse schema version here
- Product list is fetched and stored in ProductModelObject only once
- Three external flags added to this model isInWatchList,isInCart and cartCounter
- isInWatchList helps in identifying the product object added in wish list
- this will help in managing data of wish list only slocally
- isInCart helps in identifying object which are addedin cart
- while adding any cart item Alarmofire makes a network call to add cart post API
- on success if product is added in cart then that object is marked with true flag of isInCart
- out of stock response recieved from api for an object is not marked true for isInCart
- While removing any items from first I check for quantity i.e cartCounter value if its greater then 1 
then quantity is been decremented by 1 else cart item is been removed
- for adding and deleting items from watch list simply isInWatchList flag is been marked as true or false
depending upon adding or deleting
- total amount is calculated with respect to price of an item but one should have more than 1 item in cart.


HelperClasses Group
Consist of Database handler and API handler
1. Database handler will manage all processess regarding database
2. Api Handler will manage all network related stuffs

ViewController Group
1. Controllers for view 
2. Data operations for all screen

Model Classes group
1. This Consist of Model object used for storing data in realm file
2. ProductModelObject is class which holds an object of realm file
3. cart object used to receive response while calling add to cart or delete cart api

Cell row group
1. These are cells which are populated on each of the three screens viz product,wish list and cart
2. All data on cell is been set on screen through these classes
