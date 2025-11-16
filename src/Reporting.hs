{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE InstanceSigs #-}

module Reporting where

import Data.Monoid (Sum(getSum))

import qualified Database as DB
import           Project

data Report = Report
  { budgetProfit :: Money
  , netProfit :: Money
  , difference :: Money
  } deriving (Show, Eq)

instance Semigroup Report where
  (<>) :: Report -> Report -> Report
  Report b1 n1 d1 <> Report b2 n2 d2 =
    Report (b1+b2) (n1+n2) (d1+d2)

instance Monoid Report where
  mempty :: Report
  mempty = Report 0 0 0

calculateReport :: Budget -> [Transaction] -> Report
calculateReport budget transactions =
  Report
    { budgetProfit = budgetProfit'
    , netProfit = netProfit'
    , difference = netProfit' - budgetProfit'}
  where
    budgetProfit' = budgetIncome budget - budgetExpediture budget
    netProfit'    = getSum (foldMap asProfit transactions)
    asProfit (Sale m)     = pure m
    asProfit (Purchase m) = pure (negate m)

calculateProjectReport :: Project -> IO Report
calculateProjectReport = \case
  SingleProject pId _ -> calculateReport <$> DB.getBudget pId <*> DB.getTransactions pId
  GroupProject _ projects -> foldMap calculateProjectReport projects
