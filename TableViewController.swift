
import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating
{
    
	let searchController = UISearchController()
	@IBOutlet weak var shapeTableView: UITableView!
	var IngredientList = [Ingredient]()
	var filteredIngredient = [Ingredient]()
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		initList()
		initSearchController()
	}
	
	func initSearchController()
	{
		searchController.loadViewIfNeeded()
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.enablesReturnKeyAutomatically = false
		searchController.searchBar.returnKeyType = UIReturnKeyType.done
		definesPresentationContext = true
		
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
		searchController.searchBar.scopeButtonTitles = ["All", "Cookies", "Cake", "Bread", "Brownies", "Muffins"]
		searchController.searchBar.delegate = self
	}
	
	func initList()
	{
		let Flour = Ingredient(id: "0", name: "Flour", imageName: "Flour")
        IngredientList.append(Flour)
		
		let Eggs = Ingredient(id: "1", name: "Eggs", imageName: "Eggs")
        IngredientList.append(Eggs)
		
		let Butter = Ingredient(id: "2", name: "Butter", imageName: "Butter")
        IngredientList.append(Butter)
		
		let Sugar = Ingredient(id: "3", name: "Sugar", imageName: "Sugar")
        IngredientList.append(Sugar)
		
		let BakingSoda = Ingredient(id: "4", name: "Baking Soda", imageName: "Baking Soda")
        IngredientList.append(BakingSoda)
		
		let Chocolate = Ingredient(id: "5", name: "Chocolate", imageName: "Chocolate")
        IngredientList.append(Chocolate)
		
		let Milk = Ingredient(id: "6", name: "Milk", imageName: "Milk")
        IngredientList.append(Milk)
		
		let Vanilla = Ingredient(id: "7", name: "Vanilla", imageName: "Vanilla")
        IngredientList.append(Vanilla)
		
		let Water = Ingredient(id: "8", name: "Water", imageName: "Water")
        IngredientList.append(Water)
		
		let Oil = Ingredient(id: "9", name: "Oil", imageName: "Oil")
        IngredientList.append(Oil)
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		if(searchController.isActive)
		{
			return filteredIngredient.count
		}
		return IngredientList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellID") as! TableViewCell
		
		let thisShape: Ingredient!
		
		if(searchController.isActive)
		{
			thisShape = filteredIngredient[indexPath.row]
		}
		else
		{
			thisShape = IngredientList[indexPath.row]
		}
		
		
		tableViewCell.shapeName.text = thisShape.id + " " + thisShape.name
		tableViewCell.shapeImage.image = UIImage(named: thisShape.imageName)
		
		return tableViewCell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		self.performSegue(withIdentifier: "detailSegue", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		if(segue.identifier == "detailSegue")
		{
			let indexPath = self.shapeTableView.indexPathForSelectedRow!
			
			let tableViewDetail = segue.destination as? TableViewDetail
			
			let selectedShape: Ingredient!
			
			if(searchController.isActive)
			{
				selectedShape = filteredIngredient[indexPath.row]
			}
			else
			{
				selectedShape = IngredientList[indexPath.row]
			}
			
			
			tableViewDetail!.selectedShape = selectedShape
			
			self.shapeTableView.deselectRow(at: indexPath, animated: true)
		}
	}

	
	func updateSearchResults(for searchController: UISearchController)
	{
		let searchBar = searchController.searchBar
		let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
		let searchText = searchBar.text!
		
		filterForSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
	}
	

    
	func filterForSearchTextAndScopeButton(searchText: String, scopeButton : String = "All")
    
	{
		filteredIngredient = IngredientList.filter
		{
            shape in
			let scopeMatch = (scopeButton == "All"
            || //shape.name.lowercased().contains(scopeButton.lowercased())
                
                shape.name.contains("Egg")
            ||
                shape.name.contains("Flour")
            ||
                shape.name.contains("Sugar")
            ||
                shape.name.contains("Baking Soda")
            ||
                (  scopeButton == "Cake" && shape.name.contains("Vanilla"))
            ||
                (  scopeButton == "Cake" && shape.name.contains("Oil"))
            ||
                (  scopeButton == "Cookies" && shape.name.contains("Chocolate"))
            ||
                (  scopeButton == "Cookies" && shape.name.contains("Butter"))
            ||
                (  scopeButton == "Bread" && shape.name.contains("Oil"))
            ||
                (  scopeButton == "Bread" && shape.name.contains("Water"))
            ||
                (  scopeButton == "Brownies" && shape.name.contains("Oil"))
            ||
                (  scopeButton == "Brownies" && shape.name.contains("Chocolate"))
            ||
                (  scopeButton == "Muffins" && shape.name.contains("Chocolate"))
            ||
                (  scopeButton == "Muffins" && shape.name.contains("Milk"))
                                        
                    

            )
			
            
            
            
            
            
            
            if(searchController.searchBar.text != "")
			{
				let searchTextMatch = shape.name.lowercased().contains(searchText.lowercased())
				
				return scopeMatch && searchTextMatch
			}
			else
			{
				return scopeMatch
			}
		}
		shapeTableView.reloadData()
	}
}

