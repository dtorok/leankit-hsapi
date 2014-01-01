{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}

module Leankit.Types.CardContext where

import Data.Aeson.TH

import Leankit.Types.Common
import Leankit.Types.TH


data CardContext = CardContext {
                  _id :: CardContextID,
                  _name :: Maybe String,

                  _taskBoardId :: Maybe BoardID,

                  _totalSize :: Int,
                  _totalCards :: Int,
                  _completedCardCount :: Int,
                  _completedCardSize :: Int,
                  _progressPercentage :: Int
} deriving (Eq, Show)

$(deriveFromJSON parseOptions ''CardContext)
