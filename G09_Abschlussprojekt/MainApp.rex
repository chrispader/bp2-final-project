#!/usr/bin/env rexx

call bsf.import "java.net.URL",                                 "URL"
call bsf.import "java.util.Arrays",                             "Arrays"
call bsf.import "java.util.ArrayList",                          "ArrayList"
call bsf.import "javafx.fxml.FXMLLoader",                       "FXMLLoader"
call bsf.import "javafx.scene.Scene",                           "Scene"

call bsf.import "io.fair_acc.chartfx.XYChart",                            "XYChart"
call bsf.import "io.fair_acc.chartfx.axes.spi.CategoryAxis",              "CategoryAxis"
call bsf.import "io.fair_acc.chartfx.axes.spi.DefaultNumericAxis",        "DefaultNumericAxis"
call bsf.import "io.fair_acc.chartfx.renderer.LineStyle",                 "LineStyle"
call bsf.import "io.fair_acc.dataset.spi.DefaultErrorDataSet",            "DefaultErrorDataSet"
call bsf.import "io.fair_acc.chartfx.ui.geometry.Side",                   "Side"

parse source  . . pgm
call directory filespec('L', pgm)   -- change to the directory where the program resides

months = .array~of("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")
monthsArrayList = .ArrayList~new
do i = 1 to months~size
  monthsArrayList~add(months[i])
end

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
::requires "json.cls"

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

  xAxis = .CategoryAxis~new("Months")
  xAxis~setSide(.Side~BOTTOM)

  yAxis = .DefaultNumericAxis~new("Amount")
  yAxis~setSide(.Side~LEFT)

  lineChart = .XYChart~new
  lineChart~getAxes~add(xAxis)
  lineChart~getAxes~add(yAxis)

  incomeDataSet = .DefaultErrorDataSet~new("Income")
  do i = 1 to monthData~size
    incomeDataSet~add(i-1, monthData[i]["income"], 0.0, 0.1)
  end

  expenseDataSet = .DefaultErrorDataSet~new("Expenses")
  do i = 1 to monthData~size
    expenseDataSet~add(i-1, monthData[i]["expense"], 0.0, 0.1)
  end

  lineChart~getDatasets~add(incomeDataSet)
  lineChart~getDatasets~add(expenseDataSet)
  lineChartContainer~getChildren~add(lineChart)

  say "Chart data successfully populated."
