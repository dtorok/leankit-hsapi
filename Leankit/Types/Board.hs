{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}

module Leankit.Types.Board where

import Control.Applicative ((<$>), (<*>))
import Control.Monad (mzero)
import Data.Aeson.TH

import Leankit.Types.Common
import Leankit.Types.User
import Leankit.Types.Lane

import Leankit.Types.TH

data Board = Board {
		_active                      :: Maybe Bool,
    	_title                       :: Maybe String,
		_prefix                      :: Maybe String,
		_description                 :: Maybe String,

		_version                     :: Maybe Int,

		_excludeCompletedAndArchiveViolations :: Maybe Bool,
		_isCardIdEnabled             :: Maybe Bool,
		_isHyperlinkEnabled          :: Maybe Bool,
		_isPrefixEnabled             :: Maybe Bool,
		_isPrefixIncludedInHyperlink :: Maybe Bool,
		_isPrivate                   :: Maybe Bool,
		_isWelcome                   :: Maybe Bool,
		_classOfServiceEnabled       :: Maybe Bool,
		_archiveTopLevelLaneId       :: Maybe Int,

		_organizationId              :: Maybe OrganizationID,
		_cardColorField              :: Maybe String,
		_maxFileSize                 :: Maybe Int,
		_format                      :: Maybe String,

		_boardUsers                  :: [User],
		_currentUserRole             :: Maybe Int,
		_topLevelLaneIds             :: [LaneID],
    	_lanes                       :: [Lane]
} deriving (Eq, Show)

$(deriveFromJSON parseOptions ''Board)
