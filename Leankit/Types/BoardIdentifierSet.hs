{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}

module Leankit.Types.BoardIdentifierSet where

import Data.Aeson.TH

import Leankit.Types.TH
import Leankit.Types.Common
import Leankit.Types.LaneShort


data BoardIdentifier a = BoardIdentifier {
	_id   :: a,
	_name :: String
} deriving (Eq, Show)

data BoardIdentifierSet = BoardIdentifierSet {
	_boardId          :: BoardID,

	_lanes            :: [LaneShort],
	_laneType         :: [BoardIdentifier LaneTypeID],
	_laneClassType    :: [BoardIdentifier LaneClassTypeID],

	_cardTypes        :: [BoardIdentifier CardTypeID],
	_boardUsers       :: [BoardIdentifier UserID],
	_priorities       :: [BoardIdentifier PriorityID]
--  _classesOfService :: Something -- TODO
--	_boardStatistics  :: Something -- TODO
} deriving (Eq, Show)

$(deriveFromJSON parseOptions ''BoardIdentifier)
$(deriveFromJSON parseOptions ''BoardIdentifierSet)
