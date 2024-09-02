#!/usr/bin/env rexx

.environment~my.app=.directory~new
.my.app~bDebug=.false

call bsf.import "javafx.collections.FXCollections", "fx.FXCollections"
call bsf.import "javafx.scene.chart.XYChart$Data", "fx.XYChartData"

-- change directory to program location such that relatively addressed resources can be found
parse source . . pgm
call directory filespec('L', pgm)   -- change to the directory where the program resides

rxApp=.RexxApplication~new -- create Rexx object that will control the FXML set up
.my.app~mainApp=rxApp

-- Debug message to ensure the RexxApplication is created
say "RexxApplication object created successfully."

jrxApp=BSFCreateRexxProxy(rxApp, ,"javafx.application.Application")

-- Debug message to ensure BSFCreateRexxProxy is successful
say "BSFCreateRexxProxy created successfully."

-- Launch the application using the correct method invocation
jrxApp~launch(jrxApp~getClass, .nil)

::requires "BSF.CLS"    -- get Java support
::requires "json-rgf.cls"

-- Rexx class defines "javafx.application.Application" abstract method "start"
::class RexxApplication -- implements the abstract class "javafx.application.Application"

::method init
  expose incomeData expenseData

  -- Debug message to verify method call
  say "Loading data from income_expense.json"

  data=.json~fromJsonFile("income_expense.json")
  say "Loaded data: " data

  incomeData=bsf.createJavaArray("int.class", data~size)
  expenseData=bsf.createJavaArray("int.class", data~size)

  do i=1 to data~size
    incomeData[i] = .java.lang.Integer~parseInt(data[i]["income"])
    expenseData[i] = .java.lang.Integer~parseInt(data[i]["expense"])
  end
  say "Income Data: " incomeData
  say "Expense Data: " expenseData

::method start
  expose incomeData expenseData
  use arg primaryStage
  primaryStage~setTitle("Income vs Expenses")

  fxmlUrl=.bsf~new("java.net.URL", "file:RootLayout.fxml")
  rootNode=bsf.loadClass("javafx.fxml.FXMLLoader")~load(fxmlUrl)

  scene=.bsf~new("javafx.scene.Scene", rootNode)
  primaryStage~setScene(scene)
  primaryStage~show

  -- Initialize the controller with the mainApp
  /* .IncomeExpenseOverviewController~new(mainApp) */
