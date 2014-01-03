{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}

module Leankit.Types.CardComment where

import Data.Aeson.TH

import Leankit.Types.TH
import Leankit.Types.Common


data CardComment = CardComment {
      _id                   :: CardCommentID,

      _postDate             :: Maybe DateTime,
      _postedById           :: Maybe UserID,
      _postedByFullName     :: Maybe String,
      _postedByGravatarLink :: Maybe String, -- TODO gravatar link

      _text                 :: Maybe String,

--      _taggedUsers          :: Maybe [Something], -- TODO what's this?
      _editable             :: Maybe Bool
} deriving (Eq, Show)

$(deriveFromJSON parseOptions ''CardComment)
