.environment~my.app=.directory~new  -- directory to contain objects relevant to this application
.my.app~bDebug=.false               /* if set to .true, "put_FXID_objects_into.my.app.rex" will show
                                       all entries in ScriptContext Bindings on the console           */
-- starting with JavaFX 8u40 true dialogs got introduced; taking advantage of them if running on Java 1.8 or higher

-- import JavaFX classes that we may use more often
call bsf.import "javafx.fxml.FXMLLoader",                      "fx.FXMLLoader"
call bsf.import "javafx.scene.Scene",                          "fx.Scene"
call bsf.import "javafx.beans.property.SimpleStringProperty",  "fx.SimpleStringProperty"
call bsf.import "javafx.beans.property.SimpleIntegerProperty", "fx.SimpleIntegerProperty"

call bsf.import "javafx.collections.FXCollections",            "fx.FXCollections"
call bsf.import "javafx.stage.Modality",                       "fx.Modality"

rexxApp=.MainApp~new
.my.app~mainApp=rexxApp        -- store the Rexx MainApp object in .my.app

-- instantiate the abstract JavaFX class, the abstract "start" method will be served by rexxApp
jRexxApp=BsfCreateRexxProxy(rexxApp, ,"javafx.application.Application")

signal on syntax
   -- launch the application, invoke "start" and then stay up until the application closes
jRexxApp~launch(jRexxApp~getClass, .nil)  -- need to use this version of launch in order to work
call sysSleep 0.01                 -- let ooRexx clean up
exit

syntax:
   co=condition("object")
   say ppJavaExceptionChain(co, .true) -- display Java exception chain and stack trace of original Java exception
   say " done. "~center(100, "-")
   exit -1

::requires "BSF.CLS"

::class MainApp

::attribute primaryStage   -- stores the primaryStage supplied via the start method by JavaFX

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
