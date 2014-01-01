{-# LANGUAGE OverloadedStrings #-}
module Leankit.Types.Common where

import Control.Applicative ((<$>), pure)
import Data.Aeson.Types
import Data.Attoparsec.Number
import Data.Colour
import Data.Colour.SRGB

type Date = String
type DateTime = String

-- TODO use some template haskell magic to generate these stuff

newtype BoardID = BoardID Int deriving (Eq, Show)
instance FromJSON BoardID where
        parseJSON v = BoardID <$> parseJSON v

newtype OrganizationID = OrganizationID Int deriving (Eq, Show)
instance FromJSON OrganizationID where
        parseJSON v = OrganizationID <$> parseJSON v

newtype UserID = UserID Int deriving (Eq, Show)
instance FromJSON UserID where
        parseJSON v = UserID <$> parseJSON v

newtype LaneID = LaneID Int deriving (Eq, Show)
instance FromJSON LaneID where
        parseJSON v = LaneID <$> parseJSON v

newtype CardID = CardID Int deriving (Eq, Show)
instance FromJSON CardID where
        parseJSON v = CardID <$> parseJSON v

newtype CardContextID = CardContextID Int deriving (Eq, Show)
instance FromJSON CardContextID where
        parseJSON v = CardContextID <$> parseJSON v

newtype CardCommentID = CardCommentID Int deriving (Eq, Show)
instance FromJSON CardCommentID where
        parseJSON v = CardCommentID <$> parseJSON v

newtype CardTypeID = CardTypeID Int deriving (Eq, Show)
instance FromJSON CardTypeID where
        parseJSON v = CardTypeID <$> parseJSON v

newtype Color = Color (Colour Double) deriving (Eq, Show)
instance FromJSON Color where
        parseJSON (String "") = parseJSON (String "#FFFFFF")
        parseJSON v = (Color . sRGB24read) <$> parseJSON v
        -- TODO clumsy... Empty string should be Nothing at the end of the day

newtype LaneClassTypeID = LaneClassTypeID Int deriving (Eq, Show)
instance FromJSON LaneClassTypeID where
        parseJSON v = LaneClassTypeID <$> parseJSON v

newtype LaneTypeID = LaneTypeID Int deriving (Eq, Show)
instance FromJSON LaneTypeID where
        parseJSON v = LaneTypeID <$> parseJSON v

newtype PriorityID = PriorityID Int deriving (Eq, Show)
instance FromJSON PriorityID where
        parseJSON v = PriorityID <$> parseJSON v

