{-# LANGUAGE LambdaCase #-}

module PrettyPrint where

import Data.Tree (Tree (..), drawTree)
import Text.Printf (printf)
import Data.Text (unpack)

import Project
import Reporting 

asTree :: Project -> Tree String
asTree = \case
  SingleProject pId name -> Node (printf "%s (%d)" name (unProjectId pId)) []
  GroupProject name projects -> Node (unpack name) (map asTree projects)

prettyProject :: Project -> String
prettyProject = drawTree . asTree

prettyReport :: Report -> String
prettyReport = printf "Budget: %.2f, Net: %.2f, Difference: %.2f"
    <$> unMoney . budgetProfit
    <*> unMoney . netProfit
    <*> unMoney . difference
