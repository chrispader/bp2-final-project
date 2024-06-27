#!/usr/bin/env rexx

.environment~my.app=.directory~new
.my.app~bDebug=.false

call bsf.import "javafx.collections.FXCollections",            "fx.FXCollections"

-- change directory to program location such that relatively addressed resources can be found
parse source  . . pgm
call directory filespec('L', pgm)   -- change to the directory where the program resides

rxApp=.RexxApplication~new -- create Rexx object that will control the FXML set up
.my.app~mainApp=rxApp
jrxApp=BSFCreateRexxProxy(rxApp, ,"javafx.application.Application")
jrxApp~launch(jrxApp~getClass, .nil)    -- launch the application, invokes "start"

::requires "BSF.CLS"    -- get Java support
::requires "json-rgf.cls"

-- Rexx class defines "javafx.application.Application" abstract method "start"
::class RexxApplication -- implements the abstract class "javafx.application.Application"

::method init
   expose incomeData expenseData
   data=.json~fromJsonFile("income_expense.json")
   incomeData=.fx.FXCollections~observableArrayList
   expenseData=.fx.FXCollections~observableArrayList

   do d over data
      incomeData~add(d["income"])
      expenseData~add(d["expense"])
   end

::method start          -- Rexx method "start" implements the abstract method
  use arg primaryStage  -- fetch the primary stage (window)
  primaryStage~setTitle("Hello JavaFX from ooRexx! (Green Version)")

   -- create an URL for the FMXLDocument.fxml file (hence the protocol "file:")
  fxmlUrl=.bsf~new("java.net.URL", "file:fxml_01.fxml")
   -- use FXMLLoader to load the FXML and create the GUI graph from its definitions:
  rootNode=bsf.loadClass("javafx.fxml.FXMLLoader")~load(fxmlUrl)

  scene=.bsf~new("javafx.scene.Scene", rootNode)    -- create a scene for our document
  primaryStage~setScene(scene)  -- set the stage to our scene
  primaryStage~show             -- show the stage (and thereby our scene)


/*
      ------------------------ Apache Version 2.0 license -------------------------
         Copyright 2016-2017 Rony G. Flatscher

         Licensed under the Apache License, Version 2.0 (the "License");
         you may not use this file except in compliance with the License.
         You may obtain a copy of the License at

             http://www.apache.org/licenses/LICENSE-2.0

         Unless required by applicable law or agreed to in writing, software
         distributed under the License is distributed on an "AS IS" BASIS,
         WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
         See the License for the specific language governing permissions and
         limitations under the License.
      -----------------------------------------------------------------------------
*/
