{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}

module Leankit.Types.LaneShort where

import Control.Applicative ((<$>), (<*>))
import Control.Monad (mzero)
import Data.Aeson.TH

import Leankit.Types.TH
import Leankit.Types.Common
import Leankit.Types.Card (Card)


data LaneShort = LaneShort {
            _id                   :: LaneID,
            _name                 :: Maybe String,
            _type                 :: LaneTypeID,

            _classType            :: LaneClassTypeID,
            _laneClassType        :: LaneClassTypeID, -- TODO ???

            _activityId           :: Maybe Int,
            _parentLaneId         :: Maybe LaneID,
            _topLevelParentLaneId :: Maybe LaneID,

            _cardLimit            :: Int,
            _index                :: Int
} deriving (Eq, Show)

$(deriveFromJSON parseOptions ''LaneShort)
