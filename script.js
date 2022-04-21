/*
 * Get all packages name from table
 *
*/
var getAllPackagesName = function(){
  var packageNameClasses = document.querySelectorAll(".package-name")
  var allPackagesName = Array.from(packageNameClasses).map(elem => elem.innerHTML)
  var allUniquePackagesName = allPackagesName .filter((value, index, self) =>  self.indexOf(value) === index )
  
  return allUniquePackagesName
}


/*
 * Append 1 option HTML element to a parent HTML element
 * @param {HTMLElement} parent to be populated with option
 * @param {string} optionValue is the value to set for option value and inner text
 */
var appendOption = function(parent, optionValue){
  var newOpt = document.createElement("option")
  newOpt.setAttribute("value", optionValue)
  var newText = document.createTextNode(optionValue)

  newOpt.appendChild(newText)
  parent.appendChild(newOpt)
}


/*
 * Create all options from Array
 * @param {HTMLElement} select in which populate with options
 * @param {Array} values in options
 */
var createOptionFromArray = function(selectHTMLElement, arr){
  arr.forEach(elem => appendOption(selectHTMLElement, elem))
}

/*
 * get all selected option values from a select html element
 * @param {string} selectedId id of the select html element
 * @return {Array} packages name array
 */
var getSelectedOptionsValues = function(selectId="packages-selector"){
  var selectedOptions = document.getElementById(selectId).selectedOptions
	var selectedOptionsValues = Array.from(selectedOptions).map(elem => elem.value)

  return selectedOptionsValues
}


/*
 * hide elements if not in selection
 * @param {NodeList} nodeList to hide or not, depending in selection
 * @param {Array} selection is an array of elements to display
 */
var hideElementsNotinSelection = function(nodeList, selection){
    if(selection.length == 0){
        nodeList.forEach(elem => elem.removeAttribute("hidden"));
    } else {
        nodeList.forEach(elem => {
            if(selection.includes(elem.getAttribute("data-package-name"))){
                elem.removeAttribute("hidden")
            } else {
                elem.setAttribute("hidden", "true")
            }
        })
    }
};



var allPackagesName = getAllPackagesName()
var selectElement = document.getElementById("packages-selector")

// Populate options
createOptionFromArray(selectElement, allPackagesName)

// Add dynanism on selection change
selectElement.onchange = () => {
  var packagesNodeList = document.querySelectorAll("table .packages-list tr")
  var selectedPackagesArray = getSelectedOptionsValues()
    
  hideElementsNotinSelection(packagesNodeList, selectedPackagesArray)
};

// Add Choices.js plugin for select UI
var choices = new Choices(selectElement, {
  removeItemButton: true,
  // resetScrollPosition: false // overwritten with hideDropDown when adding item
});

// Hide dropdown after addind item
selectElement.addEventListener('addItem', () => choices.hideDropdown(), false);

