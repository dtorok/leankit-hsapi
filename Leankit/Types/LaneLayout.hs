{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}

module Leankit.Types.LaneLayout where

import Data.Aeson.TH

import Leankit.Types.TH
import Leankit.Types.Lane (Lane)


data LaneLayout = LaneLayout {
      _lane       :: Maybe Lane,
      _parentLane :: Maybe Lane,
      _childLanes :: [Lane]
} deriving (Eq, Show)

$(deriveFromJSON parseOptions ''LaneLayout)
