#!/usr/bin/env rexx

call bsf.import "java.net.URL",                                 "URL"
call bsf.import "java.util.ArrayList",                          "ArrayList"
call bsf.import "javafx.fxml.FXMLLoader",                       "FXMLLoader"
call bsf.import "javafx.scene.Scene",                           "Scene"
/* call bsf.import "javafx.geometry.Orientation",                  "Orientation" */
call bsf.import "eu.hansolo.fx.charts.XYChart",                 "XYChart"
call bsf.import "eu.hansolo.fx.charts.XYPane",                  "XYPane"
/* call bsf.import "eu.hansolo.fx.charts.Position",                "Position" */
call bsf.import "eu.hansolo.fx.charts.AxisBuilder",             "AxisBuilder"
call bsf.import "eu.hansolo.fx.charts.GridBuilder",             "GridBuilder"
call bsf.import "eu.hansolo.fx.charts.data.XYChartItem",        "XYChartItem"
call bsf.import "eu.hansolo.fx.charts.series.XYSeriesBuilder",  "XYSeriesBuilder"

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
  say ppJavaExceptionChain(co, .true)
  say " done. "~center(100, "-")
  exit -1

::requires "BSF.CLS"
::requires "json-rgf.cls"

::class RexxApplication

::method start
  expose lineChartContainer
  use arg primaryStage
  primaryStage~setTitle("Income vs Expenses")

  fxmlUrl=.URL~new("file:RootLayout.fxml")
  rootNode=.FXMLLoader~load(fxmlUrl)

  scene=.Scene~new(rootNode)
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

  incomeItems=.ArrayList~new()
  expenseItems=.ArrayList~new()
  do i = 1 to monthData~size
      incomeItem=.XYChartItem~new(i, monthData[i]["income"], months[i], months[i])
      expenseItem=.XYChartItem~new(i, monthData[i]["expense"], months[i], months[i])
      incomeItems~add(incomeItem)
      expenseItems~add(expenseItem)
  end

  incomeSeries=.XYSeriesBuilder~create~items(incomeItems)~build
  expenseSeries=.XYSeriesBuilder~create~items(expenseItems)~build

  seriesList=.ArrayList~new()
  seriesList~add(incomeSeries)
  seriesList~add(expenseSeries)

  lineChartPane=.XYPane~new(seriesList)

  Orientation=bsf.loadClass("javafx.geometry.Orientation")
  Position=bsf.loadClass("eu.hansolo.fx.charts.Position")

  xAxis = .AxisBuilder~create(Orientation~HORIZONTAL, Position~BOTTOM)~build
  yAxis = .AxisBuilder~create(Orientation~VERTICAL, Position~LEFT)~build
  grid = .GridBuilder~create(xAxis, yAxis)~build

  axisList=.ArrayList~new()
  axisList~add(yAxis)
  axisList~add(xAxis)

  lineChart=.XYChart~new(lineChartPane, grid, yAxis, xAxis)
  lineChartContainer~getChildren~add(lineChart)

  say "Chart data successfully populated."

::routine refreshChart
  populateChart()
