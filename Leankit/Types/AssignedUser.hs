{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}

module Leankit.Types.AssignedUser where

import Control.Applicative ((<$>), (<*>))
import Control.Monad (mzero)
import Data.Aeson
import Data.Aeson.TH

import Leankit.Types.Common
import Leankit.Types.TH


data AssignedUser = AssignedUser {
    _id                :: UserID,
    _emailAddress      :: Maybe String,
    _fullName          :: Maybe String,

    _gravatarLink      :: Maybe String,
    _smallGravatarLink :: Maybe String,

    _assignedUserName  :: Maybe String,
    _assignedUserId    :: Maybe UserID
} deriving (Eq, Show)

$(deriveFromJSON parseOptions ''AssignedUser)
