{-# LANGUAGE OverloadedStrings #-}

module Demo where

import Project
import Reporting

someProject :: Project
someProject = GroupProject "Central Luzon" [tarlac, pampanga, nuevaEcija]
  where
    tarlac     = SingleProject 1 "Tarlac"
    pampanga   = SingleProject 2 "Pampanga"
    nuevaEcija = GroupProject "Nueva Ecija" [cabanatuan, gapan]
    cabanatuan = SingleProject 3 "Cabanatuan City"
    gapan      = SingleProject 4 "Gapan City"

sampleReport :: IO Report
sampleReport = calculateProjectReport someProject
