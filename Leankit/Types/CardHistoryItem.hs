{-# LANGUAGE OverloadedStrings #-}

module Leankit.Types.CardHistoryItem where

import Control.Applicative ((<$>), (<*>))
import Control.Monad (mzero)
import Data.Aeson

import Leankit.Types.Common


data CardHistoryItem = CardHistoryItem {
        _cardId                       :: CardID,
        _overrideType                 :: Maybe String, -- TODO what's this?
        _taskboardContainingCardId    :: Maybe CardID,
        _userName                     :: Maybe String,
        _cardTitle                    :: Maybe String,
        _gravatarLink                 :: Maybe String,
        _timeDifference               :: Maybe String,
        _dateTime                     :: Maybe DateTime,
        _lastDate                     :: Maybe Integer, -- TODO should be converted to datetime...
        _type                         :: Maybe String,
        _taskboardContainingCardTitle :: Maybe String,
        _userFullName                 :: Maybe String,
        _toLaneId                     :: Maybe LaneID,
        _toLaneTitle                  :: Maybe String,

        _details :: CardHistoryDetails
} deriving (Eq, Show)

instance FromJSON CardHistoryItem where
        parseJSON (Object v) = CardHistoryItem
                        <$> v .:  "CardId"
                        <*> v .:? "OverrideType"
                        <*> v .:? "TaskboardContainingCardId"
                        <*> v .:? "UserName"
                        <*> v .:? "CardTitle"
                        <*> v .:? "GravatarLink"
                        <*> v .:? "TimeDifference"
                        <*> v .:? "DateTime"
                        <*> v .:? "LastDate"
                        <*> v .:? "Type"
                        <*> v .:? "TaskboardContainingCardTitle"
                        <*> v .:? "UserFullName"
                        <*> v .:? "ToLaneId"
                        <*> v .:? "ToLaneTitle"
                        <*> parseJSON (Object v)
        parseJSON _          = mzero


-- ===============
-- CardFieldChange

data CardFieldChange = CardFieldChange {
        _fieldName  :: String,
        _newValue   :: String,
        _oldValue   :: Maybe String,
        _newDueDate :: Maybe String,
        _oldDueDate :: Maybe String
} deriving (Eq, Show)

instance FromJSON CardFieldChange where
        parseJSON (Object v) = do CardFieldChange
                                        <$> v .:  "FieldName"
                                        <*> v .:  "NewValue"
                                        <*> v .:? "OldValue"
                                        <*> v .:? "NewDueDate"
                                        <*> v .:? "OldDueDate"


-- ==================
-- CardHistoryDetails

data CardHistoryDetails = CardCreateEventDetails |
                          CardMoveEventDetails {
                                _fromLaneId               :: LaneID,
                                _fromLaneTitle            :: Maybe String
                          } |
                          UserAssignmentEventDetails {
                                _assignedUserId           :: UserID,
                                _assignedUserEmailAddress :: Maybe String,
                                _assignedUserFullName     :: Maybe String
                          } |
                          CardFieldChangedEventDetails {
                                _changes                  :: [CardFieldChange]
                          } |
                          UnknownEventDetails 
                          deriving (Eq, Show)


instance FromJSON CardHistoryDetails where
        parseJSON (Object v) = do
                itemType <- v .: "Type"
                case (itemType :: String) of -- TODO is this the proper place to give the type signature?
                        "CardCreationEventDTO"      -> return CardCreateEventDetails
                        "CardMoveEventDTO"          -> CardMoveEventDetails 
                                                        <$> v .:  "FromLaneId"
                                                        <*> v .:? "FromLaneTitle"
                        "UserAssignmentEventDTO"    -> UserAssignmentEventDetails 
                                                        <$> v .:  "AssignedUserId"
                                                        <*> v .:? "AssignedUserEmailAddres" -- TYPO!!!
                                                        <*> v .:? "AssignedUserFullName"
                        "CardFieldsChangedEventDTO" -> CardFieldChangedEventDetails
                                                        <$> v .:  "Changes"
                        _                           -> return UnknownEventDetails -- fallback
