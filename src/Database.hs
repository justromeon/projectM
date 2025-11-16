{-# LANGUAGE NumericUnderscores #-}

module Database where

import System.Random (getStdRandom, Random (randomR))

import Project

getBudget :: ProjectId -> IO Budget
getBudget _ = do
  income     <- Money <$> getStdRandom (randomR (0, 10_000))
  expediture <- Money <$> getStdRandom (randomR (0, 10_000))
  pure Budget { budgetIncome = income, budgetExpediture = expediture }

getTransactions :: ProjectId -> IO [Transaction]
getTransactions _ = do
  sale     <- Sale . Money <$> getStdRandom (randomR (0, 40_000))
  purchase <- Purchase . Money <$> getStdRandom (randomR (0, 40_000))
  pure [sale, purchase]
