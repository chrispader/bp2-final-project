#!/usr/bin/env rexx

parse source  . . pgm
call directory filespec('L', pgm)   -- change to the directory where the program resides

months = .array~of("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")

.environment~my.app=.directory~new
rxApp=.RexxApplication~new

jrxApp=BSFCreateRexxProxy(rxApp, ,"javafx.application.Application")

signal on syntax
jrxApp~launch(jrxApp~getClass, .nil)
call sysSleep 0.01
exit

syntax:
  co=condition("object")
  say ppJavaExceptionChain(co, .true) -- display Java exception chain and stack trace of original Java exception
  say " done. "~center(100, "-")
  exit -1

::requires "BSF.CLS"
::requires "json-rgf.cls"

::class RexxApplication

::method start
  expose lineChartContainer
  use arg primaryStage
  primaryStage~setTitle("Income vs Expenses")

  fxmlUrl=.bsf~new("java.net.URL", "file:RootLayout.fxml")
  rootNode=bsf.loadClass("javafx.fxml.FXMLLoader")~load(fxmlUrl)

  scene=.bsf~new("javafx.scene.Scene", rootNode)
  primaryStage~setScene(scene)
  primaryStage~show

  fxml=.my.app~RootLayout.fxml
  lineChartContainer=fxml~lineChartContainer

  self~populateChart()

::method populateChart
  expose lineChartContainer

  say "Loading data from income_expense.json"
  data=.json~fromJsonFile("income_expense.json")
  monthData = data["months"]

  incomeItems = .array~new
  expenseItems = .array~new
  do i = 1 to monthData~size
      incomeItem=.bsf~new("eu.hansolo.fx.charts.data.XYChartItem", i, monthData[i]["income"], months[i], months[i])
      expenseItem=.bsf~new("eu.hansolo.fx.charts.data.XYChartItem", i, monthData[i]["expense"], months[i], months[i])
      incomeItems~append(incomeItem)
      expenseItems~append(expenseItem)
  end

  incomeSeries=bsf.loadClass("eu.hansolo.fx.charts.series.XYSeriesBuilder")~create
  expenseSeries=bsf.loadClass("eu.hansolo.fx.charts.series.XYSeriesBuilder")~create
  lineChartPane=.bsf~new("eu.hansolo.fx.charts.XYPane", .list~of(incomeSeries, expenseSeries))

  lineChart=.bsf~new("eu.hansolo.fx.charts.XYChart", lineChartPane)
  stackPane=.bsf~new("javafx.scene.layout.StackPane", lineChart)
  lineChartContainer~getChildren~setAll(stackPane)

  say "Data set on chart successfully."

::routine refreshChart
  populateChart()
