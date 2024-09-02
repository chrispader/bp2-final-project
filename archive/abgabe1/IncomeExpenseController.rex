#!/usr/bin/env rexx

::class IncomeExpenseOverviewController

::method init
  expose incomeExpenseChart xAxis yAxis refreshButton mainApp
  use arg mainApp

  dir=.my.app~fxml_01.fxml
  incomeExpenseChart=dir~incomeExpenseChart
  xAxis=dir~xAxis
  yAxis=dir~yAxis
  refreshButton=dir~refreshButton

  -- Add event handler for refresh button
  rp=BSFCreateRexxProxy(self, ,"javafx.event.EventHandler")
  refreshButton~setOnAction(rp)

  self~populateChart()

::method handle
  expose refreshButton
  use arg event

  if event~source=refreshButton then
    self~populateChart()

::method populateChart
  expose incomeExpenseChart xAxis yAxis mainApp
  incomeSeries=.bsf~new("javafx.scene.chart.XYChart$Series")
  incomeSeries~setName("Income")
  expenseSeries=.bsf~new("javafx.scene.chart.XYChart$Series")
  expenseSeries~setName("Expenses")

  -- Debug message to ensure loop entry
  say "Entering loop to add data to series."

  /* do i=0 to mainApp~incomeData~length-1
    monthName = "Month " || (i + 1)
    -- Debug messages to trace data
    say "Creating data for month: " monthName
    say "Income: " mainApp~incomeData[i]
    say "Expense: " mainApp~expenseData[i]

    -- Ensure data points are added correctly
    incomeDataPoint = .bsf~new("javafx.scene.chart.XYChart$Data", monthName, mainApp~incomeData[i])
    expenseDataPoint = .bsf~new("javafx.scene.chart.XYChart$Data", monthName, mainApp~expenseData[i])

    -- Debug messages to trace data point creation
    say "Created incomeDataPoint: " incomeDataPoint
    say "Created expenseDataPoint: " expenseDataPoint

    -- Add data points to the series
    incomeSeries~getData~add(incomeDataPoint)
    expenseSeries~getData~add(expenseDataPoint)

    -- Debug messages to confirm addition
    say "Added incomeDataPoint to incomeSeries."
    say "Added expenseDataPoint to expenseSeries."
  end */

  -- Debug message to ensure data addition is completed
  say "Data addition to series completed."

  incomeExpenseChart~getData~clear()
  incomeExpenseChart~getData~add(incomeSeries)
  incomeExpenseChart~getData~add(expenseSeries)

  -- Debug message to confirm data set on chart
  say "Data set on chart successfully."
