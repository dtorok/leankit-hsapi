{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}

module Leankit.Types.BoardShort where

import Data.Aeson.TH

import Leankit.Types.TH
import Leankit.Types.Common

data BoardShort = BoardShort {
        _id                 :: BoardID,
        _title              :: Maybe String,
        _description        :: Maybe String,

        _isArchived         :: Maybe Bool,
        _isBreakoutBoard    :: Maybe Bool,
        _isPrivate          :: Maybe Bool,

        _parentId           :: Maybe Int,
        _creationDate       :: Maybe Date,

        _drillThroughBoards :: [BoardShort]
--      _breakoutBoards     :: [Something], -- TODO
} deriving (Eq, Show)

$(deriveFromJSON parseOptions ''BoardShort)
