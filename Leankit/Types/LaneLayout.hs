{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}

module Leankit.Types.LaneLayout where

import Control.Applicative ((<$>), (<*>))
import Control.Monad (mzero)
import Data.Aeson.TH

import Leankit.Types.TH
import Leankit.Types.Common
import Leankit.Types.Lane (Lane)


data LaneLayout = LaneLayout {
      _lane       :: Maybe Lane,
      _parentLane :: Maybe Lane,
      _childLanes :: [Lane]
      -- _dom :: Something -- TODO
} deriving (Eq, Show)

$(deriveFromJSON parseOptions ''LaneLayout)
