::requires "BSF.CLS"
::requires "json-rgf.cls"

::class MainApp

::method init
  expose incomeData expenseData primaryStage
  incomeData=.fx.FXCollections~observableArrayList
  expenseData=.fx.FXCollections~observableArrayList

::method start
  expose primaryStage
  use arg primaryStage

  primaryStage~setTitle("Income vs Expenses")

  rootLayoutUrl=.bsf~new("java.net.URL", "file:RootLayout.fxml")
  rootLayout   =.fx.FXMLLoader~load(rootLayoutUrl)
  .rootLayoutController~new(self)

  scene=.fx.scene~new(rootLayout)
  primaryStage~setScene(scene)

  incomeExpenseOverviewUrl=.bsf~new("java.net.URL", "file:IncomeExpenseOverview.fxml")
  overviewPage=.fx.FXMLLoader~load(incomeExpenseOverviewUrl)
  rootLayout~setCenter(overviewPage)
  .incomeExpenseOverviewController~new(self)

  primaryStage~show

::method loadIncomeExpenseDataFromFile
  expose incomeData expenseData
  use arg filePath

  data=.json~fromJsonFile(filePath)
  incomeData~clear
  expenseData~clear
  do d over data
     incomeData~add(d["income"])
     expenseData~add(d["expense"])
  end

::method saveIncomeExpenseDataToFile
  expose incomeData expenseData
  use arg filePath

  data=.array~new
  do i=1 to incomeData~size
     data~append(.directory~new~put("income", incomeData[i])~put("expense", expenseData[i]))
  end

  .json~toJsonFile(filePath, data, .true)

::method handleOpen
  expose primaryStage

  fileChooser=.bsf~new("javafx.stage.FileChooser")
  extFilter=  .bsf~new("javafx.stage.FileChooser$ExtensionFilter", "JSON files (*.json)", bsf.createJavaArrayOf("java.lang.String", "*.json"))
  fileChooser~getExtensionFilters~add(extFilter)
  file = fileChooser~showOpenDialog(primaryStage)
  if file<>.nil then
     self~loadIncomeExpenseDataFromFile(file~getPath)

::method handleSave
  expose primaryStage

  fileChooser=.bsf~new("javafx.stage.FileChooser")
  extFilter=  .bsf~new("javafx.stage.FileChooser$ExtensionFilter", "JSON files (*.json)", bsf.createJavaArrayOf("java.lang.String", "*.json"))
  fileChooser~getExtensionFilters~add(extFilter)
  file = fileChooser~showSaveDialog(primaryStage)
  if file<>.nil then
     self~saveIncomeExpenseDataToFile(file~getPath)

::method handleExit
  bsf.loadClass("javafx.application.Platform")~exit
