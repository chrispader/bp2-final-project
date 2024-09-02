::class RootLayoutController

::method init
  expose mainApp menuOpen menuSave menuExit menuAbout
  use arg mainApp

  dir=.my.app~rootLayout.fxml
  menuOpen=dir~menuOpen~~setOnAction(BsfCreateRexxProxy(self, "javafx.event.EventHandler"))
  menuSave=dir~menuSave~~setOnAction(BsfCreateRexxProxy(self, "javafx.event.EventHandler"))
  menuExit=dir~menuExit~~setOnAction(BsfCreateRexxProxy(self, "javafx.event.EventHandler"))
  menuAbout=dir~menuAbout~~setOnAction(BsfCreateRexxProxy(self, "javafx.event.EventHandler"))

::method handle
  expose mainApp menuOpen menuSave menuExit menuAbout
  use arg event

  if event~getTarget~objectName=menuOpen~objectName then mainApp~handleOpen
  else if event~getTarget~objectName=menuSave~objectName then mainApp~handleSave
  else if event~getTarget~objectName=menuExit~objectName then mainApp~handleExit
  else if event~getTarget~objectName=menuAbout~objectName then self~handleAbout

::method handleAbout
  -- Show an about dialog
  bsf.dialog~messageBox("Income vs Expenses App\nVersion 1.0", "About", "information")
