{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}

module Leankit.Types.BoardHistoryItem where

import Control.Applicative ((<$>), (<*>))
import Control.Monad (mzero)
import Data.Aeson.TH

import Leankit.Types.TH
import Leankit.Types.Common


data BoardHistoryItem = BoardHistoryItem {
        _eventType            :: Maybe String,
        _eventDateTime        :: Maybe String,

        _cardId               :: Maybe CardID,
        _userId               :: Maybe UserID,
        _assignedUserId       :: Maybe UserID,
        _fromLaneId           :: Maybe LaneID,
        _toLaneId             :: Maybe LaneID,

        _message              :: Maybe String,
        _commentText          :: Maybe String,
        _blockedComment       :: Maybe String,
        _wipOverrideUser      :: Maybe Int,
        _wipOverrideLane      :: Maybe Int,
        _wipOverrideComment   :: Maybe String,

        _isUnassigning        :: Maybe Bool,
        _isBlocked            :: Maybe Bool,
        _requiresBoardRefresh :: Maybe Bool
} deriving (Eq, Show)

$(deriveFromJSON parseOptions ''BoardHistoryItem)
