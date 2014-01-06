{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}

module Leankit.Types.Card where

import Control.Applicative ((<$>))

import Data.Aeson
import Data.Aeson.TH
import Data.List.Split

import Leankit.Types.TH
import Leankit.Types.Common
import Leankit.Types.AssignedUser (AssignedUser)
import Leankit.Types.CardContext (CardContext)


-- TODO clumsy, why do I need a separate data type??
newtype Tags = Tags [String] deriving (Eq, Show)
instance FromJSON Tags where
        parseJSON Null = return $ Tags []
        parseJSON v = toTags <$> parseJSON v where
                        toTags = Tags . splitOn ","


data Card = Card {
        _id                            :: Int,
        _version                       :: Maybe Int,

        _typeId                        :: Maybe Int,
        _typeName                      :: Maybe String,
        _typeColorHex                  :: Maybe Color,
        _typeIconPath                  :: Maybe String,

        _title                         :: Maybe String,
        _description                   :: Maybe String,
        _tags                          :: Tags,
        _dueDate                       :: Maybe Date,
        _size                          :: Maybe Int,
        _priority                      :: Maybe Int,
        _priorityText                  :: Maybe String,
        _color                         :: Maybe Color,

        _laneId                        :: Maybe Int,
        _parentCardId                  :: Maybe CardID,
        _gravatarLink                  :: Maybe String,
        _smallGravatarLink             :: Maybe String,

        _active                        :: Maybe Bool,
        _index                         :: Maybe Int,
        _taskBoardCompletionPercent    :: Maybe Int,
        _classOfServiceId              :: Maybe Int,
        _classOfServiceTitle           :: Maybe String,
        _classOfServiceColorHex        :: Maybe Color,
        _classOfServiceIconPath        :: Maybe String,
        _currentTaskBoardId            :: Maybe BoardID,
        _systemType                    :: Maybe String,
        _currentContext                :: Maybe String,
        _cardContexts                  :: Maybe [CardContext], -- ?
        _taskBoardTotalCards           :: Maybe Int,
        _taskBoardTotalSize            :: Maybe Int,
        _blockReason                   :: Maybe String,
        _blockStateChangeDate          :: Maybe String,

        _assignedUsers                 :: [AssignedUser],
        _assignedUserIds               :: [UserID],

        _externalCardID                :: Maybe String,
        _externalSystemName            :: Maybe String,
        _externalSystemUrl             :: Maybe String,

        _drillThroughBoardId           :: Maybe BoardID,
        _drillThroughCompletionPercent :: Maybe Int,
        _drillThroughProgressComplete  :: Maybe Int,
        _drillThroughProgressTotal     :: Maybe String,

        _lastAttachment                :: Maybe String,
        _lastActivity                  :: Maybe DateTime,
        _lastMove                      :: Maybe DateTime,
        _lastComment                   :: Maybe String,
        _commentsCount                 :: Maybe Int,
        _dateArchived                  :: Maybe Date,
        _attachmentsCount              :: Maybe Int,
        _countOfOldCards               :: Maybe Int,

        _hasDrillThroughBoard          :: Maybe Bool,
        _isBlocked                     :: Maybe Bool

} deriving (Eq, Show)

$(deriveFromJSON parseOptions ''Card)
