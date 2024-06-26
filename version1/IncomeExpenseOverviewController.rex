::class IncomeExpenseOverviewController

::method init
  expose incomeExpenseChart xAxis yAxis mainApp
  use arg mainApp

  dir=.my.app~incomeExpenseOverview.fxml
  incomeExpenseChart=dir~incomeExpenseChart
  xAxis=dir~xAxis
  yAxis=dir~yAxis

  self~populateChart

::method populateChart
  expose incomeExpenseChart xAxis yAxis mainApp

  incomeSeries=.bsf~new("javafx.scene.chart.XYChart$Series")
  incomeSeries~setName("Income")
  expenseSeries=.bsf~new("javafx.scene.chart.XYChart$Series")
  expenseSeries~setName("Expenses")

  do i=1 to mainApp~incomeData~size
     incomeSeries~getData~add(.bsf~new("javafx.scene.chart.XYChart$Data", "Month "i, mainApp~incomeData[i]))
     expenseSeries~getData~add(.bsf~new("javafx.scene.chart.XYChart$Data", "Month "i, mainApp~expenseData[i]))
  end

  incomeExpenseChart~getData~add(incomeSeries)
  incomeExpenseChart~getData~add(expenseSeries)
