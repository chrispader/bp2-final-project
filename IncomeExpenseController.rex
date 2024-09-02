#!/usr/bin/env rexx

call bsf.import "java.lang.Double", "Double"
call bsf.import "java.lang.String", "String"

mainApp = .my.app~mainApp

::class IncomeExpenseController

::method init
  expose incomeExpenseChart refreshButton mainApp
  use arg mainApp

  dir=.my.app~RootLayout.fxml
  incomeExpenseChart=dir~incomeExpenseChart
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

  /* create a pie chart with four areas */
  barDataset = .DefaultCategoryDataset~new();

  do i=1 to mainApp~incomeData~length
    monthName = "Month " || (i)
    -- Debug messages to trace data

    -- Ensure data points are added correctly
    barDataset~setValue(.Double~new(mainApp~incomeData[i]), "Income" || i, monthName);
    barDataset~setValue(.Double~new(mainApp~expenseData[i]), "Expense" || i, monthName);
  end
  say "Data set on chart successfully."

  chart = .ChartFactory~createBarChart("Income vs. Expenses", "Months", "Amount", barDataset);
  .my.app;
  incomeExpenseChart~setChart(chart);
