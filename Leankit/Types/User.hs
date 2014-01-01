{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}

module Leankit.Types.User where

import Control.Applicative ((<$>), (<*>))
import Control.Monad (mzero)
import Data.Aeson.TH

import Leankit.Types.TH
import Leankit.Types.Common


data User = User {
		_id             :: UserID,
		_userName       :: String,
		_fullName       :: Maybe String,
		_emailAddress   :: Maybe String,

		_gravatarFeed   :: Maybe String,
		_gravatarLink   :: Maybe String,

		_role           :: Maybe Int,
		_roleName       :: Maybe String,

		_enabled        :: Maybe Bool,
		_isAccountOwner :: Maybe Bool,
		_isDeleted      :: Maybe Bool,

		_dateFormat     :: Maybe String,
--		_settings       :: Something, -- TODO
		_wip            :: Maybe Int
} deriving (Eq, Show)

$(deriveFromJSON parseOptions ''User)
