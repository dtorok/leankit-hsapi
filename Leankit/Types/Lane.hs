{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}

module Leankit.Types.Lane where

import Control.Applicative ((<$>), (<*>))
import Control.Monad (mzero)
import Data.Aeson.TH

import Leankit.Types.TH
import Leankit.Types.Common
import Leankit.Types.Card (Card)


data Lane = Lane {
            _id                     :: LaneID,
            _type                   :: Maybe Int,
            _title                  :: Maybe String,
            _description            :: Maybe String,
            _active                 :: Maybe Bool,

            _index                  :: Maybe Int,
            _laneState              :: Maybe String,
            _classType              :: Maybe Int,
            _width                  :: Maybe Int,
            _cardLimit              :: Maybe Int,
            _orientation            :: Maybe Int,
            _isDrillthroughDoneLane :: Maybe Bool,

            _cards                  :: [Card],

            _cardContextId          :: Maybe Int,
            _activityId             :: Maybe Int,
            _taskBoardId            :: Maybe BoardID,

            _parentLaneId           :: Maybe Int,
            _siblingLaneIds         :: [LaneID],
            _activityName           :: Maybe String,
            _childLaneIds           :: [LaneID]

} deriving (Eq, Show)

$(deriveFromJSON parseOptions ''Lane)
